//
//  ListSection.swift
//  Composition-2
//
//  Created by Дмитрий Лоренц on 26.04.2023.
//

import Foundation
enum ListSection {
    case sales([ListItem])
    case cathegory ([ListItem])
    case example([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .sales(let array):
            return array
        case .cathegory(let array):
            return array
        case .example(let array):
            return array
        }
    }
    var count: Int {
        items.count
    }
    var title: String {
        switch self {
        case .sales(_):
            return "Sales"
        case .cathegory(_):
            return "Cathegory"
        case .example(_):
            return "Example"
        }
    }
}
