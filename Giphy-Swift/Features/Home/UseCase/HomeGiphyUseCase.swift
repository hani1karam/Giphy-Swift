//
//  HomeGiphyUseCase.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation
protocol HomeGiphyUseCaseProtocol {
    func getRequest(
        page: Int,
        completionHandler: @escaping((Result<HomeResponseModel, Error>) -> ()))
}
class HomeGiphyUseCase: HomeGiphyUseCaseProtocol {
    private let serviceLogic: DataProviderProtocol
    
    internal init(serviceLogic: DataProviderProtocol = APIClient()) {
        self.serviceLogic = serviceLogic
    }
    
    func getRequest(page: Int, completionHandler: @escaping ((Result<HomeResponseModel, Error>) -> ())) {
        let placesRequest = SimpleGetRequest(url: "https://api.giphy.com/v1/gifs/trending?api_key=Ar4n9X5e98UlABp4o7hQNv9sLbkwA9mV&limit=\(page)&rating=pg",parameters: nil, method: .get)
        self.serviceLogic.sentRequest(request: placesRequest, mapResponseOnType: HomeResponseModel.self, successHandler: { response in
            completionHandler(self.getResultFromOffersResponse(response))
        }, failureHandler: { err in
            
        })
    }
    
    private func getResultFromOffersResponse(_ response: Any) -> Result<HomeResponseModel, Error> {
        guard let mappedResponse = response as? HomeResponseModel else {return .failure(Error.self as! Error)}
        
        if let data = mappedResponse.data, data.count > 0 {
            return getNonEmptyOffers(mappedResponse)
        }else {
            return .failure(Error.self as! Error)
        }
    }
    
    private func getNonEmptyOffers(_ mappedResponse: HomeResponseModel) -> Result<HomeResponseModel, Error> {
        if let data = mappedResponse.data, !data.isEmpty {
            return .success(mappedResponse)
        }else {
            return .failure(Error.self as! Error)
        }
    }
}
