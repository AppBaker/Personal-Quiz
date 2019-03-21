//
//  ResultViewController.swift
//  Personal Quiz
//
//  Created by Ivan Nikitin on 17/03/2019.
//  Copyright © 2019 Ivan Nikitin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    
    var resultAnswers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateResult()
    }
    
    func calculateResult() {
        var typeFrequency = [PersonType: Int]()
        
        let types = resultAnswers.map { $0.type }
        
        types.forEach { typeFrequency[$0] = (typeFrequency[$0] ?? 0) + 1 }
        
        let sortedTypeFrequency = typeFrequency.sorted { $0.value > $1.value }
        let result = sortedTypeFrequency.first!.key
        
        updateUI(with: result)
    }
    
    func updateUI(with person: PersonType) {
        headerLabel.text = "Вы — \(person.rawValue)"
        discriptionLabel.text = person.definition
    }

}
