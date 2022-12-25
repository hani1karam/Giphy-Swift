//
//  HomeSectionType.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation

enum HomeSectionType {
    case Slider
    case Categories
}
class HomeSectionViewModel {
    var type: HomeSectionType
    init(_ type: HomeSectionType) {
        self.type = type
    }
}
