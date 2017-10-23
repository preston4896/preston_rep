//
//  ResultsViewController.swift
//  PrestonOngPersonalityQuiz
//
//  Created by Preston Ong on 10/21/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var responses = answerChosen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide back button
        navigationItem.hidesBackButton = true
        
        calculateResult()
    }
    
    func calculateResult() {
        var frequency: [Country: Int] = [:]
        let responseType = responses.map { $0.type }
        for response in responseType {
            frequency[response] = (frequency[response] ?? 0) + 1
        }
        let mostCommonAnswer = frequency.sorted{$0.1>$1.1}.first!.key
        resultLabel.text = "You should live in \(mostCommonAnswer.rawValue)!"
        definitionLabel.text = mostCommonAnswer.definitons
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
