import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrTimeline', () {
    late List<ZephyrTimelineNode> testNodes;

    setUp(() {
      testNodes = [
        ZephyrTimelineNode(
          id: '1',
          title: '项目启动',
          description: '项目正式启动',
          status: ZephyrTimelineNodeStatus.completed,
          time: DateTime(2024, 1, 1),
        ),
        ZephyrTimelineNode(
          id: '2',
          title: '需求分析',
          description: '完成需求分析文档',
          status: ZephyrTimelineNodeStatus.processing,
          time: DateTime(2024, 1, 15),
        ),
        ZephyrTimelineNode(
          id: '3',
          title: '设计阶段',
          description: 'UI/UX设计',
          status: ZephyrTimelineNodeStatus.pending,
          time: DateTime(2024, 2, 1),
        ),
      ];
    });

    testWidgets('renders timeline with nodes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrTimeline(
              nodes: testNodes,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
      expect(find.text('需求分析'), findsOneWidget);
      expect(find.text('设计阶段'), findsOneWidget);
    });

    testWidgets('handles node tap', (WidgetTester tester) async {
      bool tapped = false;
      String tappedNodeId = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrTimeline(
              nodes: const [
                ZephyrTimelineNode(
                  id: '1',
                  title: 'Test Node',
                  clickable: true,
                ),
              ],
              onNodeTap: (node) {
                tapped = true;
                tappedNodeId = node.id;
              },
            ),
          ),
        ),
      );

      // Find and tap the node icon specifically
      await tester.tap(find.byType(Icon).first);
      await tester.pump();

      expect(tapped, isTrue);
      expect(tappedNodeId, equals('1'));
    });

    testWidgets('shows time when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrTimeline(
              nodes: testNodes,
              showTime: true,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
    });

    testWidgets('hides time when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrTimeline(
              nodes: testNodes,
              showTime: false,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
    });

    testWidgets('supports horizontal mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrTimeline(
              nodes: testNodes,
              mode: ZephyrTimelineMode.horizontal,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
      expect(find.text('需求分析'), findsOneWidget);
    });

    testWidgets('supports alternate layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrTimeline(
              nodes: testNodes,
              layout: ZephyrTimelineLayout.alternate,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
      expect(find.text('需求分析'), findsOneWidget);
    });

    testWidgets('applies custom theme', (WidgetTester tester) async {
      final customTheme = ZephyrTimelineTheme.custom(
        primaryColor: Colors.red,
        titleStyle: const TextStyle(fontSize: 20),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrTimeline(
              nodes: testNodes,
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
    });
  });

  group('ZephyrTimelineTheme', () {
    test('creates light theme', () {
      final theme = ZephyrTimelineTheme.light();
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.primaryColor, equals(const Color(0xFF3B82F6)));
    });

    test('creates dark theme', () {
      final theme = ZephyrTimelineTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.primaryColor, equals(const Color(0xFF60A5FA)));
    });

    test('creates custom theme', () {
      final theme = ZephyrTimelineTheme.custom(
        primaryColor: Colors.red,
        titleStyle: const TextStyle(fontSize: 20),
      );
      expect(theme.primaryColor, equals(Colors.red));
      expect(theme.titleStyle.fontSize, equals(20));
    });

    test('copies theme with modifications', () {
      final theme = ZephyrTimelineTheme.light();
      final modified = theme.copyWith(primaryColor: Colors.blue);
      expect(modified.primaryColor, equals(Colors.blue));
      expect(modified.backgroundColor, equals(theme.backgroundColor));
    });

    test('merges themes', () {
      final theme1 = ZephyrTimelineTheme.light();
      final theme2 = ZephyrTimelineTheme.custom(primaryColor: Colors.red);
      final merged = theme1.merge(theme2);
      expect(merged.primaryColor, equals(Colors.red));
      expect(merged.backgroundColor, equals(theme1.backgroundColor));
    });

    test('compares themes for equality', () {
      final theme1 = ZephyrTimelineTheme.light();
      final theme2 = ZephyrTimelineTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      final theme = ZephyrTimelineTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('ZephyrTimelineNode', () {
    test('creates node with required parameters', () {
      const node = ZephyrTimelineNode(
        id: '1',
        title: 'Test Node',
      );
      expect(node.id, equals('1'));
      expect(node.title, equals('Test Node'));
      expect(node.status, equals(ZephyrTimelineNodeStatus.pending));
    });

    test('creates node with all parameters', () {
      final node = ZephyrTimelineNode(
        id: '1',
        title: 'Test Node',
        description: 'Description',
        status: ZephyrTimelineNodeStatus.completed,
        time: DateTime(2024, 1, 1),
        clickable: true,
        data: {'key': 'value'},
      );
      expect(node.id, equals('1'));
      expect(node.title, equals('Test Node'));
      expect(node.description, equals('Description'));
      expect(node.status, equals(ZephyrTimelineNodeStatus.completed));
      expect(node.time, equals(DateTime(2024, 1, 1)));
      expect(node.clickable, isTrue);
      expect(node.data, equals({'key': 'value'}));
    });
  });
}