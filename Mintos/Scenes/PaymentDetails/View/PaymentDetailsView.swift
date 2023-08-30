//
//  PaymentDetailsView.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import SwiftUI
import Combine

struct PaymentDetailsView: View {
    
    private let viewModel: PaymentDetailsViewModelProtocol
    
    @StateObject private var input: PaymentDetailsViewModel.Input
    @StateObject private var output: PaymentDetailsViewModel.Output
    
    init(viewModel: PaymentDetailsViewModelProtocol) {
        self.viewModel = viewModel
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }
    
    var body: some View {
        makeContent()
            .onAppear(perform: {
                input.viewDidLoadTrigger.send()
            })
            .alert(isPresented: .constant($output.error.wrappedValue != nil)) {
                makeAlert()
            }
            .overlay(makeProgressView())
    }
    
    // MARK: - Content
    private func makeContent() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                makeHeader()
                
                Spacer()
                
                makeAccountList()
            }
        }
    }
    
    // MARK: - Header
    private func makeHeader() -> some View {
        Text("\(viewModel.output.dataSource?.paymentDetails ?? "")")
            .font(.headline)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading)
    }
    
    // MARK: - AccountsList
    private func makeAccountList() -> some View {
        LazyVStack() {
            ForEach(output.dataSource?.items ?? []) { item in
                makeAccountItem(item: item)
                
                Divider()
                    .foregroundColor(.gray)
            }
        }
    }
    
    // MARK: - AccountItem
    private func makeAccountItem(item: Item) -> some View {
            VStack {
                makeLabel(text: "Bank Name", value: item.bank ?? "")
                makeLabel(text: "Swift", value: item.swift ?? "")
                makeLabel(text: "Currency", value: item.currency ?? "")
                makeLabel(text: "Beneficiary Name", value: item.beneficiaryName ?? "")
                makeLabel(text: "Beneficiary Bank Address", value: item.beneficiaryBankAddress ?? "")
                makeLabel(text: "IBAN", value: item.iban ?? "")
            }
            .padding(.all)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.2))
            )
    }
    
    // MARK: - Label
    private func makeLabel(text: String, value: String) -> some View {
        Text("\(text):- \(value)")
            .font(.body)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading)
    }
    
    // MARK: - Alet
    private func makeAlert() -> Alert {
        Alert(
            title: Text("Error"),
            message: Text(output.error ?? ""),
            dismissButton: .default(Text("Got it!"))
        )
    }
    
    // MARK: - ProgressView
    private func makeProgressView() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .frame(width: 25, height: 25)
            .isHidden(output.viewState == .idle, remove: true)
    }

}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SceneFactory.PaymentDetails.makePaymentDetailsView()
    }
}
