//
//  Exercise.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class Exercise: Identifiable, ObservableObject {
    var exerciseID: String
    var exerciseType: String?
    var reps: String?
    var sets: String?
    var rpe: String?
    var rest: String?
    var exerciseGroupNumber: Int?

    init(exerciseID: String, exerciseType: String?, reps: String?, sets: String?, rpe: String?, rest: String?, exerciseGroupNumber: Int?) {
        self.exerciseID = exerciseID
        self.exerciseType = exerciseType
        self.reps = reps
        self.sets = sets
        self.rpe = rpe
        self.rest = rest
        self.exerciseGroupNumber = exerciseGroupNumber
    }
}
