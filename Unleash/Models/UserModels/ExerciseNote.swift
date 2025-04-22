//
//  ExerciseNote.swift
//  Unleash
//
//  Created by Rod Toll on 4/21/25.
//

import SwiftUI

class ExerciseNote: Identifiable, ObservableObject {
    init(exerciseId: String, note: String) {
        self.exerciseId = exerciseId
        self.note = note
        self.modified = false
    }
    
    var exerciseId: String
    var note: String
    var modified: Bool
    
    func setNote(note: String) {
        if self.note != note {
            self.note = note
            self.modified = true
        }
    }
    
    func clearModified() {
        self.modified = false
    }
    
    func setModified() {
        self.modified = true
    }
    
    
}
