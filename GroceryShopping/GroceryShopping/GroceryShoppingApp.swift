//
//  GroceryShoppingApp.swift
//  GroceryShopping
//
//  Created by Ankit Bansal on 2/5/2024.
//

import SwiftUI
import FirebaseCore

@main
struct GroceryShoppingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase connected")
        return true
    }
}
