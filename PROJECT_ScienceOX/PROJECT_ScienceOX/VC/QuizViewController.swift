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
    private var postmodel : CheckModel?
    
    @IBOutlet weak var quizLabel : UILabel!
    
    @IBAction func correctButton(_ sender : UIButton){
        CheckAnswer(correct: "1")
    }
    
    @IBAction func incorrectButton(_ sender : UIButton){
        CheckAnswer(correct: "0")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func GetQuiz(question : String){
        httpclient.get(.ProvideQuiz(question)).responseJSON(completionHandler: {(response) in
            switch response.response?.statusCode{
            case 200:
                guard let data = response.data else {return}
                guard let model = try? JSONDecoder().decode(ProvideQuizModel.self, from: data) else {return}
                self.getmodel = model
                
                self.quizLabel.text = model.question
            case 404:
                print("NOT FOUND")
            default:
                print("알 수 없는 오류")
            }
        })
    }
    
    
    func CheckAnswer(correct : String){
        httpclient.post(.Check(correct)).responseJSON(completionHandler: {(response) in
            switch response.response?.statusCode{
            case 200:
                print("채점 성공")
                guard let data = response.data else {return}
                guard let model = try? JSONDecoder().decode(CheckModel.self, from: data) else {return}
                self.postmodel = model
                
                if model.correct == "1"{
                    let alert = UIAlertController(title: "정답입니다!", message: nil, preferredStyle: UIAlertController.Style.alert)
                    let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
                else if model.correct == "0"{
                    let alert = UIAlertController(title: "틀렸습니다!", message: nil, preferredStyle: UIAlertController.Style.alert)
                    let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
                else {
                    print("오류입니다.")
                }
                
            case 400:
                print("BAD REQUEST")
            case 404:
                print("NOT FOUND")
            default:
                print("알 수 없는 오류")
                
            }
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
