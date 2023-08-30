//
//  ViewState.swift
//  Mintos
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation

enum ViewState: Equatable {
    case loading(isUserInteractionEnabled: Bool)
    case idle
}
