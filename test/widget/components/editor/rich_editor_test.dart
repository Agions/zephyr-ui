import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/input_advanced/rich_editor/index.dart';

void main() {
  group('ZephyrRichEditorTheme', () {
    test('creates light theme', () {
      const theme = ZephyrRichEditorTheme.light();
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.textColor, equals(const Color(0xFF1F2937)));
      expect(theme.toolbarBackgroundColor, equals(const Color(0xFFF9FAFB)));
    });

    test('creates dark theme', () {
      const theme = ZephyrRichEditorTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.textColor, equals(const Color(0xFFF9FAFB)));
      expect(theme.toolbarBackgroundColor, equals(const Color(0xFF111827)));
    });

    test('creates custom theme', () {
      const theme = ZephyrRichEditorTheme(
        backgroundColor: Colors.red,
        borderColor: Colors.black,
        borderWidth: 1.0,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        textColor: Colors.white,
        placeholderColor: Colors.grey,
        toolbarBackgroundColor: Colors.black,
        toolbarIconColor: Colors.white,
        toolbarButtonBackgroundColor: Colors.transparent,
        toolbarButtonHoverColor: Colors.grey,
        toolbarButtonActiveColor: Colors.blue,
        toolbarBorderColor: Colors.black,
        toolbarBorderRadius: BorderRadius.all(Radius.circular(6)),
        selectionBackgroundColor: Colors.blue,
        linkColor: Colors.blue,
        codeBlockBackgroundColor: Colors.grey,
        quoteBackgroundColor: Colors.black,
        quoteBorderColor: Colors.grey,
        headerStyle: TextStyle(fontSize: 20),
        bodyStyle: TextStyle(fontSize: 14),
        codeStyle: TextStyle(fontFamily: 'monospace'),
        quoteStyle: TextStyle(fontStyle: FontStyle.italic),
        placeholderStyle: TextStyle(color: Colors.grey),
      );

      expect(theme.backgroundColor, equals(Colors.red));
      expect(theme.textColor, equals(Colors.white));
      expect(theme.toolbarBackgroundColor, equals(Colors.black));
    });

    test('copies theme with modifications', () {
      const theme = ZephyrRichEditorTheme.light();
      final modified = theme.copyWith(backgroundColor: Colors.blue);

      expect(modified.backgroundColor, equals(Colors.blue));
      expect(modified.textColor, equals(theme.textColor));
    });

    test('merges themes', () {
      const theme1 = ZephyrRichEditorTheme.light();
      const theme2 = ZephyrRichEditorTheme(
        backgroundColor: Colors.red,
        borderColor: Colors.black,
        borderWidth: 1.0,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        textColor: Colors.white,
        placeholderColor: Colors.grey,
        toolbarBackgroundColor: Colors.black,
        toolbarIconColor: Colors.white,
        toolbarButtonBackgroundColor: Colors.transparent,
        toolbarButtonHoverColor: Colors.grey,
        toolbarButtonActiveColor: Colors.blue,
        toolbarBorderColor: Colors.black,
        toolbarBorderRadius: BorderRadius.all(Radius.circular(6)),
        selectionBackgroundColor: Colors.blue,
        linkColor: Colors.blue,
        codeBlockBackgroundColor: Colors.grey,
        quoteBackgroundColor: Colors.black,
        quoteBorderColor: Colors.grey,
        headerStyle: TextStyle(fontSize: 24),
        bodyStyle: TextStyle(fontSize: 16),
        codeStyle: TextStyle(fontFamily: 'monospace'),
        quoteStyle: TextStyle(fontStyle: FontStyle.italic),
        placeholderStyle: TextStyle(fontSize: 16),
      );
      final merged = theme1.merge(theme2);

      expect(merged.backgroundColor, equals(Colors.red));
      expect(merged.textColor, equals(theme1.textColor));
    });

    test('compares themes for equality', () {
      const theme1 = ZephyrRichEditorTheme.light();
      const theme2 = ZephyrRichEditorTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      const theme = ZephyrRichEditorTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('ZephyrRichEditorFormats', () {
    test('has all standard formats', () {
      expect(ZephyrRichEditorFormats.bold, equals('bold'));
      expect(ZephyrRichEditorFormats.italic, equals('italic'));
      expect(ZephyrRichEditorFormats.underline, equals('underline'));
      expect(ZephyrRichEditorFormats.strikethrough, equals('strikethrough'));
    });

    test('has all advanced formats', () {
      expect(ZephyrRichEditorFormats.header, equals('header'));
      expect(ZephyrRichEditorFormats.size, equals('size'));
      expect(ZephyrRichEditorFormats.color, equals('color'));
      expect(ZephyrRichEditorFormats.link, equals('link'));
    });

    test('has header levels', () {
      expect(ZephyrRichEditorFormats.headerLevels, hasLength(6));
      expect(ZephyrRichEditorFormats.headerLevels, contains('h1'));
      expect(ZephyrRichEditorFormats.headerLevels, contains('h6'));
    });

    test('has text sizes', () {
      expect(ZephyrRichEditorFormats.textSizes, hasLength(4));
      expect(ZephyrRichEditorFormats.textSizes, contains('small'));
      expect(ZephyrRichEditorFormats.textSizes, contains('huge'));
    });

    test('has alignments', () {
      expect(ZephyrRichEditorFormats.alignments, hasLength(4));
      expect(ZephyrRichEditorFormats.alignments, contains('left'));
      expect(ZephyrRichEditorFormats.alignments, contains('justify'));
    });

    test('has list types', () {
      expect(ZephyrRichEditorFormats.listTypes, hasLength(2));
      expect(ZephyrRichEditorFormats.listTypes, contains('ordered'));
      expect(ZephyrRichEditorFormats.listTypes, contains('bullet'));
    });

    test('has standard formats list', () {
      expect(ZephyrRichEditorFormats.standardFormats, hasLength(4));
      expect(ZephyrRichEditorFormats.standardFormats, contains('bold'));
      expect(ZephyrRichEditorFormats.standardFormats, contains('underline'));
    });

    test('has advanced formats list', () {
      expect(ZephyrRichEditorFormats.advancedFormats, hasLength(10));
      expect(ZephyrRichEditorFormats.advancedFormats, contains('header'));
      expect(ZephyrRichEditorFormats.advancedFormats, contains('video'));
    });

    test('has all formats list', () {
      expect(ZephyrRichEditorFormats.allFormats, hasLength(14));
      expect(ZephyrRichEditorFormats.allFormats, contains('bold'));
      expect(ZephyrRichEditorFormats.allFormats, contains('clean'));
    });

    test('has toolbar groups', () {
      expect(ZephyrRichEditorFormats.toolbarGroups, contains('basic'));
      expect(ZephyrRichEditorFormats.toolbarGroups, contains('advanced'));
      expect(ZephyrRichEditorFormats.toolbarGroups['basic'], hasLength(4));
    });
  });

  group('ZephyrRichEditorUtils', () {
    test('converts plain text to delta', () {
      final delta = ZephyrRichEditorUtils.plainTextToDelta('Hello World');
      expect(ZephyrRichEditorUtils.deltaToPlainText(delta), equals('Hello World'));
    });

    test('converts delta to json', () {
      final delta = ZephyrRichEditorUtils.plainTextToDelta('Hello');
      final json = ZephyrRichEditorUtils.deltaToJson(delta);
      expect(json, isA<String>());
      
      final convertedDelta = ZephyrRichEditorUtils.jsonToDelta(json);
      expect(ZephyrRichEditorUtils.deltaToPlainText(convertedDelta), equals('Hello'));
    });

    test('counts words correctly', () {
      final delta = ZephyrRichEditorUtils.plainTextToDelta('Hello World Test');
      expect(ZephyrRichEditorUtils.getWordCount(delta), equals(3));
    });

    test('counts characters correctly', () {
      final delta = ZephyrRichEditorUtils.plainTextToDelta('Hello');
      expect(ZephyrRichEditorUtils.getCharacterCount(delta), equals(5));
    });

    test('handles empty content', () {
      final delta = ZephyrRichEditorUtils.plainTextToDelta('');
      expect(ZephyrRichEditorUtils.getWordCount(delta), equals(0));
      expect(ZephyrRichEditorUtils.getCharacterCount(delta), equals(0));
    });

    test('extracts URLs from text', () {
      const text = 'Check out https://example.com and http://test.org';
      final urls = ZephyrRichEditorUtils.extractUrls(text);
      expect(urls, hasLength(2));
      expect(urls, contains('https://example.com'));
      expect(urls, contains('http://test.org'));
    });

    test('calculates reading time', () {
      final delta = ZephyrRichEditorUtils.plainTextToDelta('This is a test text with multiple words to calculate reading time.');
      final readingTime = ZephyrRichEditorUtils.getReadingTime(delta);
      expect(readingTime, greaterThan(0));
    });

    test('creates sample delta', () {
      final delta = ZephyrRichEditorUtils.createSampleDelta();
      expect(ZephyrRichEditorUtils.getWordCount(delta), greaterThan(0));
      expect(ZephyrRichEditorUtils.getCharacterCount(delta), greaterThan(0));
    });

    test('validates delta content', () {
      final validDelta = ZephyrRichEditorUtils.plainTextToDelta('Hello');
      expect(ZephyrRichEditorUtils.isValidDelta(validDelta), isTrue);
    });

    test('formats file size', () {
      expect(ZephyrRichEditorUtils.formatFileSize(500), equals('500 B'));
      expect(ZephyrRichEditorUtils.formatFileSize(1024), equals('1.0 KB'));
      expect(ZephyrRichEditorUtils.formatFileSize(1024 * 1024), equals('1.0 MB'));
    });

    test('sanitizes HTML', () {
      const html = '<p>Hello</p><script>alert("test")</script>';
      final sanitized = ZephyrRichEditorUtils.sanitizeHtml(html);
      expect(sanitized, isNot(contains('<script>')));
      expect(sanitized, contains('<p>Hello</p>'));
    });
  });
}