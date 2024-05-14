
import SwiftUI
import MapKit

struct Store: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let description: String
}

struct MapView: View {
    @State private var selectedStore: Store?
    @ObservedObject var viewModel = ContentViewModel()
//    @ObservedObject var viewModel = GroceryListViewModel()
    let stores: [Store] = [
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -33.886492, longitude: 151.209816), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -33.877830, longitude: 151212822), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -33.877830, longitude: 151.121149), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -33.7615, longitude: 151.1005), description: "Find your daily needs at one place"),
        Store(name: "Sell Fresh", coordinate: CLLocationCoordinate2D(latitude: -37.7879, longitude: 151.2005), description: "Find your daily needs at one place")
    ]
    
    var body: some View {
        ZStack{
            Map(coordinateRegion:   .constant(MKCoordinateRegion(center: CLLocationCoordinate2D (latitude:-33.8835, longitude: 151.2005), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), showsUserLocation:true, annotationItems: stores) { store in
                MapAnnotation(coordinate: store.coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.selectedStore = store
                        }
                        .accentColor(.black)
                    
                }
                
            }
            .sheet(item: $selectedStore) { store in
                StoreDetailView(store: store)
            }
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
//                .ignoresSafeArea()
//                .accentColor(Color(.black))
//                .onAppear(){
//                    viewModel.checkIfLocationServiceIsEnable() // Call method from ContentViewModel
//
//                }
            .ignoresSafeArea()
        }
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
final class ContentViewModel:NSObject, ObservableObject, CLLocationManagerDelegate{
    

    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:-33.865143, longitude:151.2093),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var locationManager: CLLocationManager?
    func checkIfLocationServiceIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("your location is turned of ")
        }
    }
        private func checkLocationAuthorization(){
            guard let locationManager = locationManager else {return}
            
            switch locationManager.authorizationStatus{
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted")
            case .denied:
                print("You have denied app location please allow location from settings" )
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            @unknown default:
                break
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
            checkLocationAuthorization()
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
