//
//  LocalUser.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation
// exercises: {
//   "id": {
//      "1,1": [25,20,15],
//      "2,1": [25,25,20],
//      "3,2": [30,30,25]
//   }
// }

class LocalUser: Identifiable, ObservableObject {
    init(id: String, name: String, email: String, exercises: [String: [String: [Double]]]) {
        self.id = id
        self.name = name
        self.email = email
        self.exercises = exercises
    }
    var id: String
    var email: String
    
    @Published var name: String
    @Published var exercises: [String: [String: [Double]]]
    
    static var NullUser: LocalUser = LocalUser(id:"(null)", name:"(null)", email: "(null)", exercises: [:])
    
    func isNull() -> Bool {
        return (id == "(null)")
    }
}
