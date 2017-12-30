//
//  ViewController.swift
//  TodoList
//
//  Created by 김진선 on 2017. 12. 30..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellID = "CellID"
    let itemArray = ["Study Swift", "Meet John", "Buy milk"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: view.frame.height))
        titleLabel.text = "  TodoList"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        navigationItem.titleView = titleLabel
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checked = tableView.cellForRow(at: indexPath)
        if checked?.accessoryType == .checkmark {
            checked?.accessoryType = .none
        } else {
            checked?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

