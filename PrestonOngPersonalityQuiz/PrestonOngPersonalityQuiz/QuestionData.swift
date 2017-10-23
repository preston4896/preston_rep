//
//  QuestionData.swift
//  PrestonOngPersonalityQuiz
//
//  Created by Preston Ong on 10/21/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import Foundation

//define response type
enum Response {
    case single, multiple, ranged
}

//define countries and its definition
enum Country: Character {
    case usa = "🇺🇸" , malaysia = "🇲🇾", mexico = "🇲🇽", italy = "🇮🇹"
    
    var definitons: String {
        switch self {
        case .usa:
            return "MURICA! You are an American. Go outside and treat yourself some extra bacon and double cheese burger. SHOW THE WORLD THE FREEDOM YOU ARE ENJOYING!"
        case .malaysia:
            return "ON LAH! You are a Malaysian! I know you must be really hungry for some Nasi Lemak and all the good food you can find in Penang!"
        case .mexico:
            return "BUENO! You are a Mexican. NOW GO GET YOURSELF SOME TEQUILA SHOTS WITH YOUR AMIGOS!"
        case .italy:
            return "Mama mia! You are Italiano. You always knew that your veins are simply made out of pasta!"
        }
    }
}

//define answers struct.
struct Answer {
    var text: String
    var type: Country
}

//define questions struct.
struct Question {
    var text: String
    var type: Response
    var answers: [Answer]
}

//define questions and answers
var questions: [Question] = [
    Question(text: "Pick your carb.", type: .single, answers: [Answer(text:"Bread", type: .usa), Answer(text: "Rice", type: .malaysia), Answer(text: "Tortilla", type: .mexico), Answer(text: "Pasta", type: .italy)]),
    Question(text: "Pick your proteins.", type: .multiple, answers: [Answer(text: "Ground beef", type: .usa), Answer(text: "Chorizo", type: .mexico), Answer(text: "Salami", type: .italy), Answer(text: "Beef Rendang (Dried Curry)", type: .malaysia), Answer(text: "Beans", type: .mexico), Answer(text: "Meatball", type: .italy), Answer(text: "Bacon", type: .usa), Answer(text: "Asam Pedas (Fish Stew)", type: .malaysia)]),
    Question(text: "Do you enjoy living under cold, hot or a little of both temperatures?", type: .ranged, answers: [Answer(text: "Mostly cold.", type: .italy), Answer(text: "Cold but warm during summer.", type: .usa), Answer(text: "Tropical hot.", type: .malaysia), Answer(text: "Extreme heat." ,type: .mexico)])
]

//counter
var questionCount = 0
