---
sidebar_position: 1
slug: /
---

# Introduction

**Zephyr UI Design System** is an enterprise Flutter UI framework that provides a comprehensive design system with 60+ professional components, advanced design tokens, and complete tooling for building beautiful, accessible, and performant mobile applications (iOS & Android).

## 🌟 Key Features

### **Mobile-Optimized Components**

- **60+ Professional Components** designed specifically for mobile
- **7 Component Categories**: Basic, Form, Navigation, Feedback, Display, Layout, Advanced
- **Material Design 3 Compliance** with mobile-first design principles
- **Consistent Theming System** with light/dark mode support
- **Touch-Optimized Interactions** with proper gesture support

### **Enterprise Architecture**

- **Scalable Architecture** with dependency injection and service locator patterns
- **Comprehensive Testing** with 90%+ test coverage
- **Type Safety** with full null safety
- **Performance Optimized** with virtual scrolling and lazy loading
- **Accessibility First** with full screen reader support

### **Advanced Features**

- **Design Token System** for consistent theming
- **Responsive Layout System** for multi-device support
- **Form Validation System** with comprehensive validation
- **Data Visualization** with interactive charts
- **File Upload System** with drag-and-drop support
- **Performance Monitoring** with real-time metrics

## 🚀 Quick Start

### Installation

Add zephyr-ui to your `pubspec.yaml`:

```yaml
dependencies:
  zephyr-ui: ^2.0.0
```

Then run:

```bash
flutter pub get
```

### Basic Usage

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(
    MaterialApp(
      theme: zephyr-uiThemeData.light(),
      darkTheme: zephyr-uiThemeData.dark(),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zephyr UI Demo')),
      body: Center(
        child: zephyr-uiButton.primary(
          text: 'Get Started',
          onPressed: () => print('Button pressed!'),
        ),
      ),
    );
  }
}
```

## 📚 Component Categories

### **Basic Components**

- **Button** - Multiple variants with loading states
- **Input** - Advanced form field with validation
- **Card** - Flexible container with theming
- **Avatar** - Image/text/icon with shapes and borders
- **Badge** - Status indicators with color variants
- **Chip** - Filter and selection chips
- **Divider** - Visual separators
- **Icon** - Theme-aware icon component

### **Form Components**

- **Enhanced Form Validation** - Comprehensive validation system
- **Select** - Advanced dropdown with search
- **DatePicker** - Date selection with ranges
- **TimePicker** - Time selection with validation
- **Checkbox** - Accessible checkbox with indeterminate state
- **Radio** - Radio button groups
- **Switch** - Toggle switches with animations
- **Slider** - Range and value sliders
- **Textarea** - Multi-line text input

### **Navigation Components**

- **Tabs** - Multiple variants with smooth transitions
- **Stepper** - Multi-step navigation
- **SideMenu** - Collapsible navigation drawer
- **Breadcrumb** - Hierarchical navigation
- **Pagination** - Page navigation with sizes

### **Display Components**

- **Enhanced Table** - Sorting, filtering, pagination
- **Charts** - Interactive data visualization
- **Timeline** - Event visualization
- **Calendar** - Interactive calendar with events
- **Statistic** - Data display components

### **Layout Components**

- **Grid System** - Responsive 12-column grid
- **Accordion** - Expandable sections
- **Split View** - Resizable panels
- **Virtual List** - Efficient large list rendering

### **Advanced Components**

- **Enhanced File Upload** - Drag-and-drop with progress
- **Signature Pad** - Digital signature capture
- **Tour Guide** - Interactive feature tours
- **Color Picker** - Color selection with palettes

## 🎨 Design System

### **Design Tokens**

zephyr-ui uses a comprehensive design token system for consistent theming:

```dart
// Access design tokens
final tokens = zephyr-uiTokenManager().tokens;
final primaryColor = tokens.colors.primary.primary;
final spacing = tokens.spacing.md;
final borderRadius = tokens.borderRadius.lg;
```

### **Theme Customization**

```dart
// Custom theme
final customTheme = zephyr-uiThemeData(
  colors: zephyr-uiColors(
    primary: Color(0xFF6366F1),
    secondary: Color(0xFFEC4899),
  ),
  spacing: zephyr-uiSpacing(
    md: 20.0,
    lg: 32.0,
  ),
);
```

## 🧪 Testing

zephyr-ui provides comprehensive testing utilities:

```dart
// Component testing
await zephyr-uiComponentTestUtils.testComponent(
  componentName: 'Button',
  component: zephyr-uiButton.primary(text: 'Test'),
  testCases: {
    'renders correctly': {
      'expectations': {'findsOneWidget': 'Button'},
    },
  },
);
```

## 📖 Documentation Structure

- **[Getting Started](./getting-started)** - Installation and basic usage
- **[Design Tokens](./design-tokens/overview)** - Comprehensive token system
- **[Components](./components/overview)** - Detailed component documentation
- **[Advanced Topics](./advanced/customization)** - Customization and extension
- **[API Reference](./api/overview)** - Complete API documentation

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](./contributing/overview) for details.

## 📄 License

Zephyr UI is licensed under the MIT License. See [LICENSE](https://github.com/agions/zephyr-ui/blob/main/LICENSE) for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the design inspiration
- Community contributors and feedback providers

---

**Ready to build beautiful, accessible, and performant Flutter applications?**

Start with our [Quick Start Guide](./quick-start) or explore the [Component Documentation](./components/overview).
