//
//  WorkoutWeek.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class WorkoutWeek: Identifiable, ObservableObject {
    var weekNumber: Int
    var workouts: [Workout]
    
    init(weekNumber: Int, workouts: [Workout]) {
        self.weekNumber = weekNumber
        self.workouts = workouts
    }
}
