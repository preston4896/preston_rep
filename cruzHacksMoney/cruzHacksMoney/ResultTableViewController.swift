//
//  ResultTableViewController.swift
//  cruzHacksMoney
//
//  Created by Preston Ong on 1/20/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    var user: UserData?
    var cashflow: Cashflow?
    var totalExpenses: Double?
    var expenses: [Expenses]?
    
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var spendingLabel: UILabel!
    @IBOutlet weak var wealthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = "\(user!.firstName)'s Wealth Report"
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadUI() {
        let annualIncome = cashflow!.income*12
        let annualSpending = totalExpenses!*12
        assetLabel.text = String(format: "%.2f", cashflow!.networth)
        incomeLabel.text = String(format: "%.2f", annualIncome)
        spendingLabel.text = String(format: "%.2f", annualSpending)
        wealthLabel.text = String(format: "%.2f", ((cashflow!.networth)/annualSpending))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adviceSegue" {
            let adviceViewController = segue.destination as! AdviceTableViewController
            adviceViewController.cashflow = self.cashflow
            adviceViewController.expenses = self.expenses
            adviceViewController.totalExpenseCost = self.totalExpenses
        }
    }
}
