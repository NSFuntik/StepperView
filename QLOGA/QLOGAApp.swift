//
//  QLOGAApp.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

#if DEBUG

#else
import GoogleMaps

import GooglePlaces
#endif

@main
struct QLOGAApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            IntroView()
                .environment(\.colorScheme, .light)
                .preferredColorScheme(.light)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if !DEBUG

        GMSServices.provideAPIKey("AIzaSyAbIJ7itdp7QalU2jYGZG6C5MV1rNZN0L8")
        GMSPlacesClient.provideAPIKey("AIzaSyAbIJ7itdp7QalU2jYGZG6C5MV1rNZN0L8")
#endif
        return true
    }
}

