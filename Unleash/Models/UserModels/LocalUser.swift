//
//  LocalUser.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class LocalUser: Identifiable, ObservableObject {
    init(id: String, name: String, email: String, exerciseHistory: [ExerciseHistoryInstance], exerciseNotes: [ExerciseNote]) {
        self.id = id
        self.name = name
        self.email = email
        self.exerciseHistory = exerciseHistory
        self.exerciseNotes = exerciseNotes
    }
    var id: String
    var email: String
    var exerciseNotes: [ExerciseNote]
    
    @Published var name: String
    @Published var exerciseHistory: [ExerciseHistoryInstance]
    
    static var NullUser: LocalUser = LocalUser(id:"(null)", name:"(null)", email: "(null)", exerciseHistory: [], exerciseNotes: [])
    
    func isNull() -> Bool {
        return (id == "(null)")
    }
}
