//
//  Workout.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class Workout: Identifiable, ObservableObject {
    var dayNumber: Int
    var focus: String?
    var warmups: [Exercise]
    var exercises: [Exercise]
    var cooldowns: [Exercise]
    
    init(dayNumber: Int, focus: String?, warmups: [Exercise], exercises: [Exercise], cooldowns: [Exercise]) {
        self.dayNumber = dayNumber
        self.focus = focus
        self.warmups = warmups
        self.exercises = exercises
        self.cooldowns = cooldowns
    }
    
    init(dayNumber: Int) {
        self.dayNumber = dayNumber
        self.focus = nil
        self.warmups = []
        self.exercises = []
        self.cooldowns = []
    }
}
