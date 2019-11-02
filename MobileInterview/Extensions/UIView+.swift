//
//  UIView+.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

// MARK: - Identifiable
extension UIView {
    /// Returns an instance of the given type instantiated from a nib
    /// with the same name as the class
    class func createFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(T.identifier(), owner: nil, options: nil)![0] as! T
    }
    
    /// Returns the class unique name as an identifier
    class func identifier() -> String {
        return String(describing: self.classForCoder())
    }
}

// MARK: - Round Corners
extension UIView {
    /// Round specified corners using UIBezierPath.
    /// This eliminates the off-screen rendering performed by the default `layer.cornerRadius` property
    /// - parameters:
    ///     - corners: The option set of rect corners to be rounded
    ///     - radius: The radius of the rounded corner
    func roundCorners(corners: UIRectCorner, withRadius radius: Double) {
        // Creates the bezier path for the view corner rounding
        // Note: use `self.bounds` to apply the transformation to the view itself, not considering the position
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds,
                                              byRoundingCorners: corners,
                                              cornerRadii: CGSize(width: radius, height: radius))
        // Create the mask shape layer applying the bezier path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        // Set the mask to the view layer
        self.layer.mask = maskLayer
    }
}
