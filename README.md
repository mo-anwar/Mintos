# SimpleMVVM iOS App

A modern iOS application that displays payment details and bank account information using clean architecture principles and reactive programming.

## 📱 Features

- **Payment Details Display**: Shows investor information and associated bank accounts
- **Real-time Data Loading**: Fetches data from API with proper loading states
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Modern UI**: Clean SwiftUI interface with professional styling
- **Reactive Architecture**: Built with Combine for reactive data flow

## 🏗️ Architecture

### MVVM with Input/Output Pattern
- **Unidirectional Data Flow**: Clear separation between user inputs and view outputs
- **Reactive Programming**: Combine framework for data binding and state management
- **Clean Architecture**: Proper separation of concerns across layers

### Project Structure
```
SimpleMVVM/
├── Application/           # App entry point and configuration
├── Base/                 # Base classes and protocols
├── Configuration/        # App configuration settings
├── Entities/            # Data models (PaymentDetails, Item)
├── Extensions/          # Swift extensions (View, JSONDecoder)
├── Network/             # Networking layer
│   ├── Service/         # NetworkService, ServiceError
│   ├── Repository/      # PaymentDetailsRepository
│   ├── Errors/          # Domain-specific errors
│   └── Logging/         # Network logging utilities
├── Scenes/              # UI scenes and features
│   └── PaymentDetails/  # Payment details feature
│       ├── Model/       # View presentation models
│       ├── View/        # SwiftUI views
│       └── ViewModel/   # MVVM view models
└── Utilities/           # Helper classes and utilities
```

## 🛠️ Technical Stack

- **iOS 17.0+**: Modern iOS deployment target
- **SwiftUI**: Declarative UI framework
- **Combine**: Reactive programming framework
- **Swift Testing**: Modern testing framework
- **Async/Await**: Modern Swift concurrency
- **MVVM**: Model-View-ViewModel architecture pattern

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 17.0+ deployment target
- macOS 14.0+ for development

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd SimpleMVVM
   ```

2. Open the project in Xcode:
   ```bash
   open SimpleMVVM.xcodeproj
   ```

3. Build and run:
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

## 🧪 Testing

The project includes comprehensive unit tests using Swift Testing framework:

```bash
# Run tests from command line
xcodebuild test -project SimpleMVVM.xcodeproj -scheme SimpleMVVM -destination 'platform=iOS Simulator,name=iPhone 16'

# Or run from Xcode
# Press Cmd + U to run all tests
```

### Test Coverage
- **ViewModel Tests**: Input/output behavior and data transformation
- **Repository Tests**: Data fetching and error handling
- **Network Tests**: API integration and error scenarios

## 🔧 Configuration

### API Endpoint
The app fetches data from: `https://api.jsonbin.io/v3/b/673e2c4ead19ca34f8c8c9b1`

### Network Configuration
- **Timeout**: 30 seconds
- **Retry Logic**: Automatic retry on network failures
- **Error Handling**: Comprehensive error mapping and user feedback

## 📊 Data Models

### PaymentDetails
```swift
struct PaymentDetails: Codable {
    let paymentDetails: String?    // Investor ID
    let items: [Item]?            // Bank accounts
}
```

### Item (Bank Account)
```swift
struct Item: Codable {
    let bank: String?             // Bank name
    let swift: String?            // Swift code
    let currency: String?         // Currency code
    let beneficiaryName: String?  // Account holder
    let beneficiaryBankAddress: String?  // Bank address
    let iban: String?            // IBAN number
}
```

## 🎨 UI Components

- **PaymentDetailsView**: Main screen displaying all payment information
- **AccountView**: Individual bank account card component
- **Loading States**: Spinner and progress indicators
- **Error States**: User-friendly error messages with retry options

## 🔄 Data Flow

1. **User Opens App** → `viewDidLoadTrigger` fired
2. **ViewModel** → Calls repository to fetch data
3. **Repository** → Makes network request via service
4. **Service** → Fetches JSON data from API
5. **JSON Decoder** → Parses response with keyPath extraction
6. **ViewModel** → Transforms data to presentation model
7. **View** → Updates UI reactively via `@Published` properties

## 🛡️ Error Handling

### Network Errors
- **No Connection**: Offline state handling
- **Timeout**: Request timeout management
- **HTTP Errors**: Status code error mapping
- **Invalid Data**: JSON parsing error handling

### User Experience
- **Loading States**: Clear loading indicators
- **Error Messages**: User-friendly error descriptions
- **Retry Actions**: Easy retry mechanisms

## 🏃‍♂️ Performance

- **Async/Await**: Non-blocking network operations
- **Reactive UI**: Efficient SwiftUI updates
- **Memory Management**: Proper retain cycle prevention
- **Network Efficiency**: Minimal data transfer with targeted JSON parsing

## 🔮 Future Enhancements

- **Offline Support**: Cache data for offline viewing
- **Pull-to-Refresh**: Manual data refresh capability
- **Search & Filter**: Bank account filtering options
- **Accessibility**: Enhanced VoiceOver support
- **Localization**: Multi-language support
- **Analytics**: User behavior tracking

## 📝 License

This project demonstrates a simple MVVM architecture implementation in iOS.

## 👨‍💻 Author

**Mohamed Anwar**
- Email: mohamedanwar18295@gmail.com
- LinkedIn: [[LinkedIn]](https://www.linkedin.com/in/mohamed-anwar-aa0575b1/)

---

Built with ❤️ using Swift and SwiftUI
