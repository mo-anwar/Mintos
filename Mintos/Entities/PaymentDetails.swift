//
//  PaymentDetails.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

struct PaymentDetails: Codable {
    let paymentDetails: String?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable, Identifiable {
    var id: String { iban ?? "" }
    let bank: String?
    let swift: String?
    let currency: String?
    let beneficiaryName: String?
    let beneficiaryBankAddress: String?
    let iban: String?
}
