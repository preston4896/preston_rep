//
//  AdviceTableViewController.swift
//  cruzHacksMoney
//
//  Created by Preston Ong on 1/21/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import UIKit

class AdviceTableViewController: UITableViewController {
    
    var expenses: [Expenses]?
    var cashflow: Cashflow?
    var totalExpenseCost: Double?

    @IBOutlet weak var wealthLabel: UILabel!
    @IBOutlet weak var incrementLabel: UILabel!
    @IBOutlet weak var incrementStepper: UIStepper!
    
    @IBAction func incrementChanged(_ sender: UIStepper) {
        let annualIncome = cashflow!.income*12
        let annualSpending = totalExpenseCost!*12
        incrementLabel.text = Int(sender.value).description
        wealthLabel.text = String(format: "%.2f", (((cashflow!.networth)+((sender.value)*(annualIncome)))/annualSpending))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
        incrementStepper.wraps = true
        incrementStepper.autorepeat = true
        incrementStepper.minimumValue = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadContent() {
        let annualSpending = totalExpenseCost!*12
        wealthLabel.text = String(format: "%.2f", ((cashflow!.networth)/annualSpending))
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
