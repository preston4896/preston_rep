//
//  GameTableViewController.swift
//  EAP
//
//  Created by Preston Ong on 12/6/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit

class GameTableViewController: UITableViewController {

    var isNightModeEnabled: Bool!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBAction func unwindGameSegue (segue: UIStoryboardSegue) {
        
    }
    
    var categories: [GameCategory] = [
    GameCategory(title: "General", game: [
        Game(title: "Basically Preston"),
        Game(title: "How Well Do You Know Preston")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUI() {
        if isNightModeEnabled{
            tableView.tintColor = .orange
            tableView.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0)
            tableView.separatorColor = .darkGray
            messageView.backgroundColor = .black
            messageLabel.textColor = .white
            navigationItem.backBarButtonItem?.tintColor = .orange
        }
        else {
            tableView.tintColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
            tableView.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.9655, alpha: 1.0)
            tableView.separatorColor = .lightGray
            messageView.backgroundColor = .white
            messageLabel.textColor = .black
            navigationItem.backBarButtonItem?.tintColor = UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1)
        }
    }

    // MARK: - Table view data source

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].game.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].title
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isNightModeEnabled {
            cell.textLabel?.textColor = .white
            cell.contentView.backgroundColor = .black
        }
        else {
            cell.textLabel?.textColor = .black
            cell.contentView.backgroundColor = .white
        }
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.section].game[indexPath.row].title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "beginSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beginSegue" {
           let questionsViewController = segue.destination as! QNATableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            questionsViewController.navigationItem.title = categories[indexPath.section].game[indexPath.row].title
            questionsViewController.isNightModeEnabled = isNightModeEnabled
            if indexPath == IndexPath(row: 0, section: 0) {
                questionsViewController.questions = questionGame1
            }
            else if indexPath == IndexPath(row: 1, section: 0) {
                questionsViewController.questions = questionGame2
            }
        }
    }
}
