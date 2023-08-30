//
//  Service.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

protocol ServiceProtocol {
    func get(request: Request) async throws -> Data
}

final class NetworkService: ServiceProtocol {
    
    func get(request: Request) async throws -> Data {
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: ServiceError.noData)
                    return
                }
                continuation.resume(returning: data)
            }
            .resume()
        }
    }
    
}
