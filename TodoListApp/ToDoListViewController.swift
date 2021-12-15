//
//  ViewController.swift
//  TodoListApp
//
//  Created by Shahad Nasser on 14/12/2021.
//

import UIKit
import CoreData

class ToDoListTableViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [ToDo]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ToDoTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        cell.titleLabel.text = items[indexPath.row].title!
        cell.descriptionLabel.text = items[indexPath.row].desc!
        cell.dateLabel.text = dateFormatter.string(from: items[indexPath.row].date!)
        if items[indexPath.row].checked {
            cell.accessoryType = .checkmark
            cell.backgroundColor = UIColor(named: "blue2")
        }else{
            cell.accessoryType = .none
            cell.backgroundColor = UIColor(named: "blue3")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        saveContext()
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                cell.backgroundColor = UIColor(named: "blue3")
                items[indexPath.row].checked = false
            } else {
                cell.accessoryType = .checkmark
                cell.backgroundColor = UIColor(named: "blue2")
                items[indexPath.row].checked = true
            }
        }
        saveContext()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addItemViewController = navigationController.topViewController as! AddItemViewController
        addItemViewController.delegate = self
    }
    
    func addItem(by controller: AddItemViewController, title: String, desc: String, date: Date) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: managedObjectContext) as! ToDo
        item.title = title
        item.desc = desc
        item.date = date
        item.checked = false
        items.append(item)
        saveContext()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [ToDo]
        }catch{
            print("\(error)")
        }
    }
    
}

