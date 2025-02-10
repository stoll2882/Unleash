//
//  ExerciseHistoryView.swift
//  Unleash
//
//  Created by Sam Toll on 2/9/25.
//

import SwiftUI

struct ExerciseHistoryView: View {
    let exerciseName: String
    let history: [WorkoutSet]
    
    @Environment(\.presentationMode) var presentationMode
    
    var groupedHistory: [String: [WorkoutSet]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"  // ✅ Format dates like "Feb 9, 2025"

        return Dictionary(grouping: history.sorted { ($0.dateCompleted ?? Date.distantPast) > ($1.dateCompleted ?? Date.distantPast) }) { set in
            dateFormatter.string(from: set.dateCompleted ?? Date.distantPast)
        }
    }

    var body: some View {
        VStack {
            Text("\(exerciseName) History")
                .font(.title)
                .bold()
                .padding()

            if history.isEmpty {
                Text("No history available.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
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
                                            .foregroundColor(.blue)
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                }
            }
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(AppConfig.main_neon_green))
                .shadow(radius: 5)
        )
        .frame(maxWidth: .infinity)
        .padding(30)
    }
}


