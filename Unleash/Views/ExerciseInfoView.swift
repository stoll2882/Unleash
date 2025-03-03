//
//  ExerciseInfoView.swift
//  Unleash
//
//  Created by Sam Toll on 3/2/25.
//

import SwiftUI
import FirebaseCore

struct ExerciseInfoView: View {
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    let exerciseName: String
    let exercise: Exercise
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("GreenInfoIcon")
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text("\(exercise.exerciseName!)")
                        .font(.custom("Nexa-Heavy", size: 25))
                        .foregroundStyle(Color(AppConfig.main_other_pink))
                        .bold()
                        .padding()
                    Spacer()
                }
                .padding(.top, 10)
                
                ScrollView {
                    Text("\(exercise.exerciseDescription!)")
                        .font(.custom("Nexa-ExtraLight", size: 18))
                        .foregroundStyle(Color(.black))
                        .bold()
                        .padding()
                }
            }
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(AppConfig.main_light_blue))
                    .shadow(radius: 5)
            )
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }
}


