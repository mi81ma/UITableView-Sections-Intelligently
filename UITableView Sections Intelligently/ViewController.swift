//
//  ViewController.swift
//  UITableView Sections Intelligently
//
//  Created by masato on 10/10/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // ******** Data Set ***************
    let cellId = "cellId123123"

    let names = [
        "Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mike"
    ]

    let cNames = [
        "Carl", "Chris", "Christina", "Cameron"
    ]

    // *********************************


    override func viewDidLoad() {
        super.viewDidLoad()

    // ******** Navigation Bar *********
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
     // *********************************
    }




    // ******** add Sections ************

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.lightGray
        return label
    }

    // return the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

     // *********************************






    // ************** Cell ***************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return names.count
        }
        return cNames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // "names Array" element into "name"
//        let name = self.names[indexPath.row]

        let name = indexPath.section == 0 ? names[indexPath.row] : cNames[indexPath.row]


        // set name to cell.textLabel
        cell.textLabel?.text = name

        // "name", "indexPath", "indexPath".row
        cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"


        return cell

    }


}

