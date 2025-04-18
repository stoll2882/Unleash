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
    
    private func checkForCompletion() -> Bool {
        let exerciseIds = Set((workout.exercises + workout.warmups + workout.cooldowns).map { "\($0.exerciseID)_week\(weekNumber)_day\(workout.dayNumber)" })
        let historyIds = Set(appDataStore.activeUser.exerciseHistory.map { $0.id })
        
        return exerciseIds.isSubset(of: historyIds)
    }
    
    var body: some View {
        NavigationLink(destination: WorkoutDayDetailView(workoutData: workout, weekNumber: weekNumber, dayNumber: workout.dayNumber)) {
            HStack {
                VStack {
                    HStack {
                        Text("Day \(workout.dayNumber)").bold()
                            .textDayTitle()
                        Spacer()
                    }
                    .padding(.bottom, -10)
                    HStack {
                        Text(workout.focus!)
                            .textMain()
                        Spacer()
                    }
                    .padding(.bottom, -3)
                }
                .frame(alignment: .leading)
                .layoutPriority(1)
                VStack {
                    Spacer()
                    if checkForCompletion() {
                        Image("Complete")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(AppConfig.Styles.Colors.main_dark_blue))
                    } else {
                        Image("Incomplete")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(AppConfig.Styles.Colors.main_dark_blue))
                    }
                    Spacer()
                }
                .frame(width: 40, alignment: .trailing)
                .layoutPriority(0)
            }
            .padding(15)
        }
        .background(Color(AppConfig.Styles.Colors.main_light_blue))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 10)
    }
}
