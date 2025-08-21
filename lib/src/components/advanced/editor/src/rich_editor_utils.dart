import 'package:flutter_quill/quill_delta.dart' as delta;
import 'dart:convert';

/// Zephyr Rich Editor Utilities
/// 
/// Provides utility methods for the rich text editor including
/// content conversion, validation, and formatting helpers.
class ZephyrRichEditorUtils {
  /// Converts Quill Delta to HTML
  static String deltaToHtml(delta.Delta delta) {
    final buffer = StringBuffer();
    
    for (final operation in delta.operations) {
      if (operation.isInsert) {
        final text = operation.data.toString();
        final attributes = operation.attributes;
        
        if (attributes != null && attributes.isNotEmpty) {
          buffer.write(_applyHtmlAttributes(text, attributes));
        } else {
          buffer.write(text);
        }
      }
    }
    
    return buffer.toString();
  }
  
  /// Converts Quill Delta to plain text
  static String deltaToPlainText(delta.Delta delta) {
    final buffer = StringBuffer();
    
    for (final operation in delta.operations) {
      if (operation.isInsert) {
        buffer.write(operation.data.toString());
      }
    }
    
    return buffer.toString();
  }
  
  /// Converts HTML to Quill Delta
  static delta.Delta htmlToDelta(String html) {
    // This is a simplified implementation
    // In a real implementation, you would use a proper HTML parser
    final deltaObj = delta.Delta();
    final text = _stripHtmlTags(html);
    
    if (text.isNotEmpty) {
      deltaObj.insert(text);
    }
    
    return deltaObj;
  }
  
  /// Converts plain text to Quill Delta
  static delta.Delta plainTextToDelta(String text) {
    final deltaObj = delta.Delta();
    deltaObj.insert(text);
    return deltaObj;
  }
  
  /// Converts Quill Delta to JSON string
  static String deltaToJson(delta.Delta delta) {
    return jsonEncode(delta.toJson());
  }
  
  /// Converts JSON string to Quill Delta
  static delta.Delta jsonToDelta(String jsonString) {
    final jsonData = jsonDecode(jsonString);
    return delta.Delta.fromJson(jsonData);
  }
  
  /// Gets word count from Quill Delta
  static int getWordCount(delta.Delta delta) {
    final text = deltaToPlainText(delta);
    if (text.trim().isEmpty) return 0;
    
    return text.trim().split(RegExp(r'\s+')).length;
  }
  
  /// Gets character count from Quill Delta
  static int getCharacterCount(delta.Delta delta) {
    final text = deltaToPlainText(delta);
    return text.length;
  }
  
  /// Validates HTML content
  static bool isValidHtml(String html) {
    try {
      final document = _parseHtml(html);
      return document != null;
    } catch (e) {
      return false;
    }
  }
  
  /// Sanitizes HTML content
  static String sanitizeHtml(String html) {
    // This is a simplified implementation
    // In a real implementation, you would use a proper HTML sanitizer
    return html
        .replaceAll(RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false), '')
        .replaceAll(RegExp(r'<iframe[^>]*>.*?</iframe>', caseSensitive: false), '')
        .replaceAll(RegExp(r'<object[^>]*>.*?</object>', caseSensitive: false), '')
        .replaceAll(RegExp(r'<embed[^>]*>', caseSensitive: false), '');
  }
  
  /// Extracts URLs from text
  static List<String> extractUrls(String text) {
    final urlRegex = RegExp(
      r'https?://(?:[-\w.])+(?:[:\d]+)?(?:/(?:[\w/_.])*(?:\?(?:[\w&=%.])*)?(?:#(?:[\w.])*)?)?',
      caseSensitive: false,
    );
    
    return urlRegex.allMatches(text).map((match) => match.group(0)!).toList();
  }
  
  /// Extracts image URLs from Delta
  static List<String> extractImageUrls(delta.Delta delta) {
    final urls = <String>[];
    
    for (final operation in delta.operations) {
      if (operation.isInsert && operation.data is Map) {
        final data = operation.data as Map;
        if (data['image'] != null) {
          urls.add(data['image'].toString());
        }
      }
    }
    
    return urls;
  }
  
  /// Extracts video URLs from Delta
  static List<String> extractVideoUrls(delta.Delta delta) {
    final urls = <String>[];
    
    for (final operation in delta.operations) {
      if (operation.isInsert && operation.data is Map) {
        final data = operation.data as Map;
        if (data['video'] != null) {
          urls.add(data['video'].toString());
        }
      }
    }
    
    return urls;
  }
  
  /// Applies HTML attributes to text
  static String _applyHtmlAttributes(String text, Map<String, dynamic> attributes) {
    String result = text;
    
    if (attributes['bold'] == true) {
      result = '<strong>$result</strong>';
    }
    
    if (attributes['italic'] == true) {
      result = '<em>$result</em>';
    }
    
    if (attributes['underline'] == true) {
      result = '<u>$result</u>';
    }
    
    if (attributes['strike'] == true) {
      result = '<s>$result</s>';
    }
    
    if (attributes['header'] != null) {
      final level = attributes['header'] as int;
      result = '<h$level>$result</h$level>';
    }
    
    if (attributes['code'] == true) {
      result = '<code>$result</code>';
    }
    
    if (attributes['blockquote'] == true) {
      result = '<blockquote>$result</blockquote>';
    }
    
    if (attributes['link'] != null) {
      final url = attributes['link'] as String;
      result = '<a href="$url">$result</a>';
    }
    
    if (attributes['color'] != null) {
      final color = attributes['color'] as String;
      result = '<span style="color: $color">$result</span>';
    }
    
    if (attributes['background'] != null) {
      final background = attributes['background'] as String;
      result = '<span style="background-color: $background">$result</span>';
    }
    
    return result;
  }
  
  /// Strips HTML tags from text
  static String _stripHtmlTags(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false), '');
  }
  
  /// Parses HTML document (simplified)
  static dynamic _parseHtml(String html) {
    // This is a placeholder for HTML parsing
    // In a real implementation, you would use a proper HTML parser
    return html.isNotEmpty ? html : null;
  }
  
  /// Creates a sample Delta for testing
  static delta.Delta createSampleDelta() {
    final deltaObj = delta.Delta()
      ..insert('Zephyr Rich Editor\n', {'header': 1})
      ..insert('This is a ')
      ..insert('rich text editor', {'bold': true})
      ..insert(' with support for ')
      ..insert('multiple formats', {'italic': true, 'color': '#3B82F6'})
      ..insert('.\n\n')
      ..insert('Features:\n', {'header': 2})
      ..insert('• Bold, Italic, Underline\n')
      ..insert('• Headers and Lists\n')
      ..insert('• Links and Images\n')
      ..insert('• Code Blocks\n', {'code': true})
      ..insert('• And much more!\n');
    return deltaObj;
  }
  
  /// Validates Delta content
  static bool isValidDelta(delta.Delta delta) {
    try {
      // Check if all operations are valid
      for (final operation in delta.operations) {
        if (operation.data == null) return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Gets reading time estimate in minutes
  static double getReadingTime(delta.Delta delta) {
    final wordCount = getWordCount(delta);
    // Average reading speed: 200 words per minute
    return wordCount / 200.0;
  }
  
  /// Formats file size for display
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}