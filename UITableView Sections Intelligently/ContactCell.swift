//
//  ContactCell.swift
//  UITableView Sections Intelligently
//
//  Created by masato on 11/10/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
