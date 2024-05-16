//
//  MapView.swift
//  GroceryShopping
//
//  Created by Rohit Gugadiya on 4/5/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
 
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @ObservedObject var viewModel = GroceryListViewModel()
    @State private var mapSelection: MKMapItem?
    @Namespace private var locationSpace
    @State private var viewingRegion: MKCoordinateRegion?
    
    //Search Properties
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    
    //Map Selection Detail Properties
    @State private var showDetails: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?
    
    //Route Properties
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    @State var goToLocal: Bool = false

var body: some View {
        ZStack {
            NavigationStack {
                Map(position: $cameraPosition, selection: $mapSelection, scope: locationSpace) {
                    //Map Annotations
                    Annotation("Your location", coordinate: .myLocation) {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.blue)
                                
                        }
                    }
                   
                    
                    // Shows annotation marker
                    ForEach(searchResults, id: \.self) { mapItem in
                        if routeDisplaying {
                            if mapItem == routeDestination {
                                let placemark = mapItem.placemark
                                Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                                    .tint(.blue)
                            }
                        } else {
                            let placemark = mapItem.placemark
                            Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                                .tint(.blue)
                        }
                    }
                    
                    
                    if let route {
                        MapPolyline(route.polyline)
                            .stroke(.blue, lineWidth: 7)
                    }
                    
                    //To Show User Current Location
                    UserAnnotation()
                }
                .onMapCameraChange({ ctx in
                    viewingRegion = ctx.region
                })
                .overlay(alignment: .bottomTrailing) {
                    VStack(spacing: 15) {
                        MapCompass(scope: locationSpace)
                        MapPitchToggle(scope: locationSpace)
                        // As this will work only when the User Gave Location Access
                        MapUserLocationButton(scope: locationSpace)
                        // This will Goes to the Defined User Region
                        Button {
                            withAnimation(.smooth) {
                                cameraPosition = .region(.myRegion)
                            }
                        } label: {
                            Image(systemName: "mappin")
                                .font(.title3)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .buttonBorderShape(.circle)
                    .padding()
                }
                .mapScope(locationSpace)
                .navigationTitle("Are you looking for nearest grocery store?")
                .navigationBarTitleDisplayMode(.inline)
                /// Search Bar
                .searchable(text: $searchText, isPresented: $showSearch)
                /// Showing Trasnlucent ToolBar
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                /// When Route Displaying Hiding Top And Bottom Bar
                .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
                .sheet(isPresented: $showDetails, onDismiss: {
                    withAnimation(.snappy) {
                        /// Zooming Region
                        if let boundingRect = route?.polyline.boundingMapRect, routeDisplaying {
                            cameraPosition = .rect(boundingRect.reducedRect(0.45))
                        }
                    }
                }, content: {
                    MapDetails()
                        .presentationDetents([.height(300)])
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                        .presentationCornerRadius(25)
                        .interactiveDismissDisabled(true)
                })
                .safeAreaInset(edge: .bottom) {
                    if routeDisplaying {
                        Button("End Route") {
                            // Closing The Route and Setting the Selection
                            withAnimation(.snappy) {
                                routeDisplaying = false
                                showDetails = true
                                mapSelection = routeDestination
                                routeDestination = nil
                                route = nil
                                if let coordinate = mapSelection?.placemark.coordinate {
                                    cameraPosition = .region(.init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000))
                                }
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                        .padding(.vertical, 12)
                        .background(.blue.gradient, in: .rect(cornerRadius: 15))
                        .padding()
                        .background(.ultraThinMaterial)
                    }
                }
            }
           
            
            .ignoresSafeArea()
            .onSubmit(of: .search) {
                Task {
                    guard !searchText.isEmpty else { return }
                    
                    await searchPlaces()
                }
            }
            
            .onChange(of: showSearch, initial: false) {
                if !showSearch {
                    // Clearing Search Results
                    searchResults.removeAll(keepingCapacity: false)
                    showDetails = false
                    // Zooming out to User Region when Search Cancelled
                    withAnimation(.smooth) {
                        cameraPosition = .region(viewingRegion ?? .myRegion)
                    }
                }
            }
            .onChange(of: mapSelection) { oldValue, newValue in
                showDetails = newValue != nil
                // Fetching Look Around Preview, when ever selection Changes
                fetchLookAroundPreview()
             
        }
        }
    VStack {
        Button(action: {
                self.goToLocal = true
            } ) {
                Text("Shop local")
                    .font(.custom("Poppins-Bold", size: 18))
                    .foregroundColor(.white)
                    .padding(10)
                
            }
            .frame(width: 300)
            .padding(5)
            .background(Color.mainMintColor)
        .cornerRadius(40)
    }


    NavigationLink(destination: LocalStoreView(), isActive: $goToLocal) { EmptyView() }
 
    }
    
    //Map Details View
    @ViewBuilder
    func MapDetails() -> some View {
        VStack(spacing: 15) {
            ZStack {
                //New Look Around API
                if lookAroundScene == nil {
                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
                } else {
                    LookAroundPreview(scene: $lookAroundScene)
                }
            }
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 15))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showDetails = false
                    withAnimation(.snappy) {
                        mapSelection = nil
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                        .background(.white, in: .circle)
                })
                .padding(10)
            }
            
            //Direction's Button
            Button("Get Directions", action: fetchRoute)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
                .background(.blue.gradient, in: .rect(cornerRadius: 15))
        }
        .padding(15)
    }
    
    //Search Places
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = viewingRegion ?? .myRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    
    // Fetching Location Preview
    func fetchLookAroundPreview() {
        if let mapSelection {
            // Clearing Old One
            lookAroundScene = nil
            Task.detached(priority: .background) {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
               
            }
        }
    }
    
    //fetching route
    func fetchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = .init(placemark: .init(coordinate: .myLocation))
            request.destination = mapSelection
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                /// Saving Route Destination
                routeDestination = mapSelection
                
                withAnimation(.snappy) {
                    routeDisplaying = true
                    showDetails = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension MKMapRect {
    func reducedRect(_ fraction: CGFloat = 0.35) -> MKMapRect {
        var regionRect = self

        let wPadding = regionRect.size.width * fraction
        let hPadding = regionRect.size.height * fraction
                    
        regionRect.size.width += wPadding
        regionRect.size.height += hPadding
                    
        regionRect.origin.x -= wPadding / 2
        regionRect.origin.y -= hPadding / 2
        
        return regionRect
    }
}

/// Location Data
extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        return .init(latitude: -33.8835, longitude: 151.2005)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}
