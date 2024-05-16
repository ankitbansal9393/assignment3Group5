//
//  LocalStoreView.swift
//  GroceryShopping
//
//  Created by Rohit Gugadiya on 4/5/2024.
//

import SwiftUI
import MapKit

struct Store: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let description: String
}

struct LocalStoreView: View {
    @State private var selectedStore: Store?
    @State var shop = 0

    let stores: [Store] = [
        Store(name: "Sell Fresh Locals", coordinate: CLLocationCoordinate2D(latitude: -33.886492, longitude: 151.209816), description: "Find your daily needs at one place "),
        Store(name: "Local store 2", coordinate: CLLocationCoordinate2D(latitude: -33.890163, longitude: 151.196071), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh center", coordinate: CLLocationCoordinate2D(latitude: -33.893441, longitude: 151.194440), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -33.895934, longitude: 151.201912), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -33.884036, longitude: 151.204231), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh town", coordinate: CLLocationCoordinate2D(latitude: -33.892443, longitude: 151.209212), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh home", coordinate: CLLocationCoordinate2D(latitude: -33.886652, longitude: 151.198844), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -33.881023, longitude: 151.203653), description: "Find your daily needs at one place")

    ]

    var body: some View {
        ZStack{
            HStack {
                Map(coordinateRegion:   .constant(MKCoordinateRegion(center: CLLocationCoordinate2D (latitude: -33.8835, longitude: 151.2005), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),  annotationItems: stores) { store in
                    MapAnnotation(coordinate: store.coordinate) {
                        Image(systemName: "cart.fill")
                            .foregroundColor(.black)
                            
                            
                            .font(.title)
                       
                            .onTapGesture {
                                self.selectedStore = store
                            }
                    }
                }
                  .sheet(item: $selectedStore) { store in
                        StoreDetailView(store: store)
                    

                .ignoresSafeArea()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct StoreDetailView: View {
    let store: Store

    var body: some View {
        VStack {
            Text(store.name)
                .font(.title)
            Text(store.description)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    LocalStoreView()
}
