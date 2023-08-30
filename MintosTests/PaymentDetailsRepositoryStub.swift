//
//  PaymentDetailsRepositoryStub.swift
//  MintosTests
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation
@testable import Mintos

final class PaymentDetailsRepositoryStub: PaymentDetailsRepositoryProtocol {

    var paymentDetails: PaymentDetails?
    
    func getPaymentDetails() async throws -> PaymentDetails {
        
        if let paymentDetails {
            return paymentDetails
        }
        
        throw ServiceError.noData
    }
    
}
