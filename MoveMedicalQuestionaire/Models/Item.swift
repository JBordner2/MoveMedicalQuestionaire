//
//  ItemModel.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import Foundation

protocol Item {
    var name: String { get set  }
    var description: String { get set }
    var itemType: ItemType { get  }
}

enum ItemType: String {
    case book = "Book"
    case phone = "Phone"
    case car = "Car"
}
