//
//  QuizViewController.swift
//  PROJECT_ScienceOX
//
//  Created by 장서영 on 2021/01/02.
//

import UIKit
import Alamofire

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizTextView : UITextView!
    
    let httpclient = HTTPClient()
    private var getmodel : ProvideQuizModel?
    
    var quiz = String()
    var isCorrect = Bool()
    var correct = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.quizTextView.textColor = UIColor.white
        Quiz()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        reloadInputViews()
    }
    
    @IBAction func correctButton(_ sender : UIButton){
        correct = true
        Answer()
    }
    
    @IBAction func incorrectButton(_ sender : UIButton){
        correct = false
        Answer()
    }
    
   
    func Quiz(){
        httpclient.get(NetworkingAPI.ProvideQuiz(quiz, isCorrect)).responseJSON {(response) in
            switch response.response?.statusCode{
            case 200 :
                print("get success")
                guard let data = response.data else {return}
                guard let model = try? JSONDecoder().decode(ProvideQuizModel.self, from: data) else {return}
                self.getmodel = model
                self.quizTextView.text = model.question
            case 404 :
                print("NOT FOUND")
                id = 1
                let alert = UIAlertController(title: "게임이 끝났습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: "확인", style: .cancel) {
                    (action) in self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
            default :
                print(response.response?.statusCode)
            }
        }
    }
    
    func Answer(){
        httpclient.get(NetworkingAPI.ProvideQuiz(quiz, isCorrect)).responseJSON {(response) in
            switch response.response?.statusCode{
            case 200:
                guard let data = response.data else {return}
                guard let model = try? JSONDecoder().decode(ProvideQuizModel.self, from: data) else {return}
                self.getmodel = model
                
                if model.isCorrect == self.correct{
                    let alert = UIAlertController(title: "정답입니다!", message: nil, preferredStyle: UIAlertController.Style.alert)
                    id = id+1
                    let cancelAction = UIAlertAction(title: "확인", style: .cancel){
                        (action) in self.Quiz()
                    }
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = UIAlertController(title: "틀렸습니다!", message: nil, preferredStyle: UIAlertController.Style.alert)
                    id = id+1
                    let cancelAction = UIAlertAction(title: "확인", style: .cancel){
                        (action) in self.Quiz()
                    }
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            case 404 :
                print("NOT FOUND")
            default :
                print(response.response?.statusCode)
            }
        }
    }
    
}
