//
//  WorkoutProgram.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class WorkoutProgram: Identifiable, ObservableObject {
//    var trainingBlocks: [TrainingBlock]
    var trainingWeeks: [WorkoutWeek]
    
    init(trainingWeeks: [WorkoutWeek]) {
        self.trainingWeeks = trainingWeeks
    }
    
//    init(trainingBlocks: [TrainingBlock]) {
//        self.numBlocks = trainingBlocks.count
//        self.trainingBlocks = trainingBlocks
//    }
}
