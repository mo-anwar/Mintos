import Foundation

protocol PaymentDetailsRepositoryProtocol {
    @MainActor func getPaymentDetails() async throws -> PaymentDetails
}

final class PaymentDetailsRepository: PaymentDetailsRepositoryProtocol {
    
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    @MainActor func getPaymentDetails() async throws -> PaymentDetails {
        do {
            let request = PaymentDetailsRequest()
            let data = try await service.get(request: request)
            
            let paymentDetails = try JSONDecoder().decode(
                PaymentDetails.self, 
                from: data, 
                keyPath: "response"
            )
            
            return paymentDetails
            
        } catch let serviceError as ServiceError {
            throw serviceError
        } catch {
            throw ServiceError.unknown(error)
        }
    }
}
