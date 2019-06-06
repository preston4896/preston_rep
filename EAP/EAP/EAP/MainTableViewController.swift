//
//  MainTableViewController.swift
//  EAP
//
//  Created by Preston Ong on 12/2/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

var tableViewData: [TableData] =
[TableData(sectionIndex: 0, rows:
    [Row(title:"Resume", icon: nil)]),
TableData(sectionIndex: 1, rows:
    [Row(title:"Preston Ong", icon: UIImage(named:"fb")),
     Row(title: "@haha_preston", icon: UIImage(named: "insta")),
     Row(title: "@preston4896", icon: UIImage(named: "snapchat")),
     Row(title: "Preston Ong", icon: UIImage(named: "linkedIn"))]),
TableData(sectionIndex: 2, rows: [Row(title:"Preston's Quizzes", icon: UIImage(named:"bitmoji"))])]

class MainTableViewController: UITableViewController, MFMailComposeViewControllerDelegate{
    
    var isSimplified: Bool = false
    var isDarkModeEnabled: Bool = true
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var cnName: UILabel!
    @IBOutlet weak var engName: UILabel!
    @IBOutlet weak var nightModeLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var simpTradSegmentedControl: UISegmentedControl!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var contactMeButton: UIButton!
    @IBOutlet weak var namePicView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var homeNav: UINavigationItem!
    @IBAction func darkModeSwitchActivated(_ sender: UISwitch) {
        updateUI()
    }
    @IBAction func simpTradSwitched(_ sender: UISegmentedControl) {
        updateCNName()
    }
    @IBAction func contactMeButtonTapped(_ sender: UIButton) {
        contactMeButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        contactMeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        if !MFMailComposeViewController.canSendMail() {
            print("Cannot Send Mail.")
            return
        }
        else {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setSubject("Your App Rocks, Keep It Up!")
            mailComposer.setToRecipients(["preston4896@me.com"])
            present(mailComposer, animated: true, completion: nil)
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindSnapchat(unwindSegue: UIStoryboardSegue) {
        //returns to home screen from SnapChat view
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func updateCNName() {
        isSimplified = !isSimplified
        if isSimplified {
            simpTradSegmentedControl.isEnabledForSegment(at: 1)
            cnName.text = "王列圣"
        }
        
        else {
            cnName.text = "王列聖"
        }
    }
    
    func updateUI() {
        isDarkModeEnabled = !isDarkModeEnabled
        if isDarkModeEnabled {
            darkModeSwitch.isOn = true
            updateTheme(backgroundAndButtonTitleColor: .black, tintColor: .orange, textColor: .white, emailViewColor: UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1.0), color5: .darkGray)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        else {
            darkModeSwitch.isOn = false
            updateTheme(backgroundAndButtonTitleColor: .white, tintColor: UIColor(red: 0.03125, green: 0.20703125, blue: 0.3984375, alpha: 1), textColor: .black, emailViewColor: UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1.0), color5: .lightGray)
            UIApplication.shared.statusBarStyle = .default
        }
        tableView.reloadData()
    }
    
    func updateTheme(backgroundAndButtonTitleColor color1: UIColor, tintColor color2: UIColor, textColor color3: UIColor, emailViewColor color4: UIColor, color5: UIColor) {
        tableView.tintColor = color2
        tableView.backgroundColor = color4
        tableView.separatorColor = color5
        namePicView.backgroundColor = color1
        emailView.backgroundColor = color4
        contactMeButton.setTitleColor(color1, for: .normal)
        contactMeButton.backgroundColor = color2
        cnName.textColor = color3
        engName.textColor = color3
        nightModeLabel.textColor = color3
        feedbackLabel.textColor = color3
        navigationItem.backBarButtonItem?.tintColor = color2
        navigationController?.navigationBar.barTintColor = color1
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : color3]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : color3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundImage(image: pic)
        darkModeSwitch.layer.cornerRadius = 16
        updateUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewData[section].title
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let myCell = cell as! ActionTableViewCell
        if isDarkModeEnabled {
            myCell.cellView.backgroundColor = .black
            myCell.descriptionLabel.textColor = .white
            myCell.iconImageView.backgroundColor = .black
        }
        else {
            myCell.cellView.backgroundColor = .white
            myCell.descriptionLabel.textColor = .black
            myCell.iconImageView.backgroundColor = .white
        }
    }
 
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "actionCell", for: indexPath) as? ActionTableViewCell else {fatalError("Could not dequeue a cell.")}
        cell.descriptionLabel.text = tableViewData[indexPath.section].rows[indexPath.row].title
        cell.iconImageView.image = tableViewData[indexPath.section].rows[indexPath.row].icon
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        //snapchat
        if (indexPath.section == 1 && indexPath.row == 2) {
            performSegue(withIdentifier: "snapchatSegue", sender: nil)
            UIApplication.shared.isStatusBarHidden = true
        }
        
        //resume
        else if (indexPath.section == 0 && indexPath.row == 0) {
            if let url = URL(string:"https://drive.google.com/file/d/0B-Ji0y4yMmmhRnRYNDFkUjV2bVE/view?usp=sharing") {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController,animated: true, completion: nil)
            }
        }
            
        //fb
        else if (indexPath.section == 1) && (indexPath.row == 0) {
            let fbURL = URL(string:"fb://profile?id=prestonong4896")!
            if UIApplication.shared.canOpenURL(fbURL) {
                UIApplication.shared.open(fbURL)
            }
            else {
                UIApplication.shared.open(URL(string:"http://www.facebook.com/prestonong4896")!)
            }
        }
        
        //insta
        else if (indexPath.section == 1) && (indexPath.row == 1) {
            let instaURL = URL(string:"instagram://user?username=haha_preston")!
            if UIApplication.shared.canOpenURL(instaURL) {
                UIApplication.shared.open(instaURL)
            }
            else {
                UIApplication.shared.open(URL(string:"http://instagram.com/haha_preston")!)
            }
        }
            
        //linkedIm
        else if (indexPath.section == 1) && (indexPath.row == 3) {
            let fbURL = URL(string:"linkedin://profile/prestonong")!
            if UIApplication.shared.canOpenURL(fbURL) {
                UIApplication.shared.open(fbURL)
            }
            else {
                UIApplication.shared.open(URL(string:"http://www.linkedin.com/in/prestonong")!)
            }
        }
        
        else if (indexPath.section == 2 ) && (indexPath.row == 0) {
            performSegue(withIdentifier: "gameSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameSegue" {
            let gameViewController = segue.destination as! GameTableViewController
            gameViewController.isNightModeEnabled = isDarkModeEnabled
        }
    }
}

func roundImage(image: UIImageView) {
    image.layer.borderWidth = 1
    image.layer.masksToBounds = false
    image.layer.cornerRadius = image.frame.height/2
    image.clipsToBounds = true
    image.layer.borderColor = UIColor.black.cgColor
}
