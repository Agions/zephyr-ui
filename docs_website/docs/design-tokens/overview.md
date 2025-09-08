# zephyr-ui Design Token System

## Overview

The zephyr-ui Design Token System is a comprehensive, enterprise-grade design token implementation based on the [Design Tokens Community Group specification](https://design-tokens.github.io/community-group/format/). It provides a centralized, scalable approach to managing design decisions across your Flutter applications.

## What are Design Tokens?

Design tokens are the visual design atoms of the design system — specifically, they are named entities that store visual design attributes. They replace hard-coded values with dynamic, semantic values that can be easily updated and maintained.

## Token Categories

### 1. **Color Tokens** (`zephyr-uiColorTokens`)

- **Semantic Color Scales**: Primary, Secondary, Success, Warning, Error, Info, Neutral
- **Color States**: Primary, Hover, Active, Disabled for each scale
- **Color Scale**: 10-step color scale (50-900) for each semantic color
- **Background Colors**: Canvas, Surface, Elevated, Overlay
- **Text Colors**: Primary, Secondary, Tertiary, Quaternary, Disabled, Inverse
- **Border Colors**: Primary, Secondary, Tertiary, Disabled, Focus, Error

```dart
final tokens = zephyr-uiDesignTokens.light();
final primaryColor = tokens.colors.primary.primary;
final successHover = tokens.colors.success.primaryHover;
```

### 2. **Typography Tokens** (`zephyr-uiTypographyTokens`)

- **Font Families**: Primary, Secondary, Mono, Icon
- **Font Sizes**: XS (12px) to XL8 (96px) with semantic naming
- **Font Weights**: Thin (100) to Black (900)
- **Line Heights**: None (1) to Loose (2)
- **Letter Spacing**: Tighter (-0.05em) to Widest (0.1em)
- **Text Styles**: Material Design 3 text styles (Display, Headline, Title, Body, Label)

```dart
final typography = tokens.typography;
final displayLarge = typography.textStyles.displayLarge;
final bodyMedium = typography.textStyles.bodyMedium;
```

### 3. **Spacing Tokens** (`zephyr-uiSpacingTokens`)

- **Base Scale**: 0, 1, 2, 4, 8, 12, 16, 20, 24, 32, 40, 48, 56, 64, 80, 96, 128, 160, 192, 224, 256px
- **Semantic Names**: none, xs, sm, md, lg, xl, xl2, xl3, xl4, xl5, xl6, xl7
- **Responsive Multipliers**: Automatic scaling based on device type

```dart
final spacing = tokens.spacing;
final smallSpacing = spacing.sm; // 8px
final largeSpacing = spacing.lg; // 24px
```

### 4. **Border Radius Tokens** (`zephyr-uiBorderRadiusTokens`)

- **Base Values**: None (0), SM (2px), Base (4px), MD (6px), LG (8px), XL (12px), XL2 (16px), XL3 (24px), Full (9999px)
- **Convenience Methods**: Direct access to `Radius` and `BorderRadius` objects

```dart
final borderRadius = tokens.borderRadius;
final cardRadius = borderRadius.lgBorderRadius; // BorderRadius.circular(8)
final buttonRadius = borderRadius.baseRadius; // Radius.circular(4)
```

### 5. **Shadow Tokens** (`zephyr-uiShadowTokens`)

- **Elevation Levels**: SM, Base, MD, LG, XL, XL2, Inner, None
- **Light/Dark Variants**: Optimized shadows for each theme
- **Material Design 3 Compatible**: Follows elevation guidelines

```dart
final shadows = tokens.shadows;
final cardShadow = shadows.md; // Medium elevation shadow
final modalShadow = shadows.xl2; // Highest elevation shadow
```

### 6. **Animation Tokens** (`zephyr-uiAnimationTokens`)

- **Duration Tokens**: Instant (0ms), Fast (100ms), Normal (200ms), Slow (300ms), Slower (500ms)
- **Easing Functions**: Linear, Ease In/Out, Quad, Cubic variants
- **Transition Presets**: Common transition combinations

```dart
final animation = tokens.animation;
final fastDuration = animation.duration.fast;
final easeOut = animation.easing.easeOut;
```

### 7. **Responsive Breakpoint Tokens** (`zephyr-uiBreakpointTokens`)

- **Standard Breakpoints**: SM (640px), MD (768px), LG (1024px), XL (1280px), XL2 (1536px)
- **Device Detection**: Mobile, Tablet, Desktop classification
- **Responsive Utilities**: Dynamic value selection based on screen size

```dart
final breakpoints = tokens.breakpoints;
final isMobile = breakpoints.isMobile(screenWidth);
final isTablet = breakpoints.isTablet(screenWidth);
```

### 8. **Supporting Tokens**

- **Z-Index Tokens**: Layer management (Hide, Base, Docked, Dropdown, Modal, etc.)
- **Opacity Tokens**: Transparency levels (0% to 100%)
- **Size Tokens**: Standard component sizes (XS to XL6)

## Token Manager

The `zephyr-uiTokenManager` provides centralized token management with the following features:

### Initialization

```dart
// Initialize with default tokens
zephyr-uiTokenManager().initialize();

// Initialize with custom tokens
final customTokens = zephyr-uiDesignTokens.custom(
  colors: zephyr-uiColorTokens.light().copyWith(
    primary: zephyr-uiColorScale.purple(),
  ),
);
zephyr-uiTokenManager().initialize(tokens: customTokens);
```

### Dynamic Theme Switching

```dart
// Switch between light and dark themes
zephyr-uiTokenManager().updateThemeMode(ThemeMode.dark);

// Listen to theme changes
zephyr-uiTokenManager().addListener(() {
  // Theme has changed, rebuild UI
  setState(() {});
});
```

### Token Overrides

```dart
// Override specific tokens
zephyr-uiTokenManager().overrideTokens({
  'colors.primary.primary': 0xFFE91E63, // Pink primary color
  'spacing.md': 20.0, // Custom medium spacing
});

// Reset all overrides
zephyr-uiTokenManager().resetOverrides();
```

### Responsive Values

```dart
// Get responsive spacing
final spacing = zephyr-uiTokenManager().getResponsiveSpacing(
  width: MediaQuery.of(context).size.width,
  size: 'md',
  mobileMultiplier: 0.8,
  desktopMultiplier: 1.2,
);

// Get responsive font size
final fontSize = zephyr-uiTokenManager().getResponsiveFontSize(
  width: MediaQuery.of(context).size.width,
  size: 'base',
);
```

## Responsive System

The responsive system provides comprehensive breakpoint management:

### Responsive Widgets

```dart
// Responsive widget builder
zephyr-uiResponsiveWidget(
  builder: (context, deviceType, constraints) {
    return Column(
      children: [
        Text('Device: ${deviceType.name}'),
        Text('Width: ${constraints.maxWidth}px'),
        if (deviceType == zephyr-uiDeviceType.desktop)
          const DesktopLayout()
        else if (deviceType == zephyr-uiDeviceType.tablet)
          const TabletLayout()
        else
          const MobileLayout(),
      ],
    );
  },
)
```

### Responsive Flex Container

```dart
zephyr-uiResponsiveFlex(
  direction: Axis.horizontal,
  spacing: zephyr-uiTokenManager().tokens.spacing.md,
  children: [
    Expanded(child: Container(color: Colors.red)),
    Expanded(child: Container(color: Colors.green)),
    Expanded(child: Container(color: Colors.blue)),
  ],
)
```

### Responsive Visibility

```dart
zephyr-uiResponsiveVisibility(
  mobile: true,
  tablet: false,
  desktop: true,
  child: const Text('Visible on mobile and desktop only'),
)
```

## Theme Integration

Generate Flutter ThemeData from design tokens:

```dart
// Generate theme data
final themeData = zephyr-uiTokenTheme.generateThemeData(
  tokens: zephyr-uiDesignTokens.light(),
  brightness: Brightness.light,
);

// Use with MaterialApp
MaterialApp(
  theme: zephyr-uiTokenManager().lightTheme,
  darkTheme: zephyr-uiTokenManager().darkTheme,
  themeMode: zephyr-uiTokenManager().themeMode,
  home: const MyApp(),
)
```

## Serialization & Import/Export

### Export Tokens

```dart
// Export current tokens as JSON
final tokensJson = zephyr-uiTokenManager().exportTokens();

// Save to file or send to server
await File('tokens.json').writeAsString(jsonEncode(tokensJson));
```

### Import Tokens

```dart
// Import tokens from JSON
final importedTokens = {
  'colors': {
    'primary': {
      'primary': 0xFF4CAF50,
      'primaryHover': 0xFF66BB6A,
      // ...
    }
  },
  // ...
};

zephyr-uiTokenManager().importTokens(importedTokens);
```

## Best Practices

### 1. **Use Semantic Names**

Always use semantic token names rather than hard-coded values:

```dart
// ✅ Good
Container(
  padding: EdgeInsets.all(tokens.spacing.md),
  decoration: BoxDecoration(
    color: tokens.colors.background.surface,
    borderRadius: tokens.borderRadius.lgBorderRadius,
    boxShadow: tokens.shadows.md,
  ),
)

// ❌ Bad
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
  ),
)
```

### 2. **Responsive Design**

Use responsive utilities for adaptive layouts:

```dart
zephyr-uiResponsiveWidget(
  builder: (context, deviceType, constraints) {
    final spacing = zephyr-uiTokenManager().getResponsiveSpacing(
      width: constraints.maxWidth,
      size: 'md',
      mobileMultiplier: 0.8,
      desktopMultiplier: 1.2,
    );

    return Padding(
      padding: EdgeInsets.all(spacing),
      child: // ...
    );
  },
)
```

### 3. **Theme Consistency**

Ensure all components use tokens for consistency:

```dart
// Create a custom component using tokens
class zephyr-uiCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokens = zephyr-uiTokenManager().tokens;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: tokens.borderRadius.lgBorderRadius,
        side: BorderSide(color: tokens.colors.border.secondary),
      ),
      margin: EdgeInsets.all(tokens.spacing.md),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.lg),
        child: // ...
      ),
    );
  }
}
```

### 4. **Performance Optimization**

Use token caching and efficient updates:

```dart
// Cache frequently used tokens
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late zephyr-uiDesignTokens _tokens;

  @override
  void initState() {
    super.initState();
    _tokens = zephyr-uiTokenManager().tokens;
    zephyr-uiTokenManager().addTokenListener(_onTokensChanged);
  }

  void _onTokensChanged() {
    setState(() {
      _tokens = zephyr-uiTokenManager().tokens;
    });
  }

  @override
  void dispose() {
    zephyr-uiTokenManager().removeTokenListener(_onTokensChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_tokens.spacing.md),
      // ...
    );
  }
}
```

## Migration Guide

### From Hard-coded Values

```dart
// Before
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
)

// After
Container(
  padding: EdgeInsets.all(zephyr-uiTokenManager().tokens.spacing.md),
  decoration: BoxDecoration(
    color: zephyr-uiTokenManager().tokens.colors.background.surface,
    borderRadius: zephyr-uiTokenManager().tokens.borderRadius.lgBorderRadius,
    boxShadow: zephyr-uiTokenManager().tokens.shadows.md,
  ),
)
```

### From Theme Extensions

```dart
// Before
ThemeData(
  extensions: [
    MyThemeExtension(
      primaryColor: Colors.blue,
      spacingSmall: 8,
    ),
  ],
)

// After
final tokens = zephyr-uiDesignTokens.light();
ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: tokens.colors.primary.primary,
  ),
  extensions: [
    zephyr-uiThemeExtension.fromTokens(tokens),
  ],
)
```

## Advanced Features

### Custom Token Validation

```dart
// Validate tokens meet accessibility requirements
bool validateAccessibility(zephyr-uiDesignTokens tokens) {
  // Check color contrast ratios
  final primaryColor = tokens.colors.primary.primary;
  final textColor = tokens.colors.text.primary;

  return _checkContrastRatio(primaryColor, textColor) >= 4.5;
}
```

### Dynamic Token Generation

```dart
// Generate tokens from brand colors
zephyr-uiDesignTokens generateBrandTokens(Color brandColor) {
  final colorScale = _generateColorScale(brandColor);

  return zephyr-uiDesignTokens.custom(
    colors: zephyr-uiColorTokens(
      primary: colorScale,
      // ... other colors
    ),
  );
}
```

### Token Analytics

```dart
// Analyze token usage in your app
Map<String, int> analyzeTokenUsage() {
  // Track which tokens are used most frequently
  // Identify unused tokens
  // Suggest optimizations
}
```

## Integration with Design Tools

### Figma Integration

```dart
// Import tokens from Figma
final figmaTokens = await FigmaTokenImporter.import(
  fileId: 'your-figma-file-id',
  tokenSet: 'design-tokens',
);

zephyr-uiTokenManager().importTokens(figmaTokens);
```

### Style Dictionary Integration

```dart
// Convert from Style Dictionary format
final styleDictionaryTokens = await loadStyleDictionaryTokens();
final zephyr-uiTokens = StyleDictionaryConverter.convert(styleDictionaryTokens);

zephyr-uiTokenManager().importTokens(zephyr-uiTokens);
```

This comprehensive design token system provides a solid foundation for building consistent, scalable, and maintainable Flutter applications with zephyr-ui.
