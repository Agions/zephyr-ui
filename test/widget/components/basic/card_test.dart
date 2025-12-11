import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/display/card/card.dart';

void main() {
  group('VelocityCard Widget Tests', () {
    late ThemeData theme;

    setUpAll(() {
      theme = ThemeData.light();
    });

    testWidgets('renders standard card with child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCard(
              child: SizedBox(
                height: 100,
                child: Text('Test Card'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Card'), findsOneWidget);
      expect(find.byType(VelocityCard), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders outlined card variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityOutlinedCard(
              child: Text('Outlined Card'),
            ),
          ),
        ),
      );

      expect(find.text('Outlined Card'), findsOneWidget);
      expect(find.byType(VelocityOutlinedCard), findsOneWidget);
    });

    testWidgets('renders filled card variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityFilledCard(
              child: Text('Filled Card'),
            ),
          ),
        ),
      );

      expect(find.text('Filled Card'), findsOneWidget);
      expect(find.byType(VelocityFilledCard), findsOneWidget);
    });

    testWidgets('handles custom style with margin and padding',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCard(
              style: VelocityCardStyle(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(10.0),
              ),
              child: Text('Card with Margin and Padding'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCard), findsOneWidget);
      expect(find.text('Card with Margin and Padding'), findsOneWidget);
    });

    testWidgets('handles custom style with dimensions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCard(
              style: VelocityCardStyle(
                width: 200.0,
                height: 150.0,
              ),
              child: Text('Card with Custom Dimensions'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCard), findsOneWidget);
      expect(find.text('Card with Custom Dimensions'), findsOneWidget);
    });

    testWidgets('handles custom style with background color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCard(
              style: VelocityCardStyle(
                backgroundColor: Colors.blue,
              ),
              child: Text('Card with Background Color'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCard), findsOneWidget);
      expect(find.text('Card with Background Color'), findsOneWidget);
    });

    testWidgets('handles custom style with borderRadius',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCard(
              style: VelocityCardStyle(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              child: Text('Card with Border Radius'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCard), findsOneWidget);
      expect(find.text('Card with Border Radius'), findsOneWidget);
    });

    testWidgets('handles custom style with border',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCard(
              style: VelocityCardStyle(
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: const Text('Card with Border'),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCard), findsOneWidget);
      expect(find.text('Card with Border'), findsOneWidget);
    });

    testWidgets('handles onTap callback', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCard(
              onTap: () {
                tapped = true;
              },
              child: const Text('Tappable Card'),
            ),
          ),
        ),
      );

      expect(tapped, isFalse);

      await tester.tap(find.byType(VelocityCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('handles onLongPress callback', (WidgetTester tester) async {
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCard(
              onLongPress: () {
                longPressed = true;
              },
              child: const Text('Long Pressable Card'),
            ),
          ),
        ),
      );

      expect(longPressed, isFalse);

      await tester.longPress(find.byType(VelocityCard));
      await tester.pump();

      expect(longPressed, isTrue);
    });

    testWidgets('handles complex child content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCard(
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
      expect(find.byType(VelocityCard), findsOneWidget);
    });

    testWidgets('handles edge case with empty child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCard(
              child: SizedBox(),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityCard), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('handles edge case with null child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityCard(),
          ),
        ),
      );

      expect(find.byType(VelocityCard), findsOneWidget);
    });

    testWidgets('handles interactive states correctly',
        (WidgetTester tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityCard(
              onTap: () {
                tapCount++;
              },
              child: const Text('Interactive Card'),
            ),
          ),
        ),
      );

      // Test multiple taps
      await tester.tap(find.byType(VelocityCard));
      await tester.pump();

      await tester.tap(find.byType(VelocityCard));
      await tester.pump();

      expect(tapCount, equals(2));
    });

    testWidgets('handles different card variants',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: const [
                VelocityCard(
                  child: Text('Default Card'),
                ),
                SizedBox(height: 10),
                VelocityOutlinedCard(
                  child: Text('Outlined Card'),
                ),
                SizedBox(height: 10),
                VelocityFilledCard(
                  child: Text('Filled Card'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Default Card'), findsOneWidget);
      expect(find.text('Outlined Card'), findsOneWidget);
      expect(find.text('Filled Card'), findsOneWidget);
      expect(find.byType(VelocityCard), findsNWidgets(3));
    });
  });
}
