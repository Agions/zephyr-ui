# ZephyrUI Getting Started Guide

## Table of Contents
- [Introduction](#introduction)
- [Installation](#installation)
- [Basic Setup](#basic-setup)
- [First Component](#first-component)
- [Theme Configuration](#theme-configuration)
- [Common Components](#common-components)
- [Responsive Design](#responsive-design)
- [Accessibility](#accessibility)
- [Testing](#testing)
- [Next Steps](#next-steps)

## Introduction

Welcome to ZephyrUI! This guide will help you get started with our comprehensive Flutter component library. ZephyrUI provides 60+ high-quality components with a consistent design system, built-in accessibility, and excellent performance.

### What You'll Learn

- How to install and set up ZephyrUI
- Basic component usage
- Theme customization
- Responsive design patterns
- Accessibility best practices
- Testing strategies

## Installation

### Prerequisites

Before you begin, ensure you have the following:

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- A Flutter project set up

### Step 1: Add ZephyrUI to Your Project

Add ZephyrUI to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  zephyr_ui: ^0.1.0
```

### Step 2: Install Dependencies

Run the following command in your terminal:

```bash
flutter pub get
```

### Step 3: Import ZephyrUI

Import ZephyrUI in your Dart files:

```dart
import 'package:zephyr_ui/zephyr_ui.dart';
```

## Basic Setup

### Step 1: Wrap Your App with ZephyrApp

Replace your `MaterialApp` with `ZephyrApp`:

```dart
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrApp(
      title: 'My App',
      theme: ZephyrTheme.light(),
      darkTheme: ZephyrTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
```

### Step 2: Create a Basic Home Screen

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to ZephyrUI!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a demonstration of ZephyrUI components.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            // Components will be added here
          ],
        ),
      ),
    );
  }
}
```

## First Component

Let's add your first ZephyrUI component - a button:

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to ZephyrUI!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a demonstration of ZephyrUI components.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            
            // Your first ZephyrUI component
            ZephyrButton(
              text: 'Click Me!',
              onPressed: () {
                ZephyrToast.show(
                  context,
                  message: 'Hello from ZephyrUI!',
                  type: ZephyrToastType.success,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Theme Configuration

ZephyrUI provides powerful theming capabilities. Let's customize the theme:

### Create a Custom Theme

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrApp(
      title: 'My App',
      theme: _createCustomTheme(),
      darkTheme: ZephyrTheme.dark(),
      home: const HomeScreen(),
    );
  }

  ZephyrThemeData _createCustomTheme() {
    return ZephyrThemeData(
      primaryColor: const Color(0xFF6366F1),
      secondaryColor: const Color(0xFF8B5CF6),
      backgroundColor: const Color(0xFFF9FAFB),
      surfaceColor: Colors.white,
      errorColor: const Color(0xFFEF4444),
      warningColor: const Color(0xFFF59E0B),
      successColor: const Color(0xFF10B981),
      infoColor: const Color(0xFF3B82F6),
      
      // Typography
      typography: ZephyrTypography(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        h1: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        h2: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        h3: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        body: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        caption: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),
      
      // Border radius
      borderRadius: ZephyrBorderRadius(
        small: 4,
        medium: 8,
        large: 12,
        xlarge: 16,
        full: 9999,
      ),
      
      // Spacing
      spacing: ZephyrSpacing(
        xs: 4,
        sm: 8,
        md: 16,
        lg: 24,
        xl: 32,
        xxl: 48,
      ),
    );
  }
}
```

### Dynamic Theme Switching

```dart
class ThemeProvider with ChangeNotifier {
  ZephyrThemeData _theme = ZephyrTheme.light();
  bool _isDarkMode = false;
  
  ZephyrThemeData get theme => _theme;
  bool get isDarkMode => _isDarkMode;
  
  void setTheme(ZephyrThemeData theme) {
    _theme = theme;
    notifyListeners();
  }
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _theme = _isDarkMode ? ZephyrTheme.dark() : ZephyrTheme.light();
    notifyListeners();
  }
}

// Update your app to use the theme provider
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ZephyrApp(
            title: 'My App',
            theme: themeProvider.theme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
```

## Common Components

Let's add some common components to your home screen:

### Form Components

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Demo'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: themeProvider.toggleTheme,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Welcome to ZephyrUI!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a demonstration of ZephyrUI components.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            
            // Buttons
            const Text(
              'Buttons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ZephyrButton(
                  text: 'Primary',
                  type: ZephyrButtonType.primary,
                  onPressed: () {},
                ),
                ZephyrButton(
                  text: 'Secondary',
                  type: ZephyrButtonType.secondary,
                  onPressed: () {},
                ),
                ZephyrButton(
                  text: 'Text',
                  type: ZephyrButtonType.text,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Input Fields
            const Text(
              'Input Fields',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrInput(
              placeholder: 'Enter your name',
              prefix: const Icon(Icons.person),
              onChanged: (value) {
                print('Name: $value');
              },
            ),
            const SizedBox(height: 16),
            ZephyrInput(
              placeholder: 'Enter your email',
              prefix: const Icon(Icons.email),
              onChanged: (value) {
                print('Email: $value');
              },
            ),
            const SizedBox(height: 32),
            
            // Rating Component
            const Text(
              'Rating',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrRating(
              value: 4.5,
              allowHalfRating: true,
              onChanged: (value) {
                print('Rating: $value');
              },
            ),
            const SizedBox(height: 32),
            
            // Cards
            const Text(
              'Cards',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ZephyrCard(
              title: 'Feature Card',
              subtitle: 'This is a feature card',
              content: const Text(
                'This is an example of a ZephyrCard component with custom content.',
              ),
              actions: [
                ZephyrButton(
                  text: 'Learn More',
                  type: ZephyrButtonType.text,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Responsive Design

ZephyrUI includes built-in responsive design utilities:

### Responsive Layout

```dart
class ResponsiveHomeScreen extends StatelessWidget {
  const ResponsiveHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Demo'),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          // Mobile layout
          if (sizingInformation.isMobile) {
            return _buildMobileLayout();
          }
          // Tablet layout
          else if (sizingInformation.isTablet) {
            return _buildTabletLayout();
          }
          // Desktop layout
          else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildContent(),
          const SizedBox(height: 24),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildContent(),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: _buildActions(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildContent(),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 1,
            child: _buildActions(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsive Design',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'This layout adapts to different screen sizes.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return ZephyrCard(
      title: 'Main Content',
      content: const Text(
        'This is the main content area. It adjusts its size and layout based on the screen size.',
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        ZephyrButton(
          text: 'Primary Action',
          type: ZephyrButtonType.primary,
          onPressed: () {},
          isFullWidth: true,
        ),
        const SizedBox(height: 16),
        ZephyrButton(
          text: 'Secondary Action',
          type: ZephyrButtonType.secondary,
          onPressed: () {},
          isFullWidth: true,
        ),
      ],
    );
  }
}
```

## Accessibility

ZephyrUI components are built with accessibility in mind:

### Accessibility Best Practices

```dart
class AccessibleForm extends StatelessWidget {
  const AccessibleForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessible Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Form',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'All fields are required',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            
            // Accessible input with semantic label
            ZephyrInput(
              placeholder: 'Full Name',
              prefix: const Icon(Icons.person),
              semanticLabel: 'Enter your full name',
              onChanged: (value) {
                print('Name: $value');
              },
            ),
            const SizedBox(height: 16),
            
            // Accessible email input
            ZephyrInput(
              placeholder: 'Email Address',
              prefix: const Icon(Icons.email),
              semanticLabel: 'Enter your email address',
              onChanged: (value) {
                print('Email: $value');
              },
            ),
            const SizedBox(height: 16),
            
            // Accessible rating component
            ZephyrRating(
              value: 0,
              semanticLabel: 'Rate your experience',
              onChanged: (value) {
                print('Rating: $value');
              },
            ),
            const SizedBox(height: 32),
            
            // Accessible button
            ZephyrButton(
              text: 'Submit Form',
              type: ZephyrButtonType.primary,
              onPressed: () {
                ZephyrToast.show(
                  context,
                  message: 'Form submitted successfully!',
                  type: ZephyrToastType.success,
                );
              },
              semanticLabel: 'Submit the contact form',
            ),
          ],
        ),
      ),
    );
  }
}
```

## Testing

ZephyrUI components are designed to be testable:

### Component Testing Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrUI Components Test', () {
    testWidgets('Button displays correctly and responds to taps', (WidgetTester tester) async {
      bool wasTapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrButton(
              text: 'Test Button',
              onPressed: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      // Verify button is displayed
      expect(find.text('Test Button'), findsOneWidget);
      
      // Tap the button
      await tester.tap(find.text('Test Button'));
      await tester.pump();
      
      // Verify callback was called
      expect(wasTapped, isTrue);
    });

    testWidgets('Input field accepts text input', (WidgetTester tester) async {
      String inputValue = '';
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              placeholder: 'Test Input',
              onChanged: (value) {
                inputValue = value;
              },
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Hello World');
      await tester.pump();
      
      // Verify input was captured
      expect(inputValue, equals('Hello World'));
    });

    testWidgets('Rating component handles user interaction', (WidgetTester tester) async {
      double ratingValue = 0.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrRating(
              value: ratingValue,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // Tap on the 3rd star
      await tester.tap(find.byType(Icon).at(2));
      await tester.pump();
      
      // Verify rating was updated
      expect(ratingValue, equals(3.0));
    });
  });
}
```

## Next Steps

Congratulations! You've successfully set up ZephyrUI and created your first components. Here are some suggested next steps:

### Explore More Components

- **Navigation**: Try `ZephyrTabs`, `ZephyrSideMenu`, `ZephyrStepper`
- **Data Display**: Explore `ZephyrTable`, `ZephyrList`, `ZephyrTimeline`
- **Advanced**: Check out `ZephyrTour`, `ZephyrTree`, `ZephyrAutoComplete`

### Learn Advanced Features

- [Theme Customization](../theming.md)
- [Responsive Design](../responsive-design.md)
- [Accessibility Guidelines](../accessibility.md)
- [Performance Optimization](../performance.md)

### Build Real Applications

1. **Todo App**: Use `ZephyrInput`, `ZephyrButton`, `ZephyrList`
2. **E-commerce**: Use `ZephyrCard`, `ZephyrRating`, `ZephyrTable`
3. **Dashboard**: Use `ZephyrGrid`, `ZephyrStatistic`, `ZephyrChart`

### Join the Community

- 📚 **Documentation**: [Full Documentation](../README.md)
- 🐛 **Issues**: [Report Bugs](https://github.com/zephyrui/zephyr_ui/issues)
- 💬 **Discussions**: [Join Discussions](https://github.com/zephyrui/zephyr_ui/discussions)
- 🌟 **Star Us**: [GitHub Repository](https://github.com/zephyrui/zephyr_ui)

## Need Help?

If you encounter any issues or have questions:

1. Check the [Documentation](../README.md)
2. Search existing [Issues](https://github.com/zephyrui/zephyr_ui/issues)
3. Join our [Discussions](https://github.com/zephyrui/zephyr_ui/discussions)
4. Contact us at [support@zephyrui.dev](mailto:support@zephyrui.dev)

Happy coding with ZephyrUI! 🚀