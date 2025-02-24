//
//  WorkoutProgram.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class WorkoutProgram: Identifiable, ObservableObject {
    var trainingWeeks: [WorkoutWeek]
    
    init(trainingWeeks: [WorkoutWeek]) {
        self.trainingWeeks = trainingWeeks
    }
}
