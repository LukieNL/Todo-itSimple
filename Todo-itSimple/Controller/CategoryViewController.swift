//
//  CategoryViewController.swift
//  Todo-itSimple
//
//  Created by Lucas van Leerdam on 20/05/2020.
//  Copyright © 2020 Lucas van Leerdam. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        tableView.rowHeight = 60.0
    }

    override func viewWillAppear(_ animated: Bool) {
        
        setColor()

    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryArray?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let message = categoryArray?[indexPath.row]
        
        
        cell.textLabel?.text = message?.name ?? "No Categories Added Yet"
        
        cell.backgroundColor = UIColor(hexString: message?.color ?? "ffffff")
        
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        
        return cell
    }
    
    //MARK: - Delete Data with Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let deleteCategory = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(deleteCategory)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != "" {
                
                let newCategory = Category()
                newCategory.name = textField.text!
                newCategory.color = RandomFlatColor().hexValue()
                
                self.saveCategories(category: newCategory)
                
            } else {
                print("Nothing added!")
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Categories"
        navigationItem.backBarButtonItem = backItem
    }
    
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories(category: Category) {
            do {
                
                try realm.write {
                    realm.add(category)
                }
            } catch {
                print("Error saving categories, \(error)")
            }
            
            self.tableView.reloadData()
        }
        
        func loadCategories() {
            
            categoryArray = realm.objects(Category.self)
            
            tableView.reloadData()
        }
    
    
    //MARK: - Color Methods
    
    func setColor() {
        
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        let color = UIColor(hexString: "1D9BF6")
        let contrastColour = ContrastColorOf(color!, returnFlat: true)
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: contrastColour]
        navBarAppearance.backgroundColor = color
        navBar.tintColor = contrastColour
        navBar.standardAppearance = navBarAppearance
        navBar.scrollEdgeAppearance = navBarAppearance
        
    }
    
    
    
    
}
