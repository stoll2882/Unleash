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
    @State private var isActive: Bool = false
    
    var body: some View {
        if self.isActive {
            ContentView() // Your main app view
        } else {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .background(Color(AppConfig.main_background))
                        .foregroundStyle(Color(AppConfig.main_background))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    Image("UnleashOrange")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 80)
                }
                .background(Color(AppConfig.main_neon_green))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
