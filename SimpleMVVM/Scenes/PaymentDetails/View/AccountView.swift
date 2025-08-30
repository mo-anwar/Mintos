//
//  AccountView.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

import SwiftUI

struct AccountView: View {
    private let presentation: Presentation
    
    init(presentation: Presentation) {
        self.presentation = presentation
    }
    
    var body: some View {
            makeContent()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 8) {
            makeLabel(text: "Bank Name", value: presentation.bank)
            
            makeLabel(text: "Swift", value: presentation.swift)
            
            makeLabel(text: "Currency", value: presentation.currency)
            
            makeLabel(text: "Beneficiary Name", value: presentation.beneficiaryName)
            
            makeLabel(text: "Beneficiary Bank Address", value: presentation.beneficiaryBankAddress)
            
            makeLabel(text: "IBAN", value: presentation.iban)
        }
        .padding(.all)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
    
    // MARK: - Label
    private func makeLabel(text: String, value: String) -> some View {
        HStack {
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .accessibilityLabel("\(text): \(value)")
                .accessibilityAddTraits(.isStaticText)
        }
        .padding(.horizontal)
    }
}

#Preview {
    AccountView(presentation: .stub())
}
