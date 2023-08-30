//
//  MintosApp.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import SwiftUI

@main
struct MintosApp: App {
    var body: some Scene {
        WindowGroup {
            SceneFactory.PaymentDetails.makePaymentDetailsView()
        }
    }
}
