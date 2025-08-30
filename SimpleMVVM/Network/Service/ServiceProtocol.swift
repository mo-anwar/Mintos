//
//  Service.swift
//  SimpleMVVM
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
        do {
            let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ServiceError.invalidResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw ServiceError.httpError(httpResponse.statusCode)
            }
            
            return data
            
        } catch let error as ServiceError {
            throw error
        } catch {
            let nsError = error as NSError
            switch nsError.code {
            case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                throw ServiceError.noConnection
            case NSURLErrorTimedOut:
                throw ServiceError.networkTimeout
            default:
                throw ServiceError.noConnection
            }
        }
    }
    
}
