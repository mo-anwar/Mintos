//
//  View.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

// MARK: Animation
extension View {
    func animate(if condition: Bool, animations: @escaping () -> Void) {
        if condition {
            withAnimation {
                animations()
            }
        } else {
            animations()
        }
    }
}


extension ViewModifier {
    func animate(if condition: Bool, animations: @escaping () -> Void) {
        if condition {
            withAnimation {
                animations()
            }
        } else {
            animations()
        }
    }
}

extension View {
    func animateChanges<Presentation: AnimatablePresentation & Equatable>(
        from source: Presentation,
        updating destination: Binding<Presentation>
    ) -> some View {
        onChange(of: source) { oldValue, newValue in
            animate(if: oldValue.shouldAnimate(to: newValue)) {
                destination.wrappedValue = newValue
            }
        }
    }
}
