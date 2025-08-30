//
//  ViewModel.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

import Foundation
import Combine

@MainActor
class ViewModel: ObservableObject {
    
    internal var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.removeAll()
    }
}
