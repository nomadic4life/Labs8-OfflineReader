//
//  APIService.swift
//  Anywhere Reader
//
//  Created by Conner on 11/27/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation
import Stripe

enum Result {
    case success
    case failure(Error)
}

final class APIService {
    static let shared = APIService()
    
    private init() {}
    
    private lazy var baseURL: URL = {
        guard let url = URL(string: "https://anywhere-reader-test.herokuapp.com/") else {
            fatalError("Invalid URL")
        }
        return url
    }()
    
    // MARK: - Stripe Payments
    
    func completeCharge(with token: STPToken, amount: Int, completion: @escaping (Result) -> Void) {
        let url = baseURL.appendingPathComponent("api").appendingPathComponent("create-charge/")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyData = "source=\(token.tokenId)&amount=\(amount)&currency=usd&description=test"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            if let error = error {
                NSLog("Error with charge: \(error)")
                completion(Result.failure(error))
                return
            }
            completion(Result.success)
        }).resume()
    }
}
