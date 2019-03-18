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
    var answersArray = [PersonType]()
    var questionIndex = 0
    
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
    
    //MARK: - ... Custom Methods
    func updateUI() {
        var toggles = [UISwitch]()
        var index = 0
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        
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
        
        // Single Question Tipe setup
        
        if curentQuestion.type == .single {
            for item in singleStackView.arrangedSubviews {
                if let button = item as? UIButton {
                    button.setTitle(curentQuestion.answers[index].text, for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    button.layer.cornerRadius = button.frame.height / 2
                    button.clipsToBounds = true
                    index += 1
                    button.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
                }
            }
            
            // Multiple Question Tipe setup
        } else if curentQuestion.type == .multiple {
            for stackView in multipleStackView.arrangedSubviews {
                if let view = stackView as? UIStackView {
                    for item in view.arrangedSubviews {
                        if let answerLable = item as? UILabel {
                            answerLable.text = curentQuestion.answers[index].text
                        } else if let toggle = item as? UISwitch {
                            toggles.append(toggle)
                        }
                    }
                }  else if let button = stackView as? UIButton {
                    button.layer.cornerRadius = button.frame.height / 2
                    button.clipsToBounds = true
                    button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    button.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
                    
                }
                index += 1
            }
            // Range Question Tipe setup
        } else if curentQuestion.type == .ranged {
            for item in rangeStackView.arrangedSubviews {
                if let slider = item as? UISlider {
                    slider.value = 0.5
                    slider.addTarget(self, action: #selector(changeValueOfSlider), for: .allEvents)
                } else if let button = item as? UIButton {
                    button.layer.cornerRadius = button.frame.height / 2
                    button.clipsToBounds = true
                    button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    button.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
                }
            }
        }
        index = 0
        questionIndex += 1
        progressView.setProgress(Float(questionIndex)/Float(questions.count), animated: true)
    }
    //MARK: - ... @Objc Selectors
    
    @objc func nextQuestion(sender: UIButton) {
        if questionIndex / questions.count == 1 {
            performSegue(withIdentifier: "resultSegue", sender: nil)

        } else {
            updateUI()
        }
    }
    
    @IBAction func changeValueOfSlider(sender: UISlider, forEvent event: UIEvent) {
        sliderValueLable.text = "\(Int(sender.value * 100))%"
    }
    
    //MARK: - ... Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue"{
            let dvc = segue.destination as! ResultViewController
            dvc.answers = answersArray
        }
    }
}
