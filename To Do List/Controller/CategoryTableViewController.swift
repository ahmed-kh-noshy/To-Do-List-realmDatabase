//
//  CategoryTableViewController.swift
//  To Do List
//
//  Created by n0shy on 04/06/2023.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var catArray: Results<Category>!

    @IBAction func addCategoryButton(_ sender: UIBarButtonItem) {
        
        var alertText = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let category = Category()
            category.name = alertText.text!
            
            self.tableView.reloadData()
            
            try! self.realm.write{
                self.realm.add(category)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(addAction)
        alert.addAction(cancel)
        alert.addTextField{ (alertTextField) in
            
            alertTextField.placeholder = "Add Category"
            alertText = alertTextField
            
            
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Category List"
        catArray = realm.objects(Category.self)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = catArray[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let itemVC = segue.destination as! itemTableViewController
        let selectedCategory = catArray[tableView.indexPathForSelectedRow!.row]
        
        itemVC.category = selectedCategory
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        var category = catArray[indexPath.row]
        
        try! realm.write{
            realm.delete(category)
        }
        
        tableView.reloadData()
        
    }
    


}
