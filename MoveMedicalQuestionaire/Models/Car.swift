//
//  Car.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import Foundation

struct Car: Item {
    
    let itemType: ItemType = .car
    
    var name: String
    var description: String
    
    var model: String
    var year: Int
}
