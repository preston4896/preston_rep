//
//  ViewController.swift
//  POApplePie
//
//  Created by Preston Ong on 10/2/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //outlets and actions
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var currentWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameStat()
    }
    
    //variables
    var listofWords = ["apple", "banana", "cantaloupe", "durian", "elephant", "falco"]
    
    let incorrectMoveAllowed = 5
    
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    //function definitions
    func newRound() {
        if !listofWords.isEmpty {
        let newWord = listofWords.removeFirst()
        
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMoveAllowed, guessedLetters: [])
        enableLetterButtons(true)
        updateUI()
        }
        
        else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons (_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        scoreLabel.text = "Total Wins: \(totalWins); Total Losses: \(totalLosses)"
        
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
        //formatted word label
        var letters: [String] = []
        for letter in currentGame.formattedWordString.characters
        {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        currentWordLabel.text = wordWithSpacing
    }
    
    func updateGameStat() {
        if currentGame.incorrectMovesRemaining==0
        {
            totalLosses-=1
        }
        else if currentGame.word == currentGame.formattedWordString
        {
            totalWins+=1
        }
        else {
            updateUI()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

