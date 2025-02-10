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
    
    var exercises: [UserExercise]
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(exercises) { exercise in
                    ExerciseBlockView(exercise: exercise, weekNumber: weekNumber, dayNumber: dayNumber)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
