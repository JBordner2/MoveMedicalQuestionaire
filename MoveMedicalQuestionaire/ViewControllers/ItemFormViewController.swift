//
//  ItemFormViewController.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import UIKit

protocol ItemFormViewControllerDelegate: class {
    func didCreateNewItem(item: Item)
}

class ItemFormViewController: UIViewController {
    
    weak var delegate: ItemFormViewControllerDelegate?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var tableViewCells = ItemTypesCells.formItemTableViewCells(forItemType: .phone)
    var formItem : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formItem = Phone(name: "", description: "", number: -1, business: nil)
        configureTableView()
    }
    
    @IBAction func didChangeSegmentAction(_ sender: Any) {
        // In a product app I would use an array of my ItemType enums to configure segemnt
        if segmentControl.selectedSegmentIndex == 0 {
            tableViewCells = ItemTypesCells.formItemTableViewCells(forItemType: .phone)
            formItem = Phone(name: "", description: "", number: -1, business: nil)
        } else if segmentControl.selectedSegmentIndex == 1 {
            tableViewCells = ItemTypesCells.formItemTableViewCells(forItemType: .book)
            formItem = Book(name: "", description: "", numberOfPages: -1, author: "")
        } else {
            tableViewCells = ItemTypesCells.formItemTableViewCells(forItemType: .car)
            formItem = Car(name: "", description: "", model: "", year: -1)
        }
        
        tableView.reloadData()
    }
    
    @IBAction func createButtonAction(_ sender: Any) {
        guard let item = formItem else { return }
        guard formIsComplete(item: item) else {
            presentIncompleteAlert()
            return
        }
        
        dismiss(animated: true) {
            self.delegate?.didCreateNewItem(item: item)
        }
    }
    
    private func presentIncompleteAlert() {
        let alertController = UIAlertController(title: "Form not complete", message: "Either a value was missing or a number was entered as a text. Please try again", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ItemFormTableViewCell", bundle: nil), forCellReuseIdentifier: "itemFormTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // In production app, would have this logic in viewModel or utility class
    private func formIsComplete(item: Item) -> Bool {
        guard let item = formItem else { return false }
        
        if item.description == "" || item.name == "" {
            return false
        }
        switch item.itemType {
        case .book:
            guard let item = formItem as? Book else { return false }
            if item.author == "" || item.numberOfPages < 0  {
                return false
            } else {
                return true
            }
        case .car:
            guard let item = formItem as? Car else { return false }
            if item.model == "" || item.year < 0 {
                return false
            } else {
                return true
            }
        case .phone:
            guard let item = formItem as? Phone else { return false }
            if item.number < 0 {
                return false
            } else {
                return true
            }
        }
    }
}

extension ItemFormViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemFormTableViewCell") as? ItemFormTableViewCell else { return UITableViewCell() }
        
        let cellType = tableViewCells[indexPath.row]
        cell.configure(forCellType: cellType, delegate: self)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
}

extension ItemFormViewController: ItemFormTableViewCellDelegate {
    
    // In production app, would have this logic in viewModel or utility class
    func textFieldDidChange(text: String, cellType: ItemTypesCells) {
        switch cellType {
        
        // Shared Item values
        case .name, .description:
            if cellType == .name {
                formItem?.name = text
            } else {
                formItem?.description = text
            }
            
        //Book
        case .numberOfPages, .author:
            guard var item = formItem as? Book else { return }
            if cellType == .numberOfPages {
                guard let numberOfPages = Int(text) else {
                    item.numberOfPages = -1
                    formItem = item
                    return
                }
                item.numberOfPages = numberOfPages
            } else {
                item.author = text
            }
            
            formItem = item
            
        // Phone
        case .number, .business:
            guard var item = formItem as? Phone else { return }
            if cellType == .number {
                guard let number = Int(text) else {
                    item.number = -1
                    formItem = item
                    return
                }
                item.number = number
            } else {
                item.business = text
            }
            
            formItem = item
            
        // Car
        case .model, .year:
            guard var item = formItem as? Car else { return }
            if cellType == .model {
                item.model = text
            } else {
                guard let year = Int(text) else {
                    item.year = -1
                    formItem = item
                    return
                    
                }
                item.year = year
            }
            
            formItem = item
        }
    }
}
