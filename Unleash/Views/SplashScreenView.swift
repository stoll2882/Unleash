//
//  SplashScreenView.swift
//  Unleash
//
//  Created by Sam Toll on 2/5/25.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @EnvironmentObject var appDataStore: AppDataStorage
    
    var body: some View {
        ContentView()
            .environmentObject(firebaseManager)
            .environmentObject(appDataStore)
    }
}
