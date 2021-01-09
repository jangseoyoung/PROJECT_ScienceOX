//
//  NetworkingAPI.swift
//  PROJECT_ScienceOX
//
//  Created by 장서영 on 2021/01/02.
//

import Foundation
import Alamofire

var id : Int = 1

enum NetworkingAPI{
    case ProvideQuiz(_ question : String, _ isCorrect : Bool)
    
    var path : String{
        switch self {
        case .ProvideQuiz:
            return "/question/\(id)"
        }
    }
    
    var headers : HTTPHeaders?{
        return nil
    }
    
    var parameters : [String:Any]{
        return [:]
    }
}

