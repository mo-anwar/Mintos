import SwiftUI

@main
struct SimpleMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            SceneFactory.PaymentDetails.makePaymentDetailsView()
        }
    }
}
