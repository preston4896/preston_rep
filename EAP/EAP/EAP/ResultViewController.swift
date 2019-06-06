//
//  ResultViewController.swift
//  EAP
//
//  Created by Preston Ong on 12/10/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var percentageScore: Float = 0.00
    var isNightModeEnabled: Bool!
    @IBOutlet weak var bitmojiView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindGameSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        loadUI()
        loadTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadUI() {
        scoreLabel.text = "You Scored: \(String(format: "%.2f", percentageScore)) %"
        if (percentageScore >= 0.00) && (percentageScore < 10) {
            bitmojiView.image = UIImage(named: "lo")
            descriptionLabel.text = "Uhh ok. I guess we haven't met. Thanks for playing tho."
        }
        
        else if (percentageScore >= 10) && (percentageScore < 50) {
            bitmojiView.image = UIImage(named: "medlo")
            descriptionLabel.text = "Preston is sad because you didn't know him well enough. He wishes that you would talk to him more."
        }
        
        else if (percentageScore >= 50) && (percentageScore < 90) {
            bitmojiView.image = UIImage(named: "medHi")
            descriptionLabel.text = "Not bad! We should hang out more."
        }
        
        else if (percentageScore >= 90) && (percentageScore <= 100) {
            bitmojiView.image = UIImage(named: "hi")
            descriptionLabel.text = "Wow I mean wow! I can not express how happy I am to know there are people like you. I mean it takes dedication for you to know me this well and I am grateful for you. Thanks for being here for me."
        }
    }
    
    func loadTheme() {
        if isNightModeEnabled {
            doneButton.tintColor = .orange
            descriptionLabel.textColor = .white
            scoreLabel.textColor = .white
            view.backgroundColor = .black
        }
        else {
            doneButton.tintColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
            descriptionLabel.textColor = .black
            scoreLabel.textColor = .black
            view.backgroundColor = .white
        }
    }
}
