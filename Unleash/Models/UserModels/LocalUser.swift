//
//  LocalUser.swift
//  Unleash
//
//  Created by Sam Toll on 2/1/25.
//

import Foundation

class LocalUser: Identifiable, ObservableObject {
    init(id: String, name: String, email: String, favorites: [String]) {
        self.id = id
        self.name = name
        self.email = email
        self.favorites = favorites
    }
    var id: String
    var email: String
    @Published var name: String
    @Published var favorites: [String]
    
    static var NullUser: LocalUser = LocalUser(id:"(null)", name:"(null)", email: "(null)", favorites: [])
    
    func isNull() -> Bool {
        return (id == "(null)")
    }
}
