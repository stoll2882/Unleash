//
//  Workout.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class Workout: Identifiable, ObservableObject {
    var dayNumber: Int
    var warmups: [Exercise]
    var exercises: [Exercise]
    var cooldowns: [Exercise]
    
    init(dayNumber: Int, warmups: [Exercise], exercises: [Exercise], cooldowns: [Exercise]) {
        self.dayNumber = dayNumber
        self.warmups = warmups
        self.exercises = exercises
        self.cooldowns = cooldowns
    }
}
