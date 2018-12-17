//
//  CategoryViewController.swift
//  Tadoey
//
//  Created by Scotty Goldsmith on 12/16/18.
//  Copyright © 2018 Scotty Goldsmith. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Data
        loadCategory()
    }
    
    //MARK: - Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    //Load size of table from array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1 //Nil Coalescing Operator (??) = if nil, make 1
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    //Load table data from array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
    }
    
    //Mark: - TableView Delegate Methods
    //Select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
    }
    
    //Mark: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happend once the user clicks the Add Item Button on our UIAlert
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
    }
        
        //Add Text Field Input to Alert Window
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Create New Category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }

        tableView.reloadData()
    }
    
    func loadCategory() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}

