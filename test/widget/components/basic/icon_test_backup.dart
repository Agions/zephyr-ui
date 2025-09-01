import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/basic/icon/icon.dart';
import 'package:zephyr_ui/src/components/basic/icon/icon_theme.dart';
import 'package:zephyr_ui/src/core/theme/theme.dart';
import 'package:zephyr_ui/src/core/theme/theme_data.dart';

void main() {
  group('ZephyrIcon Widget Tests', () {
    late final ThemeData theme;

    setUpAll(() {
      final zephyrTheme = ZephyrThemeData.light();
      theme = ThemeData(
        brightness: zephyrTheme.brightness,
        primaryColor: zephyrTheme.primaryColor,
      );
    });

    testWidgets('renders icon with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: const Scaffold(
              body: ZephyrIcon(Icons.home),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('renders small icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
              body: ZephyrIcon.small(Icons.star),
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders medium icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.medium(Icons.favorite),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('renders large icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.large(Icons.settings),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('renders primary icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.primary(Icons.check_circle),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('renders secondary icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.secondary(Icons.info),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('renders error icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.error(Icons.error),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('renders warning icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.warning(Icons.warning),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('renders success icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.success(Icons.check),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('renders info icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.info(Icons.info_outline),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('renders disabled icon with factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ZephyrIcon.disabled(Icons.block),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.block), findsOneWidget);
    });

    testWidgets('applies custom color to icon', (WidgetTester tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              color: customColor,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, customColor);
    });

    testWidgets('applies custom size to icon', (WidgetTester tester) async {
      const customSize = 48.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              customSize: customSize,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, customSize);
    });

    testWidgets('applies semantic label to icon', (WidgetTester tester) async {
      const semanticLabel = 'Home icon';

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              semanticLabel: semanticLabel,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.bySemanticsLabel(semanticLabel), findsOneWidget);
    });

    testWidgets('applies custom theme to icon', (WidgetTester tester) async {
      const customTheme = ZephyrIconTheme(
        defaultColor: Colors.purple,
        primaryColor: Colors.deepPurple,
        secondaryColor: Colors.indigo,
        errorColor: Colors.red,
        warningColor: Colors.orange,
        successColor: Colors.green,
        infoColor: Colors.blue,
        disabledColor: Colors.grey,
        defaultSize: 24.0,
        smallSize: 12.0,
        mediumSize: 20.0,
        largeSize: 28.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              theme: customTheme,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('applies different sizes with enum values',
        (WidgetTester tester) async {
      // Test small size
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              size: ZephyrIconSize.small,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final smallIcon = tester.widget<Icon>(find.byType(Icon));
      expect(smallIcon.size, 16.0);

      // Test medium size
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              size: ZephyrIconSize.medium,
            ),
          ),
          ),
        ),
      );

      final mediumIcon = tester.widget<Icon>(find.byType(Icon));
      expect(mediumIcon.size, 24.0);

      // Test large size
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              size: ZephyrIconSize.large,
            ),
          ),
          ),
        ),
      );

      final largeIcon = tester.widget<Icon>(find.byType(Icon));
      expect(largeIcon.size, 32.0);
    });

    testWidgets('applies different status colors', (WidgetTester tester) async {
      // Test normal status
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              status: ZephyrIconStatus.normal,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final normalIcon = tester.widget<Icon>(find.byType(Icon));

      // Test primary status
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              status: ZephyrIconStatus.primary,
            ),
          ),
          ),
        ),
      );

      final primaryIcon = tester.widget<Icon>(find.byType(Icon));
      expect(primaryIcon.color, isNot(normalIcon.color));

      // Test error status
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              status: ZephyrIconStatus.error,
            ),
          ),
          ),
        ),
      );

      final errorIcon = tester.widget<Icon>(find.byType(Icon));
      expect(errorIcon.color, isNot(normalIcon.color));
      expect(errorIcon.color, isNot(primaryIcon.color));
    });

    testWidgets('handles custom size overriding theme size',
        (WidgetTester tester) async {
      const customSize = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              size: ZephyrIconSize.large,
              customSize: customSize,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, customSize);
    });

    testWidgets('handles custom color overriding theme color',
        (WidgetTester tester) async {
      const customColor = Colors.pink;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              status: ZephyrIconStatus.primary,
              color: customColor,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, customColor);
    });

    testWidgets('handles icon with null values in constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              color: null,
              customSize: null,
              semanticLabel: null,
              theme: null,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('renders multiple icons in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Row(
              children: [
                ZephyrIcon(Icons.home),
                ZephyrIcon(Icons.star),
                ZephyrIcon(Icons.settings),
              ],
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsNWidgets(3));
      expect(find.byType(Icon), findsNWidgets(3));
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('handles icon in different widget contexts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const ZephyrIcon(Icons.home),
                ),
                const SizedBox(height: 20),
                const Card(
                  child: ZephyrIcon(Icons.star),
                ),
                const SizedBox(height: 20),
                const ListTile(
                  leading: ZephyrIcon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsNWidgets(3));
      expect(find.byType(Icon), findsNWidgets(3));
    });

    testWidgets('handles icon with zero custom size',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              customSize: 0.0,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, 0.0);
    });

    testWidgets('handles icon with large custom size',
        (WidgetTester tester) async {
      const largeSize = 100.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              customSize: largeSize,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, largeSize);
    });

    testWidgets('handles icon with mixed properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              size: ZephyrIconSize.large,
              status: ZephyrIconStatus.success,
              customSize: 40.0,
              semanticLabel: 'Home button',
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.bySemanticsLabel('Home button'), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, 40.0);
    });

    testWidgets('handles icon with transparent color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              color: Colors.transparent,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, Colors.transparent);
    });

    testWidgets('handles icon with theme override',
        (WidgetTester tester) async {
      const customTheme = ZephyrIconTheme(
        defaultColor: Colors.cyan,
        primaryColor: Colors.blue,
        secondaryColor: Colors.teal,
        errorColor: Colors.red,
        warningColor: Colors.orange,
        successColor: Colors.green,
        infoColor: Colors.lightBlue,
        disabledColor: Colors.grey,
        defaultSize: 24.0,
        smallSize: 14.0,
        mediumSize: 22.0,
        largeSize: 30.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              theme: customTheme,
              color: Colors.red, // This should override the theme color
              customSize: 50.0, // This should override the theme size
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, Colors.red); // Override should take precedence
      expect(icon.size, 50.0); // Override should take precedence
    });

    testWidgets('handles icon with empty semantic label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              semanticLabel: '',
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('handles icon in scrollable context',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: ZephyrTheme(
            data: ZephyrThemeData.light(),
            child: Scaffold(
            body: ListView(
              children: const [
                SizedBox(height: 100, child: ColoredBox(color: Colors.red)),
                ZephyrIcon(Icons.home),
                SizedBox(height: 100, child: ColoredBox(color: Colors.blue)),
                ZephyrIcon(Icons.star),
                SizedBox(height: 100, child: ColoredBox(color: Colors.green)),
              ],
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsNWidgets(2));
      expect(find.byType(Icon), findsNWidgets(2));
    });

    testWidgets('handles all icon variants in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: [
                ZephyrIcon(Icons.home, size: ZephyrIconSize.small),
                ZephyrIcon(Icons.star, size: ZephyrIconSize.medium),
                ZephyrIcon(Icons.settings, size: ZephyrIconSize.large),
                ZephyrIcon(Icons.favorite, status: ZephyrIconStatus.primary),
                ZephyrIcon(Icons.error, status: ZephyrIconStatus.error),
                ZephyrIcon(Icons.warning, status: ZephyrIconStatus.warning),
                ZephyrIcon(Icons.check, status: ZephyrIconStatus.success),
                ZephyrIcon(Icons.info, status: ZephyrIconStatus.info),
                ZephyrIcon(Icons.block, status: ZephyrIconStatus.disabled),
              ],
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsNWidgets(9));
      expect(find.byType(Icon), findsNWidgets(9));
    });

    testWidgets('handles icon with complex theme combinations',
        (WidgetTester tester) async {
      const customTheme = ZephyrIconTheme(
        defaultColor: Colors.purple,
        primaryColor: Colors.deepPurple,
        secondaryColor: Colors.indigo,
        errorColor: Colors.red,
        warningColor: Colors.orange,
        successColor: Colors.green,
        infoColor: Colors.blue,
        disabledColor: Colors.grey,
        defaultSize: 24.0,
        smallSize: 12.0,
        mediumSize: 24.0,
        largeSize: 48.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrIcon(
              Icons.home,
              theme: customTheme,
              size: ZephyrIconSize.large,
              status: ZephyrIconStatus.primary,
            ),
          ),
          ),
        ),
      );

      expect(find.byType(ZephyrIcon), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, 48.0);
    });
  });
}
