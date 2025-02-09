//
//  Exercise.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class Exercise: Identifiable, ObservableObject {
    var exerciseName: String
    var reps: Int
    var sets: Int
    var rpe: Double
    var rest: String

    init(exerciseName: String, reps: Int, sets: Int, rpe: Double, rest: String) {
        self.exerciseName = exerciseName
        self.reps = reps
        self.sets = sets
        self.rpe = rpe
        self.rest = rest
    }
}
