//
//  QuizViewController.swift
//  PROJECT_ScienceOX
//
//  Created by 장서영 on 2021/01/02.
//

import UIKit
import Alamofire

class QuizViewController: UIViewController {
    
    let httpclient = HTTPClient()
    private var getmodel : ProvideQuizModel?

    var quiz = String()
    var isCorrect = String()
    var correct = String()
    
    @IBOutlet weak var quizLabel : UILabel!
    
    
    @IBAction func correctButton(_ sender : UIButton){
        correct = "1"
    }
    
    @IBAction func incorrectButton(_ sender : UIButton){
       correct = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.quizLabel.text = quiz
        Quiz()
        
    }
    
    func Quiz(){
        httpclient.get(.ProvideQuiz(quiz, isCorrect: isCorrect)).responseJSON(completionHandler: {(response) in
            switch response.response?.statusCode{
            case 200 :
                print("get success")
                guard let data = response.data else {return}
                guard let model = try? JSONDecoder().decode(ProvideQuizModel.self, from: data) else {return}
                self.getmodel = model
                
                if model.isCorrect == self.correct{
                    let alert = UIAlertController(title: "정답입니다!", message: nil, preferredStyle: UIAlertController.Style.alert)
                    let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = UIAlertController(title: "틀렸습니다!", message: nil, preferredStyle: UIAlertController.Style.alert)
                    let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            case 404 :
                print("NOT FOUND")
            default :
                print(response.response?.statusCode)
            }
        })
    }

}
