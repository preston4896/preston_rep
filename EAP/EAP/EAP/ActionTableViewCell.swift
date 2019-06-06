//
//  ActionTableViewCell.swift
//  EAP
//
//  Created by Preston Ong on 12/2/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import UIKit
class ActionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
