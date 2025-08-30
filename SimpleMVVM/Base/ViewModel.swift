import Foundation
import Combine

@MainActor
class ViewModel: ObservableObject {
    
    internal var cancellables = Set<AnyCancellable>()
    
    deinit {
        cancellables.removeAll()
    }
}
