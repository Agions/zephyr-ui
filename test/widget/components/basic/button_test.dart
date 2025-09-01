/// Button组件基础测试
///
/// 测试ZephyrButton组件的基本功能
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/basic/button/button.dart';
import 'package:zephyr_ui/src/components/basic/button/button_theme.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';

void main() {
  group('ZephyrButton', () {
    late VoidCallback? onPressed;

    setUp(() {
      onPressed = () {};
    });

    group('primary constructor', () {
      testWidgets('应该正确渲染主要按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ZephyrButton.primary(
              text: 'Primary Button',
              onPressed: onPressed,
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('Primary Button'), findsOneWidget);
        expect(find.byType(Material), findsWidgets);
      });

      testWidgets('应该正确处理点击事件', (WidgetTester tester) async {
        bool clicked = false;
        void callback() => clicked = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Click Me',
                onPressed: callback,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ZephyrButton));
        await tester.pumpAndSettle();

        expect(clicked, isTrue);
      });

      testWidgets('禁用状态不应该响应点击', (WidgetTester tester) async {
        bool clicked = false;

        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Disabled',
                onPressed: null,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ZephyrButton));
        await tester.pumpAndSettle();

        expect(clicked, isFalse);
      });
    });

    group('secondary constructor', () {
      testWidgets('应该正确渲染次要按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.secondary(
                text: 'Secondary Button',
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('Secondary Button'), findsOneWidget);
      });
    });

    group('outline constructor', () {
      testWidgets('应该正确渲染轮廓按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.outline(
                text: 'Outline Button',
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('Outline Button'), findsOneWidget);
      });
    });

    group('text constructor', () {
      testWidgets('应该正确渲染文本按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.text(
                text: 'Text Button',
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('Text Button'), findsOneWidget);
      });
    });

    group('icon constructor', () {
      testWidgets('应该正确渲染图标按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.icon(
                icon: Icons.add,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      testWidgets('应该支持不同类型的图标按钮', (WidgetTester tester) async {
        for (final type in ZephyrButtonType.values) {
          await tester.pumpWidget(
            MaterialApp(
              home: Material(
                child: ZephyrButton.icon(
                  icon: Icons.star,
                  onPressed: onPressed,
                  type: type,
                ),
              ),
            ),
          );

          expect(find.byType(ZephyrButton), findsOneWidget);
          expect(find.byIcon(Icons.star), findsOneWidget);
        }
      });
    });

    group('sizes', () {
      testWidgets('应该支持不同尺寸', (WidgetTester tester) async {
        for (final size in ZephyrButtonSize.values) {
          await tester.pumpWidget(
            MaterialApp(
              home: Material(
                child: ZephyrButton.primary(
                  text: 'Size Test',
                  onPressed: onPressed,
                  size: size,
                ),
              ),
            ),
          );

          expect(find.byType(ZephyrButton), findsOneWidget);
          expect(find.text('Size Test'), findsOneWidget);
        }
      });
    });

    group('loading state', () {
      testWidgets('应该显示加载状态', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Loading',
                onPressed: onPressed,
                isLoading: true,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Loading'), findsOneWidget);
      });

      testWidgets('加载状态应该禁用按钮', (WidgetTester tester) async {
        bool clicked = false;
        void callback() => clicked = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Loading',
                onPressed: callback,
                isLoading: true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ZephyrButton));
        await tester.pump();

        expect(clicked, isFalse);
      });
    });

    group('disabled state', () {
      testWidgets('应该正确显示禁用状态', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Disabled',
                onPressed: null,
                isDisabled: true,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('Disabled'), findsOneWidget);
      });
    });

    group('full width', () {
      testWidgets('应该支持全宽模式', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ZephyrButton.primary(
                text: 'Full Width',
                onPressed: onPressed,
                isFullWidth: true,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('Full Width'), findsOneWidget);
      });
    });

    group('icons', () {
      testWidgets('应该支持带图标的按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'With Icon',
                onPressed: onPressed,
                icon: Icons.star,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('With Icon'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('加载状态应该隐藏图标', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Loading',
                onPressed: onPressed,
                icon: Icons.star,
                isLoading: true,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byIcon(Icons.star), findsNothing);
      });
    });

    group('custom theme', () {
      testWidgets('应该支持自定义主题', (WidgetTester tester) async {
        final customTheme = ZephyrButtonTheme(
          primaryBackgroundColor: Colors.purple,
          primaryTextColor: Colors.white,
          secondaryBackgroundColor: Colors.orange,
          secondaryTextColor: Colors.black,
          outlineColor: Colors.green,
          outlineTextColor: Colors.green,
          textButtonColor: Colors.red,
          disabledBackgroundColor: Colors.grey,
          disabledTextColor: Colors.grey.shade600,
          borderRadius: 8.0,
          smallPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          mediumPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          largePadding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          loadingColor: Colors.white,
          splashColor: Colors.white.withValues(alpha: 0.3),
          elevation: 4.0,
          disabledElevation: 0.0,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Custom Theme',
                onPressed: onPressed,
                theme: customTheme,
              ),
            ),
          ),
        );

        expect(find.byType(ZephyrButton), findsOneWidget);
        expect(find.text('Custom Theme'), findsOneWidget);
      });
    });

    group('semantic properties', () {
      testWidgets('应该包含语义信息', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ZephyrButton.primary(
                text: 'Semantic Button',
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(Semantics), findsWidgets);
        expect(find.text('Semantic Button'), findsOneWidget);
      });
    });
  });
}
