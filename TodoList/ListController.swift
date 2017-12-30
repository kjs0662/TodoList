//
//  ViewController.swift
//  TodoList
//
//  Created by 김진선 on 2017. 12. 30..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    let cellID = "CellID"
    var itemArray = ["Study Swift", "Meet John", "Buy milk"]

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
        
        setupBarButtonItem()
    }
    
    func setupBarButtonItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        addButtonItem.tintColor = .white
        
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    @objc func handleAdd() {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
            guard let item = textField.text else { return }
            self.itemArray.append(item)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
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

