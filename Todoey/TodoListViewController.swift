//
//  ViewController.swift
//  Todoey
//
//  Created by jiashun liu on 1/14/19.
//  Copyright © 2019 jiashun liu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray=["Find Mike","Eat egg","Destory Demogorgon"]
    
    let defaults=UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items=defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray=items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    //Mark - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //Mark - Table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen item pressed
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray,forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField=alertTextField
        }
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
}

