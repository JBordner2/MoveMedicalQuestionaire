//
//  ItemTypeCells.swift
//  MoveMedicalQuestionaire
//
//  Created by Jack Bordner on 8/12/21.
//

import Foundation

enum ItemTypesCells {
    case name
    case description
    case numberOfPages
    case author
    case number
    case business
    case model
    case year

    static func formItemTableViewCells(forItemType item: ItemType) -> [ItemTypesCells] {
        
        switch item {
        case .book:
            return [.name, .description, .numberOfPages, .author]
        case .phone:
            return [.name, .description, .number, .business]
        case .car:
            return [.name, .description, .model, .year]
        }
    }
    
    static func detailItemTableViewCells(forItem item: Item) -> [ItemTypesCells] {
        
        if let _ = item as? Book {
            return [.name, .description, .numberOfPages, .author]
        } else if let item = item as? Phone {
            if item.business == nil {
                return [.name, .description, .number]
            } else {
                return [.name, .description, .number, .business]
            }
        }
        else if let _ = item as? Car {
            return [.name, .description, .model, .year]
        } else {
            return []
        }
    }
    
    static func tableViewCellFormPlaceHolder(forItemCell itemType: ItemTypesCells) -> String {
        
        switch itemType {
        case .name:
            return "name"
        case .description:
            return "description"
        case .numberOfPages:
            return "number of pages"
        case .author:
            return "author"
        case .number:
            return "number"
        case .business:
            return "Optional(business)"
        case .model:
            return "model"
        case .year:
            return "year"
        }
    }
}
