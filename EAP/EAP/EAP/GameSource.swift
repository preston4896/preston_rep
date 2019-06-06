//
//  GameSource.swift
//  EAP
//
//  Created by Preston Ong on 12/7/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import Foundation

struct GameCategory {
    var title: String
    var game: [Game]
    init (title: String, game: [Game]) {
        self.title = title
        self.game = game
    }
}

class Game {
    var title: String
    init (title: String) {
        self.title = title
    }
}

enum QuestionType {
    case single, multipled, reordering, ranged
}

struct Answer {
    var text: String
    var percentage: Float?
    init (text: String, percentage: Float?) {
        self.text = text
        self.percentage = percentage
    }
}

struct Question {
    var text: String
    var type: QuestionType
    var answers: [Answer]
    var rangedAnswerPercentage: Float?
    init (title: String, type: QuestionType, answers: [Answer], rangedAnswerPercentage: Float?) {
        self.text = title
        self.type = type
        self.answers = answers
        self.rangedAnswerPercentage = rangedAnswerPercentage
    }
}

var questionGame1: [Question] = [
    Question(title: "Preston's left brain vs right brain.", type: .ranged,
         answers: [
         Answer(text: "Left Brain", percentage: nil),
         Answer(text: "Right Brain", percentage: nil)], rangedAnswerPercentage: 35),
    /*
    Question(title: "Preston's productivity for the Fall 2017 Semester.", type: .ranged,
         answers: [
         Answer(text: "Unproductive", percentage: nil),
         Answer(text: "Productive", percentage: nil)], rangedAnswerPercentage: 85),
     */
    Question(title: "How likely is Preston going to meet his significant other? (In 2 years)", type: .ranged,
        answers: [
        Answer(text: "Unlikely", percentage: nil),
        Answer(text: "Likely", percentage: nil)], rangedAnswerPercentage: 5)]

var questionGame2: [Question] = [
    Question(title: "Veganism or All Meat, Preston chooses: ", type: .ranged,
             answers: [
                Answer(text: "Veganism", percentage: nil),
                Answer(text: "All Meat", percentage: nil)], rangedAnswerPercentage: 60),
    Question(title: "Netflix or Hulu? Preston chooses: ", type: .ranged,
             answers: [
                Answer(text: "Netflix", percentage: nil),
                Answer(text: "Hulu", percentage: nil)], rangedAnswerPercentage: 5)]
