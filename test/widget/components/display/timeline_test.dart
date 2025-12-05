import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  group('VelocityTimeline', () {
    late List<VelocityTimelineNode> testNodes;

    setUp(() {
      testNodes = [
        VelocityTimelineNode(
          id: '1',
          title: '项目启动',
          description: '项目正式启动',
          status: VelocityTimelineNodeStatus.completed,
          time: DateTime(2024, 1, 1),
        ),
        VelocityTimelineNode(
          id: '2',
          title: '需求分析',
          description: '完成需求分析文档',
          status: VelocityTimelineNodeStatus.processing,
          time: DateTime(2024, 1, 15),
        ),
        VelocityTimelineNode(
          id: '3',
          title: '设计阶段',
          description: 'UI/UX设计',
          status: VelocityTimelineNodeStatus.pending,
          time: DateTime(2024, 2, 1),
        ),
      ];
    });

    testWidgets('renders timeline with nodes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTimeline(
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
      var tapped = false;
      var tappedNodeId = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTimeline(
              nodes: const [
                VelocityTimelineNode(
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
            body: VelocityTimeline(
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
            body: VelocityTimeline(
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
            body: VelocityTimeline(
              nodes: testNodes,
              mode: VelocityTimelineMode.horizontal,
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
            body: VelocityTimeline(
              nodes: testNodes,
              layout: VelocityTimelineLayout.alternate,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
      expect(find.text('需求分析'), findsOneWidget);
    });

    testWidgets('applies custom theme', (WidgetTester tester) async {
      final customTheme = VelocityTimelineTheme.custom(
        primaryColor: Colors.red,
        titleStyle: const TextStyle(fontSize: 20),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTimeline(
              nodes: testNodes,
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.text('项目启动'), findsOneWidget);
    });
  });

  group('VelocityTimelineTheme', () {
    test('creates light theme', () {
      final theme = VelocityTimelineTheme.light();
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.primaryColor, equals(const Color(0xFF3B82F6)));
    });

    test('creates dark theme', () {
      final theme = VelocityTimelineTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.primaryColor, equals(const Color(0xFF60A5FA)));
    });

    test('creates custom theme', () {
      final theme = VelocityTimelineTheme.custom(
        primaryColor: Colors.red,
        titleStyle: const TextStyle(fontSize: 20),
      );
      expect(theme.primaryColor, equals(Colors.red));
      expect(theme.titleStyle.fontSize, equals(20));
    });

    test('copies theme with modifications', () {
      final theme = VelocityTimelineTheme.light();
      final modified = theme.copyWith(primaryColor: Colors.blue);
      expect(modified.primaryColor, equals(Colors.blue));
      expect(modified.backgroundColor, equals(theme.backgroundColor));
    });

    test('merges themes', () {
      final theme1 = VelocityTimelineTheme.light();
      final theme2 = VelocityTimelineTheme.custom(primaryColor: Colors.red);
      final merged = theme1.merge(theme2);
      expect(merged.primaryColor, equals(Colors.red));
      expect(merged.backgroundColor, equals(theme1.backgroundColor));
    });

    test('compares themes for equality', () {
      final theme1 = VelocityTimelineTheme.light();
      final theme2 = VelocityTimelineTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      final theme = VelocityTimelineTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('VelocityTimelineNode', () {
    test('creates node with required parameters', () {
      const node = VelocityTimelineNode(
        id: '1',
        title: 'Test Node',
      );
      expect(node.id, equals('1'));
      expect(node.title, equals('Test Node'));
      expect(node.status, equals(VelocityTimelineNodeStatus.pending));
    });

    test('creates node with all parameters', () {
      final node = VelocityTimelineNode(
        id: '1',
        title: 'Test Node',
        description: 'Description',
        status: VelocityTimelineNodeStatus.completed,
        time: DateTime(2024, 1, 1),
        clickable: true,
        data: {'key': 'value'},
      );
      expect(node.id, equals('1'));
      expect(node.title, equals('Test Node'));
      expect(node.description, equals('Description'));
      expect(node.status, equals(VelocityTimelineNodeStatus.completed));
      expect(node.time, equals(DateTime(2024, 1, 1)));
      expect(node.clickable, isTrue);
      expect(node.data, equals({'key': 'value'}));
    });
  });
}