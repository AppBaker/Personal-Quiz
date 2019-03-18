//
//  ViewController.swift
//  Personal Quiz
//
//  Created by Ivan Nikitin on 15/03/2019.
//  Copyright © 2019 Ivan Nikitin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = startButton.frame.height / 2
        startButton.clipsToBounds = true
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }


}

