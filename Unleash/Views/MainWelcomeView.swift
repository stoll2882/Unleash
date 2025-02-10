//
//  MainWelcomeView.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import SwiftUI
import AVKit

struct MainWelcomeView: View {
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        GeometryReader { geometry in
            if appDataStore.activeWorkoutProgram != nil && !appDataStore.activeUser.isNull() { 
                NavigationView {
                    VStack {
                        ZStack {
                            Rectangle()
                                .background(Color(AppConfig.main_neon_green))
                                .foregroundStyle(Color(AppConfig.main_neon_green))
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: geometry.size.width, height: 50)
                            Image("UnleashLogoSmall")
                                .resizable()
                                .frame(width: 200, height: 50)
                                .padding(.horizontal, 50)
                        }
                        .frame(alignment: .top)
                        Spacer()
                        ZStack {
                            VStack {
                                Spacer()
                                Text("Welcome, \(appDataStore.activeUser.name)")
                                    .bold()
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30))
                                    .padding(.bottom, 10)
                                Text("14 WEEK PROGRAM")
                                    .bold()
                                    .foregroundStyle(.white)
                                    .font(.system(size: 22))
                                    .padding(.bottom, 10)
                                NavigationLink(destination: WeekSelectionView(trainingWeeks: appDataStore.activeWorkoutProgram!.trainingWeeks)) {
                                    Text("START PROGRAM")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color(AppConfig.main_orange)) // Button color
                                        .cornerRadius(10)
                                }
                                .padding(.bottom, 5)
                                Button {
                                    do {
                                        try firebaseManager.auth.signOut()
                                    } catch {
                                        print("Error signing out")
                                    }
                                } label: {
                                    Text("LOGOUT")
                                        .foregroundStyle(Color(AppConfig.main_bright_pink))
                                        .padding(5)
                                        .underline()
                                }
                                .background(.clear)
                                .cornerRadius(20)
                            }
                            .padding(.bottom, 20)
                        }
                        .background(content: {
                            // Background Image - Fills the entire screen
                            Image("KarlieMainTall") // Replace with your image name in Assets.xcassets
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(20)
//                                .edgesIgnoringSafeArea(.all)
                        })
                        .frame(maxWidth: geometry.size.width - 40, alignment: .bottom)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color(AppConfig.main_neon_green))
                }
                .accentColor(Color(AppConfig.main_bright_pink))
            } else {
                ProgressView()
            }
        }
    }
}
