//
//  AddItemTableViewControllerDelegate.swift
//  TodoListApp
//
//  Created by Shahad Nasser on 14/12/2021.
//

import Foundation

protocol AddItemViewControllerDelegate: AnyObject{
    func addItem(by controller: AddItemViewController, title: String, desc: String, date: Date)    
}
