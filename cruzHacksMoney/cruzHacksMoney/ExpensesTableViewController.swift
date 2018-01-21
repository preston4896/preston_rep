//
//  ExpensesTableViewController.swift
//  cruzHacksMoney
//
//  Created by Preston Ong on 1/20/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import UIKit

class ExpensesTableViewController: UITableViewController {
    
    var user: UserData?
    var cashflow: Cashflow?
    var expenses: [Expenses] = []
    var totalCostExpenses: Double = 0.00
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "\(user!.firstName), Are You Sure To Continue?", message: "You cannot change your information once you tap continue.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: {
            (action) in
            
            self.performSegue(withIdentifier: "resultSegue", sender: nil)
        })
        alertController.addAction(continueAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateButtonColor() {
        if doneButton.isEnabled {
            doneButton.backgroundColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
        }
        else if !doneButton.isEnabled{
            doneButton.backgroundColor = .lightGray
        }
    }
    
    func updateUI() {
        totalCostExpenses = 0.00
        if expenses.isEmpty {
            doneButton.isEnabled = false
        }
        else {
            doneButton.isEnabled = true
        for i in 0...expenses.count-1 {
            totalCostExpenses += expenses[i].expenses
            }
        }
        totalPriceLabel.text = String(format: "$%.2f", totalCostExpenses)
        if totalCostExpenses == 0.00 {
            messageLabel.text = "Begin itemizing your expenses by clicking the + button."
            messageLabel.textColor = .black
            totalPriceLabel.textColor = .black
        }
        else if (totalCostExpenses/cashflow!.income) < 0.75 {
            totalPriceLabel.textColor = .green
            messageLabel.text = "You spend your money very wisely. You should consider to invest some of that extra money."
            messageLabel.textColor = .green
        }
        else if ((totalCostExpenses/cashflow!.income) >= 0.75) && ((totalCostExpenses/cashflow!.income) < 0.90) {
            totalPriceLabel.textColor = .orange
            messageLabel.text = "Your spending has exceeded 75% of your monthly income. You should save up your remaining income by reducing some of your expenses."
            messageLabel.textColor = .orange
        }
        else if (totalCostExpenses/cashflow!.income) >= 0.90 {
            totalPriceLabel.textColor = .red
            messageLabel.text = "Your excessive spending of your income is turning your asset into liability. Start saving up now to avoid bankcruptcy."
            messageLabel.textColor = .red
        }
        updateButtonColor()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "expensesCell", for: indexPath) as? ExpensesTableViewCell else {fatalError("Cannot dequeue cell.")}
        cell.descriptionLabel.text = expenses[indexPath.row].description
        cell.expensesLabel.text = String(format: "$%.2f", expenses[indexPath.row].expenses)
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateUI()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    @IBAction func unwindSegue (segue: UIStoryboardSegue) {
        guard let expensesDetailedViewController = segue.source as? ExpensesDetailedTableViewController, let expense = expensesDetailedViewController.expenses else {return}
            expenses.append(expense)
    }
    
    @IBAction func cancelUnwindSegue (segue: UIStoryboardSegue) {
        //does nothing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let resultViewController = segue.destination as! ResultTableViewController
            resultViewController.user = self.user
            resultViewController.cashflow = self.cashflow
            resultViewController.totalExpenses = self.totalCostExpenses
            resultViewController.expenses = self.expenses
        }
    }
}
