//
//  UIImageView+.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import Foundation
import UIKit

// Create a NSCache object for the URL - Image
fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    /// Downloads an image from a URL, inserting the resulting image in this instance
    /// In the case the image is already downloaded, it will get it from cache to prevent equal requests
    /// - Parameters:
    ///     - url: The url of the image
    ///     - contentMode: The UIViewContentMode that will apply for the image
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionHandler: (() -> Void)? = nil) {
        // Apply the UIView ContentMode
        contentMode = mode
        
        // Look for the url in the cache to get the saved image in case is cached
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completionHandler?()
            return
        }
        // Create a URLSession dataTask to retrieve the image from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for the response properties to ensure it contains actual image data
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("ImageView: Invalid image url")
                    return
                }
            // Update the UI on the main thread
            // Save the downloaded image in cache
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                self.image = image
                completionHandler?()
            }
        }.resume()
    }
    
    /// Downloads an image from a link (url path), inserting the resulting image in this instance
    /// - Parameters:
    ///     - link: The url path of the image
    ///     - contentMode: The UIViewContentMode that will apply for the image
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completionHandler: (() -> Void)? = nil) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode, completionHandler: completionHandler)
    }
}
