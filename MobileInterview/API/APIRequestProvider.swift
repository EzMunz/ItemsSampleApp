//
//  APIManager.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import Foundation
import Alamofire

public enum ApiResult <T> {
    case success(T)
    case error(String)
}

typealias ApiCompletionHandler<T> = ((ApiResult<T>) -> Void)

class ApiManager {
    func createRequest(withURL url: URL, httpMethod: HTTPMethod, andParams params: [String: Any]? = nil) -> URLRequest {
        // Create the request with the url
        var request: URLRequest = URLRequest(url: url)
        // Set the correct http method to the request object
        request.httpMethod = httpMethod.rawValue
        // Return the initial request object if there are no params
        guard let params = params else { return request }
        // Set the proper parameter encoding
        let destination: URLEncoding.Destination = httpMethod == .get ? .queryString : .httpBody
        let urlEncoder = Alamofire.URLEncoding(destination: destination, arrayEncoding: .brackets, boolEncoding: .literal)
        do {
            return try urlEncoder.encode(request, with: params)
        }
        catch {
            fatalError("Couldn't encode the request with the given params")
        }
    }
}

