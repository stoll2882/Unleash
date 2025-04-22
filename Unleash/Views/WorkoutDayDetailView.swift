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
    
    @State private var showFullTimer = false
    @State private var timerOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0

    let collapsedHeight: CGFloat = 60
    let expandedHeight: CGFloat = 250

    @State private var timer: Timer? = nil
    @State private var startTime: Date = Date()
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning: Bool = true
    
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
    
    func startWorkoutTimer() {
        startTime = Date()
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime = Date().timeIntervalSince(startTime)
        }
    }

    func stopWorkoutTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }

    func resetWorkoutTimer() {
        stopWorkoutTimer()
        elapsedTime = 0
        startWorkoutTimer()
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
            .overlay(alignment: .bottom) {
                VStack(spacing: 10) {
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 40, height: 5)
                        .padding(.top, 10)
                    
                    VStack(spacing: 10) {
                        if showFullTimer {
                            Image("GreenTimer2")
                                .resizable()
                                .foregroundStyle(Color(AppConfig.Styles.Colors.main_other_pink))
                                .frame(width: 120, height: 140)
                                .padding(10)
//                            Text("Workout Timer")
//                                .font(.custom("Nexa-Bold", size: 18))

                            Text(formatTime(elapsedTime))
                                .font(.system(size: 32, weight: .bold, design: .monospaced))

//                            HStack {
//                                Button(action: {
//                                    isTimerRunning ? stopWorkoutTimer() : startWorkoutTimer()
//                                }) {
//                                    Text(isTimerRunning ? "Pause" : "Resume")
//                                        .padding()
//                                        .background(Color.green)
//                                        .foregroundColor(.white)
//                                        .cornerRadius(10)
//                                }
//
//                                Button(action: {
//                                    resetWorkoutTimer()
//                                }) {
//                                    Text("Reset")
//                                        .padding()
//                                        .background(Color.red)
//                                        .foregroundColor(.white)
//                                        .cornerRadius(10)
//                                }
//                            }
                        } else {
                            HStack {
                                Image("GreenTimer2")
                                    .resizable()
                                    .foregroundStyle(Color(AppConfig.Styles.Colors.main_other_pink))
                                    .frame(width: 21, height: 25)
                                    .padding(10)
//                                Image("GreenTimer")
//                                    .resizable()
//                                    .foregroundStyle(Color(AppConfig.Styles.Colors.main_other_pink))
//                                    .frame(width: 25, height: 21)
//                                    .padding(.trailing, 10)
//                                Text("\(formatTime(elapsedTime))")
//                                    .font(.custom("Nexa-Bold", size: 16))
//                                    .foregroundColor(AppConfig.Styles.Colors.main_neon_green)
//                                Spacer()
                            }
                            .padding(.horizontal)
                            .frame(height: collapsedHeight)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: showFullTimer ? expandedHeight : collapsedHeight)
                    .background(AppConfig.Styles.Colors.main_other_pink)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation.height
                            }
                            .onEnded { value in
                                withAnimation {
                                    if value.translation.height < -50 {
                                        showFullTimer = true
                                    } else if value.translation.height > 50 {
                                        showFullTimer = false
                                    }
                                }
                            }
                    )
                    .offset(y: dragOffset)
                }
                .padding()
            }
        }
        .onAppear(perform: {
            loadExercises(firebaseManager: firebaseManager)
            startWorkoutTimer()
        })
    }
}
