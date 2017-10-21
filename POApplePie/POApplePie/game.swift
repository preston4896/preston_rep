//
//  game.swift
//  POApplePie
//
//  Created by Preston Ong on 10/2/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    //called from button function
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter)
        {
            incorrectMovesRemaining-=1
        }
    }
    
    //word label
    var formattedWordString: String {
        var guessedWord = ""
        for letter in word.characters
        {
            if guessedLetters.contains(letter)
            {
                guessedWord += "\(letter)"
            }
            
            else {
                guessedWord = "_"
            }
        }
        return guessedWord
    }
}
