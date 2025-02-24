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
                                .background(Color(AppConfig.main_background))
                                .foregroundStyle(Color(AppConfig.main_background))
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: geometry.size.width, height: 50)
                            Image("UnleashOrange")
                                .resizable()
                                .frame(width: 250, height: 50)
                                .padding(.horizontal, 50)
                        }
                        .frame(alignment: .top)
                        Spacer()
                        ZStack {
                            VStack {
                                Spacer()
//                                Text("Welcome, \(appDataStore.activeUser.name)")
//                                    .bold()
//                                    .foregroundStyle(.white)
//                                    .font(.system(size: 30))
//                                    .padding(.bottom, 10)
                                Text("14 WEEK PROGRAM")
                                    .bold()
                                    .foregroundStyle(.white)
                                    .font(.custom("Nexa-Heavy", size: 25))
                                    .padding(.bottom, 10)
                                CircularCompletionBar(progress: appDataStore.calculateProgramCompletion())
//                                Button {
//                                    do {
//                                        try firebaseManager.auth.signOut()
//                                    } catch {
//                                        print("Error signing out")
//                                    }
//                                } label: {
//                                    Text("LOGOUT")
//                                        .foregroundStyle(Color(AppConfig.main_bright_pink))
//                                        .padding(5)
//                                        .underline()
//                                }
//                                .background(.clear)
//                                .cornerRadius(20)
                            }
                            .padding(.bottom, 20)
                        }
                        .background(content: {
                            // Background Image - Fills the entire screen
                            Image("KarlieMainColored") // Replace with your image name in Assets.xcassets
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width - (40), height: geometry.size.height - 130)
                                .cornerRadius(20)
                                .clipped()
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
//                                .edgesIgnoringSafeArea(.all)
                        })
                        .frame(maxWidth: geometry.size.width - 40, alignment: .bottom)
                        NavigationLink(destination: WeekSelectionView(trainingWeeks: appDataStore.activeWorkoutProgram!.trainingWeeks)) {
                            Text("START PROGRAM")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(AppConfig.main_other_pink)) // Button color
                                .cornerRadius(10)
                                .frame(minWidth: geometry.size.width - (40))
                        }
                        .frame(minWidth: geometry.size.width - (40))
                        .padding(.bottom, 5)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color(AppConfig.main_background))
                }
                .background(Color(AppConfig.main_background))
                .accentColor(Color(AppConfig.main_neon_green))
            } else {
                ProgressView()
            }
        }
    }
}
