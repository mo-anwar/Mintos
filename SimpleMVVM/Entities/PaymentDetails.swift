//
//  PaymentDetails.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

struct PaymentDetails: Codable, Equatable {
    let paymentDetails: String?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable, Equatable {
    let id: String?
    let bank: String?
    let swift: String?
    let currency: String?
    let beneficiaryName: String?
    let beneficiaryBankAddress: String?
    let iban: String?
}
