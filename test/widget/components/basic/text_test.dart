/// Text组件基础测试
///
/// 测试VelocityText组件的基本功能
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/basic/text/text.dart';
import 'package:velocity_ui/src/components/basic/text/text_theme.dart';
import 'package:velocity_ui/src/core/theme/theme_config.dart';

void main() {
  group('VelocityText', () {
    setUp(() {
      // 设置主题
      VelocityThemeConfig.createLightTheme();
    });

    group('constructor', () {
      testWidgets('应该正确渲染基本文本', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText('Test Text'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Test Text'), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('应该支持自定义样式', (WidgetTester tester) async {
        const customStyle = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(
                'Custom Style',
                style: customStyle,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Custom Style'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 20);
        expect(textWidget.style?.fontWeight, FontWeight.bold);
        expect(textWidget.style?.color, Colors.red);
      });

      testWidgets('应该支持自定义颜色', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(
                'Colored Text',
                color: Colors.blue,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Colored Text'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.color, Colors.blue);
      });

      testWidgets('应该支持文本对齐', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(
                'Aligned Text',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Aligned Text'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.textAlign, TextAlign.center);
      });

      testWidgets('应该支持最大行数', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(
                'Long text that should be truncated',
                maxLines: 2,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Long text that should be truncated'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.maxLines, 2);
      });

      testWidgets('应该支持文本溢出处理', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(
                'Very long text that will overflow',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Very long text that will overflow'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('应该支持软换行', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(
                'Soft wrap text',
                softWrap: true,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Soft wrap text'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.softWrap, true);
      });

      testWidgets('应该支持文本缩放', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(
                'Scaled text',
                textScaleFactor: 1.5,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Scaled text'), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.textScaler, const TextScaler.linear(1.5));
      });
    });

    group('headline variants', () {
      testWidgets('应该正确渲染headlineLarge', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.headlineLarge('Headline Large'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Headline Large'), findsOneWidget);
      });

      testWidgets('应该正确渲染headlineMedium', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.headlineMedium('Headline Medium'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Headline Medium'), findsOneWidget);
      });

      testWidgets('应该正确渲染headlineSmall', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.headlineSmall('Headline Small'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Headline Small'), findsOneWidget);
      });
    });

    group('title variants', () {
      testWidgets('应该正确渲染titleLarge', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.titleLarge('Title Large'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Title Large'), findsOneWidget);
      });

      testWidgets('应该正确渲染titleMedium', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.titleMedium('Title Medium'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Title Medium'), findsOneWidget);
      });

      testWidgets('应该正确渲染titleSmall', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.titleSmall('Title Small'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Title Small'), findsOneWidget);
      });
    });

    group('body variants', () {
      testWidgets('应该正确渲染bodyLarge', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.bodyLarge('Body Large'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Body Large'), findsOneWidget);
      });

      testWidgets('应该正确渲染bodyMedium', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.bodyMedium('Body Medium'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Body Medium'), findsOneWidget);
      });

      testWidgets('应该正确渲染bodySmall', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.bodySmall('Body Small'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Body Small'), findsOneWidget);
      });
    });

    group('label variants', () {
      testWidgets('应该正确渲染labelLarge', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.labelLarge('Label Large'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Label Large'), findsOneWidget);
      });

      testWidgets('应该正确渲染labelMedium', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.labelMedium('Label Medium'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Label Medium'), findsOneWidget);
      });

      testWidgets('应该正确渲染labelSmall', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.labelSmall('Label Small'),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Label Small'), findsOneWidget);
      });
    });

    group('custom theme', () {
      testWidgets('应该支持自定义主题', (WidgetTester tester) async {
        const customTheme = VelocityTextTheme(
          primaryColor: Colors.purple,
          secondaryColor: Colors.orange,
          errorColor: Colors.red,
          disabledColor: Colors.grey,
          headlineLarge:
              TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium:
              TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          headlineSmall:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge:
              TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          titleMedium:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleSmall:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
          labelLarge:
              TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          labelMedium:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          labelSmall:
              TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText.headlineLarge(
                'Custom Theme',
                theme: customTheme,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text('Custom Theme'), findsOneWidget);
      });
    });

    group('all variants', () {
      testWidgets('应该支持所有文本变体', (WidgetTester tester) async {
        final variants = [
          () => VelocityText.headlineLarge('Test'),
          () => VelocityText.headlineMedium('Test'),
          () => VelocityText.headlineSmall('Test'),
          () => VelocityText.titleLarge('Test'),
          () => VelocityText.titleMedium('Test'),
          () => VelocityText.titleSmall('Test'),
          () => VelocityText.bodyLarge('Test'),
          () => VelocityText.bodyMedium('Test'),
          () => VelocityText.bodySmall('Test'),
          () => VelocityText.labelLarge('Test'),
          () => VelocityText.labelMedium('Test'),
          () => VelocityText.labelSmall('Test'),
        ];

        for (final variantBuilder in variants) {
          await tester.pumpWidget(
            MaterialApp(
              home: Material(
                child: variantBuilder(),
              ),
            ),
          );

          expect(find.byType(VelocityText), findsOneWidget);
          expect(find.text('Test'), findsOneWidget);

          // 清理widget树
          await tester.pumpWidget(const SizedBox());
        }
      });
    });

    group('edge cases', () {
      testWidgets('应该处理空文本', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(''),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text(''), findsOneWidget);
      });

      testWidgets('应该处理长文本', (WidgetTester tester) async {
        final longText =
            'This is a very long text that should be handled properly by the text component. ' *
                10;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityText(longText),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('应该处理特殊字符', (WidgetTester tester) async {
        const specialText = r'Special chars: @#$%^&*()_+-=[]{}|;:,.<>?';

        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityText(specialText),
            ),
          ),
        );

        expect(find.byType(VelocityText), findsOneWidget);
        expect(find.text(specialText), findsOneWidget);
      });
    });
  });
}
