//
//  WorkoutDayDetailView.swift
//  Unleash
//
//  Created by Sam Toll on 2/4/25.
//

import SwiftUI
import Collections

struct UnderlineExerciseTypePicker: View {
    @Binding var selection: Int
    let workoutTypes: [Int]
    var labels: [String]
    var width: Double
    
    var body: some View {
        HStack {
            ForEach(workoutTypes, id: \.self) { option in
                VStack {
                    Text("\(labels[option])")
                        .bold()
                        .foregroundColor(selection == option ? Color(AppConfig.main_orange) : .black)
                        .frame(width: (width/Double(workoutTypes.count) - 20.0/3.0))
                        .onTapGesture {
                            selection = option
                        }
                    if selection == option {
                        Spacer()
                        Rectangle()
                            .background(Color(AppConfig.main_orange))
                            .foregroundStyle(Color(AppConfig.main_orange))
                            .frame(height: 5)
                    }
                    if selection != option {
                        Spacer()
                    }
                }
            }
        }
        .frame(height: 30)
        .padding(.horizontal, 20)
    }
}

struct WorkoutDayDetailView: View {
    @State var workoutData: Workout
    var weekNumber: Int
    var dayNumber: Int
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State var exercises: [[UserExercise]] = []
    @State var mainExerciseBlocks: OrderedDictionary<Int, [UserExercise]> = [:]
    
    @State var selectedTab: Int = 0
    
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

        var exerciseBlocks: OrderedDictionary<Int, [UserExercise]> = [:]
        
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
                WorkoutLabel(weekNumber: weekNumber, dayNumber: dayNumber, workoutName: workoutData.focus!)
                UnderlineExerciseTypePicker(selection: $selectedTab, workoutTypes: [0,1,2], labels: ["Warmup", "Main", "Cooldown"], width: geometry.size.width)
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    .background(alignment: .bottom) {
                        Rectangle()
                            .background(Color(AppConfig.main_bright_pink))
                            .foregroundStyle(Color(AppConfig.main_bright_pink))
                            .frame(height: 5)
                            .offset(y: -10)
                    }
                    .padding(.bottom, 20)
                if self.exercises.isEmpty || self.mainExerciseBlocks.isEmpty {
                    Spacer()
                }
                if !self.exercises.isEmpty && !self.mainExerciseBlocks.isEmpty {
                    switch(selectedTab) {
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
            .background(Color(AppConfig.main_mint_green))
           .task {
                loadExercises(firebaseManager: firebaseManager)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(AppConfig.main_mint_green))
        }
        .onAppear(perform: {
            loadExercises(firebaseManager: firebaseManager)
        })
    }
}
