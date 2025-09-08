---
sidebar_position: 2
---

# Design Tokens

Design tokens are the single source of truth for all design decisions in the Zephyr UI library. They are named entities that store visual design attributes. We use them in place of hard-coded values in order to maintain a scalable and consistent visual system.

## Token Categories

Our tokens are organized into the following categories:

- **Colors (`zephyr-uiColorTokens`)**: Defines the color palette for the entire application, including primary, secondary, neutral, and semantic colors.
- **Typography (`zephyr-uiTypographyTokens`)**: Includes font sizes, weights, line heights, and letter spacing.
- **Spacing (`zephyr-uiSpacingTokens`)**: Consistent spacing values for margins, paddings, and layout gaps.
- **Radii (`zephyr-uiRadiusTokens`)**: Border radius values for components like buttons and cards.
- **Borders (`zephyr-uiBorderTokens`)**: Border width values.
- **Elevation (`zephyr-uiElevationTokens`)**: Shadow and elevation levels.
- **Animation (`zephyr-uiAnimationTokens`)**: Durations and curves for animations.

## Using Tokens

You can access these tokens directly for custom styling needs, although most of the time, the component's theme will handle this for you.

```dart
import 'package:zephyr_ui/src/core/constants/design_tokens.dart';

Container(
  padding: const EdgeInsets.all(zephyr-uiSpacingTokens.medium),
  decoration: BoxDecoration(
    color: zephyr-uiColorTokens.neutral90,
    borderRadius: BorderRadius.circular(zephyr-uiRadiusTokens.large),
  ),
)
```
