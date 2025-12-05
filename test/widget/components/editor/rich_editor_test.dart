import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/input_advanced/rich_editor/index.dart';

void main() {
  group('VelocityRichEditorTheme', () {
    test('creates light theme', () {
      const theme = VelocityRichEditorTheme.light();
      expect(theme.backgroundColor, equals(Colors.white));
      expect(theme.textColor, equals(const Color(0xFF1F2937)));
      expect(theme.toolbarBackgroundColor, equals(const Color(0xFFF9FAFB)));
    });

    test('creates dark theme', () {
      const theme = VelocityRichEditorTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.textColor, equals(const Color(0xFFF9FAFB)));
      expect(theme.toolbarBackgroundColor, equals(const Color(0xFF111827)));
    });

    test('creates custom theme', () {
      const theme = VelocityRichEditorTheme(
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
      const theme = VelocityRichEditorTheme.light();
      final modified = theme.copyWith(backgroundColor: Colors.blue);

      expect(modified.backgroundColor, equals(Colors.blue));
      expect(modified.textColor, equals(theme.textColor));
    });

    test('merges themes', () {
      const theme1 = VelocityRichEditorTheme.light();
      const theme2 = VelocityRichEditorTheme(
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
      const theme1 = VelocityRichEditorTheme.light();
      const theme2 = VelocityRichEditorTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      const theme = VelocityRichEditorTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('VelocityRichEditorFormats', () {
    test('has all standard formats', () {
      expect(VelocityRichEditorFormats.bold, equals('bold'));
      expect(VelocityRichEditorFormats.italic, equals('italic'));
      expect(VelocityRichEditorFormats.underline, equals('underline'));
      expect(VelocityRichEditorFormats.strikethrough, equals('strikethrough'));
    });

    test('has all advanced formats', () {
      expect(VelocityRichEditorFormats.header, equals('header'));
      expect(VelocityRichEditorFormats.size, equals('size'));
      expect(VelocityRichEditorFormats.color, equals('color'));
      expect(VelocityRichEditorFormats.link, equals('link'));
    });

    test('has header levels', () {
      expect(VelocityRichEditorFormats.headerLevels, hasLength(6));
      expect(VelocityRichEditorFormats.headerLevels, contains('h1'));
      expect(VelocityRichEditorFormats.headerLevels, contains('h6'));
    });

    test('has text sizes', () {
      expect(VelocityRichEditorFormats.textSizes, hasLength(4));
      expect(VelocityRichEditorFormats.textSizes, contains('small'));
      expect(VelocityRichEditorFormats.textSizes, contains('huge'));
    });

    test('has alignments', () {
      expect(VelocityRichEditorFormats.alignments, hasLength(4));
      expect(VelocityRichEditorFormats.alignments, contains('left'));
      expect(VelocityRichEditorFormats.alignments, contains('justify'));
    });

    test('has list types', () {
      expect(VelocityRichEditorFormats.listTypes, hasLength(2));
      expect(VelocityRichEditorFormats.listTypes, contains('ordered'));
      expect(VelocityRichEditorFormats.listTypes, contains('bullet'));
    });

    test('has standard formats list', () {
      expect(VelocityRichEditorFormats.standardFormats, hasLength(4));
      expect(VelocityRichEditorFormats.standardFormats, contains('bold'));
      expect(VelocityRichEditorFormats.standardFormats, contains('underline'));
    });

    test('has advanced formats list', () {
      expect(VelocityRichEditorFormats.advancedFormats, hasLength(10));
      expect(VelocityRichEditorFormats.advancedFormats, contains('header'));
      expect(VelocityRichEditorFormats.advancedFormats, contains('video'));
    });

    test('has all formats list', () {
      expect(VelocityRichEditorFormats.allFormats, hasLength(14));
      expect(VelocityRichEditorFormats.allFormats, contains('bold'));
      expect(VelocityRichEditorFormats.allFormats, contains('clean'));
    });

    test('has toolbar groups', () {
      expect(VelocityRichEditorFormats.toolbarGroups, contains('basic'));
      expect(VelocityRichEditorFormats.toolbarGroups, contains('advanced'));
      expect(VelocityRichEditorFormats.toolbarGroups['basic'], hasLength(4));
    });
  });

  group('VelocityRichEditorUtils', () {
    test('converts plain text to delta', () {
      final delta = VelocityRichEditorUtils.plainTextToDelta('Hello World');
      expect(VelocityRichEditorUtils.deltaToPlainText(delta), equals('Hello World'));
    });

    test('converts delta to json', () {
      final delta = VelocityRichEditorUtils.plainTextToDelta('Hello');
      final json = VelocityRichEditorUtils.deltaToJson(delta);
      expect(json, isA<String>());
      
      final convertedDelta = VelocityRichEditorUtils.jsonToDelta(json);
      expect(VelocityRichEditorUtils.deltaToPlainText(convertedDelta), equals('Hello'));
    });

    test('counts words correctly', () {
      final delta = VelocityRichEditorUtils.plainTextToDelta('Hello World Test');
      expect(VelocityRichEditorUtils.getWordCount(delta), equals(3));
    });

    test('counts characters correctly', () {
      final delta = VelocityRichEditorUtils.plainTextToDelta('Hello');
      expect(VelocityRichEditorUtils.getCharacterCount(delta), equals(5));
    });

    test('handles empty content', () {
      final delta = VelocityRichEditorUtils.plainTextToDelta('');
      expect(VelocityRichEditorUtils.getWordCount(delta), equals(0));
      expect(VelocityRichEditorUtils.getCharacterCount(delta), equals(0));
    });

    test('extracts URLs from text', () {
      const text = 'Check out https://example.com and http://test.org';
      final urls = VelocityRichEditorUtils.extractUrls(text);
      expect(urls, hasLength(2));
      expect(urls, contains('https://example.com'));
      expect(urls, contains('http://test.org'));
    });

    test('calculates reading time', () {
      final delta = VelocityRichEditorUtils.plainTextToDelta('This is a test text with multiple words to calculate reading time.');
      final readingTime = VelocityRichEditorUtils.getReadingTime(delta);
      expect(readingTime, greaterThan(0));
    });

    test('creates sample delta', () {
      final delta = VelocityRichEditorUtils.createSampleDelta();
      expect(VelocityRichEditorUtils.getWordCount(delta), greaterThan(0));
      expect(VelocityRichEditorUtils.getCharacterCount(delta), greaterThan(0));
    });

    test('validates delta content', () {
      final validDelta = VelocityRichEditorUtils.plainTextToDelta('Hello');
      expect(VelocityRichEditorUtils.isValidDelta(validDelta), isTrue);
    });

    test('formats file size', () {
      expect(VelocityRichEditorUtils.formatFileSize(500), equals('500 B'));
      expect(VelocityRichEditorUtils.formatFileSize(1024), equals('1.0 KB'));
      expect(VelocityRichEditorUtils.formatFileSize(1024 * 1024), equals('1.0 MB'));
    });

    test('sanitizes HTML', () {
      const html = '<p>Hello</p><script>alert("test")</script>';
      final sanitized = VelocityRichEditorUtils.sanitizeHtml(html);
      expect(sanitized, isNot(contains('<script>')));
      expect(sanitized, contains('<p>Hello</p>'));
    });
  });
}