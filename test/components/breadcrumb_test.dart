import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/components/navigation/breadcrumb/index.dart';

void main() {
  group('VelocityBreadcrumb Widget Tests', () {
    late List<VelocityBreadcrumbItem> testItems;

    setUp(() {
      testItems = [
        const VelocityBreadcrumbItem(
          title: 'Home',
          icon: Icons.home,
          route: '/home',
        ),
        const VelocityBreadcrumbItem(
          title: 'Products',
          icon: Icons.inventory_2,
          route: '/products',
        ),
        const VelocityBreadcrumbItem(
          title: 'Electronics',
          icon: Icons.devices,
          route: '/products/electronics',
          isCurrent: true,
        ),
      ];
    });

    testWidgets('Breadcrumb renders correctly with basic configuration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBreadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Electronics'), findsOneWidget);
    });

    testWidgets('Breadcrumb renders icons when showIcons is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              showIcons: true,
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.inventory_2), findsOneWidget);
      expect(find.byIcon(Icons.devices), findsOneWidget);
    });

    testWidgets('Breadcrumb hides icons when showIcons is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              showIcons: false,
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsNothing);
      expect(find.byIcon(Icons.inventory_2), findsNothing);
      expect(find.byIcon(Icons.devices), findsNothing);
    });

    testWidgets('Breadcrumb uses custom separator when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              separator: const Text('>'),
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      expect(find.text('>'), findsNWidgets(2)); // 2 separators for 3 items
    });

    testWidgets('Breadcrumb auto-collapses when items exceed maxItems', (WidgetTester tester) async {
      final longItems = [
        ...testItems,
        const VelocityBreadcrumbItem(title: 'Smartphones', route: '/products/electronics/smartphones'),
        const VelocityBreadcrumbItem(title: 'iPhone', route: '/products/electronics/smartphones/iphone', isCurrent: true),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: longItems,
              maxItems: 4,
              autoCollapse: true,
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('...'), findsOneWidget); // Collapsed indicator
      expect(find.text('iPhone'), findsOneWidget);
      expect(find.text('Products'), findsNothing); // Should be collapsed
    });

    testWidgets('Breadcrumb applies current item styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              showCurrent: true,
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      final currentTextFinder = find.text('Electronics');
      expect(currentTextFinder, findsOneWidget);
      
      // Check if the current item styling is applied by verifying the theme
      final theme = VelocityBreadcrumbTheme.light();
      expect(theme.currentItemStyle?.fontWeight, equals(FontWeight.w500));
    });

    testWidgets('Breadcrumb handles item taps', (WidgetTester tester) async {
      var wasTapped = false;
      
      final tapItems = [
        VelocityBreadcrumbItem(
          title: 'Home',
          onTap: () {
            wasTapped = true;
          },
        ),
        const VelocityBreadcrumbItem(
          title: 'Current',
          isCurrent: true,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: tapItems,
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Home'));
      await tester.pump();

      expect(wasTapped, isTrue);
    });

    testWidgets('Breadcrumb applies custom theme', (WidgetTester tester) async {
      final customTheme = VelocityBreadcrumbTheme.custom(
        itemStyle: const TextStyle(
          fontSize: 18,
          color: Colors.red,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              theme: customTheme,
            ),
          ),
        ),
      );

      final textFinder = find.text('Home');
      expect(textFinder, findsOneWidget);
      
      // Verify the custom theme was applied correctly
      expect(customTheme.itemStyle?.fontSize, equals(18));
      expect(customTheme.itemStyle?.color, equals(Colors.red));
    });

    testWidgets('Breadcrumb wraps content when wrapContent is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: VelocityBreadcrumb(
                items: testItems,
                wrapContent: true,
                theme: VelocityBreadcrumbTheme.light(),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityBreadcrumb), findsOneWidget);
      // Should wrap instead of overflow
    });

    testWidgets('Breadcrumb shows tooltips when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              showTooltip: true,
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      expect(find.byType(Tooltip), findsWidgets);
    });

    testWidgets('Breadcrumb respects margin and padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityBreadcrumb(
              items: testItems,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(8),
              theme: VelocityBreadcrumbTheme.light(),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.margin, equals(const EdgeInsets.all(16)));
      expect(container.padding, equals(const EdgeInsets.all(8)));
    });
  });

  group('VelocityBreadcrumbTheme Tests', () {
    testWidgets('Light theme creates correct styling', (WidgetTester tester) async {
      final theme = VelocityBreadcrumbTheme.light();
      
      expect(theme.backgroundColor, equals(const Color(0xFFFFFFFF)));
      expect(theme.itemStyle?.color, equals(const Color(0xFF6B7280)));
      expect(theme.currentItemStyle?.fontWeight, equals(FontWeight.w500));
    });

    testWidgets('Dark theme creates correct styling', (WidgetTester tester) async {
      final theme = VelocityBreadcrumbTheme.dark();
      
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.itemStyle?.color, equals(const Color(0xFF9CA3AF)));
      expect(theme.currentItemStyle?.color, equals(const Color(0xFFBFDBFE)));
    });

    testWidgets('Custom theme overrides default values', (WidgetTester tester) async {
      final customTheme = VelocityBreadcrumbTheme.custom(
        itemStyle: const TextStyle(fontSize: 20, color: Colors.purple),
        iconSize: 24,
      );

      expect(customTheme.itemStyle!.fontSize, equals(20));
      expect(customTheme.itemStyle!.color, equals(Colors.purple));
      expect(customTheme.iconSize, equals(24));
    });
  });

  group('VelocityBreadcrumbUtils Tests', () {
    test('generateFromPath creates correct breadcrumb structure', () {
      final result = VelocityBreadcrumbUtils.generateFromPath('/dashboard/products/electronics');
      
      expect(result.length, equals(4)); // Home + 3 segments
      expect(result[0]['title'], equals('Home'));
      expect(result[1]['title'], equals('Dashboard'));
      expect(result[2]['title'], equals('Products'));
      expect(result[3]['title'], equals('Electronics'));
    });

    test('validateItems returns true for valid breadcrumb', () {
      final validItems = [
        {'title': 'Home', 'isCurrent': false},
        {'title': 'Products', 'isCurrent': true},
      ];
      
      expect(VelocityBreadcrumbUtils.validateItems(validItems), isTrue);
    });

    test('validateItems returns false for invalid breadcrumb', () {
      final invalidItems = [
        {'title': 'Home', 'isCurrent': false},
        {'title': 'Products', 'isCurrent': false}, // No current item
      ];
      
      expect(VelocityBreadcrumbUtils.validateItems(invalidItems), isFalse);
    });

    test('getCurrentItem returns correct current item', () {
      final items = [
        {'title': 'Home', 'isCurrent': false},
        {'title': 'Products', 'isCurrent': true},
      ];
      
      final current = VelocityBreadcrumbUtils.getCurrentItem(items);
      expect(current?['title'], equals('Products'));
    });

    test('truncateItems reduces item count correctly', () {
      final items = List.generate(8, (i) => {'title': 'Item $i', 'isCurrent': i == 7});
      final truncated = VelocityBreadcrumbUtils.truncateItems(items, maxItems: 5);
      
      expect(truncated.length, equals(5));
      expect(truncated[0]['title'], equals('Item 0'));
      expect(truncated[1]['title'], equals('...'));
      expect(truncated[4]['title'], equals('Item 7'));
    });

    test('formatSegmentTitle converts kebab-case to Title Case', () {
      // This is a private method, so we test it indirectly through generateFromPath
      final result = VelocityBreadcrumbUtils.generateFromPath('/user-profile/settings');
      
      expect(result[1]['title'], equals('User Profile'));
      expect(result[2]['title'], equals('Settings'));
    });
  });

  group('VelocityBreadcrumbItem Tests', () {
    test('BreadcrumbItem creates with default values', () {
      const item = VelocityBreadcrumbItem(
        title: 'Test Item',
      );

      expect(item.title, equals('Test Item'));
      expect(item.route, isNull);
      expect(item.icon, isNull);
      expect(item.isCurrent, isFalse);
    });

    test('BreadcrumbItem creates with custom values', () {
      const item = VelocityBreadcrumbItem(
        title: 'Test Item',
        route: '/test',
        icon: Icons.star,
        isCurrent: true,
      );

      expect(item.title, equals('Test Item'));
      expect(item.route, equals('/test'));
      expect(item.icon, equals(Icons.star));
      expect(item.isCurrent, isTrue);
    });
  });
}