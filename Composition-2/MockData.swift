//
//  MockData.swift
//  Composition-2
//
//  Created by Дмитрий Лоренц on 26.04.2023.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let sales: ListSection = {
        .sales([.init(title: "", imageName: "salesBurger"),
                .init(title: "", imageName: "salesPizza"),
                .init(title: "", imageName: "salesWok")])
    }()
    
    private let cathegory: ListSection = {
        .cathegory([ListItem(title: "Burger", imageName: "cathegoryBurger"),
                    .init(title: "Chicken", imageName: "cathegoryChicken"),
                    .init(title: "Hot-dog", imageName: "cathegoryHotdog"),
                    .init(title: "Pizza", imageName: "cathegoryPizza"),
                    .init(title: "Taco", imageName: "cathegoryTaco"),
                    .init(title: "Wok", imageName: "cathegoryWok") ])
    }()
    
    private let example: ListSection = {
        .example([ListItem(title: "", imageName: "burger1"),
                  .init(title: "", imageName: "burger2"),
                  .init(title: "", imageName: "burger3")])
    }()
    
    var pageData: [ListSection] {
        [sales, cathegory, example]
    }
    
}
