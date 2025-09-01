import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/input_advanced/auto_complete/index.dart';

void main() {
  group('ZephyrAutoCompleteTheme', () {
    test('creates light theme', () {
      final theme = ZephyrAutoCompleteTheme.light();
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.borderColor, equals(const Color(0xFFD1D5DB)));
      expect(theme.focusedBorderColor, equals(const Color(0xFF3B82F6)));
    });

    test('creates dark theme', () {
      final theme = ZephyrAutoCompleteTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.textColor, equals(const Color(0xFFF9FAFB)));
      expect(theme.suggestionBackgroundColor, equals(const Color(0xFF1F2937)));
    });

    test('creates custom theme', () {
      final theme = ZephyrAutoCompleteTheme.custom(
        backgroundColor: Colors.red,
        borderColor: Colors.blue,
        focusedBorderColor: Colors.green,
      );

      expect(theme.backgroundColor, equals(Colors.red));
      expect(theme.borderColor, equals(Colors.blue));
      expect(theme.focusedBorderColor, equals(Colors.green));
    });

    test('copies theme with modifications', () {
      final theme = ZephyrAutoCompleteTheme.light();
      final modified = theme.copyWith(backgroundColor: Colors.purple);

      expect(modified.backgroundColor, equals(Colors.purple));
      expect(modified.borderColor, equals(theme.borderColor));
    });

    test('merges themes', () {
      final theme1 = ZephyrAutoCompleteTheme.light();
      final theme2 = ZephyrAutoCompleteTheme.custom(backgroundColor: Colors.orange);
      final merged = theme1.merge(theme2);

      expect(merged.backgroundColor, equals(Colors.orange));
      expect(merged.borderColor, equals(theme1.borderColor));
    });

    test('compares themes for equality', () {
      final theme1 = ZephyrAutoCompleteTheme.light();
      final theme2 = ZephyrAutoCompleteTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      final theme = ZephyrAutoCompleteTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('ZephyrAutoCompleteUtils', () {
    final items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
    String displayString(String item) => item;

    test('filters items by query', () {
      final filtered = ZephyrAutoCompleteUtils.filterItems(
        items, 'a', displayString,
      );
      expect(filtered, contains('Apple'));
      expect(filtered, contains('Banana'));
      expect(filtered, contains('Date'));
      expect(filtered, isNot(contains('Cherry')));
    });

    test('filters items with exact match', () {
      final filtered = ZephyrAutoCompleteUtils.filterItemsAdvanced(
        items, 'Apple', displayString, exactMatch: true,
      );
      expect(filtered, equals(['Apple']));
    });

    test('filters items with fuzzy search', () {
      final filtered = ZephyrAutoCompleteUtils.filterItemsAdvanced(
        items, 'aple', displayString, fuzzySearch: true,
      );
      expect(filtered, isNotEmpty);
    });

    test('sorts items by relevance', () {
      final sorted = ZephyrAutoCompleteUtils.sortByRelevance(
        items, 'app', displayString,
      );
      expect(sorted.first, equals('Apple'));
    });

    test('groups items by category', () {
      final fruits = [
        {'name': 'Apple', 'category': 'Fruit'},
        {'name': 'Carrot', 'category': 'Vegetable'},
        {'name': 'Banana', 'category': 'Fruit'},
      ];
      
      final grouped = ZephyrAutoCompleteUtils.groupItems(
        fruits, (item) => (item as Map<String, dynamic>)['category'] as String,
      );
      
      expect(grouped, contains('Fruit'));
      expect(grouped, contains('Vegetable'));
      expect(grouped['Fruit']!.length, equals(2));
    });

    test('gets recent items from history', () {
      final history = ['Cherry', 'Apple', 'Banana'];
      final recent = ZephyrAutoCompleteUtils.getRecentItems(
        items, history, 2,
      );
      expect(recent, equals(['Cherry', 'Apple']));
    });

    test('highlights search term in text', () {
      final spans = ZephyrAutoCompleteUtils.highlightSearchTerm(
        'Hello World', 'World',
        const TextStyle(), const TextStyle(fontWeight: FontWeight.bold),
      );
      expect(spans, hasLength(2));
    });

    test('validates search query', () {
      expect(ZephyrAutoCompleteUtils.isValidQuery('test'), isTrue);
      expect(ZephyrAutoCompleteUtils.isValidQuery(''), isFalse);
      expect(ZephyrAutoCompleteUtils.isValidQuery('a'), isFalse);
    });

    test('sanitizes search query', () {
      final sanitized = ZephyrAutoCompleteUtils.sanitizeQuery('  Hello  World!  ');
      expect(sanitized, equals('Hello World'));
    });

    test('creates search suggestions', () {
      final suggestions = ['Apple', 'Banana', 'Cherry'];
      final result = ZephyrAutoCompleteUtils.createSuggestions(
        'a', suggestions, 2,
      );
      expect(result, hasLength(2));
      expect(result, contains('Apple'));
    });

    test('formats item count', () {
      expect(ZephyrAutoCompleteUtils.formatItemCount(1), equals('1 item'));
      expect(ZephyrAutoCompleteUtils.formatItemCount(2), equals('2 items'));
    });

    test('calculates typing speed', () {
      final start = DateTime.now();
      final end = start.add(const Duration(seconds: 30));
      final speed = ZephyrAutoCompleteUtils.calculateTypingSpeed(
        'Hello World', start, end,
      );
      expect(speed, greaterThan(0));
    });

    test('gets keyboard shortcuts', () {
      final shortcuts = ZephyrAutoCompleteUtils.getKeyboardShortcuts();
      expect(shortcuts, contains('ArrowUp'));
      expect(shortcuts, contains('Enter'));
    });

    test('creates search metadata', () {
      final metadata = ZephyrAutoCompleteUtils.createSearchMetadata(
        query: 'test',
        resultCount: 5,
        searchDuration: const Duration(milliseconds: 100),
        filters: ['category'],
      );
      expect(metadata['query'], equals('test'));
      expect(metadata['resultCount'], equals(5));
      expect(metadata['searchDuration'], equals(100));
    });

    test('exports and imports search history', () {
      final history = [
        {'query': 'test', 'timestamp': '2023-01-01', 'resultCount': 5},
      ];
      
      final exported = ZephyrAutoCompleteUtils.exportSearchHistory(history);
      final imported = ZephyrAutoCompleteUtils.importSearchHistory(exported);
      
      expect(imported, hasLength(1));
      expect(imported.first['query'], equals('test'));
    });
  });

  group('ZephyrAutoComplete Widget', () {
    late TextEditingController controller;
    final items = ['Apple', 'Banana', 'Cherry', 'Date'];

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('renders with basic configuration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              placeholder: 'Search fruits...',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAutoComplete<String>), findsOneWidget);
      expect(find.text('Search fruits...'), findsOneWidget);
    });

    testWidgets('shows suggestions when focused', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
    });

    testWidgets('filters items based on input', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'a');
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsNothing);
    });

    testWidgets('selects item on tap', (tester) async {
      String? selectedItem;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              onSelected: (value) {
                selectedItem = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      expect(selectedItem, equals('Apple'));
      expect(controller.text, equals('Apple'));
    });

    testWidgets('handles multi-select mode', (tester) async {
      final selectedItems = <String>[];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              multiSelect: true,
              onSelected: (value) {
                selectedItems.add(value);
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '');
      await tester.pump(const Duration(milliseconds: 300));

      await tester.tap(find.text('Banana'));
      await tester.pumpAndSettle();

      expect(selectedItems, hasLength(2));
      expect(selectedItems, contains('Apple'));
      expect(selectedItems, contains('Banana'));
    });

    testWidgets('shows loading indicator for async items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: const [],
              controller: controller,
              asyncItems: (query) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return items.where((item) => item.contains(query)).toList();
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'a');
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shows clear button when text is entered', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              showClearButton: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.clear), findsNothing);

      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('clears text when clear button is pressed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              showClearButton: true,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(controller.text, isEmpty);
    });

    testWidgets('shows no results message when no items match', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('No results found'), findsOneWidget);
    });

    testWidgets('respects disabled state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('respects read-only state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              readOnly: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, isTrue);
    });

    testWidgets('shows error text when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              errorText: 'This field is required',
            ),
          ),
        ),
      );

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('shows helper text when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              helperText: 'Start typing to search',
            ),
          ),
        ),
      );

      expect(find.text('Start typing to search'), findsOneWidget);
    });

    testWidgets('uses custom item builder when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  leading: const Icon(Icons.apple),
                  title: Text(item),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.apple), findsWidgets);
    });

    testWidgets('handles keyboard navigation', (tester) async {
      String? selectedItem;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              onSelected: (value) {
                selectedItem = value;
              },
              enableKeyboardNavigation: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // Arrow down to select first item
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();

      // Enter to select
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();

      expect(selectedItem, isNotNull);
    });

    testWidgets('applies custom theme', (tester) async {
      final customTheme = ZephyrAutoCompleteTheme.custom(
        backgroundColor: Colors.red,
        borderColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrAutoComplete<String>(
              items: items,
              controller: controller,
              theme: customTheme,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      // The theme should be applied to the internal components
      expect(container, isNotNull);
    });
  });
}