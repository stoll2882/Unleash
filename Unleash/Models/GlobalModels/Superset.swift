//
//  Superset.swift
//  Unleash
//
//  Created by Sam Toll on 2/2/25.
//

import Foundation

class Superset: Identifiable, ObservableObject {
    var exercises: [Exercise]
    var numExercises: Int
    
    init(exercises: [Exercise]) {
        self.numExercises = exercises.count
        self.exercises = exercises
    }
}
