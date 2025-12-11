/// Button组件基础测试
///
/// 测试VelocityButton组件的基本功能
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/basic/button/button.dart';

void main() {
  group('VelocityButton', () {
    late VoidCallback? onPressed;

    setUp(() {
      onPressed = () {};
    });

    group('text constructor', () {
      testWidgets('应该正确渲染主要按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: VelocityButton.text(
              text: 'Primary Button',
              onPressed: onPressed,
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Primary Button'), findsOneWidget);
        expect(find.byType(Material), findsWidgets);
      });

      testWidgets('应该正确处理点击事件', (WidgetTester tester) async {
        var clicked = false;
        void callback() => clicked = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Click Me',
                onPressed: callback,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(VelocityButton));
        await tester.pumpAndSettle();

        expect(clicked, isTrue);
      });

      testWidgets('禁用状态不应该响应点击', (WidgetTester tester) async {
        var clicked = false;

        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Disabled',
                onPressed: null,
                disabled: true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(VelocityButton));
        await tester.pumpAndSettle();

        expect(clicked, isFalse);
      });
    });

    group('different button types', () {
      testWidgets('应该正确渲染次要按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Secondary Button',
                onPressed: onPressed,
                type: VelocityButtonType.secondary,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Secondary Button'), findsOneWidget);
      });

      testWidgets('应该正确渲染轮廓按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Outline Button',
                onPressed: onPressed,
                type: VelocityButtonType.outline,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Outline Button'), findsOneWidget);
      });

      testWidgets('应该正确渲染文本按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Text Button',
                onPressed: onPressed,
                type: VelocityButtonType.text,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Text Button'), findsOneWidget);
      });
    });

    group('icon constructor', () {
      testWidgets('应该正确渲染带图标和文本的按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.icon(
                text: 'Add',
                icon: Icons.add,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Add'), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      testWidgets('应该支持不同类型的带图标按钮', (WidgetTester tester) async {
        for (final type in VelocityButtonType.values) {
          await tester.pumpWidget(
            MaterialApp(
              home: Material(
                child: VelocityButton.icon(
                  text: 'Star',
                  icon: Icons.star,
                  onPressed: onPressed,
                  type: type,
                ),
              ),
            ),
          );

          expect(find.byType(VelocityButton), findsOneWidget);
          expect(find.byIcon(Icons.star), findsOneWidget);
        }
      });
    });

    group('sizes', () {
      testWidgets('应该支持不同尺寸', (WidgetTester tester) async {
        for (final size in VelocityButtonSize.values) {
          await tester.pumpWidget(
            MaterialApp(
              home: Material(
                child: VelocityButton.text(
                  text: 'Size Test',
                  onPressed: onPressed,
                  size: size,
                ),
              ),
            ),
          );

          expect(find.byType(VelocityButton), findsOneWidget);
          expect(find.text('Size Test'), findsOneWidget);
        }
      });
    });

    group('loading state', () {
      testWidgets('应该显示加载状态', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Loading',
                onPressed: onPressed,
                loading: true,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Loading'), findsOneWidget);
      });

      testWidgets('加载状态应该禁用按钮', (WidgetTester tester) async {
        var clicked = false;
        void callback() => clicked = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Loading',
                onPressed: callback,
                loading: true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(VelocityButton));
        await tester.pump();

        expect(clicked, isFalse);
      });
    });

    group('disabled state', () {
      testWidgets('应该正确显示禁用状态', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Disabled',
                onPressed: null,
                disabled: true,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Disabled'), findsOneWidget);
      });
    });

    group('full width', () {
      testWidgets('应该支持全宽模式', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: VelocityButton.text(
                text: 'Full Width',
                onPressed: onPressed,
                fullWidth: true,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Full Width'), findsOneWidget);
      });
    });

    group('icons', () {
      testWidgets('应该支持带图标的按钮', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.icon(
                text: 'With Icon',
                onPressed: onPressed,
                icon: Icons.star,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('With Icon'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('加载状态应该隐藏图标', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.icon(
                text: 'Loading',
                onPressed: onPressed,
                icon: Icons.star,
                loading: true,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byIcon(Icons.star), findsNothing);
      });
    });

    group('custom style', () {
      testWidgets('应该支持自定义样式', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Custom Style',
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Custom Style'), findsOneWidget);
      });
    });

    group('semantic properties', () {
      testWidgets('应该包含语义信息', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: VelocityButton.text(
                text: 'Semantic Button',
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(VelocityButton), findsOneWidget);
        expect(find.text('Semantic Button'), findsOneWidget);
      });
    });
  });
}
