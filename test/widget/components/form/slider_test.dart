import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/forms/slider/slider.dart';

void main() {
  group('VelocitySlider Widget Tests', () {
    testWidgets('renders slider with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders slider with custom min and max',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 50.0,
              min: 0.0,
              max: 100.0,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders discrete slider', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 2.0,
              min: 0.0,
              max: 5.0,
              type: VelocitySliderType.discrete,
              divisions: 5,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders indicator slider', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.7,
              type: VelocitySliderType.indicator,
              label: 'Volume',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('renders disabled slider', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('handles value change callback', (WidgetTester tester) async {
      double? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(changedValue, isNull);
    });

    testWidgets('handles change start callback', (WidgetTester tester) async {
      double? startValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              onChangeStart: (value) => startValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(startValue, isNull);
    });

    testWidgets('handles change end callback', (WidgetTester tester) async {
      double? endValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              onChangeEnd: (value) => endValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(endValue, isNull);
    });

    testWidgets('handles slider at minimum value', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.0,
              min: 0.0,
              max: 1.0,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('handles slider at maximum value', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 1.0,
              min: 0.0,
              max: 1.0,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('handles slider with negative range',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: -0.5,
              min: -1.0,
              max: 0.0,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('handles multiple sliders in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                VelocitySlider(
                  value: 0.3,
                  label: 'Volume',
                ),
                SizedBox(height: 32),
                VelocitySlider(
                  value: 0.7,
                  min: 0.0,
                  max: 100.0,
                  label: 'Brightness',
                ),
                SizedBox(height: 32),
                VelocitySlider(
                  value: 2.0,
                  min: 0.0,
                  max: 5.0,
                  type: VelocitySliderType.discrete,
                  divisions: 5,
                  label: 'Contrast',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsNWidgets(3));
      expect(find.byType(Slider), findsNWidgets(3));
    });

    testWidgets('handles slider with null callback values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              onChanged: null,
              onChangeStart: null,
              onChangeEnd: null,
              theme: null,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('handles slider with semantic label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              label: 'Volume Control',
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('handles slider in disabled state with callbacks',
        (WidgetTester tester) async {
      double? changedValue;
      double? startValue;
      double? endValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              disabled: true,
              onChanged: (value) => changedValue = value,
              onChangeStart: (value) => startValue = value,
              onChangeEnd: (value) => endValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
      expect(changedValue, isNull);
      expect(startValue, isNull);
      expect(endValue, isNull);
    });

    testWidgets('handles slider with value updates from parent',
        (WidgetTester tester) async {
      var sliderValue = 0.5;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    VelocitySlider(
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          sliderValue = 0.8;
                        });
                      },
                      child: const Text('Update Value'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });

    testWidgets('handles slider with all callbacks',
        (WidgetTester tester) async {
      double? changedValue;
      double? startValue;
      double? endValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocitySlider(
              value: 0.5,
              onChanged: (value) => changedValue = value,
              onChangeStart: (value) => startValue = value,
              onChangeEnd: (value) => endValue = value,
            ),
          ),
        ),
      );

      expect(find.byWidgetPredicate((widget) => widget is VelocitySlider),
          findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
      expect(changedValue, isNull);
      expect(startValue, isNull);
      expect(endValue, isNull);
    });
  });
}
