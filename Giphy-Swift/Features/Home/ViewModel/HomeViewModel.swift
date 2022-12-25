//
//  HomeViewModel.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation
protocol HomeViewModelOutput {
    var sectionsList: Observable<[HomeSectionViewModel]?> {get}
    var errorMessage: Observable<String?> {get}
    var loading: Observable<Bool> {get}
}

protocol HomeViewModelInput {
    var getCategoriesUseCase: HomeGiphyUseCaseProtocol {get}
    func getCategories()
}

protocol HomeViewModelProtocol: HomeViewModelInput, HomeViewModelOutput {}

class HomeViewModel: HomeViewModelProtocol{
    var sectionsList: Observable<[HomeSectionViewModel]?>
    var errorMessage: Observable<String?>
    var loading: Observable<Bool>
    var getCategoriesUseCase: HomeGiphyUseCaseProtocol
    private var page: Int
    
    internal init(sectionsList: Observable<[HomeSectionViewModel]?> = .init(nil),
                  errorMessage: Observable<String?> = .init(nil),
                  loading: Observable<Bool> = .init(false),
                  page: Int = 20,
                  getCategoriesUseCase: HomeGiphyUseCaseProtocol = HomeGiphyUseCase()){
        self.sectionsList = sectionsList
        self.errorMessage = errorMessage
        self.loading = loading
        self.page = page
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func getCategories() {
        loading.value = true
        page += 1
        getCategoriesUseCase.getRequest(page: page) { [weak self] result in
            self?.loading.value = false
            switch result {
            case .success(let response):
                if (self?.page ?? 1) > 1 {
                    self?.createSectionsList(response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createSectionsList(_ response: HomeResponseModel) {
        var sectionsList: [HomeSectionViewModel] = []
        if let sliderDataSource = response.data, !sliderDataSource.isEmpty {
            sectionsList.append(HomeSliderSectionViewModel(sliderDataSource))
        }
        
        if let categoriesList = response.data, !categoriesList.isEmpty {
            sectionsList.append(HomeCategoriesSectionViewModel(categoriesList))
        }
        self.sectionsList.value = sectionsList
    }
}
