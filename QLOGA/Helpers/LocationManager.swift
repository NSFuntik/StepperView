//
//  LocationManager.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()


    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }

    
    var latitude: CLLocationDegrees {
        return location?.coordinate.latitude ?? 0
    }

    var longitude: CLLocationDegrees {
        return location?.coordinate.longitude ?? 0
    }

    override init() {
        super.init()

        locationManager.delegate = self
        let manager = CLLocationManager()
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        case .notDetermined, .denied ,.restricted:
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        @unknown default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // 4
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}
