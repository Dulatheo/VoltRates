//
//  APIRouter.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {
    
    case history(RateRequest)
    
    
    //MARK: ------HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .history:
            return .get
        }
    }
    
    //MARK: ------Path
    private var path: String {
        switch self {
        case .history:
            return "/history"
        }
        
    }
    
    //MARK: ------Parameters
    private var parameters: [String:Any]? {
        switch self {
        case .history(let request):
            return request.dictionary
        }
    }

    //MARK: ------URLRequest - HEADERS
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl().asURL()
        
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}


