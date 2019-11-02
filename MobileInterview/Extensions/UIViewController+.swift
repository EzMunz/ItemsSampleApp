//
//  UIViewController+.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

// MARK: - ALERT
extension UIViewController {
    /// Function that presents an alert controller
    /// - parameters:
    ///     - title: A `String` that represents the title
    ///     - message: A `String` that represents the message
    func showAlert(withTitle title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
