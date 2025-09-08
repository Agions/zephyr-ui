# Installation

This guide will help you install and set up zephyr-ui UI in your Flutter project.

## Prerequisites

Before installing zephyr-ui UI, ensure you have:

- **Flutter SDK**: Version 3.19.0 or higher
- **Dart SDK**: Version 3.3.0 or higher
- **Android Studio** or **Xcode** (for mobile development)
- A **Flutter project** created and running

## Installation Steps

### Step 1: Add Dependency

Add zephyr-ui UI to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  zephyr-ui: ^2.0.0
```

### Step 2: Install Packages

Run the following command to install the package:

```bash
flutter pub get
```

### Step 3: Import the Library

Import zephyr-ui UI in your Dart files:

```dart
import 'package:zephyr-ui/zephyr-ui.dart';
```

## Platform-Specific Setup

### Android Setup

No additional setup is required for Android. zephyr-ui UI works out of the box with Android projects.

### iOS Setup

For iOS, ensure your project meets the minimum requirements:

1. **Minimum iOS Version**: iOS 11.0 or higher
2. **Xcode Version**: 12.0 or higher

Add this to your `ios/Podfile` if needed:

```ruby
platform :ios, '11.0'
```

### Web Setup

For Flutter Web support, add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  zephyr-ui: ^2.0.0
  # Additional web dependencies if needed
  flutter_web_plugins:
    sdk: flutter
```

## Verification

To verify that zephyr-ui UI is properly installed, create a simple test:

```dart
import 'package:flutter/material.dart';
import 'package:zephyr-ui/zephyr-ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zephyr-ui Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('zephyr-ui Installation Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Test basic component
            zephyr-uiButton.primary(
              text: 'Test Button',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('zephyr-ui UI is working!')),
                );
              },
            ),
            const SizedBox(height: 20),
            // Test design tokens
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: zephyr-uiTokenManager().tokens.colors.primary.scale[1],
                borderRadius: zephyr-uiTokenManager().tokens.borderRadius.lgBorderRadius,
              ),
              child: Text(
                'Design Tokens Working',
                style: zephyr-uiTokenManager().tokens.typography.textStyles.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Troubleshooting

### Common Issues

#### 1. Version Conflicts

If you encounter version conflicts, ensure your Flutter and Dart versions meet the requirements:

```bash
flutter --version
```

Update if necessary:

```bash
flutter upgrade
```

#### 2. Build Failures

If you experience build failures, try:

```bash
flutter clean
flutter pub get
flutter run
```

#### 3. iOS CocoaPods Issues

For iOS build issues, update CocoaPods:

```bash
cd ios
pod repo update
pod install
```

#### 4. Android Gradle Issues

For Android build issues, try:

```bash
cd android
./gradlew clean
./gradlew build
```

## Next Steps

Once zephyr-ui UI is successfully installed:

1. **Read the [Quick Start Guide](./quick-start)** to learn basic usage
2. **Explore [Design Tokens](./design-tokens/overview)** for theming
3. **Browse [Components](./components/overview)** to see what's available
4. **Check out [Examples](./examples)** for real-world usage patterns

## Development Setup

For development with zephyr-ui UI, consider these additional tools:

### Recommended VS Code Extensions

- **Flutter** - Official Flutter extension
- **Dart** - Dart language support
- **Awesome Flutter Snippets** - Flutter code snippets
- **Material Theme** - Material Design themes

### Development Dependencies

Add these to your `pubspec.yaml` for development:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  build_runner: ^2.4.7
```

## Support

If you encounter issues during installation:

1. **Check the [FAQ](./faq)** for common problems
2. **Search [GitHub Issues](https://github.com/agions/zephyr-ui/issues)** for similar problems
3. **Create a new issue** if your problem isn't already reported
4. **Join our Discord** for community support

## System Requirements

### Minimum Requirements

- Flutter: 3.19.0+
- Dart: 3.3.0+
- Android: API level 21+
- iOS: 11.0+

### Recommended Requirements

- Flutter: Latest stable
- Dart: Latest stable
- Android: API level 24+
- iOS: 13.0+

---

**Next: [Quick Start Guide](./quick-start)** →
