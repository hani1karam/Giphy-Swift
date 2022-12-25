//
//  HomeDataSource.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import UIKit

class HomeDataSource: NSObject {
    private var dataSource: [HomeSectionViewModel]
    init(_ dataSource: [HomeSectionViewModel]){
        self.dataSource = dataSource
    }
}
extension HomeDataSource: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource[section].type {
        case .Slider:
            return 1
        case .Categories:
            let sectionViewModel = dataSource[section] as! HomeCategoriesSectionViewModel
            return sectionViewModel.dataSource.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section].type {
        case .Slider:
            return getCellOfSliderSection(tableView, indexPath: indexPath)
        case .Categories:
            return getCellOfCategoriesSection(tableView, indexPath: indexPath)
        }
    }
    private func getCellOfSliderSection(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SliderTableViewCell.className, for: indexPath) as! SliderTableViewCell
        guard let sectionViewModel = dataSource[indexPath.section] as? HomeSliderSectionViewModel else {return UITableViewCell()}
        cell.fillData(list: sectionViewModel.dataSource)
        return cell
    }
    
    private func getCellOfCategoriesSection(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatrogiesTableViewCell.className, for: indexPath) as! CatrogiesTableViewCell
        guard let sectionViewModel = dataSource[indexPath.section] as? HomeCategoriesSectionViewModel else {return UITableViewCell()}
        cell.config(with: sectionViewModel.dataSource[indexPath.row])
        return cell
    }
}
