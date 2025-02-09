//
//  WorkoutProgram.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class WorkoutProgram: Identifiable, ObservableObject {
    var numWeeks: Int
    var workoutWeeks: [WorkoutWeek]
    
    init(numWeeks: Int, workoutWeeks: [WorkoutWeek]) {
        self.numWeeks = numWeeks
        self.workoutWeeks = workoutWeeks
    }
}
