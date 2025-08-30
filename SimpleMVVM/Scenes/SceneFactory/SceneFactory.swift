import Foundation
import SwiftUI

enum SceneFactory {
    
}

extension SceneFactory {
    enum PaymentDetails {
        @MainActor
        static func makePaymentDetailsView() -> PaymentDetailsView {
            let service = NetworkService()
            let paymentDetailsRepository = PaymentDetailsRepository(service: service)
            let viewModel = PaymentDetailsViewModel(paymentDetailsRepository: paymentDetailsRepository)
            return .init(viewModel: viewModel)
        }
    }
}
