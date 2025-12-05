import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/navigation/tree/tree.dart';
import 'package:velocity_ui/src/components/navigation/tree/tree_theme.dart';

void main() {
  group('VelocityTree', () {
    late List<VelocityTreeNode<String>> sampleNodes;

    setUp(() {
      sampleNodes = [
        const VelocityTreeNode(
          id: '1',
          label: 'Root 1',
          children: [
            VelocityTreeNode(
              id: '1-1',
              label: 'Child 1-1',
              children: [
                VelocityTreeNode(id: '1-1-1', label: 'Grandchild 1-1-1'),
                VelocityTreeNode(id: '1-1-2', label: 'Grandchild 1-1-2'),
              ],
            ),
            VelocityTreeNode(id: '1-2', label: 'Child 1-2'),
          ],
        ),
        const VelocityTreeNode(
          id: '2',
          label: 'Root 2',
          children: [
            VelocityTreeNode(id: '2-1', label: 'Child 2-1'),
          ],
        ),
      ];
    });

    testWidgets('should display tree with root nodes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: sampleNodes,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityTree<String>), findsOneWidget);
      expect(find.text('Root 1'), findsOneWidget);
      expect(find.text('Root 2'), findsOneWidget);
    });

    testWidgets('should expand and collapse nodes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: sampleNodes,
              initialExpandedNodes: const ['1'],
            ),
          ),
        ),
      );

      expect(find.text('Child 1-1'), findsOneWidget);
      expect(find.text('Child 1-2'), findsOneWidget);
      expect(find.text('Grandchild 1-1-1'), findsNothing);
    });

    testWidgets('should handle node selection', (WidgetTester tester) async {
      String? selectedNodeId;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: sampleNodes,
              onNodeSelect: (node) {
                selectedNodeId = node.id;
              },
            ),
          ),
        ),
      );

      // Tap on a node
      await tester.tap(find.text('Root 1'));
      await tester.pump();

      expect(selectedNodeId, equals('1'));
    });

    testWidgets('should support multiple selection', (WidgetTester tester) async {
      final selectedNodes = <String>{};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: sampleNodes,
              allowMultipleSelection: true,
              onNodeSelect: (node) {
                selectedNodes.add(node.id);
              },
            ),
          ),
        ),
      );

      // Tap on multiple nodes
      await tester.tap(find.text('Root 1'));
      await tester.pump();
      await tester.tap(find.text('Root 2'));
      await tester.pump();

      expect(selectedNodes, contains('1'));
      expect(selectedNodes, contains('2'));
    });

    testWidgets('should filter nodes based on search query', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: sampleNodes,
              searchQuery: 'Root 1',
            ),
          ),
        ),
      );

      expect(find.text('Root 1'), findsOneWidget);
      expect(find.text('Root 2'), findsNothing);
    });

    testWidgets('should respect disabled nodes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: [
                VelocityTreeNode(
                  id: '1',
                  label: 'Enabled Node',
                ),
                VelocityTreeNode(
                  id: '2',
                  label: 'Disabled Node',
                  isDisabled: true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Enabled Node'), findsOneWidget);
      expect(find.text('Disabled Node'), findsOneWidget);
    });

    testWidgets('should show custom widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: [
                VelocityTreeNode(
                  id: '1',
                  label: 'Custom Node',
                  customWidget: Container(
                    color: Colors.red,
                    width: 50,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should show badges', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VelocityTree<String>(
              nodes: [
                VelocityTreeNode(
                  id: '1',
                  label: 'Node with Badge',
                  metadata: {'badge': '5'},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });
  });

  group('VelocityTreeController', () {
    late List<VelocityTreeNode<String>> sampleNodes;
    late VelocityTreeController<String> controller;

    setUp(() {
      sampleNodes = [
        const VelocityTreeNode(
          id: '1',
          label: 'Node 1',
          children: [
            VelocityTreeNode(id: '1-1', label: 'Child 1'),
          ],
        ),
        const VelocityTreeNode(id: '2', label: 'Node 2'),
      ];
      controller = VelocityTreeController<String>(sampleNodes);
    });

    test('should expand and collapse nodes', () {
      controller.expandNode('1');
      expect(controller.expandedNodes, contains('1'));

      controller.collapseNode('1');
      expect(controller.expandedNodes, isNot(contains('1')));
    });

    test('should toggle node expansion', () {
      controller.toggleNode('1');
      expect(controller.expandedNodes, contains('1'));

      controller.toggleNode('1');
      expect(controller.expandedNodes, isNot(contains('1')));
    });

    test('should select and deselect nodes', () {
      controller.selectNode('1');
      expect(controller.selectedNodes, contains('1'));

      controller.deselectNode('1');
      expect(controller.selectedNodes, isNot(contains('1')));
    });

    test('should find nodes by ID', () {
      final node = controller.findNode('1');
      expect(node, isNotNull);
      expect(node!.id, equals('1'));

      final notFoundNode = controller.findNode('999');
      expect(notFoundNode, isNull);
    });

    test('should support multiple selection', () {
      controller.selectNode('1', multiple: true);
      controller.selectNode('2', multiple: true);
      expect(controller.selectedNodes, contains('1'));
      expect(controller.selectedNodes, contains('2'));
    });
  });

  group('VelocityTreeTheme', () {
    test('should create light theme', () {
      final theme = VelocityTreeTheme.light();
      expect(theme.selectedColor, equals(const Color(0xFF2196F3)));
      expect(theme.textColor, equals(const Color(0xFF212121)));
    });

    test('should create dark theme', () {
      final theme = VelocityTreeTheme.dark();
      expect(theme.selectedColor, equals(const Color(0xFF64B5F6)));
      expect(theme.textColor, equals(const Color(0xFFE0E0E0)));
    });

    test('should copy theme with modifications', () {
      final theme = VelocityTreeTheme.light();
      final modifiedTheme = theme.copyWith(
        selectedColor: Colors.red,
        textColor: Colors.green,
      );

      expect(modifiedTheme.selectedColor, equals(Colors.red));
      expect(modifiedTheme.textColor, equals(Colors.green));
      expect(modifiedTheme.iconColor, equals(theme.iconColor));
    });
  });
}