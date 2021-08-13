//
//  ItemFormTableViewCell.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import UIKit

protocol ItemFormTableViewCellDelegate: class {
    func textFieldDidChange(text: String, cellType: ItemTypesCells)
}

class ItemFormTableViewCell: UITableViewCell {
    
    weak var delegate: ItemFormTableViewCellDelegate?

    @IBOutlet weak var textField: UITextField!
    private var cellType: ItemTypesCells?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func textFieldDidChangeAction(_ sender: Any) {
        guard let text = textField.text, let cellType = cellType else { return }
        delegate?.textFieldDidChange(text: text, cellType: cellType)
    }
    
    public func configure(forCellType cellType: ItemTypesCells, delegate: ItemFormTableViewCellDelegate?) {
        
        self.textField.text = ""
        self.cellType = cellType
        self.delegate = delegate
        self.textField.placeholder = ItemTypesCells.tableViewCellFormPlaceHolder(forItemCell: cellType)
    }
}
