//
//  userData.swift
//  cruzHacksMoney
//
//  Created by Preston Ong on 1/20/18.
//  Copyright © 2018 Preston Ong. All rights reserved.
//

import Foundation

class UserData {
    var firstName: String
    var lastName: String
    var age: Int
    var occupation: String
    init (age: Int, fN: String, lN: String, occupation: String) {
        self.firstName = fN
        self.lastName = lN
        self.age = age
        self.occupation = occupation
    }
}

class Cashflow {
    var networth: Double
    var income: Double
    init (networth: Double, income: Double) {
        self.networth = networth
        self.income = income
    }
}

struct Expenses {
    var frequency: String
    var expenses: Double
    var description: String
    
    var category: String
    
    init (category: String, frequency: String, input expenses: Double, description: String) {
        self.frequency = frequency
        switch frequency {
        case "Weekly":
            self.expenses = expenses*4.5
        case "Monthly":
            self.expenses = expenses
        case "Annually":
            self.expenses = expenses/12
        default:
            fatalError("Invalid argument.")
        }
        self.description = description
        self.category = category
    }
}
