import Foundation

enum ServiceError: Error, LocalizedError {
    case noData
    case invalidResponse
    case httpError(Int)
    case networkTimeout
    case noConnection
    case unknown(Error)
    
    var errorDescription: String {
        switch self {
        case .noData:
            return "No Data"
        case .invalidResponse:
            return "Invalid Response"
        case .httpError(let code):
            return "HTTP Error: \(code)"
        case .networkTimeout:
            return "Network Timeout"
        case .noConnection:
            return "No Connection"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
