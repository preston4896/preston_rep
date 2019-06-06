//
//  QNATableViewController.swift
//  EAP
//
//  Created by Preston Ong on 12/9/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit

class QNATableViewController: UITableViewController, QACellDelegate {
    
    // var storedCell: [QATableViewCell] = []

    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Are You Reaaally Done?", message: "Some of the answers might make you think that I am an interesting person, but it may not be even close to actual facts. Make sure you tapped all set buttons.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let submitAction = UIAlertAction(title: "Yes, I am done", style: .default, handler: {
            (action) in
            self.performSegue(withIdentifier: "resultSegue", sender: action)
        })
        alertController.addAction(submitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.isNightModeEnabled = isNightModeEnabled
            resultViewController.percentageScore = totalPercentage/Float(questions.count)
        }
    }
    
    var isNightModeEnabled: Bool!
    var questions: [Question] = []
    
    var totalPercentage: Float = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI() {
        if isNightModeEnabled{
                tableView.tintColor = .orange
                tableView.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0)
                tableView.separatorColor = .darkGray
            navigationItem.backBarButtonItem?.tintColor = .orange
            navigationItem.rightBarButtonItem?.tintColor = .orange
            submitView.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0)
            submitButton.backgroundColor = .orange
            submitButton.setTitleColor(.black, for: .normal)
            }
        else {
                tableView.tintColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
                tableView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.9655, alpha: 1.0)
                tableView.separatorColor = .lightGray
                navigationItem.backBarButtonItem?.tintColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
            navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
            submitView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.9655, alpha: 1.0)
            submitButton.backgroundColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
            submitButton.setTitleColor(.white, for: .normal)
            }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Question #\(section+1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let myCell = cell as! QATableViewCell
        if isNightModeEnabled {
            myCell.backgroundColor = .black
            myCell.questionLabel.textColor = .white
            myCell.contentView.tintColor = .orange
            myCell.sliderAnswer1.textColor = .white
            myCell.sliderAnswer2.textColor = .white
            myCell.singleTableView.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0)
            myCell.multipledTableView.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0)
            myCell.reorderedTableView.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0)
        }
        else {
            myCell.backgroundColor = .white
            myCell.questionLabel.textColor = .black
            myCell.contentView.tintColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
            myCell.sliderAnswer1.textColor = .black
            myCell.sliderAnswer2.textColor = .black
            myCell.singleTableView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.9655, alpha: 1.0)
            myCell.multipledTableView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.9655, alpha: 1.0)
            myCell.reorderedTableView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.9655, alpha: 1.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        if isNightModeEnabled {
            header.tintColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0)
            header.textLabel?.textColor = .white
        }
        else {
            header.tintColor = UIColor(red: 0.965, green: 0.965, blue: 0.9655, alpha: 1.0)
            header.textLabel?.textColor = .black
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "qaCell", for: indexPath) as? QATableViewCell else { fatalError("Unable to dequeue cell.")}
        cell.answers = questions[indexPath.section].answers
        cell.numberOfAnswers = questions[indexPath.section].answers.count
        cell.questionLabel.text = questions[indexPath.section].text
        cell.rangedStackView.isHidden = true
        cell.multipledTableView.isHidden = true
        cell.reorderedTableView.isHidden = true
        cell.singleTableView.isHidden = true
        cell.delegate = self
        switch questions[indexPath.section].type {
        case .single:
            loadSingleView(cell: cell, forQuestion: indexPath.section)
        case .multipled:
            loadMultipleView(cell: cell, forQuestion: indexPath.section)
        case .reordering:
            loadReorderView(cell: cell, forQuestion: indexPath.section)
        case .ranged:
            loadRangedView(cell: cell, forQuestion: indexPath.section)
        }
        
        /*
        if storedCell[indexPath.section].questionLabel.text == cell.questionLabel.text {
            //do nothing
        }
        
        else {
            storedCell.append(cell)
        }
         */
        
        return cell
    }
    
    func updateTotalPercentage (inputPercentage: Float) {
        totalPercentage += inputPercentage
    }
    
    func checkViewEnabled (sender: QATableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func loadRangedView(cell: QATableViewCell, forQuestion index: Int) {
        cell.rangedStackView.isHidden = false
        cell.sliderAnswer1.text = questions[index].answers.first?.text
        cell.sliderAnswer2.text = questions[index].answers.last?.text
        cell.sliderPickedAnswer = questions[index].rangedAnswerPercentage
    }
    
    func loadSingleView(cell: QATableViewCell, forQuestion index: Int) {
        cell.singleTableView.isHidden = false
    }
    
    func loadReorderView(cell: QATableViewCell, forQuestion index: Int) {
        cell.reorderedTableView.isHidden = false
    }
    
    func loadMultipleView(cell: QATableViewCell, forQuestion index: Int) {
        cell.multipledTableView.isHidden = false
    }
}
