//
//  ItemDetailViewController.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    public var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ItemDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "itemDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemDetailTableViewCell", for: indexPath) as? ItemDetailTableViewCell else { return UITableViewCell() }
        
        guard let item = item else { return cell}
        let cellType = ItemTypesCells.detailItemTableViewCells(forItem: item)[indexPath.row]
        
        // In product app, would likely use utility class or ItemTypeCells class to help configure values
        switch cellType {

        // All Item models inherit name and description property
        case .name, .description:
            if cellType == .name {
                cell.label?.text = "Name: \(item.name)"
            } else {
                cell.label?.text = "Description: \(item.description)"
            }
            
        // Book
        case .numberOfPages, .author:
            guard let item = item as? Book else { return cell }
            if cellType == .numberOfPages {
                cell.label?.text = "Number Of Pages: \(String(item.numberOfPages))"
            } else {
                cell.label?.text = "Author: \(item.author)"
            }
            
        // Phone
        case .number, .business:
            guard let item = item as? Phone else { return cell }
            if cellType == .number {
                cell.label?.text = "Number: \(String(item.number))"
            } else {
                // return case should never be hit because cells will never contain business cell if business is nil
                guard let business = item.business else { return cell }
                cell.label?.text = "Business: \(business)"
            }
        // Car
        case .model, .year:
            guard let item = item as? Car else { return cell }
            if cellType == .model {
                cell.label?.text = "Model: \(item.model)"
            } else {
                cell.label?.text = "Year: \(String(item.year))"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let item = item else { return 0 }
        return ItemTypesCells.detailItemTableViewCells(forItem: item).count
    }
}
