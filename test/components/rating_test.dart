import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/forms/rating/rating.dart';
import 'package:velocity_ui/src/components/forms/rating/rating_theme.dart';

void main() {
  group('VelocityRating', () {
    testWidgets('should display rating with default value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(5));
    });

    testWidgets('should handle rating change', (WidgetTester tester) async {
      var ratingValue = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: ratingValue,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // Tap on the 4th star
      await tester.tap(find.byType(Icon).at(3));
      await tester.pump();

      expect(ratingValue, equals(4.0));
    });

    testWidgets('should support half ratings', (WidgetTester tester) async {
      var ratingValue = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: ratingValue,
              allowHalfRating: true,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // Tap on the 3rd star
      await tester.tap(find.byType(Icon).at(2));
      await tester.pump();

      // Tap again to get half rating
      await tester.tap(find.byType(Icon).at(2));
      await tester.pump();

      expect(ratingValue, equals(2.5));
    });

    testWidgets('should respect readOnly mode', (WidgetTester tester) async {
      var ratingValue = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: ratingValue,
              readOnly: true,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // Try to tap on a star
      await tester.tap(find.byType(Icon).at(2));
      await tester.pump();

      expect(ratingValue, equals(0.0));
    });

    testWidgets('should respect disabled state', (WidgetTester tester) async {
      var ratingValue = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: ratingValue,
              disabled: true,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // Try to tap on a star
      await tester.tap(find.byType(Icon).at(2));
      await tester.pump();

      expect(ratingValue, equals(0.0));
    });

    testWidgets('should show labels when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              showLabels: true,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('should support custom icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              customIcons: [Icons.favorite, Icons.favorite_border],
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsNWidgets(3));
      expect(find.byIcon(Icons.favorite_border), findsNWidgets(2));
    });

    testWidgets('should support custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              selectedColor: Colors.red,
              unselectedColor: Colors.grey,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      final ratingFinder = find.byType(VelocityRating);
      expect(ratingFinder, findsOneWidget);
    });

    testWidgets('should handle hover state', (WidgetTester tester) async {
      var hoverValue = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              onHover: (value) {
                hoverValue = value;
              },
              onChanged: (value) {},
            ),
          ),
        ),
      );

      // Hover over the 4th star
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: tester.getCenter(find.byType(Icon).at(3)));
      await tester.pump();

      expect(hoverValue, equals(4.0));
    });

    testWidgets('should support vertical layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              direction: Axis.vertical,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle allowClear functionality', (WidgetTester tester) async {
      var ratingValue = 4.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: ratingValue,
              allowClear: true,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // Tap on the 4th star (same as current value)
      await tester.tap(find.byType(Icon).at(3));
      await tester.pump();

      expect(ratingValue, equals(0.0));
    });

    testWidgets('should support custom itemCount', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              itemCount: 7,
              maxValue: 10,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNWidgets(7));
    });

    testWidgets('should handle tooltip display', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              showTooltip: true,
              tooltipPrefix: 'Rate',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(Tooltip), findsNWidgets(5));
    });

    testWidgets('should respect animation duration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              animationDuration: const Duration(milliseconds: 500),
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle value clamping', (WidgetTester tester) async {
      var ratingValue = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 10.0, // Above maxValue
              maxValue: 5.0,
              onChanged: (value) {
                ratingValue = value;
              },
            ),
          ),
        ),
      );

      // Should clamp to maxValue
      expect(ratingValue, equals(5.0));
    });

    testWidgets('should support different alignments', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              alignment: WrapAlignment.center,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle spacing configuration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              spacing: 8.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle size configuration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              size: 32.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });
  });

  group('VelocityRatingDisplay', () {
    testWidgets('should display rating in read-only mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRatingDisplay(
              value: 4.5,
              allowHalfRating: true,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRatingDisplay), findsOneWidget);
    });

    testWidgets('should not allow interaction', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRatingDisplay(
              value: 3.0,
            ),
          ),
        ),
      );

      // Try to tap on a star
      await tester.tap(find.byType(Icon).at(2));
      await tester.pump();

      // Should not cause any errors and value should remain the same
      expect(find.byType(VelocityRatingDisplay), findsOneWidget);
    });

    testWidgets('should show numeric value when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRatingDisplay(
              value: 4.5,
              showValue: true,
              allowHalfRating: true,
            ),
          ),
        ),
      );

      expect(find.text('4.5'), findsOneWidget);
    });

    testWidgets('should support custom value style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRatingDisplay(
              value: 4.5,
              showValue: true,
              valueStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      expect(find.text('4.5'), findsOneWidget);
    });

    testWidgets('should support vertical layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRatingDisplay(
              value: 3.0,
              direction: Axis.vertical,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRatingDisplay), findsOneWidget);
    });

    testWidgets('should handle custom itemCount', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRatingDisplay(
              value: 3.0,
              itemCount: 7,
              maxValue: 10,
            ),
          ),
        ),
      );

      expect(find.byType(Icon), findsNWidgets(7));
    });
  });

  group('VelocityRatingTheme', () {
    test('should create light theme', () {
      final theme = VelocityRatingTheme.light();
      expect(theme.selectedColor, equals(const Color(0xFFFFC107)));
      expect(theme.unselectedColor, equals(const Color(0xFFE0E0E0)));
    });

    test('should create dark theme', () {
      final theme = VelocityRatingTheme.dark();
      expect(theme.selectedColor, equals(const Color(0xFFFFC107)));
      expect(theme.unselectedColor, equals(const Color(0xFF424242)));
    });

    test('should copy theme with modifications', () {
      final theme = VelocityRatingTheme.light();
      final modifiedTheme = theme.copyWith(
        selectedColor: Colors.red,
        unselectedColor: Colors.grey,
      );

      expect(modifiedTheme.selectedColor, equals(Colors.red));
      expect(modifiedTheme.unselectedColor, equals(Colors.grey));
      expect(modifiedTheme.hoverColor, equals(theme.hoverColor));
    });

    test('should handle null values in copyWith', () {
      final theme = VelocityRatingTheme.light();
      final modifiedTheme = theme.copyWith();

      expect(modifiedTheme.selectedColor, equals(theme.selectedColor));
      expect(modifiedTheme.unselectedColor, equals(theme.unselectedColor));
      expect(modifiedTheme.hoverColor, equals(theme.hoverColor));
    });

    test('should support custom animation duration', () {
      final theme = VelocityRatingTheme.light();
      final modifiedTheme = theme.copyWith(
        animationDuration: const Duration(milliseconds: 500),
      );

      expect(modifiedTheme.animationDuration, equals(const Duration(milliseconds: 500)));
    });

    test('should support custom label style', () {
      final theme = VelocityRatingTheme.light();
      const customStyle = TextStyle(fontSize: 12, color: Colors.blue);
      final modifiedTheme = theme.copyWith(
        labelStyle: customStyle,
      );

      expect(modifiedTheme.labelStyle, equals(customStyle));
    });
  });

  group('Accessibility', () {
    testWidgets('should provide semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              semanticLabel: 'Product rating',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Product rating'), findsOneWidget);
    });

    testWidgets('should handle accessibility features toggle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              enableAccessibilityFeatures: false,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });
  });

  group('Edge Cases', () {
    testWidgets('should handle zero value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 0.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle negative value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: -1.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle very large value', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 1000.0,
              maxValue: 5.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle zero maxValue', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              maxValue: 0.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });

    testWidgets('should handle negative maxValue', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityRating(
              value: 3.0,
              maxValue: -1.0,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityRating), findsOneWidget);
    });
  });
}