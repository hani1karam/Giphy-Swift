//
//  RequestManager.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import Foundation
import Alamofire

public protocol RequestProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters { get }
}

extension RequestProtocol {
    var headers: HTTPHeaders { return ["Content-Type" : "application/json"]}
    var parameters: Parameters { return [:] }
}

class SimpleGetRequest: RequestProtocol {
    var method: HTTPMethod
    var url: String
    var parameters: Parameters?
    
    required init(url: String, parameters: Parameters?,method:HTTPMethod?) {
        self.url = url
        self.parameters = parameters
        self.method = method ?? .get
    }
}
