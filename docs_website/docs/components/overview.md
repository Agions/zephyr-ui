# Components Overview

Zephyr UI Design System provides 60+ professional components organized into 7 categories. Each component is built with accessibility, performance, and customization in mind.

## Component Categories

### 1. **Basic Components** 🎯

Foundational UI elements that form the building blocks of any interface.

| Component                  | Description                                | Status    |
| -------------------------- | ------------------------------------------ | --------- |
| [Button](./basic/button)   | Interactive buttons with multiple variants | ✅ Stable |
| [Input](./basic/input)     | Text input fields with validation          | ✅ Stable |
| [Card](./basic/card)       | Flexible content containers                | ✅ Stable |
| [Avatar](./basic/avatar)   | User representation with image/text/icon   | ✅ Stable |
| [Badge](./basic/badge)     | Status indicators and counts               | ✅ Stable |
| [Chip](./basic/chip)       | Filter and selection chips                 | ✅ Stable |
| [Divider](./basic/divider) | Visual separators                          | ✅ Stable |
| [Icon](./basic/icon)       | Consistent icon rendering                  | ✅ Stable |
| [Text](./basic/text)       | Typography components                      | ✅ Stable |

### 2. **Form Components** 📝

Complete form solution with validation, layout, and accessibility.

| Component                        | Description                         | Status    |
| -------------------------------- | ----------------------------------- | --------- |
| [Input](./form/input)            | Advanced text input with validation | ✅ Stable |
| [Select](./form/select)          | Dropdown selection with search      | ✅ Stable |
| [Checkbox](./form/checkbox)      | Binary selection controls           | ✅ Stable |
| [Radio](./form/radio)            | Single selection from groups        | ✅ Stable |
| [Switch](./form/switch)          | Toggle controls                     | ✅ Stable |
| [Slider](./form/slider)          | Range and value selection           | ✅ Stable |
| [DatePicker](./form/date-picker) | Date selection with ranges          | ✅ Stable |
| [TimePicker](./form/time-picker) | Time selection                      | ✅ Stable |
| [Validation](./form/validation)  | Comprehensive form validation       | ✅ Stable |

### 3. **Navigation Components** 🧭

Navigation and wayfinding elements for complex applications.

| Component                             | Description                   | Status    |
| ------------------------------------- | ----------------------------- | --------- |
| [Tabs](./navigation/tabs)             | Tab-based navigation          | ✅ Stable |
| [Stepper](./navigation/stepper)       | Multi-step process navigation | ✅ Stable |
| [SideMenu](./navigation/side-menu)    | Collapsible navigation drawer | ✅ Stable |
| [Breadcrumb](./navigation/breadcrumb) | Hierarchical navigation       | ✅ Stable |
| [Pagination](./navigation/pagination) | Page-based navigation         | ✅ Stable |

### 4. **Display Components** 📊

Data presentation and visualization components.

| Component                        | Description                                 | Status    |
| -------------------------------- | ------------------------------------------- | --------- |
| [Table](./display/table)         | Enhanced data tables with sorting/filtering | ✅ Stable |
| [Chart](./display/chart)         | Interactive data visualization              | ✅ Stable |
| [Calendar](./display/calendar)   | Interactive calendar with events            | ✅ Stable |
| [Timeline](./display/timeline)   | Event visualization                         | ✅ Stable |
| [Statistic](./display/statistic) | Data display components                     | ✅ Stable |

### 5. **Feedback Components** 💬

User feedback and system status indicators.

| Component                       | Description                     | Status    |
| ------------------------------- | ------------------------------- | --------- |
| [Alert](./feedback/alert)       | Status messages with actions    | ✅ Stable |
| [Modal](./feedback/modal)       | Dialog overlays                 | ✅ Stable |
| [Toast](./feedback/toast)       | Temporary notifications         | ✅ Stable |
| [Progress](./feedback/progress) | Loading and progress indicators | ✅ Stable |
| [Skeleton](./feedback/skeleton) | Loading placeholders            | ✅ Stable |

