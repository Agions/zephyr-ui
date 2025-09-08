# Quick Start

This guide will get you up and running with zephyr-ui Design System in just a few minutes.

## 🚀 Basic Setup

### 1. Import the Library

```dart
import 'package:zephyr_ui/zephyr_ui.dart';
```

### 2. Initialize the Theme System

```dart
void main() {
  // Initialize Zephyr UI
  zephyr-uiTokenManager().initialize();

  runApp(const MyApp());
}
```

### 3. Set Up Your App

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zephyr UI Demo',
      theme: zephyr-uiTokenManager().lightTheme,
      darkTheme: zephyr-uiTokenManager().darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
```

## 🎨 Using Components

### Basic Components

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('zephyr-ui Quick Start')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primary Button
            zephyr-uiButton.primary(
              text: 'Primary Button',
              onPressed: () => print('Primary button pressed'),
            ),

            const SizedBox(height: 16),

            // Secondary Button
            zephyr-uiButton.secondary(
              text: 'Secondary Button',
              onPressed: () => print('Secondary button pressed'),
            ),

            const SizedBox(height: 16),

            // Input Field
            zephyr-uiInput(
              labelText: 'Email',
              hintText: 'Enter your email',
              onChanged: (value) => print('Input: $value'),
            ),

            const SizedBox(height: 16),

            // Card Component
            zephyr-uiCard(
              header: const Text('Card Header'),
              child: const Text('This is card content'),
              footer: const Text('Card Footer'),
            ),

            const SizedBox(height: 16),

            // Avatar Component
            Row(
              children: [
                zephyr-uiAvatar.image(
                  image: NetworkImage('https://i.pravatar.cc/150?img=1'),
                ),
                const SizedBox(width: 12),
                zephyr-uiAvatar.text(text: 'JD'),
                const SizedBox(width: 12),
                zephyr-uiAvatar.icon(icon: Icons.person),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎯 Design Tokens in Action

### Using Design Tokens

```dart
class TokenDemo extends StatelessWidget {
  const TokenDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = zephyr-uiTokenManager().tokens;

