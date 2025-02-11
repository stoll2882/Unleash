//
//  ExerciseHistoryView.swift
//  Unleash
//
//  Created by Sam Toll on 2/9/25.
//

import SwiftUI
import FirebaseCore

struct ExerciseHistoryView: View {
    @EnvironmentObject var appDataStore: AppDataStorage
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    let exerciseName: String
    let exercise: UserExercise
    @State var exerciseHistory: [WorkoutSet] = []
    
    @Environment(\.presentationMode) var presentationMode
        
    var groupedHistory: [String: [WorkoutSet]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"

        let grouped = Dictionary(grouping: exerciseHistory.sorted {
            ($0.dateCompleted ?? Date.distantPast) > ($1.dateCompleted ?? Date.distantPast)
        }) { set in
            dateFormatter.string(from: set.dateCompleted ?? Date.distantPast)
        }

        // ✅ Sort sets within each date group by `setIndex`
        return grouped.mapValues { sets in
            sets.sorted { $0.setIndex < $1.setIndex }
        }
    }
    
//    var groupedHistory: [String: [WorkoutSet]] {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy"
//
//        return Dictionary(grouping: exerciseHistory.sorted { ($0.dateCompleted ?? Date.distantPast) > ($1.dateCompleted ?? Date.distantPast) }) { set in
//            dateFormatter.string(from: set.dateCompleted ?? Date.distantPast)
//        }
//    }
    
    private func loadFullExerciseHistory() {
        let ref = firebaseManager.firestore.collection("users").document(appDataStore.activeUser.id)
            .collection("fullExerciseHistory")
            .document(exercise.exerciseID)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        ref.getDocument { document, error in
            guard let data = document?.data(), error == nil else {
                print("Error fetching full exercise history: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let fetchedSets = data["sets"] as? [[String: Any]] {
                self.exerciseHistory = fetchedSets.compactMap { dict in
                    let setIndex = dict["setIndex"] as? Int ?? -1
                    let weight = dict["weight"] as? Double ?? 0.0
                    let reps = dict["reps"] as? Int ?? 0
                    let unit = dict["unit"] as? String ?? "lb"
                    let week = dict["weekNumber"] as? Int ?? -1
                    let day = dict["dayNumber"] as? Int ?? -1
                    let completed = dict["completed"] as? Bool ?? false
                    let dateString = dict["dateCompleted"] as? Timestamp ?? nil
                     
                    let dateCompleted = dateString?.dateValue()
                    
                    return WorkoutSet(setIndex: setIndex, weight: weight, reps: reps, unit: unit, week: week, day: day, dateCompleted: dateCompleted, completed: completed)
                }
            }
        }
    }

    var body: some View {
        VStack {
            VStack {
                Text("\(exerciseName) History")
                    .font(.title)
                    .bold()
                    .padding()
                
                if exerciseHistory.isEmpty {
                    Text("No history available.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
//                    Text("History count: \(exerciseHistory.count)")
//                        .foregroundColor(.blue)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(groupedHistory.keys.sorted(by: >), id: \.self) { date in
                                VStack(alignment: .leading) {
                                    Text(date)
                                        .font(.headline)
                                        .foregroundColor(.orange)
                                        .padding(.vertical, 5)
                                    
                                    ForEach(groupedHistory[date] ?? []) { set in
                                        HStack {
                                            Text("Set \(set.setIndex + 1):")
                                                .bold()
                                            Spacer()
                                            Text("\(set.reps ?? 0) reps | \(set.weight ?? 0, specifier: "%.1f") \(set.unit ?? "")")
                                                .foregroundColor(Color(AppConfig.main_bright_pink))
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(AppConfig.main_neon_green))
                    .shadow(radius: 5)
            )
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .onAppear(perform: {
            loadFullExerciseHistory()
        })
    }
}


