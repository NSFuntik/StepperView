//
//  QLOGAApp.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

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
        GMSServices.provideAPIKey("AIzaSyAbIJ7itdp7QalU2jYGZG6C5MV1rNZN0L8")
        GMSPlacesClient.provideAPIKey("AIzaSyAbIJ7itdp7QalU2jYGZG6C5MV1rNZN0L8")

        return true
    }
}

