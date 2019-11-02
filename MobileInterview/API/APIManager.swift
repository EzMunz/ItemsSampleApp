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
protocol ItemsAPIProtocol {
    /// Function that retrieves the Item list
    /// - parameters:
    ///     - completionHandler: A completion block used to send the completion result
    func fetchItems(completionHandler: @escaping APICompletionHandler<[Item]>)
}

final class ItemsAPIManager: ItemsAPIProtocol {
    private let requestProvider: APIRequestProvider
    
    init(requestProvider: APIRequestProvider) {
        self.requestProvider = requestProvider
    }
    
    func fetchItems(completionHandler: @escaping APICompletionHandler<[Item]>) {
        guard let url = URL(string: "http://private-f0eea-mobilegllatam.apiary-mock.com/list") else {
            fatalError("Invalid URL")
        }
        // Create the request object
        let request = requestProvider.createRequest(withURL: url, httpMethod: .get)
        // Call the service using Alamofire
        Alamofire.request(request).validate().responseJSON { response in
            guard let data = response.data else {
                completionHandler(.error("Found empty response data"))
                return
            }
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let itemsData: [Item] = try decoder.decode([Item].self, from: data)
                completionHandler(.success(itemsData))
            }
            catch {
                completionHandler(.error("Unable to parse the data from the response"))
            }
        }
    }
}
