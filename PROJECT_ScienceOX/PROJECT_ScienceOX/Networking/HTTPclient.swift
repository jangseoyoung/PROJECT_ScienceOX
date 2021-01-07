//
//  HTTPclient.swift
//  PROJECT_ScienceOX
//
//  Created by 장서영 on 2021/01/02.
//

import Foundation
import Alamofire

protocol HTTPClientProvider {
    func get(_ api: NetworkingAPI) -> DataRequest
    func post(_ api: NetworkingAPI) -> DataRequest
}

class HTTPClient: HTTPClientProvider {
    
    let baseip = "http://10.156.147.203:1"
    
    func get(_ api: NetworkingAPI) -> DataRequest {
//        print(baseip + api.path)
//        print(api.parameters)
//        print(api.headers)
        
        return AF.request(baseip + api.path, method: .get, parameters: api.parameters, encoding: JSONEncoding.prettyPrinted,
                          headers: api.headers, interceptor: nil)
    }
    
    func post(_ api: NetworkingAPI) -> DataRequest {
//        print(baseip + api.path)
//        print(api.parameters)
//        print(api.headers)
        
        return AF.request(baseip + api.path, method: .post, parameters: api.parameters, encoding: JSONEncoding.prettyPrinted,
                          headers: api.headers, interceptor: nil)
    }
    
    
    
}
