//
//  UICollectionView+.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    /// Registers a specific cell class to the table view
    /// using the class identifier to create a nib instance
    /// - parameters:
    ///     - cell: The representative UITableViewCell class or subclass
    func register<T>(cell: T.Type) where T: UICollectionViewCell {
        self.register(UINib(nibName: T.identifier(), bundle: nil), forCellWithReuseIdentifier: T.identifier())
    }
}
