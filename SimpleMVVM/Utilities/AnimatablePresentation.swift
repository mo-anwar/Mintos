//
//  AnimatablePresentation.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

@MainActor
protocol AnimatablePresentation {
    func shouldAnimate(to other: Self) -> Bool
}
