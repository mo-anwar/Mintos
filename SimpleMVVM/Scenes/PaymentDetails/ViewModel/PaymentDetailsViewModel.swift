import Foundation
import Combine

@MainActor
final class PaymentDetailsViewModel: ViewModel {
    
    @MainActor
    final class Input: ObservableObject {
        let viewDidLoadTrigger = PassthroughSubject<Void, Never>()
    }
    
    @MainActor
    final class Output: ObservableObject {
        @Published var presentation: PaymentDetailsView.Presentation = .init()
    }
    
    private let paymentDetailsRepository: PaymentDetailsRepositoryProtocol
    
    let input: Input
    let output: Output
    
    init(paymentDetailsRepository: PaymentDetailsRepositoryProtocol) {
        self.paymentDetailsRepository = paymentDetailsRepository
        self.input = Input()
        self.output = Output()
        
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
        output.presentation = PaymentDetailsView.Presentation(
            title: "",
            list: [],
            error: nil,
            viewState: .loading
        )
        
        Task { @MainActor in
            do {
                let result = try await self.paymentDetailsRepository.getPaymentDetails()
                
                let list = result.items?.compactMap { item in
                    AccountView.Presentation(item)
                } ?? []
                
                output.presentation = PaymentDetailsView.Presentation(
                    title: result.paymentDetails ?? "",
                    list: list,
                    error: nil,
                    viewState: .loaded
                )
                
            } catch let serviceError as ServiceError {
                output.presentation = PaymentDetailsView.Presentation(
                    title: "",
                    list: [],
                    error: .init(error: serviceError.errorDescription, onRetry: {
                        print("Retry")
                    }),
                    viewState: .error
                )
            } catch {
                output.presentation = PaymentDetailsView.Presentation(
                    title: "",
                    list: [],
                    error: .init(error: error.localizedDescription, onRetry: {
                        print("Retry")
                    }),
                    viewState: .error
                )
            }
        }
    }
}
