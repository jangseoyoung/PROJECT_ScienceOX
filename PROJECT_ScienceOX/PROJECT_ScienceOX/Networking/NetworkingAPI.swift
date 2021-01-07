//
//  NetworkingAPI.swift
//  PROJECT_ScienceOX
//
//  Created by 장서영 on 2021/01/02.
//

import Foundation
import Alamofire

enum NetworkingAPI{
    case ProvideQuiz(_ question : String)
    case Check(_ correct : String)
    
    var path : String{
        switch self {
        case .ProvideQuiz:
            return "/question"
        case .Check:
            return "/question/check?id=1&answer=1"
        }
    }
    
    var headers : HTTPHeaders?{
        switch self {
        case .Check, .ProvideQuiz:
            return nil
        }
    }
    
    var parameters : [String:Any]{
        switch self {
        case .Check(let correct):
            print(["correct" : correct])
            return ["correct" : correct]
        default:
            return [:]
        }
    }
}
