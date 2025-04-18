//
//  WorkoutDayDetailView.swift
//  Unleash
//
//  Created by Sam Toll on 2/4/25.
//

import SwiftUI
import Collections

struct WorkoutDayDetailView: View {
    @State var workoutData: Workout
    var weekNumber: Int
    var dayNumber: Int
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State var exercises: [[ProgramExercise]] = []
    @State var mainExerciseBlocks: OrderedDictionary<Int, [ProgramExercise]> = [:]
    
    @State var selectedTab: Int = 1
    
    func loadExercises(firebaseManager: FirebaseManager) {
        let exercisesIDs = workoutData.warmups + workoutData.exercises + workoutData.cooldowns
        appDataStore.getExercisesDataSeperated(firebaseManager: firebaseManager, exercises: exercisesIDs) { fetchedExercises in
            DispatchQueue.main.async {
                self.exercises = fetchedExercises
                self.getExerciseBlocks()
            }
        }
    }
    
    func getExerciseBlocks() {
        guard exercises.count > 1 else {
            mainExerciseBlocks = [:]
            return
        }

        var exerciseBlocks: OrderedDictionary<Int, [ProgramExercise]> = [:]
        
        for exercise in exercises[1] {
            if let key = exercise.exerciseGroupNumber {
                exerciseBlocks[key, default: []].append(exercise)
            }
        }
        mainExerciseBlocks = exerciseBlocks
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                SelectorView(currentSelection: $selectedTab, options: ["Warmup", "Main", "Cooldown"] )
                
                if self.exercises.isEmpty || self.mainExerciseBlocks.isEmpty {
                    Spacer()
                }
                if !self.exercises.isEmpty && !self.mainExerciseBlocks.isEmpty {
                    switch(selectedTab-1) {
                    case 0: WorkoutTypeDetailView(exerciseType: "warmup", weekNumber: weekNumber, dayNumber: dayNumber, exercises: exercises[0])
                    case 1: WorkoutTypeMainsView(weekNumber: weekNumber, dayNumber: dayNumber, exercises: exercises[1], mainExerciseBlocks: mainExerciseBlocks)
                    case 2: WorkoutTypeDetailView(exerciseType: "cooldown", weekNumber: weekNumber, dayNumber: dayNumber, exercises: exercises[2])
                        
                    default:
                        DaySelectionTableView(weekNumber: 1)
                    }
                } else {
                    ProgressView("Loading exercises...")
                }
            }
           .task {
                loadExercises(firebaseManager: firebaseManager)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(AppConfig.Styles.Colors.main_background))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("WEEK \(weekNumber) | DAY \(dayNumber)")
                        .textMenuItem()
                }
            }
        }
        .onAppear(perform: {
            loadExercises(firebaseManager: firebaseManager)
        })
    }
}
