import Foundation
@testable import SimpleMVVM

final class PaymentDetailsRepositoryStub: PaymentDetailsRepositoryProtocol {

    var paymentDetails: PaymentDetails?
    
    func getPaymentDetails() async throws -> PaymentDetails {
        
        if let paymentDetails {
            return paymentDetails
        }
        
        throw ServiceError.noData
    }
    
}
