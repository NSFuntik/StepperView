//
//  GoogleMapView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import CoreLocation
import MapKit
import SwiftUI
import UIKit
#if DEBUG

#else
import GoogleMaps

#endif

struct GoogleMapView: View {
    @Binding var providers: [Address]?
//    @Binding var customers: [Address]?

//    @Binding var pickerCstAddress: CstAddress
    @Binding var pickedAddress: Address
    @State var isFiltersPresented = false
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: .init())

    var body: some View {
        VStack {
#if DEBUG
            Map(coordinateRegion: $region).edgesIgnoringSafeArea(.all)
#else
            GoogleMapsView(pickedAddress: $pickedAddress.wrappedValue, providers: providers!).edgesIgnoringSafeArea(.all)
#endif

        }.toolbar {
            if providers?.count ?? 0 > 0 {
                Button {
                    isFiltersPresented.toggle()
                } label: {
                    Image("FilterIcon")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.accentColor)
                        .frame(width: 30, height: 30, alignment: .trailing)
                        .padding(5)
                }
            }
        }
        .sheet(isPresented: $isFiltersPresented) {
            ProvidersFilterView()
        }.onAppear {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: pickedAddress.latitude, longitude: pickedAddress.longitude), span: .init())
        }
    }
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView(providers: .constant([]),
                      pickedAddress: .constant(Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "09")))
    }
}
#if !DEBUG

struct GoogleMapsView: UIViewRepresentable {
    private let zoom: Float = 15.0
    @ObservedObject var locationManager = LocationManager()
    
    var pickedAddress: Address
    var providers: [Address]
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: CLLocationDegrees(pickedAddress.latitude), longitude: CLLocationDegrees(pickedAddress.longitude)))
        }
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {

        if providers != [] {
            for provider in providers {
                let marker: GMSMarker = .init()
                marker.position = CLLocationCoordinate2D(latitude: provider.latitude, longitude: provider.longitude)

                marker.title = "\(provider.country)"
                marker.snippet = "\(provider.building), \(provider.street), \(provider.town)"
//                marker.snippet = "Welcome to \(provider.town)"

                marker.icon = UIImage(named: "MapSymbol")
                marker.map = mapView
            }
        }
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(pickedAddress.latitude), longitude: CLLocationDegrees(pickedAddress.longitude))
        marker.title = " \(pickedAddress.apt) \(pickedAddress.building) \(pickedAddress.street)"
        marker.snippet = "\(pickedAddress.town), \(pickedAddress.postcode)"
        marker.icon = UIImage(named: "MapPoint")
        marker.map = mapView
        mapView.selectedMarker = marker

    }
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView(pickedAddress: Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "09"), providers: [])
    }
}
#endif
