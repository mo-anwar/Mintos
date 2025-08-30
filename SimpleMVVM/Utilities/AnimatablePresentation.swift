@MainActor
protocol AnimatablePresentation {
    func shouldAnimate(to other: Self) -> Bool
}
