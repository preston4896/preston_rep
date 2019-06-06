//
//  QATableViewCell.swift
//  EAP
//
//  Created by Preston Ong on 12/9/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit

protocol QACellDelegate {
    func updateTotalPercentage (inputPercentage: Float)
    func checkViewEnabled (sender: QATableViewCell)
}

class QATableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate{
    
    var delegate: QACellDelegate?
    var numberOfAnswers: Int!
    var answers: [Answer]!
    var sliderPickedAnswer: Float!
    var isViewEnabled: Bool = true
    
    //outlets
    @IBOutlet weak var questionLabel: UILabel!
    
    //table - not now
    @IBOutlet weak var singleTableView: UITableView!
    @IBOutlet weak var multipledTableView: UITableView!
    @IBOutlet weak var reorderedTableView: UITableView!
    
    //slider
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var sliderAnswer: UISlider!
    @IBOutlet weak var sliderAnswer1: UILabel!
    @IBOutlet weak var sliderAnswer2: UILabel!
    @IBOutlet weak var setButton: UIButton!
    @IBAction func setButtonTapped(_ sender: Any) {
        updateViewStatus()
    }
    
    func updateViewStatus() {
        isViewEnabled = !isViewEnabled
        if isViewEnabled {
            delegate?.updateTotalPercentage(inputPercentage: -sliderValueChanged())
            sliderAnswer.isEnabled = true
            setButton.titleLabel?.text = "Set"
        }
        else {
            delegate?.updateTotalPercentage(inputPercentage: sliderValueChanged())
            sliderAnswer.isEnabled = false
            setButton.titleLabel?.text = "Unset"
        }
    }
    
    func sliderValueChanged () -> Float {
        let correctSliderValue = 0.01 * sliderPickedAnswer
        let error = abs((sliderAnswer.value - correctSliderValue)/correctSliderValue) * 100
        return 100.00 - error
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfAnswers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
        cell.textLabel?.text = answers[indexPath.row].text
        return cell;
    }
    
    //row selections for single, multiple
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == multipledTableView || tableView == singleTableView {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        /*
        else if tableView == singleTableView {
            let section = indexPath.section
            let numberOfRows = tableView.numberOfRows(inSection: section)
            for row in 0..<numberOfRows {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                    cell.accessoryType = row == indexPath.row ? .checkmark : .none
                }
            }
        }
         */
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == singleTableView {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
