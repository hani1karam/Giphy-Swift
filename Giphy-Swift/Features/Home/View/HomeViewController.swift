//
//  HomeViewController.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import UIKit

class HomeViewController: UIViewController,UIScrollViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var homeViewModel: HomeViewModelProtocol!
    var dataSource: HomeDataSource?
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeCongifurator.configHomeView(self)
        settupTableViewController()
        bind(to:homeViewModel)
        homeViewModel?.getCategories()
        title = "Home"
    }
    func settupTableViewController(){
        tableView.register(cellType: CatrogiesTableViewCell.self)
        tableView.register(cellType: SliderTableViewCell.self)
    }
    func bind(to viewModel: HomeViewModelOutput?) {
        viewModel?.loading.observe(on: self) { [weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }
        viewModel?.sectionsList.observe(on: self) { [weak self] list in
            self?.updateTableViewDataSource(list ?? [])
            if self?.homeViewModel.valueConfiguration.value == true {
                self?.tableView.isHidden = true
            }else{
                self?.tableView.isHidden = false
            }
        }
    }
    private func updateTableViewDataSource(_ list: [HomeSectionViewModel]) {
        dataSource = .init(list)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > (scrollView.contentSize.height + 5)) && !(homeViewModel.loading.value)){
            homeViewModel.getCategories()
        }
    }
}
