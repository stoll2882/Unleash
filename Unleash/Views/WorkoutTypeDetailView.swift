//
//  WorkoutTypeDetailView.swift
//  Unleash
//
//  Created by Sam Toll on 2/8/25.
//

import SwiftUI

struct WorkoutTypeDetailView: View {
    var exerciseType: String
    var weekNumber: Int
    var dayNumber: Int
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var exercises: [ProgramExercise]
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(exercises) { exercise in
                    ExerciseBlockView(exercise: exercise, padding: 20, weekNumber: weekNumber, dayNumber: dayNumber)
                        .padding(.bottom, 10)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
