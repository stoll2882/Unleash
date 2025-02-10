//
//  UnleashApp.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import SwiftUI
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

@main
struct UnleashApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject private var firebaseManager = FirebaseManager()
    @StateObject private var appDataStore = AppDataStorage()

    var body: some Scene {
            WindowGroup {
                SplashScreenView().environmentObject(firebaseManager).environmentObject(appDataStore)
//                ContentView().environmentObject(firebaseManager).environmentObject(appDataStore)
            }
    }
}
