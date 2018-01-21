//
//  IncomeAssetTableViewController.swift
//  cruzHacksMoney
//
//  Created by Preston Ong on 1/20/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import UIKit

class IncomeAssetTableViewController: UITableViewController {

    var user: UserData?
    var cashflow = Cashflow(networth: 0.00, income: 0.00)
    
    //outlet
    @IBOutlet weak var netWorthTextfield: UITextField!
    @IBOutlet weak var activeIncomeTextfield: UITextField!
    @IBOutlet weak var passiveIncomeTextfield: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    //action
    @IBAction func dollarChanged(_ sender: UITextField) {
        updateButton()
    }
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        netWorthTextfield.resignFirstResponder()
        activeIncomeTextfield.resignFirstResponder()
        passiveIncomeTextfield.resignFirstResponder()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "reviewIncomeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewIncomeSegue" {
            let income1String = activeIncomeTextfield.text ?? ""
            let income2String = passiveIncomeTextfield.text ?? ""
            let initialNetWorthString = netWorthTextfield.text ?? ""
            var totalIncome: Double
            totalIncome = Double(income1String)! + Double(income2String)!
            var totalNetWorth: Double
            totalNetWorth = Double(initialNetWorthString)!
            cashflow = Cashflow(networth: totalNetWorth, income: totalIncome)
            let reviewIncomeView = segue.destination as! ReviewIncomeViewController
            reviewIncomeView.user = user
            reviewIncomeView.cashflow = cashflow
            reviewIncomeView.navigationItem.title = "Review \(user!.firstName) \(user!.lastName)'s income"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = "Calculating Your Asset"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateButtonColor() {
        if doneButton.isEnabled {
            doneButton.backgroundColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
        }
        else if !doneButton.isEnabled{
            doneButton.backgroundColor = .lightGray
        }
    }
    
    func updateButton() {
        let netWorth = netWorthTextfield.text ?? ""
        let activeIncome = activeIncomeTextfield.text ?? ""
        let passiveIncome = passiveIncomeTextfield.text ?? ""
        doneButton.isEnabled = !netWorth.isEmpty && !activeIncome.isEmpty && !passiveIncome.isEmpty
        updateButtonColor()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
