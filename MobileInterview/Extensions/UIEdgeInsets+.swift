//
//  UIEdgeInsets+.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

/// Extends `UIEdgeInsets` to add convenience properties for summing insets on one plane.
public extension UIEdgeInsets {
    
    /// The sum of the horizontal (left and right) insets.
    var horizontalInsets: CGFloat {
        return left + right
    }
    
    /// The sum of the vertical (top and bottom) insets.
    var verticalInsets: CGFloat {
        return top + bottom
    }
}
