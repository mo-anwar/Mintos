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
                makeProgressView()
                
                makeErrorView()
                
                makeContentView()
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
        .isHidden(presentation.shouldHideContent, remove: true)
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
    @ViewBuilder
    private func makeErrorView() -> some View {
        if let error = presentation.error {
            ErrorView(presentation: error)
                .isHidden(presentation.shouldHideError, remove: true)
        }
    }
    
    // MARK: - ProgressView
    private func makeProgressView() -> some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .isHidden(presentation.shouldHideLoading, remove: true)
    }
    
}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SceneFactory.PaymentDetails.makePaymentDetailsView()
    }
}
