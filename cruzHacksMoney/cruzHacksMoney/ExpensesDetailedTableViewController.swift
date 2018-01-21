//
//  ExpensesDetailedTableViewController.swift
//  cruzHacksMoney
//
//  Created by Preston Ong on 1/20/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import UIKit

class ExpensesDetailedTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var expenses: Expenses?
    let categoryPickerIndexPath = IndexPath(row: 0, section: 1)
    let frequencyPickerIndexPath = IndexPath(row: 1, section: 1)
    let pickerData = [["Food", "Grocery", "Transport", "Mortgage/Rent", "Others"],["Weekly", "Monthly", "Annually"]]
    
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBAction func descriptionEdited(_ sender: UITextField) {
        navigationItem.title = descriptionTextfield.text
        updateButton()
    }
    @IBAction func costEdited(_ sender: UITextField) {
        updateButton()
    }
    @IBAction func returnKeyPressed(_ sender: Any) {
        descriptionTextfield.resignFirstResponder()
        costTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            let description = descriptionTextfield.text
            let cost = Double(costTextField.text!)
            let category = pickerData[0][categoryPicker.selectedRow(inComponent: 0)]
            let frequency = pickerData[1][categoryPicker.selectedRow(inComponent: 1)]
            expenses = Expenses(category: category, frequency: frequency, input: cost!, description: description!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        updateButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func updateButton() {
        let description = descriptionTextfield.text ?? ""
        let cost = costTextField.text ?? ""
        let cf = categoryLabel.text
        saveButton.isEnabled = !description.isEmpty && !cost.isEmpty && cf != "Select A Category and Frequency"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Category Picker Data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
        updateButton()
    }
    
    func updateLabel() {
        let category = pickerData[0][categoryPicker.selectedRow(inComponent: 0)]
        let frequency = pickerData[1][categoryPicker.selectedRow(inComponent: 1)]
        categoryLabel.text = "\(frequency) \(category) Expenses"
        categoryLabel.textColor = .black
    }
}
