//
//  DayTableRow.swift
//  Unleash
//
//  Created by Sam Toll on 2/3/25.
//

import SwiftUI

struct DayTableRow: View {
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State var workout: Workout
    @State var weekNumber: Int
         
    var body: some View {
        GeometryReader { geometry in
            NavigationLink(destination: WorkoutDayDetailView(workoutData: workout, weekNumber: weekNumber, dayNumber: workout.dayNumber)) {
                ZStack {
                    Rectangle()
                        .stroke(Color(AppConfig.main_neon_green), lineWidth: 4)
                        .background(Color(AppConfig.main_neon_green))
                    HStack {
                        VStack {
                            HStack {
                                Text("Day \(workout.dayNumber)").bold().font(.system(size: 30))
                                    .foregroundStyle(Color(AppConfig.main_dark_brown))
                                Spacer()
                            }
                            HStack {
                                Text(workout.focus!).bold().font(.system(size: 20))
                                    .foregroundStyle(Color(AppConfig.main_bright_pink))
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "timer")
                                    .foregroundStyle(Color(AppConfig.main_off_white))
                                Text("60 minutes").font(.system(size: 15))
                                    .foregroundStyle(Color(AppConfig.main_off_white))
                                Spacer()
                            }
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 40, height: 30)
                                .foregroundStyle(Color(AppConfig.main_orange))
                            Spacer()
                        }
                    }
                    .padding(20)
                }
                .padding(20)
                .foregroundStyle(Color.black)
            }
            .accentColor(Color(AppConfig.main_bright_pink))
            
        }
    }
}
