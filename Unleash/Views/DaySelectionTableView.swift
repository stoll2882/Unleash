//
//  DaySelectionTableView.swift
//  Unleash
//
//  Created by Sam Toll on 2/3/25.
//

import SwiftUI

struct DaySelectionTableView: View {
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State var weekNumber: Int
    @State var selectedDay: Int = 0
    
    var body: some View {
//        Text("Week Number \(weekNumber)").bold().font(.system(size: 20))
//            .foregroundStyle(Color(AppConfig.main_off_white))
        ScrollView(.vertical) {
            VStack {
                ForEach(appDataStore.activeWorkoutProgram!.trainingWeeks[weekNumber - 1].workouts) { workout in
                    DayTableRow(workout: workout, weekNumber: weekNumber)
                        .padding(.bottom, 120)
                }
            }
        }
    }
}
