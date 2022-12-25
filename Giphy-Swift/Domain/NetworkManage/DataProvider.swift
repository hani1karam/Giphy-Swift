//
//  DataProvider.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation
protocol DataProviderProtocol {
    func sentRequest<ResponseType: Codable> (request: RequestProtocol, mapResponseOnType: ResponseType.Type, successHandler: @escaping (ResponseType) -> Void, failureHandler: @escaping (Error) -> Void)
}
