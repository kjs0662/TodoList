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
    let todoListKey = "TodoListArray"
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

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
        
        
        print(dataFilePath)
        
        loadItems()
        
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
            let newItem = Item()
            newItem.title = item
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding item array, \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

