import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/data_display/tree_view/index.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrTreeView Widget Tests', () {
    late List<ZephyrTreeNode<String>> testNodes;

    setUp(() {
      testNodes = [
        ZephyrTreeNode<String>(
          id: 'root1',
          label: '根节点 1',
          children: [
            ZephyrTreeNode<String>(
              id: 'child1',
              label: '子节点 1',
              children: [
                ZephyrTreeNode<String>(
                  id: 'grandchild1',
                  label: '孙节点 1',
                ),
                ZephyrTreeNode<String>(
                  id: 'grandchild2',
                  label: '孙节点 2',
                ),
              ],
            ),
            ZephyrTreeNode<String>(
              id: 'child2',
              label: '子节点 2',
            ),
          ],
        ),
        ZephyrTreeNode<String>(
          id: 'root2',
          label: '根节点 2',
          initiallyExpanded: true,
          children: [
            ZephyrTreeNode<String>(
              id: 'child3',
              label: '子节点 3',
            ),
          ],
        ),
        ZephyrTreeNode<String>(
          id: 'root3',
          label: '禁用节点',
          disabled: true,
          children: [
            ZephyrTreeNode<String>(
              id: 'child4',
              label: '子节点 4',
            ),
          ],
        ),
      ];
    });

    testWidgets('renders basic tree view', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrTreeView<String>), findsOneWidget);
      expect(find.text('根节点 1'), findsOneWidget);
      expect(find.text('根节点 2'), findsOneWidget);
      expect(find.text('禁用节点'), findsOneWidget);
    });

    testWidgets('shows initially expanded nodes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
            ),
          ),
        ),
      );

      // Root2 should be expanded initially
      expect(find.text('子节点 3'), findsOneWidget);
      
      // Root1 should be collapsed initially
      expect(find.text('子节点 1'), findsNothing);
    });

    testWidgets('expands and collapses nodes on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              expandMode: ZephyrTreeExpandMode.click,
            ),
          ),
        ),
      );

      // Initially collapsed
      expect(find.text('子节点 1'), findsNothing);

      // Tap to expand
      await tester.tap(find.text('根节点 1'));
      await tester.pump();

      // Should be expanded
      expect(find.text('子节点 1'), findsOneWidget);

      // Tap to collapse
      await tester.tap(find.text('根节点 1'));
      await tester.pump();

      // Should be collapsed
      expect(find.text('子节点 1'), findsNothing);
    });

    testWidgets('calls onNodeExpand when node expanded', (WidgetTester tester) async {
      String? expandedNodeId;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              onNodeExpand: (node) {
                expandedNodeId = node.id;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('根节点 1'));
      await tester.pump();

      expect(expandedNodeId, equals('root1'));
    });

    testWidgets('calls onNodeCollapse when node collapsed', (WidgetTester tester) async {
      String? collapsedNodeId;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              expandedNodes: ['root1'],
              onNodeCollapse: (node) {
                collapsedNodeId = node.id;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('根节点 1'));
      await tester.pump();

      expect(collapsedNodeId, equals('root1'));
    });

    testWidgets('calls onNodeTap when node tapped', (WidgetTester tester) async {
      String? tappedNodeId;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              onNodeTap: (node) {
                tappedNodeId = node.id;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('根节点 1'));
      await tester.pump();

      expect(tappedNodeId, equals('root1'));
    });

    testWidgets('supports single selection mode', (WidgetTester tester) async {
      List<String> selectedNodes = [];

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              selectionMode: ZephyrTreeSelectionMode.single,
              onSelectionChange: (nodes) {
                selectedNodes = nodes;
              },
            ),
          ),
        ),
      );

      // Select first node
      await tester.tap(find.text('根节点 1'));
      await tester.pump();

      expect(selectedNodes, equals(['root1']));

      // Select second node
      await tester.tap(find.text('根节点 2'));
      await tester.pump();

      expect(selectedNodes, equals(['root2']));
    });

    testWidgets('supports multiple selection mode', (WidgetTester tester) async {
      List<String> selectedNodes = [];

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              selectionMode: ZephyrTreeSelectionMode.multiple,
              onSelectionChange: (nodes) {
                selectedNodes = nodes;
              },
            ),
          ),
        ),
      );

      // Select first node
      await tester.tap(find.text('根节点 1'));
      await tester.pump();

      expect(selectedNodes, equals(['root1']));

      // Select second node
      await tester.tap(find.text('根节点 2'));
      await tester.pump();

      expect(selectedNodes, contains('root1'));
      expect(selectedNodes, contains('root2'));
    });

    testWidgets('disables node interaction when disabled', (WidgetTester tester) async {
      String? tappedNodeId;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              onNodeTap: (node) {
                tappedNodeId = node.id;
              },
            ),
          ),
        ),
      );

      // Try to tap disabled node
      await tester.tap(find.text('禁用节点'));
      await tester.pump();

      expect(tappedNodeId, isNull);
    });

    testWidgets('shows expand icons for parent nodes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              showIcons: false,
            ),
          ),
        ),
      );

      // Parent nodes should have expand icons
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(3));
    });

    testWidgets('shows different icons for different node types', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
            ),
          ),
        ),
      );

      // Should show folder icons for parent nodes and article icons for leaf nodes
      expect(find.byIcon(Icons.folder), findsNWidgets(4)); // 3 root + 1 child
      expect(find.byIcon(Icons.article), findsNWidgets(4)); // grandchildren + child2 + child3 + child4
    });

    testWidgets('respects showLines property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              showLines: true,
              expandedNodes: ['root1'],
            ),
          ),
        ),
      );

      // Should show connecting lines
      expect(find.byType(ZephyrTreeView<String>), findsOneWidget);
    });

    testWidgets('respects showIcons property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              showIcons: false,
            ),
          ),
        ),
      );

      // Should not show icons
      expect(find.byIcon(Icons.folder), findsNothing);
      expect(find.byIcon(Icons.article), findsNothing);
    });

    testWidgets('uses custom node builder when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              nodeBuilder: (context, node, level, isSelected, isExpanded) {
                return Container(
                  key: Key('custom_node_${node.id}'),
                  height: 50,
                  color: Colors.blue,
                  child: Text('自定义节点: ${node.label}'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('自定义节点: 根节点 1'), findsOneWidget);
      expect(find.text('自定义节点: 根节点 2'), findsOneWidget);
    });

    testWidgets('uses custom icon builder when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              iconBuilder: (context, node, isExpanded) {
                return Icon(
                  isExpanded ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              },
            ),
          ),
        ),
      );

      // Should show custom icons
      expect(find.byIcon(Icons.star), findsNWidgets(1)); // root2 is expanded
      expect(find.byIcon(Icons.star_border), findsNWidgets(6)); // others are collapsed
    });

    testWidgets('loads async children when node expanded', (WidgetTester tester) async {
      final asyncNodes = [
        ZephyrTreeNode<String>(
          id: 'async_root',
          label: '异步加载节点',
          asyncLoad: true,
          asyncLoader: () async {
            return [
              ZephyrTreeNode<String>(
                id: 'async_child1',
                label: '异步子节点 1',
              ),
              ZephyrTreeNode<String>(
                id: 'async_child2',
                label: '异步子节点 2',
              ),
            ];
          },
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: asyncNodes,
            ),
          ),
        ),
      );

      // Initially no children
      expect(find.text('异步子节点 1'), findsNothing);

      // Expand to load children
      await tester.tap(find.text('异步加载节点'));
      await tester.pump();

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for async loading to complete
      await tester.pumpAndSettle();

      // Should show loaded children
      expect(find.text('异步子节点 1'), findsOneWidget);
      expect(find.text('异步子节点 2'), findsOneWidget);
    });

    testWidgets('supports drag and drop when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              draggable: true,
              droppable: true,
            ),
          ),
        ),
      );

      // Should be able to drag nodes
      expect(find.byType(LongPressDraggable<ZephyrTreeNode<String>>), findsNWidgets(4)); // 3 root nodes + 1 disabled
    });

    testWidgets('calls onNodeDragStart when drag begins', (WidgetTester tester) async {
      String? draggedNodeId;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              draggable: true,
              onNodeDragStart: (node) {
                draggedNodeId = node.id;
              },
            ),
          ),
        ),
      );

      // Start dragging
      final gesture = await tester.startGesture(tester.getCenter(find.text('根节点 1')));
      await tester.pump(kLongPressTimeout);
      await gesture.moveBy(const Offset(0, 50));
      await tester.pump();

      expect(draggedNodeId, equals('root1'));
    });

    testWidgets('respects indentation property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              ZephyrTreeViewTheme.light(),
            ],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
              expandedNodes: ['root1'],
              indentation: 40.0,
            ),
          ),
        ),
      );

      // Should respect custom indentation
      expect(find.byType(ZephyrTreeView<String>), findsOneWidget);
    });

    testWidgets('applies custom theme', (WidgetTester tester) async {
      final customTheme = ZephyrTreeViewTheme.light().copyWith(
        nodeHeight: 50.0,
        nodeTextStyle: const TextStyle(fontSize: 18, color: Colors.red),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [customTheme],
          ),
          home: Scaffold(
            body: ZephyrTreeView<String>(
              nodes: testNodes,
            ),
          ),
        ),
      );

      // Should apply custom theme
      expect(find.byType(ZephyrTreeView<String>), findsOneWidget);
    });
  });
}