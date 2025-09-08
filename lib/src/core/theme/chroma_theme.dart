import 'package:flutter/material.dart';
import 'package:flutter_ui/src/core/theme/chroma_theme_data.dart';

/// chromaTheme is an InheritedWidget that provides the chroma design system's
/// theme data down the widget tree.
///
/// It allows widgets to access the theme's design tokens, such as colors,
/// typography, spacing, and more.
class chromaTheme extends InheritedWidget {
  /// The theme data for the chroma design system.
  final chromaThemeData data;

  /// Creates a chromaTheme.
  ///
  /// The [data] argument must not be null.
  const chromaTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Retrieves the closest chromaThemeData from the given context.
  ///
  /// If no chromaTheme is found in the widget tree, it will throw an error
  /// in debug mode and return a default light theme in release mode.
  static chromaThemeData of(BuildContext context) {
    final chromaTheme? result = context.dependOnInheritedWidgetOfExactType<chromaTheme>();
    assert(result != null, 'No chromaTheme found in context');
    return result?.data ?? chromaThemeData.light();
  }

  @override
  bool updateShouldNotify(chromaTheme oldWidget) {
    return data != oldWidget.data;
  }
}
