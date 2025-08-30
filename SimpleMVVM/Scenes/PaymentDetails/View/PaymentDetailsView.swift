//
//  PaymentDetailsView.swift
//  SimpleMVVM
//
//  Created by Mohamed anwar on 30/08/2023.
//

import SwiftUI
import Combine

struct PaymentDetailsView: View {

    @State private var presentation: Presentation
    
    @StateObject private var viewModel: PaymentDetailsViewModel
    @StateObject private var input: PaymentDetailsViewModel.Input
    @StateObject private var output: PaymentDetailsViewModel.Output
    
    init(viewModel: PaymentDetailsViewModel) {
        _presentation = State(initialValue: PaymentDetailsView.Presentation())
        _viewModel = .init(wrappedValue: viewModel)
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                if presentation.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = presentation.error {
                    makeErrorView()
                } else {
                    makeContentView()
                }
            }
        }
        .onAppear {
            input.viewDidLoadTrigger.send()
        }
        .animateChanges(from: output.presentation, updating: $presentation)
    }
    
    // MARK: - Content View
    @ViewBuilder
    private func makeContentView() -> some View {
        VStack(spacing: 8) {
            makeHeader()
            
            ScrollView {
                makeAccountList()
            }
            .scrollIndicators(.hidden)
        }
    }
    
    // MARK: - Header
    private func makeHeader() -> some View {
        Text(presentation.title)
            .font(.headline)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading)
    }
    
    // MARK: - AccountsList
    private func makeAccountList() -> some View {
        LazyVStack(spacing: 8) {
            ForEach(presentation.list) { item in
                AccountView(presentation: item)
            }
        }
    }
    
    // MARK: - Error View
    private func makeErrorView() -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.orange)
            
            Text("Error")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(presentation.error ?? "An error occurred")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Button("Try Again") {
                input.viewDidLoadTrigger.send()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(.all, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - ProgressView
    private func makeProgressView() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .frame(width: 25, height: 25)
            .isHidden(presentation.shouldHideLoading, remove: true)
    }
    
}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SceneFactory.PaymentDetails.makePaymentDetailsView()
    }
}
