//
//  ViewController.swift
//  Todoey
//
//  Created by Polina Fiksson on 18/12/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //1. Create a filepath to the document's folder:
    //2. Create our own plist sub-directory
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //mutable array
    var itemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        //load our items.plist > decoding
        loadItems()
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
        cell.accessoryType = currentItem.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - tableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //save the changes
        saveItems()
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
                self.saveItems()
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
    
    //MARK: - Model manipulation methods
    
    func saveItems() {
        //3.create an encoder
        let encoder = PropertyListEncoder()
        //4.it will encode our itemArray into property list
        do {
            let data = try encoder.encode(itemArray)
            //5.write our data to our data file path
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array,\(error) ")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        //1.tap into the data located in the documents
        if let data = try? Data(contentsOf: dataFilePath!){
           //2.create a decoder
            let decoder = PropertyListDecoder()
            //3.set the itemArray to the contents of plist file
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("Error decoding item array,\(error) ")
            }
        }
    }
    
    
    


}

