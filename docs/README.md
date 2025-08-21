# ZephyrUI Documentation

Welcome to the ZephyrUI documentation! This comprehensive guide will help you understand and use the ZephyrUI component library effectively.

## Table of Contents

- [Getting Started](#getting-started)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Components](#components)
- [Theming](#theming)
- [Contributing](#contributing)

## Getting Started

ZephyrUI is a comprehensive Flutter component library designed for enterprise applications. It provides 60+ high-quality components with a consistent design system.

## Installation

Add ZephyrUI to your `pubspec.yaml`:

```yaml
dependencies:
  zephyr_ui: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

1. Import ZephyrUI:

```dart
import 'package:zephyr_ui/zephyr_ui.dart';
```

2. Wrap your app with ZephyrTheme:

```dart
MaterialApp(
  theme: ZephyrTheme.lightTheme,
  darkTheme: ZephyrTheme.darkTheme,
  home: MyApp(),
);
```

3. Use components:

```dart
ZephyrButton(
  text: 'Click me',
  onPressed: () {},
)
```

## Components

### Basic Components
- [Button](components/basic/button.md)
- [Badge](components/basic/badge.md)
- [Avatar](components/basic/avatar.md)
- [Card](components/basic/card.md)
- [Chip](components/basic/chip.md)
- [Divider](components/basic/divider.md)
- [Icon](components/basic/icon.md)
- [Text](components/basic/text.md)

### Form Components
- [Input](components/form/input.md)
- [Select](components/form/select.md)
- [DatePicker](components/form/date_picker.md)
- [CheckBox](components/form/checkbox.md)
- [Radio](components/form/radio.md)
- [Switch](components/form/switch.md)
- [Slider](components/form/slider.md)
- [FormBuilder](components/form/form_builder.md)

### Layout Components (布局组件)
- [Container](components/layout/container.md) - 容器组件，提供灵活的包装能力
- [Grid](components/layout/grid.md) - 网格布局组件，支持多种网格模式
- [Accordion](components/layout/accordion.md) - 手风琴组件，可折叠的内容展示

### Navigation Components
- [Tabs](components/navigation/tabs.md)
- [Pagination](components/navigation/pagination.md)
- [SideMenu](components/navigation/side_menu.md)
- [Stepper](components/navigation/stepper.md)

### Display Components
- [Table](components/display/table.md)
- [List](components/display/list.md)
- [Calendar](components/display/calendar.md)
- [Timeline](components/display/timeline.md)
- [Statistic](components/display/statistic.md)

### Feedback Components
- [Alert](components/feedback/alert.md)
- [Modal](components/feedback/modal.md)
- [Toast](components/feedback/toast.md)
- [Progress](components/feedback/progress.md)
- [Skeleton](components/feedback/skeleton.md)

### Advanced Components
- [AutoComplete](components/advanced/autocomplete.md)
- [Chart](components/advanced/chart.md)
- [Carousel](components/advanced/carousel.md)
- [ColorPicker](components/advanced/color_picker.md)
- [Breadcrumb](components/advanced/breadcrumb.md)
- [RichEditor](components/advanced/rich_editor.md)
- [Upload](components/advanced/upload.md)

## Theming

ZephyrUI provides a powerful theming system that allows you to customize the appearance of all components.

### Light Theme

```dart
MaterialApp(
  theme: ZephyrTheme.lightTheme,
  home: MyApp(),
);
```

### Dark Theme

```dart
MaterialApp(
  darkTheme: ZephyrTheme.darkTheme,
  themeMode: ThemeMode.dark,
  home: MyApp(),
);
```

### Custom Theme

```dart
final customTheme = ZephyrThemeData(
  primaryColor: Colors.blue,
  secondaryColor: Colors.green,
  // ... other customizations
);

MaterialApp(
  theme: customTheme.toThemeData(),
  home: MyApp(),
);
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](../CONTRIBUTING.md) for details.