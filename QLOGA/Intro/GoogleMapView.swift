//
//  GoogleMapView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: View {
    @Binding var providers: [Address]?
    @Binding var pickedAddress: Address
    @State var isFiltersPresented = false

    var body: some View {
        VStack {
            GoogleMapsView(pickedAddress: pickedAddress)
                .edgesIgnoringSafeArea(.all)
//                .frame(height: 300)
        }.toolbar {
            Button {
                isFiltersPresented.toggle()
            } label: {
                Image("FilterIcon").resizable().frame(width: 30, height: 30, alignment: .center).accentColor(Color.accentColor).foregroundColor(.accentColor)
                    .padding(5)
            }
        }
        .sheet(isPresented: $isFiltersPresented) {
            ProvidersFilterView()
        }
    }
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView(providers: .constant([]), pickedAddress: .constant( Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "09")))
    }
}


struct GoogleMapsView: UIViewRepresentable {
    private let zoom: Float = 15.0
    @ObservedObject var locationManager = LocationManager()
    var pickedAddress: Address
    var providers: [Address]?
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        
        return mapView
    }

    // 3
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: CLLocationDegrees(pickedAddress.latitude), longitude: CLLocationDegrees(pickedAddress.longitude)))
        if let providers = providers, providers != []  {
        for provider in providers  {
            let marker : GMSMarker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: provider.latitude as! CLLocationDegrees, longitude: provider.longitude as! CLLocationDegrees)
            
            marker.title = provider.total as? String
            marker.snippet = "Welcome to \(provider.town)"
            marker.icon = UIImage(named: "MapPoint")
            marker.map = mapView
            
        }
            let marker : GMSMarker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(pickedAddress.latitude), longitude: CLLocationDegrees(pickedAddress.longitude))
            marker.title = " \(pickedAddress.apt) \(pickedAddress.building) \(pickedAddress.street)"
            marker.snippet = "\(pickedAddress.town), \(pickedAddress.postcode)"
            marker.icon = UIImage(named: "MapPoint")
            marker.map = mapView
        } else {
            let marker : GMSMarker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(pickedAddress.latitude), longitude: CLLocationDegrees(pickedAddress.longitude))
            marker.title = " \(pickedAddress.apt) \(pickedAddress.building) \(pickedAddress.street)"
            marker.snippet = "\(pickedAddress.town), \(pickedAddress.postcode)"
            marker.icon = UIImage(named: "MapPoint")
            marker.map = mapView
        }
    }
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView(pickedAddress: Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "09"))
    }
}

