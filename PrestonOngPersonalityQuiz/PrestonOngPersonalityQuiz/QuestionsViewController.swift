//
//  QuestionsViewController.swift
//  PrestonOngPersonalityQuiz
//
//  Created by Preston Ong on 10/21/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit

var answerChosen: [Answer] = []

class QuestionsViewController: UIViewController {
    
    //single view outlets
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    //multiple view outlets
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiLabel5: UILabel!
    @IBOutlet weak var multiLabel6: UILabel!
    @IBOutlet weak var multiLabel7: UILabel!
    @IBOutlet weak var multiLabel8: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var switch5: UISwitch!
    @IBOutlet weak var switch6: UISwitch!
    @IBOutlet weak var switch7: UISwitch!
    @IBOutlet weak var switch8: UISwitch!
    
    //ranged view outlets
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    //question label outlet
    @IBOutlet weak var questionLabel: UILabel!
    
    //progress bar outlet
    @IBOutlet weak var progressBar: UIProgressView!
    
    //answers action
    @IBAction func singleButtonsPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionCount].answers
        
        switch sender {
        case singleButton1:
            answerChosen.append(currentAnswers[0])
        case singleButton2:
            answerChosen.append(currentAnswers[1])
        case singleButton3:
            answerChosen.append(currentAnswers[2])
        case singleButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed() {
        let currentAnswers = questions[questionCount].answers
        if switch1.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if switch2.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if switch3.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if switch4.isOn {
            answerChosen.append(currentAnswers[3])
        }
        if switch5.isOn {
            answerChosen.append(currentAnswers[4])
        }
        if switch6.isOn {
            answerChosen.append(currentAnswers[5])
        }
        if switch7.isOn {
            answerChosen.append(currentAnswers[6])
        }
        if switch8.isOn {
            answerChosen.append(currentAnswers[7])
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        let currentAnswers = questions[questionCount].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count-1)))
        answerChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    func nextQuestion() {
        questionCount+=1
        
        if questionCount < questions.count {
            updateUI()
        }
        
        else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
            questionCount = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        //hide all views for every UI update.
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        //question and answer display
        let currentQuestion = questions[questionCount]
        let currentAnswer = currentQuestion.answers
        
        //define progress bar
        let totalProgress = Float(questionCount)/Float(questions.count)
        
        //define navigation title and UI
        navigationItem.title = "Question #\(questionCount+1)"
        questionLabel.text = currentQuestion.text
        progressBar.setProgress(totalProgress, animated: true)
        
        //show appropriate response type based on questions.
        switch currentQuestion.type {
        case .single:
            updateSingleView(using: currentAnswer)
        case .multiple:
            updateMultipleView(using: currentAnswer)
        case .ranged:
            updateRangedView(using: currentAnswer)
        }
    }
    
    func updateSingleView (using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleView (using answers: [Answer]) {
        multipleStackView.isHidden = false
        switch1.isOn = false
        switch2.isOn = false
        switch3.isOn = false
        switch4.isOn = false
        switch5.isOn = false
        switch6.isOn = false
        switch7.isOn = false
        switch8.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        multiLabel5.text = answers[4].text
        multiLabel6.text = answers[5].text
        multiLabel7.text = answers[6].text
        multiLabel8.text = answers[7].text
    }
    
    func updateRangedView (using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
