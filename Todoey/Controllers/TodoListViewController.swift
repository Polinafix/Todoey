//
//  ViewController.swift
//  Todoey
//
//  Created by Polina Fiksson on 18/12/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //1.create a new object
    let defaults = UserDefaults.standard
    //mutable array
    var itemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Buy salt"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Go to the gym"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Practice iOS"
        itemArray.append(newItem2)
        
        //3. Retrive our array from user defaults
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }
    
    //MARK: - tableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let currentItem = itemArray[indexPath.row]
        cell.textLabel?.text = currentItem.title
        //ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - tableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new items
    
    @IBAction func addButtonPresses(_ sender: UIBarButtonItem) {
        //create a local variable
        var textField = UITextField()
        //create a new alert
        let alert = UIAlertController(title: "Add new to-do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //once the user click the add button
            if let myItem = textField.text {
               // print(myItem)
                let newItem = Item()
                newItem.title = myItem
                self.itemArray.append(newItem)
                //2.save into the defaults(key is for later retrieving the item)
                //self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
                
            }
            
            
        }
        //add a text field inside the ui alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item"
            //extending the scope
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    


}

