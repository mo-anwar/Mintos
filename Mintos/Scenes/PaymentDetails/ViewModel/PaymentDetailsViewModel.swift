//
//  PaymentDetailsViewModel.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation
import Combine

protocol PaymentDetailsViewModelProtocol {
    var input: PaymentDetailsViewModel.Input { get }
    var output: PaymentDetailsViewModel.Output { get }
}

final class PaymentDetailsViewModel: ViewModel, PaymentDetailsViewModelProtocol, ViewModelType {
    
    class Input: ObservableObject {
        let viewDidLoadTrigger: AnyUIEvent<Void> = .create()
    }
    
    class Output: ObservableObject {
        @Published var error: String?
        @Published fileprivate(set) var viewState: ViewState?
        @Published fileprivate(set) var dataSource: PaymentDetails?
    }
    
    private let paymentDetailsRepository: PaymentDetailsRepositoryProtocol
    
    let input: Input
    let output: Output
    
    init(paymentDetailsRepository: PaymentDetailsRepositoryProtocol) {
        input = .init()
        
        output = .init()
        
        self.paymentDetailsRepository = paymentDetailsRepository
        
        super.init()
        
        observeViewDidLoadTrigger()
        
    }
}

// MARK: - Observers
extension PaymentDetailsViewModel {
    
    private func observeViewDidLoadTrigger() {
        input
            .viewDidLoadTrigger
            .sink { [weak self] in
                guard let self else { return }
                self.loadInitialData()
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - Network
extension PaymentDetailsViewModel {
    
    private func loadInitialData() {
        Task { @MainActor in
            do {
                defer {
                    output.viewState = .idle
                }
                
                output.viewState = .loading(isUserInteractionEnabled: true)
                
                output.dataSource = try await paymentDetailsRepository.getPaymentDetails()
            } catch {
                output.error = error.localizedDescription
            }
        }
    }
    
}
