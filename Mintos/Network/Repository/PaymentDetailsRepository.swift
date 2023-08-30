//
//  PaymentDetailsRepository.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

protocol PaymentDetailsRepositoryProtocol {
    func getPaymentDetails() async throws -> PaymentDetails
}

final class PaymentDetailsRepository: PaymentDetailsRepositoryProtocol {
    
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func getPaymentDetails() async throws -> PaymentDetails {
        let request = PaymentDetailsRequest()
        let data = try await service.get(request: request)
        return try JSONDecoder().decode(PaymentDetails.self, from: data, keyPath: "response")
    }
}
