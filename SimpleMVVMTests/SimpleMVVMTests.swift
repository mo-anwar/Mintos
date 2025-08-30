//
//  SimpleMVVMTests.swift
//  SimpleMVVMTests
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Testing
import Combine
@testable import SimpleMVVM

@Suite("Payment Details ViewModel Tests")
struct PaymentDetailsViewModelTests {
    
    @MainActor
    func makeViewModel() -> (PaymentDetailsViewModel, PaymentDetailsRepositoryStub) {
        let repository = PaymentDetailsRepositoryStub()
        let viewModel = PaymentDetailsViewModel(paymentDetailsRepository: repository)
        return (viewModel, repository)
    }
    
    @Test("Fetch payment details success")
    @MainActor
    func fetchPaymentDetailsSuccess() async {
        // Given
        let (viewModel, repository) = makeViewModel()
        
        let paymentDetails: PaymentDetails = .init(
            paymentDetails: "Investor ID: 54361338",
            items: [
                .init(
                    id: "1",
                    bank: "Bank",
                    swift: "swift",
                    currency: "currency",
                    beneficiaryName: "beneficiaryName",
                    beneficiaryBankAddress: "beneficiaryBankAddress",
                    iban: "iban"
                )
            ]
        )
        
        repository.paymentDetails = paymentDetails
        
        // Initially should be empty
        #expect(viewModel.output.presentation.title == "")
        #expect(viewModel.output.presentation.list.isEmpty)
        #expect(viewModel.output.presentation.viewState == .loading)
        
        // When
        viewModel.input.viewDidLoadTrigger.send()
        
        // Wait for async operation to complete
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        
        // Then
        #expect(viewModel.output.presentation.title == "Investor ID: 54361338")
        #expect(viewModel.output.presentation.list.count == 1)
        #expect(viewModel.output.presentation.viewState == .loaded)
        #expect(viewModel.output.presentation.error == nil)
    }
    
    @Test("Fetch payment details failure")
    @MainActor
    func fetchPaymentDetailsFailure() async {
        // Given
        let (viewModel, repository) = makeViewModel()
        
        // Set repository to return nil (which triggers error)
        repository.paymentDetails = nil
        
        // Initially should be empty
        #expect(viewModel.output.presentation.title == "")
        #expect(viewModel.output.presentation.list.isEmpty)
        #expect(viewModel.output.presentation.viewState == .loading)
        #expect(viewModel.output.presentation.error == nil)
        
        // When
        viewModel.input.viewDidLoadTrigger.send()
        
        // Wait for async operation to complete
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        
        // Then
        #expect(viewModel.output.presentation.title == "")
        #expect(viewModel.output.presentation.list.isEmpty)
        #expect(viewModel.output.presentation.viewState == .error)
        #expect(viewModel.output.presentation.error == nil)
    }
    
    @Test("Loading state during fetch")
    @MainActor
    func loadingStateDuringFetch() async {
        // Given
        let (viewModel, repository) = makeViewModel()
        
        let paymentDetails: PaymentDetails = .init(
            paymentDetails: "Investor ID: 54361338",
            items: [
                .init(
                    id: "2",
                    bank: "Test Bank",
                    swift: "TEST",
                    currency: "EUR",
                    beneficiaryName: "Test User",
                    beneficiaryBankAddress: "Test Address",
                    iban: "TEST123456789"
                )
            ]
        )
        
        repository.paymentDetails = paymentDetails
        
        // When - trigger load
        viewModel.input.viewDidLoadTrigger.send()
        
        // Wait for completion
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        
        // Should eventually be loaded
        #expect(viewModel.output.presentation.viewState == .loaded)
        #expect(viewModel.output.presentation.title == "Investor ID: 54361338")
    }

}
