//
//  HomeViewModel.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation
import FirebaseRemoteConfig

protocol HomeViewModelOutput {
    var sectionsList: Observable<[HomeSectionViewModel]?> {get}
    var errorMessage: Observable<String?> {get}
    var valueConfiguration: Observable<Bool?> {get}
    var loading: Observable<Bool> {get}
}

protocol HomeViewModelInput {
    var getCategoriesUseCase: HomeGiphyUseCaseProtocol {get}
    func getCategories()
}

protocol HomeViewModelProtocol: HomeViewModelInput, HomeViewModelOutput {}

class HomeViewModel: HomeViewModelProtocol{
    var valueConfiguration: Observable<Bool?>
    var sectionsList: Observable<[HomeSectionViewModel]?>
    var errorMessage: Observable<String?>
    var loading: Observable<Bool>
    var getCategoriesUseCase: HomeGiphyUseCaseProtocol
    private var page: Int
    private let remoteConfigValue = RemoteConfig.remoteConfig()
    
    internal init(sectionsList: Observable<[HomeSectionViewModel]?> = .init(nil),
                  errorMessage: Observable<String?> = .init(nil),
                  loading: Observable<Bool> = .init(false),
                  page: Int = 20,
                  valueConfiguration: Observable<Bool?> = .init(false),
                  getCategoriesUseCase: HomeGiphyUseCaseProtocol = HomeGiphyUseCase()){
        self.sectionsList = sectionsList
        self.errorMessage = errorMessage
        self.loading = loading
        self.page = page
        self.getCategoriesUseCase = getCategoriesUseCase
        self.valueConfiguration = valueConfiguration
    }
    
    func getCategories() {
        loading.value = true
        page += 1
        getCategoriesUseCase.getRequest(page: page) { [weak self] result in
            self?.loading.value = false
            switch result {
            case .success(let response):
                self?.remoteConfig()
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
    private func remoteConfig(){
        let deafults:[String:NSObject] = [
            "shows_new_ui":false as NSObject
        ]
        remoteConfigValue.setDefaults(deafults)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfigValue.configSettings = settings
        self.remoteConfigValue.fetch(withExpirationDuration: 0) {[weak self] status, error in
            if status == .success , error == nil {
                self?.remoteConfigValue.activate(completion:{ status,error in
                    guard  error == nil else {return}
                    let value = self?.remoteConfigValue.configValue(forKey: "shows_new_ui").boolValue
                    self?.valueConfiguration.value = value
                })
            }else{
                print("error")
            }
        }
    }
}