### 6. **Layout Components** 📐

Layout and structure components for organizing content.

| Component                            | Description                    | Status    |
| ------------------------------------ | ------------------------------ | --------- |
| [Grid](./layout/grid)                | Responsive grid system         | ✅ Stable |
| [Accordion](./layout/accordion)      | Collapsible content sections   | ✅ Stable |
| [SplitView](./layout/split-view)     | Resizable panel layouts        | ✅ Stable |
| [VirtualList](./layout/virtual-list) | Efficient large list rendering | ✅ Stable |

### 7. **Advanced Components** 🚀

Complex, specialized components for advanced use cases.

| Component                              | Description                           | Status            |
| -------------------------------------- | ------------------------------------- | ----------------- |
| [DataGrid](./advanced/data-grid)       | Advanced data grid with full features | 🚧 In Development |
| [FileUpload](./advanced/file-upload)   | Drag-and-drop file upload             | ✅ Stable         |
| [Signature](./advanced/signature)      | Digital signature capture             | ✅ Stable         |
| [Tour](./advanced/tour)                | Interactive feature tours             | ✅ Stable         |
| [ColorPicker](./advanced/color-picker) | Color selection interface             | ✅ Stable         |

## Component Status Legend

- ✅ **Stable** - Production-ready, fully tested
- 🚧 **In Development** - Beta version, may have breaking changes
- 🧪 **Experimental** - Early preview, API may change
- 📋 **Planned** - Coming in future releases

## Component Features

### **Design Token Integration**

All components are built on top of the comprehensive design token system:

```dart
// Using design tokens in components
zephyr-uiButton.primary(
  text: 'Submit',
  style: ButtonStyle(
    padding: EdgeInsets.symmetric(
      horizontal: zephyr-uiTokenManager().tokens.spacing.md,
      vertical: zephyr-uiTokenManager().tokens.spacing.sm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: zephyr-uiTokenManager().tokens.borderRadius.baseBorderRadius,
    ),
  ),
)
```

### **Accessibility Built-in**

Every component includes:

- **ARIA labels** and roles
- **Keyboard navigation** support
- **Screen reader** compatibility
- **High contrast** mode support
- **Focus management**

```dart
// Accessibility is automatic
zephyr-uiButton.primary(
  text: 'Save',
  semanticLabel: 'Save document',
  onPressed: _handleSave,
)
```

### **Responsive Design**

Components adapt to different screen sizes:

```dart
// Responsive component usage
zephyr-uiResponsiveWidget(
  builder: (context, deviceType, constraints) {
    return zephyr-uiCard(
      padding: EdgeInsets.all(
        zephyr-uiTokenManager().getResponsiveSpacing(
          width: constraints.maxWidth,
          size: 'md',
        ),
      ),
      child: deviceType == zephyr-uiDeviceType.mobile
          ? const MobileCardContent()
          : const DesktopCardContent(),
    );
  },
)
```

### **Performance Optimized**

Components include performance optimizations:

- **Lazy loading** for complex components
- **Memoization** for expensive computations
- **Virtual scrolling** for large lists
- **Efficient rebuilds** with proper keys

### **Comprehensive Testing**

Each component includes:

- **Unit tests** for logic and behavior
- **Widget tests** for UI interactions
- **Accessibility tests** for a11y compliance
- **Golden tests** for visual regression
- **Performance tests** for optimization

## Component Architecture

### **Base Component System**

All components extend from `zephyr-uiBaseComponent` which provides:

- **Lifecycle management**
- **Performance monitoring**
- **Theme integration**
- **Accessibility support**

### **Theme Integration**

Components automatically integrate with the theme system:

```dart
// Theme integration is automatic
final theme = zephyr-uiThemeData.light();
final button = zephyr-uiButton.primary(
  text: 'Click me',
  // Automatically uses theme colors, spacing, typography
)
```

### **State Management**

Components use consistent state management patterns:

