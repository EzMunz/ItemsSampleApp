//
//  Item.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import Foundation

/// Model object that represents a List Item
struct Item: Codable {
    let title: String
    let description: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageURL = "image"
    }
}
