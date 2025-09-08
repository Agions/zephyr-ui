---
sidebar_position: 1
---

# Theming

Zephyr UI is built with a powerful and flexible theming system based on Material Design 3. You can easily customize the look and feel of your application to match your brand.

## Core Concepts

Our theming is centered around `zephyr-uiUnifiedThemeData`, which is a comprehensive data structure that holds all the visual properties of the UI components. It's built on top of Flutter's `ThemeData` and `ColorScheme`.

## Customizing a Theme

To create a custom theme, you can start with our base light or dark themes and override the properties you want to change.

```dart
import 'package.flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

final myAppTheme = zephyr-uiUnifiedThemeData.light(
  primaryColor: Colors.blue, // Your brand's primary color
  fontFamily: 'Roboto',
);

final myMaterialTheme = myAppTheme.toMaterialTheme();
```

You can then provide this theme to your `MaterialApp`.
