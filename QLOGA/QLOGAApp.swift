//
//  QLOGAApp.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

#if targetEnvironment(simulator)

#else
import GoogleMaps

import GooglePlaces
#endif

@main
struct QLOGAApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
#if DEBUG
            ActorTypePickerView()
                .environment(\.colorScheme, .light)
                .preferredColorScheme(.light)
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
                    AppDelegate.orientationLock = .portrait // And making sure it stays that way
                }
#else
            IntroView()
//            ActorTypePickerView()
                .environment(\.colorScheme, .light)
                .preferredColorScheme(.light)
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
                    AppDelegate.orientationLock = .portrait // And making sure it stays that way
                }

#endif

        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if !targetEnvironment(simulator)

        GMSServices.provideAPIKey("AIzaSyAbIJ7itdp7QalU2jYGZG6C5MV1rNZN0L8")
        GMSPlacesClient.provideAPIKey("AIzaSyAbIJ7itdp7QalU2jYGZG6C5MV1rNZN0L8")
#endif
        return true
    }


        static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely

        func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return AppDelegate.orientationLock
        }
}

