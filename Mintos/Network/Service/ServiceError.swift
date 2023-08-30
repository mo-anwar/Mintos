//
//  ServiceError.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case noData
    
    var errorDescription: String {
        switch self {
        case .noData:
            return "No Data"
        }
    }
}
