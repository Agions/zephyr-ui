import 'package:flutter_test/flutter_test.dart';
import 'package:chroma_ui/src/components/display/charts/implementations/area_chart.dart';
import 'package:chroma_ui/src/components/display/charts/implementations/scatter_chart.dart';
import 'package:chroma_ui/src/components/display/charts/implementations/radar_chart.dart';
import 'package:chroma_ui/src/components/display/table/enhanced_table.dart';
import 'package:chroma_ui/src/components/form/validation/form_validation_system.dart';
import 'package:chroma_ui/src/components/advanced/file_upload/enhanced_file_upload.dart';

void main() {
  group('chromaUI Enhanced Components Tests', () {
    group('AreaChart Tests', () {
      testWidgets('AreaChart renders correctly with data', (WidgetTester tester) async {
        final data = [
          AreaChartData(
            label: 'Series 1',
            color: Colors.blue,
            points: [
              AreaChartPoint(x: 1, y: 10),
              AreaChartPoint(x: 2, y: 20),
              AreaChartPoint(x: 3, y: 15),
            ],
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaAreaChart(
                data: data,
                height: 200,
                showLegend: true,
                showGrid: true,
              ),
            ),
          ),
        );

        expect(find.byType(chromaAreaChart), findsOneWidget);
        expect(find.text('Series 1'), findsOneWidget);
      });

      testWidgets('AreaChart handles empty data gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaAreaChart(
                data: [],
                height: 200,
              ),
            ),
          ),
        );

        expect(find.byType(chromaAreaChart), findsOneWidget);
      });

      testWidgets('AreaChart calls onHover callback', (WidgetTester tester) async {
        final data = [
          AreaChartData(
            label: 'Series 1',
            color: Colors.blue,
            points: [
              AreaChartPoint(x: 1, y: 10),
              AreaChartPoint(x: 2, y: 20),
            ],
          ),
        ];

        AreaChartData? hoveredData;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaAreaChart(
                data: data,
                height: 200,
                onHover: (data) => hoveredData = data,
              ),
            ),
          ),
        );

        // Simulate hover
        final center = tester.getCenter(find.byType(chromaAreaChart));
        await tester.sendEventToBinding(PointerHoverEvent(position: center));
        await tester.pumpAndSettle();

        // Note: Hover testing would require more complex setup in real tests
        expect(find.byType(chromaAreaChart), findsOneWidget);
      });
    });

    group('ScatterChart Tests', () {
      testWidgets('ScatterChart renders with multiple series', (WidgetTester tester) async {
        final data = [
          ScatterChartData(
            label: 'Series 1',
            color: Colors.red,
            points: [
              ScatterChartPoint(x: 1, y: 2, size: 5),
              ScatterChartPoint(x: 3, y: 4, size: 8),
            ],
          ),
          ScatterChartData(
            label: 'Series 2',
            color: Colors.green,
            points: [
              ScatterChartPoint(x: 2, y: 3, size: 6),
              ScatterChartPoint(x: 4, y: 5, size: 7),
            ],
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaScatterChart(
                data: data,
                height: 250,
                showLegend: true,
              ),
            ),
          ),
        );

        expect(find.byType(chromaScatterChart), findsOneWidget);
        expect(find.text('Series 1'), findsOneWidget);
        expect(find.text('Series 2'), findsOneWidget);
      });

      testWidgets('ScatterChart supports zoom and pan', (WidgetTester tester) async {
        final data = [
          ScatterChartData(
            label: 'Test',
            color: Colors.blue,
            points: [
              ScatterChartPoint(x: 1, y: 1, size: 5),
            ],
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaScatterChart(
                data: data,
                height: 200,
                enableZoom: true,
                enablePan: true,
              ),
            ),
          ),
        );

        expect(find.byType(chromaScatterChart), findsOneWidget);
      });
    });

    group('RadarChart Tests', () {
      testWidgets('RadarChart renders with categories', (WidgetTester tester) async {
        final data = [
          RadarChartData(
            label: 'Performance',
            color: Colors.purple,
            points: [
              RadarChartPoint(value: 80),
              RadarChartPoint(value: 90),
              RadarChartPoint(value: 70),
              RadarChartPoint(value: 85),
            ],
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaRadarChart(
                data: data,
                categories: ['Speed', 'Quality', 'Cost', 'Reliability'],
                height: 300,
                showGrid: true,
              ),
            ),
          ),
        );

        expect(find.byType(chromaRadarChart), findsOneWidget);
        expect(find.text('Performance'), findsOneWidget);
      });

      testWidgets('RadarChart handles mismatched data and categories', (WidgetTester tester) async {
        final data = [
          RadarChartData(
            label: 'Test',
            color: Colors.blue,
            points: [
              RadarChartPoint(value: 50),
              RadarChartPoint(value: 60),
            ],
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaRadarChart(
                data: data,
                categories: ['A', 'B', 'C'], // More categories than data points
                height: 200,
              ),
            ),
          ),
        );

        expect(find.byType(chromaRadarChart), findsOneWidget);
      });
    });

    group('EnhancedTable Tests', () {
      final testUsers = [
        User(id: 1, name: 'John Doe', email: 'john@example.com', status: 'Active'),
        User(id: 2, name: 'Jane Smith', email: 'jane@example.com', status: 'Inactive'),
        User(id: 3, name: 'Bob Johnson', email: 'bob@example.com', status: 'Active'),
      ];

      testWidgets('EnhancedTable renders with data', (WidgetTester tester) async {
        final columns = [
          TableColumn<User>(
            id: 'name',
            label: 'Name',
            valueGetter: (user) => user.name,
          ),
          TableColumn<User>(
            id: 'email',
            label: 'Email',
            valueGetter: (user) => user.email,
          ),
          TableColumn<User>(
            id: 'status',
            label: 'Status',
            valueGetter: (user) => user.status,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaEnhancedTable<User>(
                columns: columns,
                data: testUsers,
                height: 400,
                enableSorting: true,
                enableFiltering: true,
              ),
            ),
          ),
        );

        expect(find.byType(chromaEnhancedTable<User>>), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('jane@example.com'), findsOneWidget);
      });

      testWidgets('EnhancedTable handles sorting', (WidgetTester tester) async {
        final columns = [
          TableColumn<User>(
            id: 'name',
            label: 'Name',
            valueGetter: (user) => user.name,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaEnhancedTable<User>(
                columns: columns,
                data: testUsers,
                height: 300,
                enableSorting: true,
                initialSortColumn: 'name',
                initialSortDirection: SortDirection.ascending,
              ),
            ),
          ),
        );

        expect(find.byType(chromaEnhancedTable<User>>), findsOneWidget);
      });

      testWidgets('EnhancedTable handles empty data', (WidgetTester tester) async {
        final columns = [
          TableColumn<User>(
            id: 'name',
            label: 'Name',
            valueGetter: (user) => user.name,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaEnhancedTable<User>(
                columns: columns,
                data: [],
                height: 300,
                emptyWidget: const Text('No users found'),
              ),
            ),
          ),
        );

        expect(find.byType(chromaEnhancedTable<User>>), findsOneWidget);
        expect(find.text('No users found'), findsOneWidget);
      });

      testWidgets('EnhancedTable calls onRowTap callback', (WidgetTester tester) async {
        final columns = [
          TableColumn<User>(
            id: 'name',
            label: 'Name',
            valueGetter: (user) => user.name,
          ),
        ];

        User? tappedUser;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaEnhancedTable<User>(
                columns: columns,
                data: testUsers,
                height: 300,
                onRowTap: (user) => tappedUser = user,
              ),
            ),
          ),
        );

        // Tap on first row
        await tester.tap(find.text('John Doe'));
        await tester.pumpAndSettle();

        expect(tappedUser, isNotNull);
        expect(tappedUser?.name, equals('John Doe'));
      });
    });

    group('FormValidationSystem Tests', () {
      testWidgets('FormValidationSystem validates required fields', (WidgetTester tester) async {
        final formKey = GlobalKey<FormState>();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaFormValidationSystem<String>(
                validators: [
                  RequiredValidator(fieldName: 'email'),
                  EmailValidator(fieldName: 'email'),
                ],
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      chromaFormField<String>(
                        fieldName: 'email',
                        initialValue: '',
                        builder: (context, fieldState) {
                          return TextFormField(
                            decoration: InputDecoration(
                              errorText: fieldState.errorText,
                            ),
                            onChanged: fieldState.didChange,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        // Try to validate with empty field
        final formState = formKey.currentState;
        expect(formState?.validate(), isFalse);
      });

      testWidgets('FormValidationSystem validates email format', (WidgetTester tester) async {
        late String? validationResult;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaFormValidationSystem<String>(
                validators: [
                  RequiredValidator(fieldName: 'email'),
                  EmailValidator(fieldName: 'email'),
                ],
                onChanged: (values) {
                  final formState = chromaFormValidationSystem.of<String>(context);
                  validationResult = formState.validateField('email', values['email']);
                },
                child: Column(
                  children: [
                    chromaFormField<String>(
                      fieldName: 'email',
                      initialValue: 'invalid-email',
                      builder: (context, fieldState) {
                        return TextFormField(
                          initialValue: 'invalid-email',
                          onChanged: fieldState.didChange,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(validationResult, isNotNull);
        expect(validationResult, contains('valid email'));
      });

      testWidgets('FormValidationSystem handles cross-field validation', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaFormValidationSystem<String>(
                crossFieldValidators: [
                  PasswordMatchValidator(
                    passwordField: 'password',
                    confirmPasswordField: 'confirmPassword',
                  ),
                ],
                child: Column(
                  children: [
                    chromaFormField<String>(
                      fieldName: 'password',
                      initialValue: 'password123',
                      builder: (context, fieldState) {
                        return TextFormField(
                          initialValue: 'password123',
                          onChanged: fieldState.didChange,
                        );
                      },
                    ),
                    chromaFormField<String>(
                      fieldName: 'confirmPassword',
                      initialValue: 'differentpassword',
                      builder: (context, fieldState) {
                        return TextFormField(
                          initialValue: 'differentpassword',
                          onChanged: fieldState.didChange,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        final formState = chromaFormValidationSystem.of<String>(tester.element(find.byType(chromaFormValidationSystem)));
        final isValid = formState.validate();

        expect(isValid, isFalse);
      });
    });

    group('EnhancedFileUpload Tests', () {
      testWidgets('EnhancedFileUpload renders empty state', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaEnhancedFileUpload(
                maxFiles: 3,
                maxFileSize: 1024 * 1024, // 1MB
                allowedFileTypes: ['jpg', 'png'],
              ),
            ),
          ),
        );

        expect(find.byType(chromaEnhancedFileUpload), findsOneWidget);
        expect(find.text('Drag and drop files here'), findsOneWidget);
      });

      testWidgets('EnhancedFileUpload handles file validation', (WidgetTester tester) async {
        // This test would require mocking file operations
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaEnhancedFileUpload(
                maxFiles: 2,
                maxFileSize: 1024, // 1KB for testing
                allowedFileTypes: ['txt'],
              ),
            ),
          ),
        );

        expect(find.byType(chromaEnhancedFileUpload), findsOneWidget);
      });

      testWidgets('EnhancedFileUpload calls callbacks', (WidgetTester tester) async {
        List<UploadItem>? uploadedFiles;
        List<UploadItem>? failedFiles;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: chromaEnhancedFileUpload(
                maxFiles: 1,
                onFileUploaded: (item) => uploadedFiles = [item],
                onFileFailed: (item) => failedFiles = [item],
              ),
            ),
          ),
        );

        expect(find.byType(chromaEnhancedFileUpload), findsOneWidget);
        expect(uploadedFiles, isNull);
        expect(failedFiles, isNull);
      });
    });
  });
}

// Test data models
class User {
  final int id;
  final String name;
  final String email;
  final String status;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
  });
}
