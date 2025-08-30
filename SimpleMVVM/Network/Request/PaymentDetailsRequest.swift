import Foundation

struct PaymentDetailsRequest: Request {
    var urlRequest: URLRequest {
        return .init(url: Configuration.baseURL.appendingPathComponent(PaymentDetailsEndPoint.PaymentDetails))
    }
}
