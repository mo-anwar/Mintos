import Foundation

extension AccountView {
    struct Presentation {
        let id: String
        let bank: String
        let swift: String
        let currency: String
        let beneficiaryName: String
        let beneficiaryBankAddress: String
        let iban: String
    }
}

extension AccountView.Presentation: Identifiable { }

extension AccountView.Presentation: Hashable { }

extension AccountView.Presentation: Sendable { }

extension AccountView.Presentation {
    init(_ item: Item) {
        self.id = item.id ?? UUID().uuidString
        self.bank = item.bank ?? ""
        self.swift = item.swift ?? ""
        self.currency = item.currency ?? ""
        self.beneficiaryName = item.beneficiaryName ?? ""
        self.beneficiaryBankAddress = item.beneficiaryBankAddress ?? ""
        self.iban = item.iban ?? ""
    }
}

extension AccountView.Presentation {
    static func stub() -> Self {
        .init(
            id: UUID().uuidString,
            bank: "Bank",
            swift: "swift",
            currency: "currency",
            beneficiaryName: "beneficiaryName",
            beneficiaryBankAddress: "beneficiaryBankAddress",
            iban: "iban"
        )
    }
}
