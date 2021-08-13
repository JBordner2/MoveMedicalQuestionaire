//
//  Phone.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import Foundation

struct Phone: Item {
    
    let itemType: ItemType = .phone
    
    var name: String
    var description: String
    
    var number: Int
    var business: String?
}
