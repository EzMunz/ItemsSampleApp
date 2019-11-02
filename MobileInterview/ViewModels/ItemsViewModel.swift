//
//  ItemsViewModel.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

/// Protocol that defines the Items ViewModel properties and behavior,
/// from fetching items to returning the collection view data
protocol ItemsViewModel {
    var items: [Item] { get set }
    var itemsUpdateHandler: (() -> Void)? { get set }
    var errorHandler: ((_ message: String) -> Void)? { get set }
    
    func fetchItems()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func numberOfItems(in section: Int, collectionView: UICollectionView) -> Int
    func cellForItem(at indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell
}

/// Default protocol extension
extension ItemsViewModel {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int, collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func cellForItem(at indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier(), for: indexPath) as? ItemCell else { fatalError("Cell Not Registered in CollectionView") }
        
        itemCell.item = items[safe: indexPath.row]
        return itemCell
    }
}

/// Default ViewModel implementation class
final class DefaultItemsViewModel: ItemsViewModel {
    var items: [Item] = [] {
        didSet {
            itemsUpdateHandler?()
        }
    }
    
    var itemsUpdateHandler: (() -> Void)?
    var errorHandler: ((_ message: String) -> Void)?
    
    func fetchItems() {
        let apiRequestProvider: APIRequestProvider = APIRequestProvider()
        let apiManager: ItemsAPIProtocol = ItemsAPIManager(requestProvider: apiRequestProvider)
        apiManager.fetchItems(completionHandler: { result in
            switch result {
            case .success(let items):
                self.items = items
            case .error(let error):
                print("FAILURE: \(error)")
            }
        })
    }
}
