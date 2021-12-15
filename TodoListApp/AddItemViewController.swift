//
//  AddItemTableViewController.swift
//  TodoListApp
//
//  Created by Shahad Nasser on 14/12/2021.
//

import UIKit

class AddItemViewController: UIViewController {
    weak var delegate: AddItemViewControllerDelegate?
//    var item: String?
//    var indexPath: NSIndexPath?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        datePicker.minimumDate = .now
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        delegate?.addItem(by: self, title: titleTextField.text!, desc: descriptionTextField.text!, date: datePicker.date)
    }
    

}
