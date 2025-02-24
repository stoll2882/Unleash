//
//  WorkoutSet.swift
//  Unleash
//
//  Created by Sam Toll on 2/8/25.
//

import Foundation

class WorkoutSet: Identifiable, ObservableObject {
    var setIndex: Int
    var weight: Double?
    var reps: Int?
    var unit: String?
    var completed: Bool?
    
    init(setIndex: Int) {
        self.setIndex = setIndex
        self.weight = nil
        self.reps = nil
        self.unit = nil
        self.completed = false
    }
    
    init(setIndex: Int, weight: Double?, reps: Int?, unit: String?, completed: Bool?) {
        self.setIndex = setIndex
        self.weight = weight
        self.reps = reps
        self.unit = unit
        self.completed = completed
    }
}

//class WorkoutSet: Identifiable, ObservableObject {
//    var id: String = UUID().uuidString
//    var setIndex: Int
//    var weight: Double?
//    var reps: Int?
//    var unit: String?
//    var week: Int?
//    var day: Int?
//    var dateCompleted: Date?
//    var completed: Bool
//    
//    init(setIndex: Int) {
//        self.setIndex = setIndex
//        self.weight = nil
//        self.reps = nil
//        self.unit = nil
//        self.completed = false
//    }
//    
//    init(setIndex: Int, weight: Double?, reps: Int?, unit: String?) {
//        self.setIndex = setIndex
//        self.weight = weight
//        self.reps = reps
//        self.unit = unit
//        self.week = nil
//        self.day = nil
//        self.completed = false
//    }
//    
//    init(setIndex: Int, weight: Double?, reps: Int?, unit: String?, week: Int?, day: Int?, dateCompleted: Date?, completed: Bool) {
//        self.setIndex = setIndex
//        self.weight = weight
//        self.reps = reps
//        self.unit = unit
//        self.week = week
//        self.day = day
//        self.dateCompleted = dateCompleted
//        self.completed = completed
//    }
//}
