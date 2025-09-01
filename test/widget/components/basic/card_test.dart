import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/basic/card/card.dart';
import 'package:zephyr_ui/src/core/theme/theme_data.dart';

void main() {
  group('ZephyrCard Widget Tests', () {
    late ThemeData theme;

    setUpAll(() {
      final zephyrTheme = ZephyrThemeData.light();
      theme = ThemeData(
        brightness: zephyrTheme.brightness,
        primaryColor: zephyrTheme.primaryColor,
        cardTheme: CardTheme(
          color: zephyrTheme.backgroundColor,
          elevation: 1.0,
          margin: const EdgeInsets.all(8.0),
        ),
      );
    });

    testWidgets('renders standard card with child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              child: SizedBox(
                height: 100,
                child: Text('Test Card'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Card'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders flat card variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard.flat(
              child: const Text('Flat Card'),
            ),
          ),
        ),
      );

      expect(find.text('Flat Card'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('renders elevated card variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard.elevated(
              child: const Text('Elevated Card'),
            ),
          ),
        ),
      );

      expect(find.text('Elevated Card'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('renders filled card variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard.filled(
              child: const Text('Filled Card'),
            ),
          ),
        ),
      );

      expect(find.text('Filled Card'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('renders outlined card variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard.outlined(
              child: const Text('Outlined Card'),
            ),
          ),
        ),
      );

      expect(find.text('Outlined Card'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('handles custom margin', (WidgetTester tester) async {
      const customMargin = EdgeInsets.all(20.0);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              margin: customMargin,
              child: Text('Card with Margin'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.margin, equals(customMargin));
    });

    testWidgets('handles custom padding', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(20.0);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              padding: customPadding,
              child: Text('Card with Padding'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.padding, equals(customPadding));
    });

    testWidgets('handles custom width', (WidgetTester tester) async {
      const customWidth = 200.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              width: customWidth,
              child: Text('Card with Width'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.width, equals(customWidth));
    });

    testWidgets('handles custom height', (WidgetTester tester) async {
      const customHeight = 150.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              height: customHeight,
              child: Text('Card with Height'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.height, equals(customHeight));
    });

    testWidgets('handles custom backgroundColor', (WidgetTester tester) async {
      const customBackgroundColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              backgroundColor: customBackgroundColor,
              child: Text('Card with Background Color'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.backgroundColor, equals(customBackgroundColor));
    });

    testWidgets('handles custom elevation', (WidgetTester tester) async {
      const customElevation = 8.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              elevation: customElevation,
              child: Text('Card with Elevation'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.elevation, equals(customElevation));
    });

    testWidgets('handles custom borderRadius', (WidgetTester tester) async {
      const customBorderRadius = BorderRadius.all(Radius.circular(16.0));

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              borderRadius: customBorderRadius,
              child: Text('Card with Border Radius'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.borderRadius, equals(customBorderRadius));
    });

    testWidgets('handles custom border', (WidgetTester tester) async {
      const customBorderColor = Colors.blue;
      const customBorderWidth = 2.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              borderColor: customBorderColor,
              borderWidth: customBorderWidth,
              child: Text('Card with Border'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.borderColor, equals(customBorderColor));
      expect(card.borderWidth, equals(customBorderWidth));
    });

    testWidgets('handles onTap callback', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              onTap: () {
                tapped = true;
              },
              child: const Text('Tappable Card'),
            ),
          ),
        ),
      );

      expect(tapped, isFalse);

      await tester.tap(find.byType(ZephyrCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('handles onLongPress callback', (WidgetTester tester) async {
      bool longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              onLongPress: () {
                longPressed = true;
              },
              child: const Text('Long Pressable Card'),
            ),
          ),
        ),
      );

      expect(longPressed, isFalse);

      await tester.longPress(find.byType(ZephyrCard));
      await tester.pump();

      expect(longPressed, isTrue);
    });

    testWidgets('handles semantic label', (WidgetTester tester) async {
      const semanticLabel = 'Custom Card Label';

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              semanticLabel: semanticLabel,
              child: Text('Card with Semantic Label'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.semanticLabel, equals(semanticLabel));
    });

    testWidgets('handles enabled/disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              enabled: false,
              onTap: () {},
              child: const Text('Disabled Card'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.enabled, isFalse);
    });

    testWidgets('handles complex child content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Title',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Description text goes here...'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Action'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description text goes here...'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('handles edge case with empty child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              child: SizedBox(),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrCard), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('handles edge case with null child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(),
          ),
        ),
      );

      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('handles edge case with zero dimensions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              width: 0,
              height: 0,
              child: Text('Zero Size Card'),
            ),
          ),
        ),
      );

      expect(find.text('Zero Size Card'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('handles theme inheritance', (WidgetTester tester) async {
      final customTheme = ThemeData(
        cardTheme: const CardTheme(
          color: Colors.green,
          elevation: 6.0,
          margin: EdgeInsets.all(12.0),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: customTheme,
          home: const Scaffold(
            body: ZephyrCard(
              child: Text('Themed Card'),
            ),
          ),
        ),
      );

      expect(find.text('Themed Card'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsOneWidget);
    });

    testWidgets('handles interactive states correctly',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              onTap: () {
                tapCount++;
              },
              child: const Text('Interactive Card'),
            ),
          ),
        ),
      );

      // Test multiple taps
      await tester.tap(find.byType(ZephyrCard));
      await tester.pump();

      await tester.tap(find.byType(ZephyrCard));
      await tester.pump();

      expect(tapCount, equals(2));
    });

    testWidgets('handles accessibility properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              semanticLabel: 'Important Card',
              child: Text('Accessible Card'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.semanticLabel, equals('Important Card'));
    });

    testWidgets('handles different card variants with different themes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                ZephyrCard.flat(child: const Text('Flat')),
                ZephyrCard.elevated(child: const Text('Elevated')),
                ZephyrCard.filled(child: const Text('Filled')),
                ZephyrCard.outlined(child: const Text('Outlined')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Flat'), findsOneWidget);
      expect(find.text('Elevated'), findsOneWidget);
      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.byType(ZephyrCard), findsNWidgets(4));
    });

    testWidgets('handles custom colors', (WidgetTester tester) async {
      const customForegroundColor = Colors.white;
      const customShadowColor = Colors.red;
      const customSurfaceTintColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              foregroundColor: customForegroundColor,
              shadowColor: customShadowColor,
              surfaceTintColor: customSurfaceTintColor,
              child: Text('Card with Custom Colors'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.foregroundColor, equals(customForegroundColor));
      expect(card.shadowColor, equals(customShadowColor));
      expect(card.surfaceTintColor, equals(customSurfaceTintColor));
    });

    testWidgets('handles hover callback', (WidgetTester tester) async {
      bool hovered = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              onHover: (isHovered) {
                hovered = isHovered;
              },
              child: const Text('Hoverable Card'),
            ),
          ),
        ),
      );

      expect(hovered, isFalse);

      // Note: Hover testing is complex in widget tests
      // We'll just verify the widget renders correctly
      expect(find.text('Hoverable Card'), findsOneWidget);
    });

    testWidgets('handles focus node and autofocus',
        (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              focusNode: focusNode,
              autofocus: true,
              child: const Text('Focusable Card'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.focusNode, equals(focusNode));
      expect(card.autofocus, isTrue);

      focusNode.dispose();
    });

    testWidgets('handles custom clip behavior', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrCard(
              clipBehavior: Clip.hardEdge,
              child: Text('Card with Clip'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.clipBehavior, equals(Clip.hardEdge));
    });

    testWidgets('handles custom splash and highlight colors',
        (WidgetTester tester) async {
      const customSplashColor = Colors.blue;
      const customHighlightColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrCard(
              splashColor: customSplashColor,
              highlightColor: customHighlightColor,
              onTap: () {},
              child: const Text('Card with Custom Colors'),
            ),
          ),
        ),
      );

      final cardFinder = find.byType(ZephyrCard);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<ZephyrCard>(cardFinder);
      expect(card.splashColor, equals(customSplashColor));
      expect(card.highlightColor, equals(customHighlightColor));
    });
  });
}
