//
//  UserExercise.swift
//  Unleash
//
//  Created by Sam Toll on 2/2/25.
//

import Foundation

class UserExercise: Identifiable, ObservableObject {
    var exercise: Exercise
    var reps: Int
    var weight: Double?
    
    init(exercise: Exercise, reps: Int, weight: Double? = nil) {
        self.exercise = exercise
        self.reps = reps
        self.weight = weight
    }
}
