//
//  SheetType.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

enum SheetType: Identifiable {
    case dataEntry(SetIndexWrapper)
    case history
    case exerciseInfo
    
    var id: String {
        switch self {
        case .dataEntry(let setIndex):
            return "dataEntry_\(setIndex.id)"
        case .history:
            return "history"
        case .exerciseInfo:
            return "exerciseInfo"
        }
    }
}
