//
//  CategoriesSectionViewModel.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation

class HomeCategoriesSectionViewModel: HomeSectionViewModel{
    var dataSource: [HomeResponseDataModel]
    var didSelectItem: ((HomeResponseDataModel) -> ())?
    
    init(_ dataSource: [HomeResponseDataModel]) {
        self.dataSource = dataSource
        super.init(.Categories)
    }
}
