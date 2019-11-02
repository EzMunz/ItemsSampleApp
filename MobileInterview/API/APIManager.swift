//
//  ItemsAPIManager.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import Foundation
import Alamofire

/// A protocol that defines the Items API Manager behavior
protocol ItemsApiProtocol {
    /// Function that retrieves the Item list
    /// - parameters:
    ///     - completionHandler: A completion block used to send the completion result
    func fetchItems(completionHandler: @escaping ApiCompletionHandler<[Item]>)
}

final class ItemsApiManager: ApiManager, PhotosApiProtocol {
    func fetchItems(completionHandler: @escaping ApiCompletionHandler<[Item]>) {
        guard let url = URL(string: "http://www.splashbase.co/api/v1/images/latest") else {
            fatalError("Invalid URL")
        }
        // Create the request object
        let request = createRequest(withURL: url, httpMethod: .get)
        // Call the service
        Alamofire.request(request).validate().responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                completionHandler(.error("Found empty response"))
                return
            }
            
            let photosData: [[String: Any]] = json.array(forKey: "images")
            let userResponse: [Photo] = photosData.compactMap { data in
                let id = data.int(forKey: "id")
                let url = data.string(forKey: "url")
                let largeUrl = data.string(forKey: "large_url")
                return Photo(id: id, url: url, largeUrl: largeUrl)
            }
            completionHandler(.success(userResponse))
        }
    }
}
