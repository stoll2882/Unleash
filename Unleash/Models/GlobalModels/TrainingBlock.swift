//
//  TrainingBlock.swift
//  Unleash
//
//  Created by Sam Toll on 2/2/25.
//

import Foundation

class TrainingBlock: Identifiable, ObservableObject {
    var blockNumber: Int
    var workoutWeeks: [WorkoutWeek]
    
    init(blockNumber: Int, workoutWeeks: [WorkoutWeek]) {
        self.blockNumber = blockNumber
        self.workoutWeeks = workoutWeeks
    }
}
