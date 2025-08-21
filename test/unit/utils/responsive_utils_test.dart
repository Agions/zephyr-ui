/// 响应式工具测试
///
/// 测试响应式工具类的功能。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/utils/responsive/responsive_utils.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';
import 'package:zephyr_ui/src/core/constants/design_tokens.dart';

void main() {
  group('ZephyrResponsiveUtils', () {
    testWidgets('getBreakpoint should return correct breakpoint', (tester) async {
      // 测试不同屏幕宽度对应的断点
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                final breakpoint = ZephyrResponsiveUtils.getBreakpoint(context);
                expect(breakpoint, ZephyrBreakpoint.xs);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: Builder(
              builder: (context) {
                final breakpoint = ZephyrResponsiveUtils.getBreakpoint(context);
                expect(breakpoint, ZephyrBreakpoint.sm);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: Builder(
              builder: (context) {
                final breakpoint = ZephyrResponsiveUtils.getBreakpoint(context);
                expect(breakpoint, ZephyrBreakpoint.md);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1000, 600)),
            child: Builder(
              builder: (context) {
                final breakpoint = ZephyrResponsiveUtils.getBreakpoint(context);
                expect(breakpoint, ZephyrBreakpoint.lg);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1300, 600)),
            child: Builder(
              builder: (context) {
                final breakpoint = ZephyrResponsiveUtils.getBreakpoint(context);
                expect(breakpoint, ZephyrBreakpoint.xl);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1500, 600)),
            child: Builder(
              builder: (context) {
                final breakpoint = ZephyrResponsiveUtils.getBreakpoint(context);
                expect(breakpoint, ZephyrBreakpoint.xxl);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('isMobile should return correct value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                expect(ZephyrResponsiveUtils.isMobile(context), true);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: Builder(
              builder: (context) {
                expect(ZephyrResponsiveUtils.isMobile(context), false);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('isTablet should return correct value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: Builder(
              builder: (context) {
                expect(ZephyrResponsiveUtils.isTablet(context), true);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                expect(ZephyrResponsiveUtils.isTablet(context), false);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('isDesktop should return correct value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                expect(ZephyrResponsiveUtils.isDesktop(context), true);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: Builder(
              builder: (context) {
                expect(ZephyrResponsiveUtils.isDesktop(context), false);
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('responsive should return correct value based on breakpoint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                final result = ZephyrResponsiveUtils.responsive<String>(
                  context,
                  xs: 'xs',
                  sm: 'sm',
                  md: 'md',
                  lg: 'lg',
                  xl: 'xl',
                  xxl: 'xxl',
                  defaultValue: 'default',
                );
                expect(result, 'xs');
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: Builder(
              builder: (context) {
                final result = ZephyrResponsiveUtils.responsive<String>(
                  context,
                  sm: 'sm',
                  md: 'md',
                  lg: 'lg',
                  defaultValue: 'default',
                );
                expect(result, 'sm');
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('getColumns should return correct column count', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                final columns = ZephyrResponsiveUtils.getColumns(context);
                expect(columns, 1); // xs default
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: Builder(
              builder: (context) {
                final columns = ZephyrResponsiveUtils.getColumns(context);
                expect(columns, 2); // sm default
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('getSpacing should return correct spacing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                final spacing = ZephyrResponsiveUtils.getSpacing(context);
                expect(spacing, ZephyrSpacing.sm); // xs default
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: Builder(
              builder: (context) {
                final spacing = ZephyrResponsiveUtils.getSpacing(context);
                expect(spacing, ZephyrSpacing.md); // sm default
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('getFontSize should return correct font size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = ZephyrResponsiveUtils.getFontSize(context);
                expect(fontSize, ZephyrTypography.fontSize14); // xs default
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = ZephyrResponsiveUtils.getFontSize(context);
                expect(fontSize, ZephyrTypography.fontSize16); // sm default
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('getMinTouchTargetSize should return correct size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                final size = ZephyrResponsiveUtils.getMinTouchTargetSize(context);
                expect(size, 44.0); // mobile
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final size = ZephyrResponsiveUtils.getMinTouchTargetSize(context);
                expect(size, 32.0); // desktop
                return Container();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });
  });

  group('ZephyrResponsiveBuilder', () {
    testWidgets('should build correct widget based on breakpoint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: ZephyrResponsiveBuilder(
              xs: (context) => const Text('XS'),
              sm: (context) => const Text('SM'),
              md: (context) => const Text('MD'),
              lg: (context) => const Text('LG'),
              xl: (context) => const Text('XL'),
              xxl: (context) => const Text('XXL'),
              builder: (context) => const Text('Default'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('XS'), findsOneWidget);
      expect(find.text('SM'), findsNothing);

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: ZephyrResponsiveBuilder(
              xs: (context) => const Text('XS'),
              sm: (context) => const Text('SM'),
              md: (context) => const Text('MD'),
              lg: (context) => const Text('LG'),
              xl: (context) => const Text('XL'),
              xxl: (context) => const Text('XXL'),
              builder: (context) => const Text('Default'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('SM'), findsOneWidget);
      expect(find.text('XS'), findsNothing);
    });

    testWidgets('should fallback to previous breakpoint if current not defined', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: ZephyrResponsiveBuilder(
              xs: (context) => const Text('XS'),
              lg: (context) => const Text('LG'),
              builder: (context) => const Text('Default'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // MD breakpoint should fallback to XS since SM and MD are not defined
      expect(find.text('XS'), findsOneWidget);
      expect(find.text('LG'), findsNothing);
    });

    testWidgets('should use default builder if no breakpoint matches', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: ZephyrResponsiveBuilder(
              lg: (context) => const Text('LG'),
              builder: (context) => const Text('Default'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Default'), findsOneWidget);
      expect(find.text('LG'), findsNothing);
    });
  });
}
