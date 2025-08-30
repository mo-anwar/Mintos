//
//  SimpleMVVMApp.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

import SwiftUI

@main
struct SimpleMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            SceneFactory.PaymentDetails.makePaymentDetailsView()
        }
    }
}
