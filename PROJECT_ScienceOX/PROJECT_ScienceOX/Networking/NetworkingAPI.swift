//
//  NetworkingAPI.swift
//  PROJECT_ScienceOX
//
//  Created by 장서영 on 2021/01/02.
//

import Foundation
import Alamofire

enum NetworkingAPI{
    case ProvideQuiz(_ question : String, isCorrect : String)
    
    var path : String{
        switch self {
        case .ProvideQuiz:
            return "/question"
        }
    }
    
    var headers : HTTPHeaders?{
        return nil
    }
    
    var parameters : [String:Any]{
        switch self {
        case .ProvideQuiz(let question, let isCorrect):
            return [:]
        default:
            return [:]
        }
    }
}

