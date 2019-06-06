//
//  MainScreenSource.swift
//  EAP
//
//  Created by Preston Ong on 12/2/17.
//  Copyright © 2017 Preston Ong. All rights reserved.
//

import Foundation
import UIKit

struct TableData {
    var sectionTitles: [String] = ["General", "Social Media", "Game"]
    var rows: [Row]
    var title: String
    init (sectionIndex: Int, rows: [Row]) {
        self.title = sectionTitles[sectionIndex]
        self.rows = rows
    }
}

struct Row {
    var title: String
    var icon: UIImage?
    init (title: String, icon: UIImage?) {
        self.title = title
        self.icon = icon
    }
}
