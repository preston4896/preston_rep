//
//  HomeTableViewController.swift
//  cruzHacksMoney
//     //  Created by Preston Ong on 1/20/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var user: UserData?
    
    //outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //actions
    @IBAction func textFieldEdited(_ sender: UITextField) {
        updateButton()
    }
    
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        occupationTextField.resignFirstResponder()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "moneySegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moneySegue" {
            let incomeAssetViewController = segue.destination as! IncomeAssetTableViewController
            let firstName = firstNameTextField.text ?? ""
            let lastName = lastNameTextField.text ?? ""
            let age = ageTextField.text ?? ""
            let occupation = occupationTextField.text ?? ""
user = UserData(age: Int(age)!, fN: firstName, lN: lastName, occupation: occupation)
incomeAssetViewController.user = user
        }
    }
    
    func updateButton() {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let occupation = occupationTextField.text ?? ""
        nextButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !age.isEmpty && !occupation.isEmpty
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
