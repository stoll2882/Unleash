//
//  Workout.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class Workout: Identifiable, ObservableObject {
    var complete: Bool
    var dayNumber: Int
    var focus: String?
    var warmups: [ProgramExercise]
    var exercises: [ProgramExercise]
    var cooldowns: [ProgramExercise]
    
    init(dayNumber: Int, focus: String?, warmups: [ProgramExercise], exercises: [ProgramExercise], cooldowns: [ProgramExercise], complete: Bool) {
        self.dayNumber = dayNumber
        self.focus = focus
        self.warmups = warmups
        self.exercises = exercises
        self.cooldowns = cooldowns
        self.complete = complete
    }
    
    init(dayNumber: Int) {
        self.dayNumber = dayNumber
        self.focus = nil
        self.warmups = []
        self.exercises = []
        self.cooldowns = []
        self.complete = false
    }
}
