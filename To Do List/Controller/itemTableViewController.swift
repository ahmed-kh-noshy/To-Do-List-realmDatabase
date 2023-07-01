//
//  itemTableViewController.swift
//  To Do List
//
//  Created by n0shy on 04/06/2023.
//

import UIKit
import RealmSwift
class itemTableViewController: UITableViewController {

    let realm = try! Realm()
    var itemArray : Results<Item>!
    
    var category: Category?{
        didSet{
            itemArray = category?.items.sorted(byKeyPath: "name")
        }
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        
        var alertText = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let item = Item()
            item.name = alertText.text!
            
            try! self.realm.write{
                self.category?.items.append(item)
            }
            self.tableView.reloadData()
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(addAction)
        alert.addAction(cancel)
        alert.addTextField{ (alertTextField) in
            
            alertTextField.placeholder = "Add Item"
            alertText = alertTextField
            
            
        }
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].name

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        
        try! realm.write{
            item.checked = !item.checked
        }
        
        if item.checked{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        var item = itemArray[indexPath.row]
        
        try! realm.write{
            realm.delete(item)
        }
        
        tableView.reloadData()
        
    }
    
    
    func handleSwipeToBack() {
      dismiss(animated: true, completion: nil)
    }

  

}