    return Container(
      padding: EdgeInsets.all(tokens.spacing.lg),
      decoration: BoxDecoration(
        color: tokens.colors.background.surface,
        borderRadius: tokens.borderRadius.lgBorderRadius,
        boxShadow: tokens.shadows.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Design Token Powered',
            style: tokens.typography.textStyles.headlineSmall.copyWith(
              color: tokens.colors.text.primary,
            ),
          ),
          SizedBox(height: tokens.spacing.sm),
          Text(
            'This container uses design tokens for spacing, colors, border radius, and shadows.',
            style: tokens.typography.textStyles.bodyMedium.copyWith(
              color: tokens.colors.text.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Responsive Design

```dart
class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return zephyr-uiResponsiveWidget(
      builder: (context, deviceType, constraints) {
        final spacing = zephyr-uiTokenManager().getResponsiveSpacing(
          width: constraints.maxWidth,
          size: 'md',
          mobileMultiplier: 0.8,
          tabletMultiplier: 1.0,
          desktopMultiplier: 1.2,
        );

        return Padding(
          padding: EdgeInsets.all(spacing),
          child: Column(
            children: [
              Text('Device: ${deviceType.name}'),
              Text('Screen Width: ${constraints.maxWidth.toStringAsFixed(0)}px'),
              // Responsive grid
              zephyr-uiResponsiveGrid(
                children: List.generate(
                  zephyr-uiTokenManager().getGridColumns(constraints.maxWidth),
                  (index) => Container(
                    height: 100,
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: Center(child: Text('Item $index')),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

## 🧩 Form Components

### Complete Form Example

```dart
class FormDemo extends StatefulWidget {
  const FormDemo({super.key});

  @override
  State<FormDemo> createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email Input with Validation
            zephyr-uiInput(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email address',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Password Input
            zephyr-uiInput(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Select Dropdown
            zephyr-uiSelect<String>(
              labelText: 'Country',
              items: [
                zephyr-uiSelectItem(value: 'us', label: 'United States'),
                zephyr-uiSelectItem(value: 'uk', label: 'United Kingdom'),
                zephyr-uiSelectItem(value: 'jp', label: 'Japan'),
                zephyr-uiSelectItem(value: 'cn', label: 'China'),
              ],
              onChanged: (value) => print('Selected: $value'),
            ),

            const SizedBox(height: 24),

            // Submit Button
            zephyr-uiButton.primary(
              text: 'Submit Form',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, proceed with submission
                  print('Form submitted successfully!');
                  print('Email: ${_emailController.text}');
                  print('Password: ${_passwordController.text}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 Theming

### Custom Theme Example

```dart
class CustomThemeDemo extends StatelessWidget {
  const CustomThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Create custom tokens
    final customTokens = zephyr-uiDesignTokens.custom(
      colors: zephyr-uiColorTokens.custom(
        primary: zephyr-uiColorScale.fromSeedColor(const Color(0xFF4CAF50)),
        secondary: zephyr-uiColorScale.fromSeedColor(const Color(0xFF2196F3)),
      ),
      typography: zephyr-uiTypographyTokens.custom(
        fontFamily: zephyr-uiFontFamilyTokens(
          primary: 'Roboto',
          secondary: 'Open Sans',
          mono: 'Roboto Mono',
          icon: 'MaterialIcons',
        ),
      ),
    );

    return MaterialApp(
      title: 'Custom Theme Demo',
      theme: zephyr-uiTokenTheme.generateThemeData(
        tokens: customTokens,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Theme')),
        body: Center(
          child: zephyr-uiButton.primary(
            text: 'Custom Themed Button',
            onPressed: () => print('Custom theme working!'),
          ),
        ),
      ),
    );
  }
}
```

## 📱 Mobile-First Components

### Mobile-Optimized Layout

```dart
class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Mobile First'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      zephyr-uiTokenManager().tokens.colors.primary.primary,
                      zephyr-uiTokenManager().tokens.colors.secondary.primary,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(zephyr-uiTokenManager().tokens.spacing.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Mobile-optimized card list
                ...List.generate(10, (index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: zephyr-uiTokenManager().tokens.spacing.sm,
                  ),
                  child: zephyr-uiCard(
                    child: ListTile(
                      leading: zephyr-uiAvatar.text(text: '${index + 1}'),
                      title: Text('Item ${index + 1}'),
                      subtitle: Text('Subtitle for item ${index + 1}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => print('Tapped item ${index + 1}'),
                    ),
                  ),
                )),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('FAB pressed'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## 🚀 Advanced Features

### Performance Monitoring

```dart
class PerformanceDemo extends StatefulWidget {
  const PerformanceDemo({super.key});

  @override
  State<PerformanceDemo> createState() => _PerformanceDemoState();
}

class _PerformanceDemoState extends State<PerformanceDemo> {
  @override
  void initState() {
    super.initState();
    // Start performance monitoring
    zephyr-uiAdvancedPerformanceMonitor().startMonitoring();
  }

  @override
  void dispose() {
    zephyr-uiAdvancedPerformanceMonitor().stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<zephyr-uiPerformanceEvent>(
      stream: zephyr-uiAdvancedPerformanceMonitor().performanceStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final event = snapshot.data!;
          return Text(
            'Performance: ${event.componentId}.${event.metricName} = ${event.value.toStringAsFixed(2)}ms',
            style: zephyr-uiTokenManager().tokens.typography.textStyles.bodySmall,
          );
        }
        return const Text('Monitoring performance...');
      },
    );
  }
}
```

## 🎯 Best Practices

### 1. Always Use Design Tokens

```dart
// ✅ Good - Use design tokens
Container(
  padding: EdgeInsets.all(zephyr-uiTokenManager().tokens.spacing.md),
  decoration: BoxDecoration(
    color: zephyr-uiTokenManager().tokens.colors.background.surface,
    borderRadius: zephyr-uiTokenManager().tokens.borderRadius.lgBorderRadius,
    boxShadow: zephyr-uiTokenManager().tokens.shadows.md,
  ),
)

// ❌ Bad - Hard-coded values
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
  ),
)
```

### 2. Responsive Design

```dart
// ✅ Good - Responsive design
zephyr-uiResponsiveWidget(
  builder: (context, deviceType, constraints) {
    final spacing = zephyr-uiTokenManager().getResponsiveSpacing(
      width: constraints.maxWidth,
      size: 'md',
    );
    return Padding(padding: EdgeInsets.all(spacing), child: /* ... */);
  },
)
```

### 3. Accessibility First

```dart
// ✅ Good - Accessibility built-in
zephyr-uiButton.primary(
  text: 'Submit',
  onPressed: _handleSubmit,
  semanticLabel: 'Submit form',
)

// Screen reader support automatically included
```

## 🎉 What's Next?

Now that you have the basics working, explore:

1. **[Design Tokens](./design-tokens/overview)** - Deep dive into the token system
2. **[Components](./components/overview)** - Explore all available components
3. **[Advanced Topics](./advanced/customization)** - Learn about customization and extension
4. **[Examples](./examples)** - See real-world usage patterns

---

**Ready to build something amazing?** Check out the [Component Documentation](./components/overview) to see all available components.
