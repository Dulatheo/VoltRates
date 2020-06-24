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
    
    case latest(base: CurrencyType, currencies: [CurrencyType])
    
    
    //MARK: ------HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    //MARK: ------Path
    private var path: String {
        switch self {
        case .latest:
            return "/latest"
        }
        
    }
    
    //MARK: ------Parameters
    private var parameters: [String:Any]? {
        switch self {
        case .latest(base: let base, currencies: let currencies):
            var params = [String:Any]()
            var array: [String] = []
            currencies.forEach {
                array.append($0.rawValue)
            }
            params["symbols"] = array.joined(separator: ",")
            params["base"] = base.rawValue
            return params
        }
    }

    //MARK: ------URLRequest - HEADERS
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl().asURL()
        
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .patch, .delete:
                return URLEncoding.default
            default:
                return URLEncoding.httpBody
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}


