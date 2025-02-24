//
//  Exercise.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class Exercise: Identifiable, ObservableObject {
    var exerciseID: String
    var exerciseName: String?
    var exerciseDescription: String?
    var exerciseVideoURL: String?

    init(exerciseID: String, exerciseName: String?, exerciseDescription: String?, exerciseVideoURL: String?) {
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.exerciseDescription = exerciseDescription
        self.exerciseVideoURL = exerciseVideoURL
    }
}

//
//  Exercise.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

//import Foundation
// 
//class Exercise: Identifiable, ObservableObject {
//    var exerciseID: String
//    var exerciseDescription: String
//    var exerciseName: String
//    var exerciseVideoURL: String
//    
//    init(exerciseID: String, exerciseDescription: String, exerciseName: String, exerciseVideoURL: String) {
//        self.exerciseID = exerciseID
//        self.exerciseDescription = exerciseDescription
//        self.exerciseName = exerciseName
//        self.exerciseVideoURL = exerciseVideoURL
//    }
//}
