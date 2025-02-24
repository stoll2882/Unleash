//
//  ProgramExercise.swift
//  Unleash
//
//  Created by Sam Toll on 2/22/25.
//

import Foundation

class ProgramExercise: Exercise {
//    var exerciseID: String
    var exerciseType: String?
    var reps: String?
    var sets: String?
    var rpe: String?
    var rest: String?
    var exerciseGroupNumber: Int?

    init(exerciseID: String, exerciseName: String?, exerciseDescription: String?, exerciseVideoURL: String?, exerciseType: String?, reps: String?, sets: String?, rpe: String?, rest: String?, exerciseGroupNumber: Int?) {
        self.exerciseType = exerciseType
        self.reps = reps
        self.sets = sets
        self.rpe = rpe
        self.rest = rest
        self.exerciseGroupNumber = exerciseGroupNumber
        super.init(exerciseID: exerciseID, exerciseName: exerciseName, exerciseDescription: exerciseDescription, exerciseVideoURL: exerciseVideoURL)
    }
}
