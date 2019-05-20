//
//  NetLayer.swift
//  MasterDetailApp
//
//  Created by Swigut Jan, ITP-IP on 20/05/2019.
//  Copyright © 2019 Swigut Jan. All rights reserved.
//

import Foundation

enum NetError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidURL
}

enum Result<T> {
    case success(T)
    case failure(NetError)
}

func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
    
    guard let dataURL = URL(string: url) else {
        completion(Result.failure(.invalidURL))
        return
    }
    
    let session = URLSession.shared
    let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        
        guard error == nil else {
            completion(Result.failure(NetError.networkError(error!)))
            return
        }
        
        guard let data = data else {
            completion(Result.failure(NetError.dataNotFound))
            return
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
            completion(Result.success(decodedObject))
        } catch let error {
            completion(Result.failure(NetError.jsonParsingError(error as! DecodingError)))
        }
    })
    
    task.resume()
}
