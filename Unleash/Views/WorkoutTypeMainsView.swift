//
//  WorkoutTypeMainsView.swift
//  Unleash
//
//  Created by Sam Toll on 2/8/25.
//

import SwiftUI
import Collections

struct WorkoutTypeMainsView: View {
    var weekNumber: Int
    var dayNumber: Int
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State var exercises: [UserExercise]
    @State var mainExerciseBlocks: OrderedDictionary<Int, [UserExercise]>
    
    func getExerciseBlocks() {
        DispatchQueue.main.async {
            guard exercises.count > 1 else {
                mainExerciseBlocks = [:]
                return
            }
            
            var exerciseBlocks: OrderedDictionary<Int, [UserExercise]> = [:]
            
            for exercise in exercises {
                if let key = exercise.exerciseGroupNumber {
                    exerciseBlocks[key, default: []].append(exercise)
                }
            }
            self.mainExerciseBlocks = exerciseBlocks
        }
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(mainExerciseBlocks.keys, id: \.self) { key in
                    VStack {
                        if let exercises = mainExerciseBlocks[key], exercises.count > 1 {
                            HStack {
                                Text("SUPERSET")
                                    .font(.system(size: 16))
                                    .bold()
                                Spacer()
                            }
                        }
                        ForEach(mainExerciseBlocks[key] ?? [], id: \.exerciseID) { exercise in
                            ExerciseBlockView(exercise: exercise, weekNumber: weekNumber, dayNumber: dayNumber)
                        }
                    }
                    .padding(10)
                    .border(Color(AppConfig.main_neon_green), width: 3)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
