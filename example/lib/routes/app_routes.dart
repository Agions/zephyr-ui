import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../components/all_components_demo.dart';
import '../components/basic_components_demo.dart';
import '../components/form_components_demo.dart';
import '../components/layout_components_demo.dart';
import '../components/navigation_components_demo.dart';
import '../components/display_components_demo.dart';
import '../components/feedback_components_demo.dart';
import '../components/advanced_components_demo.dart';
import '../components/theme_demo.dart';
import '../components/responsive_demo.dart';
import '../components/performance_demo.dart';
import '../pages/interactive_demo_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String allComponents = '/all-components';
  static const String basicComponents = '/basic-components';
  static const String formComponents = '/form-components';
  static const String layoutComponents = '/layout-components';
  static const String navigationComponents = '/navigation-components';
  static const String displayComponents = '/display-components';
  static const String feedbackComponents = '/feedback-components';
  static const String advancedComponents = '/advanced-components';
  static const String themeDemo = '/theme-demo';
  static const String responsiveDemo = '/responsive-demo';
  static const String performanceDemo = '/performance-demo';
  static const String interactiveDemo = '/interactive-demo';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomePage(),
      allComponents: (context) => const AllComponentsDemo(),
      basicComponents: (context) => const BasicComponentsDemo(),
      formComponents: (context) => const FormComponentsDemo(),
      layoutComponents: (context) => const LayoutComponentsDemo(),
      navigationComponents: (context) => const NavigationComponentsDemo(),
      displayComponents: (context) => const DisplayComponentsDemo(),
      feedbackComponents: (context) => const FeedbackComponentsDemo(),
      advancedComponents: (context) => const AdvancedComponentsDemo(),
      themeDemo: (context) => const ThemeDemo(),
      responsiveDemo: (context) => const ResponsiveDemo(),
      performanceDemo: (context) => const PerformanceDemo(),
      interactiveDemo: (context) => const InteractiveDemoPage(),
    };
  }
}
