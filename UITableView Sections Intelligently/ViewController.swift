//
//  ViewController.swif
//  UITableView Sections Intelligently
//
//  Created by masato on 10/10/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // ******** Data Set ***************
    let cellId = "cellId"



    let names = [
        "Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mike"
    ]

    let cNames = [
        "Carl", "Chris", "Christina", "Cameron"
    ]

    let dNames = [
        "David", "Dan"
    ]

    let twoDimensionalArray = [
        ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mike"],
        ["Carl", "Chris", "Christina", "Cameron"],
        ["David", "Dan"],
        ["Patrikc", "Patty"]
    ]

    var showIndixPaths = false

    // *********************************

    @objc func  handleShowIndexPath() {
        print("Attemping reload animation indexPaths...")

        // build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()

        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }

//        for index in twoDimensionalArray[0].indices {
//            let indexPath = IndexPath(row: index, section: 0)
//            indexPathsToReload.append(indexPath)
//        }


        showIndixPaths = !showIndixPaths

        let animationStyle = showIndixPaths ? UITableView.RowAnimation.right : .left

        // when push "Show Indexpath" Button, slide page right (or left)
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }


// ------------------------- vieDidLoad() -------------------------------


    // **** Show Indexpath Button ******
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Indexpath", style: .plain, target: self, action: #selector(handleShowIndexPath))
    // *********************************


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
        return twoDimensionalArray.count
    }

     // *********************************






    // ************** Cell ***************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return twoDimensionalArray[section].count
//        if section == 0 {
//            return names.count
//        }
//        return cNames.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let name = twoDimensionalArray[indexPath.section][indexPath.row]

        // set name to cell.textLabel
        cell.textLabel?.text = name

        // "name", "indexPath", "indexPath".row
        if showIndixPaths {
            cell.textLabel?.text = "\(name)  Section:\(indexPath.section)   Row:\(indexPath.row)"
        }

        return cell

    }


}

