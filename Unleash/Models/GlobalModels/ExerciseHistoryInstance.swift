//
//  ExerciseHistoryInstance.swift
//  Unleash
//
//  Created by Sam Toll on 2/22/25.
//

import Foundation

class ExerciseHistoryInstance: Identifiable, ObservableObject {
    var id: String
    var weekNumber: Int?
    var dayNumber: Int?
    var exerciseId: String?
    var completed: Bool?
    var dateCompleted: Date?
    var sets: [WorkoutSet]?
    
    init(id: String, exerciseId: String?, weekNumber: Int?, dayNumber: Int?, completed: Bool?, dateCompleted: Date?, sets: [WorkoutSet]?) {
        self.id = id
        self.exerciseId = exerciseId
        self.weekNumber = weekNumber
        self.dayNumber = dayNumber
        self.completed = completed
        self.dateCompleted = dateCompleted
        self.sets = sets
    }
}
