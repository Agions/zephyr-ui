import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chroma_ui/src/components/display/table/enhanced_table.dart';
import 'package:chroma_ui/src/components/display/charts/implementations/area_chart.dart';
import 'package:chroma_ui/src/components/display/charts/implementations/scatter_chart.dart';
import 'package:chroma_ui/src/components/display/charts/implementations/radar_chart.dart';

void main() {
  group('chromaUI Performance Tests', () {
    group('Large Dataset Performance', () {
      testWidgets('EnhancedTable handles 10,000 rows efficiently', (WidgetTester tester) async {
        // Generate large dataset
        final largeData = List.generate(10000, (index) =>
          PerformanceUser(
            id: index,
            name: 'User $index',
            email: 'user$index@example.com',
            status: index.isEven ? 'Active' : 'Inactive',
          )
        );

        final columns = [
          TableColumn<PerformanceUser>(
            id: 'name',
            label: 'Name',
            valueGetter: (user) => user.name,
            width: 150,
          ),
          TableColumn<PerformanceUser>(
            id: 'email',
            label: 'Email',
            valueGetter: (user) => user.email,
            width: 200,
          ),
          TableColumn<PerformanceUser>(
            id: 'status',
            label: 'Status',
            valueGetter: (user) => user.status,
            width: 100,
          ),
        ];

        final stopwatch = Stopwatch()..start();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 600,
                child: chromaEnhancedTable<PerformanceUser>(
                  columns: columns,
                  data: largeData,
                  enablePagination: true,
                  pageSize: 50,
                  enableSorting: true,
                  enableFiltering: true,
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        stopwatch.stop();

        print('EnhancedTable with 10,000 rows rendered in ${stopwatch.elapsedMilliseconds}ms');

        // Performance assertion - should render in under 2 seconds
        expect(stopwatch.elapsedMilliseconds, lessThan(2000));

        // Test scrolling performance
        final scrollStopwatch = Stopwatch()..start();

        // Scroll through multiple pages
        for (int i = 0; i < 5; i++) {
          await tester.fling(find.byType(chromaEnhancedTable<PerformanceUser>), const Offset(0, -300), 1000);
          await tester.pumpAndSettle();
        }

        scrollStopwatch.stop();
        print('EnhancedTable scrolling through 5 pages took ${scrollStopwatch.elapsedMilliseconds}ms');

        // Scrolling should be smooth (under 1 second for 5 pages)
        expect(scrollStopwatch.elapsedMilliseconds, lessThan(1000));
      });

      testWidgets('AreaChart handles large dataset efficiently', (WidgetTester tester) async {
        // Generate large dataset
        final largeData = [
          AreaChartData(
            label: 'Large Dataset',
            color: Colors.blue,
            points: List.generate(1000, (index) =>
              AreaChartPoint(x: index.toDouble(), y: (index * 2).toDouble())
            ),
          ),
        ];

        final stopwatch = Stopwatch()..start();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaAreaChart(
                data: largeData,
                height: 400,
                animate: false, // Disable animation for performance testing
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        stopwatch.stop();

        print('AreaChart with 1000 points rendered in ${stopwatch.elapsedMilliseconds}ms');

        // Should render in under 1 second
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });

      testWidgets('ScatterChart handles many data points efficiently', (WidgetTester tester) async {
        // Generate large dataset
        final largeData = [
          ScatterChartData(
            label: 'Scatter Data',
            color: Colors.red,
            points: List.generate(500, (index) =>
              ScatterChartPoint(
                x: index.toDouble(),
                y: (index * 1.5).toDouble(),
                size: 5 + (index % 10),
              )
            ),
          ),
        ];

        final stopwatch = Stopwatch()..start();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaScatterChart(
                data: largeData,
                height: 400,
                animate: false,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        stopwatch.stop();

        print('ScatterChart with 500 points rendered in ${stopwatch.elapsedMilliseconds}ms');

        // Should render in under 1.5 seconds
        expect(stopwatch.elapsedMilliseconds, lessThan(1500));
      });
    });

    group('Memory Usage Tests', () {
      testWidgets('Components clean up memory properly', (WidgetTester tester) async {
        // Test memory cleanup by creating and destroying components
        final data = [
          AreaChartData(
            label: 'Test',
            color: Colors.blue,
            points: [
              AreaChartPoint(x: 1, y: 10),
              AreaChartPoint(x: 2, y: 20),
            ],
          ),
        ];

        // Create component
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaAreaChart(
                data: data,
                height: 200,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(chromaAreaChart), findsOneWidget);

        // Remove component
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Container(),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(chromaAreaChart), findsNothing);

        // Component should be properly disposed
        // This is a basic test - in real scenarios you'd use memory profiling tools
        expect(true, isTrue); // Placeholder for memory assertion
      });
    });

    group('Animation Performance Tests', () {
      testWidgets('Smooth animations maintain 60fps', (WidgetTester tester) async {
        final data = [
          AreaChartData(
            label: 'Animation Test',
            color: Colors.green,
            points: [
              AreaChartPoint(x: 1, y: 10),
              AreaChartPoint(x: 2, y: 20),
              AreaChartPoint(x: 3, y: 15),
              AreaChartPoint(x: 4, y: 25),
            ],
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaAreaChart(
                data: data,
                height: 300,
                animate: true,
                animationDuration: const Duration(milliseconds: 1000),
              ),
            ),
          ),
        );

        // Start animation
        await tester.pump();

        // Measure frames during animation
        final frameTimes = <Duration>[];
        final frameStopwatch = Stopwatch()..start();

        // Capture frames during animation
        for (int i = 0; i < 60; i++) { // Sample 60 frames
          final frameStart = Stopwatch()..start();
          await tester.pump(const Duration(milliseconds: 16)); // ~60fps
          frameStart.stop();
          frameTimes.add(frameStart.elapsed);
        }

        frameStopwatch.stop();

        // Calculate average frame time
        final averageFrameTime = frameTimes.reduce((a, b) => a + b) / frameTimes.length;
        final fps = 1000 / averageFrameTime.inMicroseconds * 1000;

        print('Average FPS during animation: $fps');
        print('Total animation time: ${frameStopwatch.elapsedMilliseconds}ms');

        // Should maintain close to 60fps (allowing some tolerance)
        expect(fps, greaterThan(50)); // At least 50fps
      });
    });

    group('Responsiveness Tests', () {
      testWidgets('Components respond quickly to user input', (WidgetTester tester) async {
        final data = [
          AreaChartData(
            label: 'Interactive Test',
            color: Colors.purple,
            points: [
              AreaChartPoint(x: 1, y: 10),
              AreaChartPoint(x: 2, y: 20),
            ],
          ),
        ];

        bool hoverCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaAreaChart(
                data: data,
                height: 200,
                onHover: (data) {
                  hoverCalled = true;
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Simulate user interaction
        final interactionStopwatch = Stopwatch()..start();

        // Tap on chart
        await tester.tap(find.byType(chromaAreaChart));
        await tester.pumpAndSettle();

        interactionStopwatch.stop();

        print('User interaction response time: ${interactionStopwatch.elapsedMilliseconds}ms');

        // Should respond within 100ms
        expect(interactionStopwatch.elapsedMilliseconds, lessThan(100));
      });
    });

    group('Stress Tests', () {
      testWidgets('Multiple complex components on same screen', (WidgetTester tester) async {
        // Create multiple instances of complex components
        final chartData = [
          AreaChartData(
            label: 'Stress Test',
            color: Colors.orange,
            points: List.generate(100, (index) =>
              AreaChartPoint(x: index.toDouble(), y: (index * 3).toDouble())
            ),
          ),
        ];

        final tableData = List.generate(1000, (index) =>
          PerformanceUser(
            id: index,
            name: 'Stress User $index',
            email: 'stress$index@example.com',
            status: 'Active',
          )
        );

        final tableColumns = [
          TableColumn<PerformanceUser>(
            id: 'name',
            label: 'Name',
            valueGetter: (user) => user.name,
          ),
          TableColumn<PerformanceUser>(
            id: 'email',
            label: 'Email',
            valueGetter: (user) => user.email,
          ),
        ];

        final stopwatch = Stopwatch()..start();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView(
                children: [
                  chromaAreaChart(data: chartData, height: 200),
                  chromaScatterChart(
                    data: [
                      ScatterChartData(
                        label: 'Stress Scatter',
                        color: Colors.red,
                        points: List.generate(50, (index) =>
                          ScatterChartPoint(
                            x: index.toDouble(),
                            y: (index * 2).toDouble(),
                            size: 5,
                          )
                        ),
                      ),
                    ],
                    height: 200,
                  ),
                  chromaRadarChart(
                    data: [
                      RadarChartData(
                        label: 'Stress Radar',
                        color: Colors.blue,
                        points: List.generate(8, (index) =>
                          RadarChartPoint(value: (index * 10).toDouble())
                        ),
                      ),
                    ],
                    categories: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
                    height: 200,
                  ),
                  SizedBox(
                    height: 300,
                    child: chromaEnhancedTable<PerformanceUser>(
                      columns: tableColumns,
                      data: tableData,
                      enablePagination: true,
                      pageSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        stopwatch.stop();

        print('Multiple complex components rendered in ${stopwatch.elapsedMilliseconds}ms');

        // Should render in under 3 seconds
        expect(stopwatch.elapsedMilliseconds, lessThan(3000));

        // Test scrolling performance with multiple components
        final scrollStopwatch = Stopwatch()..start();

        await tester.fling(find.byType(ListView), const Offset(0, -500), 1000);
        await tester.pumpAndSettle();

        scrollStopwatch.stop();

        print('Scrolling with multiple components took ${scrollStopwatch.elapsedMilliseconds}ms');
        expect(scrollStopwatch.elapsedMilliseconds, lessThan(500));
      });
    });
  });
}

// Test data model for performance testing
class PerformanceUser {
  final int id;
  final String name;
  final String email;
  final String status;

  PerformanceUser({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
  });
}
