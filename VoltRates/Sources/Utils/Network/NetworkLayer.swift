//
//  NetworkLayer.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import Alamofire

class NetworkLayer {
    static let shared = NetworkLayer()
    
    func request<T:Decodable>(route: APIRouter, _ success: @escaping (T?) -> Void, _ failure: @escaping (Error?) -> Void) {
        Alamofire.request(route)
            .responseJSON { (response) in

                if response.response?.statusCode == 200 && response.result.value == nil {
                    success(nil)
                    return
                }
                
                switch response.result {
                case .success:
                    //----LOGGING----
                    self.log(route, response)
                    
                    guard let data = response.data else {
                        failure(response.error!)
                        return
                    }
                    
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        success(object)
                        return
                    }catch{
                        success(nil)
                        return
                    }
                    
                case .failure:
                    //----LOGGING----
                    self.log(route, response)
                    
                    failure(response.error)
                    return
                }
        }
    }
}

extension NetworkLayer {
    func log(_ route:URLRequestConvertible, _ response:DataResponse<Any>) {
        print("------------------START REQUEST---------------------------")
        print("-> URL REQUEST: ", route.urlRequest?.url?.absoluteString ?? "")
        print("-> API HEADERS: ", route.urlRequest?.allHTTPHeaderFields?.toData()?.prettyPrintedJSONString ?? "")
        print("-> METHOD: ", route.urlRequest?.httpMethod ?? "")
        if let body = route.urlRequest?.httpBody {
            print("-> API BODY: ", body.prettyPrintedJSONString ?? "")
        }
        print("<- STATUS CODE: ", response.response?.statusCode ?? "")
        
        if let urlResponseString = route.urlRequest?.url?.absoluteString {
            print("<- RESPONSE FROM URL: ", urlResponseString)
        }
        if let header = response.response?.allHeaderFields as? [String:Any] {
            print("<- RESPONSE HEADER: ", header.toData()?.prettyPrintedJSONString ?? "")
        }
        print("<- RESPONSE: ", response.data?.prettyPrintedJSONString ?? "")
        print("------------------END REQUEST----------------------------")
    }
}
