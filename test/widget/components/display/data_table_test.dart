import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/data_display/data_table/index.dart';
import 'package:velocity_ui/velocity_ui.dart';

void main() {
  group('VelocityDataTable Widget Tests', () {
    late List<VelocityTableColumn<Map<String, dynamic>>> testColumns;
    late List<Map<String, dynamic>> testData;

    setUp(() {
      testColumns = [
        const VelocityTableColumn<Map<String, dynamic>>(
          label: '姓名',
          field: 'name',
          sortable: true,
          width: 100,
        ),
        const VelocityTableColumn<Map<String, dynamic>>(
          label: '年龄',
          field: 'age',
          sortable: true,
          width: 80,
          alignment: Alignment.center,
        ),
        const VelocityTableColumn<Map<String, dynamic>>(
          label: '邮箱',
          field: 'email',
          width: 200,
        ),
        const VelocityTableColumn<Map<String, dynamic>>(
          label: '状态',
          field: 'status',
          filterable: true,
          width: 100,
          alignment: Alignment.center,
        ),
      ];

      testData = [
        {'name': '张三', 'age': 25, 'email': 'zhangsan@example.com', 'status': '活跃'},
        {'name': '李四', 'age': 30, 'email': 'lisi@example.com', 'status': '离线'},
        {'name': '王五', 'age': 28, 'email': 'wangwu@example.com', 'status': '活跃'},
      ];
    });

    testWidgets('renders basic table', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityDataTable<Map<String, dynamic>>), findsOneWidget);
      expect(find.text('姓名'), findsOneWidget);
      expect(find.text('年龄'), findsOneWidget);
      expect(find.text('邮箱'), findsOneWidget);
      expect(find.text('状态'), findsOneWidget);
    });

    testWidgets('displays all rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
            ),
          ),
        ),
      );

      expect(find.text('张三'), findsOneWidget);
      expect(find.text('李四'), findsOneWidget);
      expect(find.text('王五'), findsOneWidget);
    });

    testWidgets('shows empty state when no data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: [],
            ),
          ),
        ),
      );

      expect(find.text('暂无数据'), findsOneWidget);
    });

    testWidgets('shows loading state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              loading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('加载中...'), findsOneWidget);
    });

    testWidgets('shows custom empty widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: [],
              emptyWidget: const Text('自定义空状态'),
            ),
          ),
        ),
      );

      expect(find.text('自定义空状态'), findsOneWidget);
      expect(find.text('暂无数据'), findsNothing);
    });

    testWidgets('shows custom loading widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              loading: true,
              loadingWidget: const Text('正在加载数据...'),
            ),
          ),
        ),
      );

      expect(find.text('正在加载数据...'), findsOneWidget);
      expect(find.text('加载中...'), findsNothing);
    });

    testWidgets('renders header widget when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              headerWidget: Container(
                height: 50,
                color: Colors.blue,
                child: const Center(child: Text('表格头部')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('表格头部'), findsOneWidget);
    });

    testWidgets('renders footer widget when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              footerWidget: Container(
                height: 50,
                color: Colors.green,
                child: const Center(child: Text('表格底部')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('表格底部'), findsOneWidget);
    });

    testWidgets('shows sort icons for sortable columns', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.unfold_more), findsNWidgets(2)); // 姓名和年龄列
    });

    testWidgets('calls onSort when sortable column tapped', (WidgetTester tester) async {
      VelocityTableColumn<Map<String, dynamic>>? sortedColumn;
      VelocitySortDirection? sortDirection;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              onSort: (column, direction) {
                sortedColumn = column;
                sortDirection = direction;
              },
            ),
          ),
        ),
      );

      // Tap on the name column header
      await tester.tap(find.text('姓名'));
      await tester.pump();

      expect(sortedColumn, equals(testColumns[0]));
      expect(sortDirection, equals(VelocitySortDirection.ascending));
    });

    testWidgets('shows filter icons for filterable columns', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.filter_list), findsOneWidget); // 状态列
    });

    testWidgets('shows pagination when pagination state provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              paginationState: const VelocityTablePaginationState(
                currentPage: 1,
                pageSize: 10,
                total: 25,
              ),
            ),
          ),
        ),
      );

      expect(find.text('第 1 / 3 页，共 25 条'), findsOneWidget);
      expect(find.text('上一页'), findsOneWidget);
      expect(find.text('下一页'), findsOneWidget);
    });

    testWidgets('calls onPageChange when pagination button tapped', (WidgetTester tester) async {
      int? calledPage;
      int? calledPageSize;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              paginationState: const VelocityTablePaginationState(
                currentPage: 1,
                pageSize: 10,
                total: 25,
              ),
              onPageChange: (page, pageSize) {
                calledPage = page;
                calledPageSize = pageSize;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('下一页'));
      await tester.pump();

      expect(calledPage, equals(2));
      expect(calledPageSize, equals(10));
    });

    testWidgets('shows selection checkboxes when selectable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              selectable: true,
            ),
          ),
        ),
      );

      expect(find.byType(Checkbox), findsNWidgets(4)); // 3 rows + 1 header
    });

    testWidgets('calls onSelectionChange when row selected', (WidgetTester tester) async {
      var selectedRows = <int>[];

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              selectable: true,
              onSelectionChange: (rows) {
                selectedRows = rows;
              },
            ),
          ),
        ),
      );

      // Select first row
      await tester.tap(find.byType(Checkbox).at(1));
      await tester.pump();

      expect(selectedRows, equals([0]));
    });

    testWidgets('calls onRowTap when row tapped', (WidgetTester tester) async {
      int? tappedIndex;
      Map<String, dynamic>? tappedData;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              onRowTap: (index, data) {
                tappedIndex = index;
                tappedData = data;
              },
            ),
          ),
        ),
      );

      // Tap first row
      await tester.tap(find.text('张三'));
      await tester.pump();

      expect(tappedIndex, equals(0));
      expect(tappedData, equals(testData[0]));
    });

    testWidgets('shows striped rows when striped is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              striped: true,
            ),
          ),
        ),
      );

      // Check that rows have different background colors
      // This is a visual test, so we just verify the widget renders
      expect(find.byType(VelocityDataTable<Map<String, dynamic>>), findsOneWidget);
    });

    testWidgets('shows borders when bordered is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              bordered: true,
            ),
          ),
        ),
      );

      // Check that table has borders
      expect(find.byType(VelocityDataTable<Map<String, dynamic>>), findsOneWidget);
    });

    testWidgets('hides column when hidden is true', (WidgetTester tester) async {
      final hiddenColumns = [
        ...testColumns,
        const VelocityTableColumn<Map<String, dynamic>>(
          label: '隐藏列',
          field: 'hidden',
          hidden: true,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: hiddenColumns,
              data: testData,
            ),
          ),
        ),
      );

      expect(find.text('隐藏列'), findsNothing);
    });

    testWidgets('uses custom row builder when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              rowBuilder: (context, index, data) {
                return Container(
                  key: Key('custom_row_$index'),
                  height: 60,
                  color: Colors.red,
                  child: Text('自定义行 $index'),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('自定义行 0'), findsOneWidget);
      expect(find.text('自定义行 1'), findsOneWidget);
      expect(find.text('自定义行 2'), findsOneWidget);
    });

    testWidgets('uses custom cell builder when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              cellBuilder: (context, index, data, column) {
                return Text('自定义单元格: ${data[column.field]}');
              },
            ),
          ),
        ),
      );

      expect(find.text('自定义单元格: 张三'), findsOneWidget);
      expect(find.text('自定义单元格: 25'), findsOneWidget);
    });

    testWidgets('uses custom header cell builder when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              VelocityDataTableTheme.light(),
            ],
          ),
          home: Scaffold(
            body: VelocityDataTable<Map<String, dynamic>>(
              columns: testColumns,
              data: testData,
              headerCellBuilder: (context, column) {
                return Text('自定义表头: ${column.label}');
              },
            ),
          ),
        ),
      );

      expect(find.text('自定义表头: 姓名'), findsOneWidget);
      expect(find.text('自定义表头: 年龄'), findsOneWidget);
    });
  });
}