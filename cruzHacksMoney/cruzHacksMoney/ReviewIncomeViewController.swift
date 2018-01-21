//
//  ReviewIncomeViewController.swift
//  cruzHacksMoney
//
//  Created by Preston Ong on 1/20/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import UIKit

class ReviewIncomeViewController: UIViewController {

    var user: UserData?
    var cashflow: Cashflow?
    
    @IBOutlet weak var incomeNetWorthLabel: UILabel!
    @IBOutlet weak var annualGrossIncome: UILabel!
    @IBAction func continueButton(_ sender: Any) {
        let alertController = UIAlertController(title: "\(user!.firstName), Are You Sure To Continue?", message: "You cannot change your information once you tap continue.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: {
            (action) in
            self.performSegue(withIdentifier: "expensesSegue", sender: action)
        })
        alertController.addAction(continueAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "expensesSegue" {
            let expensesViewController = segue.destination as! ExpensesTableViewController
            expensesViewController.user = user
            expensesViewController.cashflow = cashflow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUI() {
        annualGrossIncome.text = "Your annual gross income is \(String(format: "$%.2f", cashflow!.income*12))"
        incomeNetWorthLabel.text = "Based on the information you provided, you currently work as a \(user!.occupation.lowercased()) with a monthly income of \(String(format: "$%.2f", cashflow!.income)) and a total net worth \(String(format: "$%.2f", cashflow!.networth))."
    }
}
