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
    
    @State var exercises: [ProgramExercise]
    @State var mainExerciseBlocks: OrderedDictionary<Int, [ProgramExercise]>
    
    func getExerciseBlocks() {
        DispatchQueue.main.async {
            guard exercises.count > 1 else {
                mainExerciseBlocks = [:]
                return
            }
            
            var exerciseBlocks: OrderedDictionary<Int, [ProgramExercise]> = [:]
            
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
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    ForEach(mainExerciseBlocks.keys, id: \.self) { key in
                        VStack {
                            if let exercises = mainExerciseBlocks[key], exercises.count > 1 {
                                HStack {
                                    Rectangle()
                                        .background(Color(AppConfig.main_other_pink))
                                        .foregroundStyle(Color(AppConfig.main_other_pink))
                                        .frame(width: 5)
                                        .zIndex(10.0)
//                                        .padding(.leading, 10)
                                    VStack {
                                        HStack {
                                            Text("SUPERSET")
                                                .font(.custom("Nexa-Heavy", size: 25))
                                                .foregroundStyle(Color(AppConfig.main_other_pink))
                                                .bold()
                                            Spacer()
                                        }
//                                        .padding(.leading, -10)
                                        ForEach(mainExerciseBlocks[key] ?? [], id: \.exerciseID) { exercise in
                                            ExerciseBlockView(exercise: exercise, padding: 5, weekNumber: weekNumber, dayNumber: dayNumber)
                                                .zIndex(-10.0)
                                        }
                                    }
                                }
                                .padding(.top, 20)
                                .padding(.leading, 20)
                                .padding(.bottom, 20)
                            } else {
                                ForEach(mainExerciseBlocks[key] ?? [], id: \.exerciseID) { exercise in
                                    ExerciseBlockView(exercise: exercise, padding: 20, weekNumber: weekNumber, dayNumber: dayNumber)
                                }
                            }
                        }
                        .background(Color(AppConfig.main_light_blue))
                        .frame(width: geometry.size.width - 40)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom, 10)
                    }
                }
                .padding(.leading, 20)
            }
        }
    }
}
