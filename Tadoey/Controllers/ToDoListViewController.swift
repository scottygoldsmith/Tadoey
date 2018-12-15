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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Data
        loadItems()
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
        saveItems()
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
            self.saveItems()
        }
        
    
        
        //Add Text Field Input to Alert Window
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        // ADD "CODABLE" TO DATA MODEL!!
        //Encode and save data
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        
        //Decode and load
        if let data = try? Data(contentsOf: dataFilePath!) {
           let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Items].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
            
        }
        
    }
    
}


