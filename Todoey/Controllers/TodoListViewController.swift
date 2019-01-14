//
//  ViewController.swift
//  Todoey
//
//  Created by jiashun liu on 1/14/19.
//  Copyright © 2019 jiashun liu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray=[Item]()
    
    let dataFilePath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    //Mark - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item=itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //Mark - Table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            //what will happen item pressed
            self.itemArray.append(newItem)
            
           
            self.saveItems()
            
            
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField=alertTextField
        }
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data=try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("error decoding item array")
            }
        }
    }
}

