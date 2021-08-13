//
//  BookModel.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import Foundation

struct Book: Item {
    
    let itemType: ItemType = .book
    
    var name: String
    var description: String
    
    var numberOfPages: Int
    var author: String
}
