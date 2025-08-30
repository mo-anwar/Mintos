//
//  PaymentDetailsViewPresentation.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case loaded
    case error
}

extension PaymentDetailsView {
    struct Presentation {
        var title: String
        var list: [AccountView.Presentation]
        var error: String?
        var viewState: ViewState
    }
}

extension PaymentDetailsView.Presentation: AnimatablePresentation {
    func shouldAnimate(to other: PaymentDetailsView.Presentation) -> Bool {
        title != other.title ||
        list != other.list ||
        error != other.error ||
        viewState != other.viewState
    }
}

extension PaymentDetailsView.Presentation: Hashable { }

extension PaymentDetailsView.Presentation {
    var shouldHideError: Bool {
        error == nil
    }
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var shouldHideLoading: Bool {
        !isLoading
    }
}

extension PaymentDetailsView.Presentation {
    init() {
        self.title = ""
        self.list = []
        self.error = nil
        self.viewState = .loading
    }
}
