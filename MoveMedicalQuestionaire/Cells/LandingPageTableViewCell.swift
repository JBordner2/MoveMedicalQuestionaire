//
//  LandingPageTableViewCell.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import UIKit

class LandingPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(withItem item: Item) {
        itemTypeLabel.text = item.itemType.rawValue
        nameLabel.text = item.name
        descriptionLabel.text = item.description
    }
}
