//
//  ItemDetailsViewModel.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import Foundation

protocol ItemDetailsViewModel {
    var item: Item { get set }
    
    func getTitle() -> String
    func getDescription() -> String
    func getImageURL() -> String
}

extension ItemDetailsViewModel {
    func getTitle() -> String {
        return item.title
    }
    
    func getDescription() -> String {
        return item.description
    }
    
    func getImageURL() -> String {
        return item.imageURL
    }
}

final class DefaultItemDetailsViewModel: ItemDetailsViewModel {
    var item: Item
    
    init(item: Item) {
        self.item = item
    }
}
