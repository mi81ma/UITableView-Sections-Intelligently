//
//  ViewController.swif
//  UITableView Sections Intelligently
//
//  Created by masato on 10/10/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // ********varta Set ***************
    let cellId = "cellId"


    var twoDimensionalArray = [

        ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mike"]),
        ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Christina", "Cameron"]),
        ExpandableNames(isExpanded: true, names: ["David", "Dan"]),
        ExpandableNames(isExpanded: true, names: ["Patrikc", "Patty"])

    ]

    var showIndixPaths = false

    // *********************************

    @objc func  handleShowIndexPath() {
        print("Attemping reload animation indexPaths...")

        // build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()

        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].names.indices {
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


    // ======== Navigation Bar ==========
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
     // =================================
    }

// ------------------------- End: vieDidLoad() ----------------------------



    // ****** add Header Sections ********

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // expand section
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        // add close section Function to "Close" button
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)

        // section
        button.tag = section

        return button

    }

    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")

        print(button.tag)
        // @objc's argument is "button"
        let section = button.tag

        // we'll try to clonse the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded

        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }


//        twoDimensionalArray[section].names.removeAll()

        

    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }

    // return the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }

     // *********************************




    // ************** Cell ***************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // ******* Expand or Not ********
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }

        return twoDimensionalArray[section].names.count
    }




    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]

        // set name to cell.textLabel
        cell.textLabel?.text = name

        // "name", "indexPath", "indexPath".row
        if showIndixPaths {
            cell.textLabel?.text = "\(name)  Section:\(indexPath.section)   Row:\(indexPath.row)"
        }

        return cell

    }


}

