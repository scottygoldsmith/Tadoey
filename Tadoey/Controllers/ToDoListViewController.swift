//
//  ViewController.swift
//  Tadoey
//
//  Created by Scotty Goldsmith on 12/14/18.
//  Copyright © 2018 Scotty Goldsmith. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Items]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Items()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Items()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)

        let newItem3 = Items()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        // Do any additional setup after loading the view, typically from a nib.
        //Load data from UserDefaults
        if let items = defaults.array(forKey: "TodoListArray") as? [Items] {
            itemArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    //Load size of table from array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    //Load table data from array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary operation ===> value = condition ? valueIfTrue : valueIfFalse
        //If item.done is true set accessType = checkmark, if false = none
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //Mark - TableView Delegate Methods
    //Select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Add or Remove Checkmark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //if true, make false.  If false, make true.
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend once the user clicks the Add Item Button on our UIAlert
            let newItem = Items()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            //Save data to UserDefaults
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        //Add Text Field Input to Alert Window
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

