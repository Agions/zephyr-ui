---
sidebar_position: 2
---

# Installation

This guide will walk you through the process of adding zephyr-ui UI to your Flutter project.

## Prerequisites

- Flutter SDK (Latest stable version recommended)
- Dart SDK (Comes with Flutter)

## Adding the dependency

To use zephyr-ui UI, you need to add it to your `pubspec.yaml` file.

```yaml
dependencies:
  flutter:
    sdk: flutter

  zephyr-ui_ui: ^latest # TODO: Replace with the actual latest version
```

Then, run `flutter pub get` in your terminal.

## Import and use

Now you can import zephyr-ui UI in your Dart files and start using the components.

```dart
import 'package:flutter/material.dart';
import 'package:zephyr-ui_ui/zephyr_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zephyr UI Demo',
      theme: zephyr-uiUnifiedThemeData.light().toMaterialTheme(),
      darkTheme: zephyr-uiUnifiedThemeData.dark().toMaterialTheme(),
      home: const MyHomePage(),
    );
  }
}

// ... rest of your app code
```
