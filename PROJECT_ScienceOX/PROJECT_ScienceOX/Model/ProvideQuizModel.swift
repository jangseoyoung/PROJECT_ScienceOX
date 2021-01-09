//
//  ProvideQuizModel.swift
//  PROJECT_ScienceOX
//
//  Created by 장서영 on 2021/01/05.
//

import Foundation
import Alamofire

struct ProvideQuizModel : Codable {
    var question : String
    var isCorrect : Bool
}
