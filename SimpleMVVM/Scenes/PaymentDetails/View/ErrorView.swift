//
//  ErrorView.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2025.
//

import SwiftUI

struct ErrorView: View {
    private let presentation: Presentation
    
    init(presentation: Presentation) {
        self.presentation = presentation
    }
    
    var body: some View {
        makeContent()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            makeImage()
            
            makeTitle()
            
            makeDescription()
            
            makeButton()
        }
        .padding(.all, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
    
    private func makeImage() -> some View {
        Image(systemName: "exclamationmark.triangle")
            .font(.system(size: 48))
            .foregroundColor(.orange)
    }
    
    private func makeTitle() -> some View {
        Text("Error")
            .font(.headline)
            .fontWeight(.semibold)
    }
    
    private func makeDescription() -> some View {
        Text(presentation.error)
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding(.horizontal)
    }
    
    private func makeButton() -> some View {
        Button("Try Again") {
            presentation.onRetry()
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

#Preview {
    ErrorView(presentation: .stub)
}
