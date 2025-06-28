# Flutter AI Chat Application

A Flutter-based mobile application that integrates with Google AI Studio API to provide intelligent conversational responses. Built with modern Flutter architecture patterns using BLoC for state management and Dio for efficient API communication.

## 🚀 Features

- **AI-Powered Conversations**: Seamless integration with Google AI Studio API
- **Cross-Platform**: Runs on both iOS and Android devices
- **Real-time Chat Interface**: Intuitive chat UI for natural conversations
- **State Management**: Robust state handling using BLoC pattern
- **Error Handling**: Comprehensive error management and user feedback
- **Responsive Design**: Optimized for different screen sizes

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: BLoC (Business Logic Component)
- **HTTP Client**: Dio
- **API**: Google AI Studio API
- **Language**: Dart

## 📱 Screenshots

*Add your app screenshots here*

<img width="347" alt="Screenshot 2025-06-28 at 10 31 26 AM" src="https://github.com/user-attachments/assets/d98ce5ea-ac13-4e30-a09e-b5eeeefe5a8c" />

<img width="347" alt="Screenshot 2025-06-28 at 10 33 38 AM" src="https://github.com/user-attachments/assets/b98c66b5-b26b-44f8-bb08-b683bfbf496f" />

## 🏗️ Architecture

The app follows Clean Architecture principles with separation of concerns:

```
lib/
├── bloc/           # BLoC state management
├── models/         # Data models
├── repositories/   # Data layer
├── services/       # API services
├── screens/        # UI screens
├── widgets/        # Reusable widgets
└── main.dart       # App entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Google AI Studio API key
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-ai-chat.git
   cd flutter-ai-chat
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   
   Create a `.env` file in the root directory:
   ```env
   GOOGLE_AI_API_KEY=your_api_key_here
   ```
   
   Or add your API key to `lib/config/api_config.dart`:
   ```dart
   class ApiConfig {
     static const String apiKey = 'YOUR_API_KEY_HERE';
     static const String baseUrl = 'https://generativelanguage.googleapis.com';
   }
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Google AI Studio Setup

1. Visit [Google AI Studio](https://makersuite.google.com/)
2. Create a new project or select existing one
3. Generate an API key
4. Add the API key to your project configuration

### Environment Variables

Create a `.env` file with the following variables:
```env
GOOGLE_AI_API_KEY=your_google_ai_studio_api_key
API_BASE_URL=https://generativelanguage.googleapis.com
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  dio: ^5.3.2
  equatable: ^2.0.5
  flutter_dotenv: ^5.1.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.4
  mocktail: ^1.0.0
```

## 🏛️ Project Structure

### BLoC Implementation

```dart
// Chat BLoC for managing conversation state
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ApiService apiService;
  
  ChatBloc({required this.apiService}) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<LoadChatHistoryEvent>(_onLoadChatHistory);
  }
}
```

### API Service with Dio

```dart
class ApiService {
  final Dio _dio;
  
  ApiService() : _dio = Dio() {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer ${ApiConfig.apiKey}',
      'Content-Type': 'application/json',
    };
  }
  
  Future<String> sendMessage(String message) async {
    // Implementation for API call
  }
}
```

## 🧪 Testing

Run tests using:

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Widget tests
flutter test test/widget_test/
```

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## 🔮 Future Enhancements

- [ ] Message history persistence
- [ ] Multiple AI model support
- [ ] Voice input/output
- [ ] Dark/Light theme toggle
- [ ] Message search functionality
- [ ] Export chat conversations


## 👏 Acknowledgments

- Google AI Studio for providing the AI API
- Flutter team for the amazing framework
- BLoC library maintainers
- Dio HTTP client contributors

## 📊 Performance

- App size: ~XX MB
- Cold start time: ~X seconds
- Memory usage: ~XX MB average

---

**Made with ❤️ using Flutter**
