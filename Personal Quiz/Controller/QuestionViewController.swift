//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Ivan Nikitin on 17/03/2019.
//  Copyright © 2019 Ivan Nikitin. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    //MARK: - ... Properties
    var questions = Question.loadData()
    var questionIndex = 0
    var answerChosen: [Answer] = []
    var toggleArray: [UISwitch] = []
    var sliderValue: Float!
    
    //MARK: - ... @IBOutlets
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var sliderValueLable: UILabel!
    
    
    //MARK: - ... UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - ... Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ResultSegue" else { return }
        let resultViewController = segue.destination as! ResultViewController
        resultViewController.resultAnswers = answerChosen
    }
    
    //MARK: - ... Custom Methods
    func updateUI() {
        var index = 0
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        navigationItem.title = "Вопрос № \(questionIndex + 1)/\(questions.count)"
        progressView.setProgress(Float(questionIndex + 1)/Float(questions.count), animated: true)
        
        let curentQuestion = questions[questionIndex]
        switch curentQuestion.type {
        case .single:
            singleStackView.isHidden = false
        case .multiple:
            multipleStackView.isHidden = false
        case .ranged:
            rangeStackView.isHidden = false
            break
        }
        questionLable.text = curentQuestion.text
        
        // Single Question setup
        
        if curentQuestion.type == .single {
            
            for item in singleStackView.arrangedSubviews {
                if let button = item as? UIButton {
                    button.setTitle(curentQuestion.answers[index].text, for: [])
                    button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    button.layer.cornerRadius = button.frame.height / 2
                    button.clipsToBounds = true
                    button.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
                    button.tag = index
                    index += 1
                }
            }
            index = 0
            // Multiple Question setup
        } else if curentQuestion.type == .multiple {

            for stackView in multipleStackView.arrangedSubviews {
                if let view = stackView as? UIStackView {
                    for item in view.arrangedSubviews {
                        if let answerLable = item as? UILabel {
                            answerLable.text = curentQuestion.answers[index].text
                        } else if let toggle = item as? UISwitch {
                            toggle.isOn = false
                            toggle.tag = index
                            toggleArray.append(toggle)
                        }
//                        index += 1
                    }
                }  else if let button = stackView as? UIButton {
                    button.layer.cornerRadius = button.frame.height / 2
                    button.clipsToBounds = true
                    button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    // set tag "9" as identifire for multiple question
                    button.tag = 9
                    button.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
                }
                index += 1
            }
            // Range Question setup
        } else if curentQuestion.type == .ranged {
            for item in rangeStackView.arrangedSubviews {
                if let slider = item as? UISlider {
                    slider.value = 0.5
                    sliderValue = 0.5
                    slider.addTarget(self, action: #selector(changeValueOfSlider), for: .allEvents)
                } else if let button = item as? UIButton {
                    button.layer.cornerRadius = button.frame.height / 2
                    button.clipsToBounds = true
                    button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    // set tag "10" as identifire for range question
                    button.tag = 10
                    button.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
                }
            }
        }
        index = 0
    }
    //MARK: - ... @Objc Selectors
    @objc func nextQuestion(sender: UIButton) {
        
        if sender.tag == 0 || sender.tag == 1 || sender.tag == 2 || sender.tag == 3 {
            answerChosen.append(questions[questionIndex].answers[sender.tag])
            //tag "9" for multiple question answers
        } else if sender.tag == 9 {
            for i in toggleArray {
                if i.isOn {
                    answerChosen.append(questions[questionIndex].answers[i.tag])
                }
                toggleArray = []
            }
            //tag "10" for range question answer
        } else if sender.tag == 10 {
            let answerIndex = Int(round(sliderValue * Float(questions[questionIndex].answers.count - 1)))
            answerChosen.append(questions[questionIndex].answers[answerIndex])
            print("answerIndex = \(answerIndex)")
        }
        
        
        questionIndex += 1
        if questionIndex / questions.count == 1 {
            performSegue(withIdentifier: "ResultSegue", sender: nil)

        } else {
            updateUI()
        }
    }
    // Slider
    @objc func changeValueOfSlider(sender: UISlider, forEvent event: UIEvent) {
        sliderValue = sender.value
        sliderValueLable.text = "\(Int(sender.value * 100))%"
        
    }
}