```dart
// Component state management
class zephyr-uiInput extends StatefulWidget {
  @override
  State<zephyr-uiInput> createState() => _zephyr-uiInputState();
}

class _zephyr-uiInputState extends State<zephyr-uiInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## Usage Guidelines

### **1. Consistent Usage**

Always use zephyr-ui components instead of building custom ones:

```dart
// ✅ Good - Use zephyr-ui components
zephyr-uiButton.primary(
  text: 'Save',
  onPressed: _handleSave,
)

// ❌ Avoid - Building custom components
ElevatedButton(
  style: ElevatedButton.styleFrom(
    // Manual styling that may not match the design system
  ),
  child: Text('Save'),
  onPressed: _handleSave,
)
```

### **2. Semantic Naming**

Use semantic prop names for clarity:

```dart
// ✅ Good - Semantic naming
zephyr-uiButton.primary(
  text: 'Delete User',
  isLoading: _isDeleting,
  isDisabled: !_canDelete,
  onPressed: _handleDelete,
)

// ❌ Avoid - Unclear naming
zephyr-uiButton.primary(
  text: 'Delete User',
  loading: _isDeleting, // Less clear
  disabled: !_canDelete, // Less clear
  onTap: _handleDelete, // Inconsistent with Flutter conventions
)
```

### **3. Accessibility First**

Always include accessibility props:

```dart
// ✅ Good - Accessibility included
zephyr-uiImage(
  image: NetworkImage(user.avatarUrl),
  semanticLabel: 'Profile picture of ${user.name}',
  width: 64,
  height: 64,
)

// ❌ Avoid - Missing accessibility
zephyr-uiImage(
  image: NetworkImage(user.avatarUrl),
  width: 64,
  height: 64,
  // Missing semanticLabel
)
```

### **4. Responsive Design**

Consider different screen sizes:

```dart
// ✅ Good - Responsive design
zephyr-uiResponsiveWidget(
  builder: (context, deviceType, constraints) {
    final spacing = zephyr-uiTokenManager().getResponsiveSpacing(
      width: constraints.maxWidth,
      size: 'md',
    );

    return Padding(
      padding: EdgeInsets.all(spacing),
      child: deviceType == zephyr-uiDeviceType.mobile
          ? const MobileLayout()
          : const DesktopLayout(),
    );
  },
)
```

## Component Customization

### **Theme Customization**

Customize components through the theme system:

```dart
final customTheme = zephyr-uiThemeData(
  colors: zephyr-uiColors(
    primary: Color(0xFF6366F1),
    secondary: Color(0xFFEC4899),
  ),
  spacing: zephyr-uiSpacing(
    md: 20.0,
    lg: 32.0,
  ),
  borderRadius: zephyr-uiBorderRadius(
    base: 8.0,
    lg: 16.0,
  ),
);
```

### **Component Extension**

Extend components for custom behavior:

```dart
class CustomButton extends zephyr-uiButton {
  const CustomButton.primary({
    required super.text,
    required super.onPressed,
    super.key,
  }) : super.primary();

  @override
  Widget build(BuildContext context) {
    // Add custom behavior
    return super.build(context);
  }
}
```

### **Style Overrides**

Override specific styles when needed:

```dart
zephyr-uiButton.primary(
  text: 'Custom Button',
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.purple),
    padding: MaterialStateProperty.all(EdgeInsets.all(24)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    )),
  ),
  onPressed: () {},
)
```

## Performance Considerations

### **Component Performance**

- Use `const` constructors where possible
- Implement proper `shouldRebuild` logic
- Use `Keys` for list items
- Consider `RepaintBoundary` for expensive widgets

### **Memory Management**

- Properly dispose controllers and listeners
- Use weak references where appropriate
- Implement efficient caching strategies

### **Build Performance**

- Minimize widget tree depth
- Use efficient layout algorithms
- Consider `LayoutBuilder` for responsive layouts

---

**Next: Explore individual component documentation or learn about [Design Tokens](./design-tokens/overview)** →
