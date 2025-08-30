import Foundation

extension ErrorView {
    struct Presentation {
        let error: String
        let onRetry: @MainActor @Sendable () -> Void
    }
}

extension ErrorView.Presentation: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.error == rhs.error
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(error)
    }
}

extension ErrorView.Presentation: Sendable { }

extension ErrorView.Presentation {
    static var stub: ErrorView.Presentation {
        .init(error: "Error", onRetry: { })
    }
}
