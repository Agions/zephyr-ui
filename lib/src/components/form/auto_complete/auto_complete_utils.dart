import 'dart:async';
import 'package:flutter/material.dart';

/// AutoComplete utility functions
/// 
/// Provides helper methods for filtering, searching, and data processing
class ZephyrAutoCompleteUtils {
  /// Filter items based on search query
  static List<T> filterItems<T>(
    List<T> items,
    String query,
    String Function(T) displayStringForOption,
  ) {
    if (query.isEmpty) return items;
    
    final lowercaseQuery = query.toLowerCase();
    return items.where((item) {
      final displayString = displayStringForOption(item).toLowerCase();
      return displayString.contains(lowercaseQuery);
    }).toList();
  }

  /// Filter items with advanced options
  static List<T> filterItemsAdvanced<T>(
    List<T> items,
    String query,
    String Function(T) displayStringForOption, {
    bool caseSensitive = false,
    bool exactMatch = false,
    bool fuzzySearch = false,
    double fuzzyThreshold = 0.5,
  }) {
    if (query.isEmpty) return items;
    
    if (exactMatch) {
      return items.where((item) {
        final displayString = displayStringForOption(item);
        if (caseSensitive) {
          return displayString == query;
        } else {
          return displayString.toLowerCase() == query.toLowerCase();
        }
      }).toList();
    }
    
    if (fuzzySearch) {
      return items.where((item) {
        final displayString = displayStringForOption(item);
        return _fuzzyMatch(displayString, query, threshold: fuzzyThreshold, caseSensitive: caseSensitive);
      }).toList();
    }
    
    // Default case-insensitive search
    return filterItems(items, query, displayStringForOption);
  }

  /// Fuzzy search implementation
  static bool _fuzzyMatch(
    String text,
    String pattern, {
    double threshold = 0.5,
    bool caseSensitive = false,
  }) {
    if (pattern.isEmpty) return true;
    if (text.isEmpty) return false;
    
    final workingText = caseSensitive ? text : text.toLowerCase();
    final workingPattern = caseSensitive ? pattern : pattern.toLowerCase();
    
    var score = 0;
    var patternIndex = 0;
    var textIndex = 0;
    
    while (patternIndex < workingPattern.length && textIndex < workingText.length) {
      if (workingPattern[patternIndex] == workingText[textIndex]) {
        score++;
        patternIndex++;
      }
      textIndex++;
    }
    
    final matchRatio = score / workingPattern.length;
    return matchRatio >= threshold;
  }

  /// Sort items by relevance to search query
  static List<T> sortByRelevance<T>(
    List<T> items,
    String query,
    String Function(T) displayStringForOption,
  ) {
    if (query.isEmpty) return items;
    
    final lowercaseQuery = query.toLowerCase();
    
    return items..sort((a, b) {
      final scoreA = _calculateRelevanceScore(
        displayStringForOption(a).toLowerCase(),
        lowercaseQuery,
      );
      final scoreB = _calculateRelevanceScore(
        displayStringForOption(b).toLowerCase(),
        lowercaseQuery,
      );
      return scoreB.compareTo(scoreA);
    });
  }

  /// Calculate relevance score for sorting
  static int _calculateRelevanceScore(String text, String query) {
    if (query.isEmpty) return 0;
    
    // Exact match gets highest score
    if (text == query) return 1000;
    
    // Starts with query gets high score
    if (text.startsWith(query)) return 500;
    
    // Contains query gets medium score
    if (text.contains(query)) return 100;
    
    // Calculate character overlap
    var overlap = 0;
    for (var i = 0; i < query.length; i++) {
      if (text.contains(query[i])) {
        overlap++;
      }
    }
    
    return overlap;
  }

  /// Debounce function to limit search frequency
  static Function debounce(Function Function() func, Duration duration) {
    Timer? timer;
    return () {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(duration, func);
    };
  }

  /// Group items by category
  static Map<String, List<T>> groupItems<T>(
    List<T> items,
    String Function(T) categoryFunction,
  ) {
    final grouped = <String, List<T>>{};
    
    for (final item in items) {
      final category = categoryFunction(item);
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]!.add(item);
    }
    
    return grouped;
  }

  /// Get recent items from history
  static List<T> getRecentItems<T>(
    List<T> items,
    List<T> history,
    int maxItems,
  ) {
    final recentItems = <T>[];
    
    for (final item in history) {
      if (recentItems.length >= maxItems) break;
      if (items.contains(item) && !recentItems.contains(item)) {
        recentItems.add(item);
      }
    }
    
    return recentItems;
  }

  /// Highlight search term in text
  static List<TextSpan> highlightSearchTerm(
    String text,
    String query,
    TextStyle normalStyle,
    TextStyle highlightStyle,
  ) {
    if (query.isEmpty) {
      return [TextSpan(text: text, style: normalStyle)];
    }
    
    final spans = <TextSpan>[];
    final lowercaseText = text.toLowerCase();
    final lowercaseQuery = query.toLowerCase();
    var currentIndex = 0;
    
    while (currentIndex < text.length) {
      final matchIndex = lowercaseText.indexOf(lowercaseQuery, currentIndex);
      
      if (matchIndex == -1) {
        // No more matches, add remaining text
        spans.add(TextSpan(
          text: text.substring(currentIndex),
          style: normalStyle,
        ));
        break;
      }
      
      // Add text before match
      if (matchIndex > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, matchIndex),
          style: normalStyle,
        ));
      }
      
      // Add highlighted match
      spans.add(TextSpan(
        text: text.substring(matchIndex, matchIndex + query.length),
        style: highlightStyle,
      ));
      
      currentIndex = matchIndex + query.length;
    }
    
    return spans;
  }

  /// Validate search query
  static bool isValidQuery(String query, {int minLength = 1, int maxLength = 100}) {
    if (query.isEmpty) return false;
    if (query.length < minLength) return false;
    if (query.length > maxLength) return false;
    return true;
  }

  /// Sanitize search query
  static String sanitizeQuery(String query) {
    return query
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ') // Normalize whitespace
        .replaceAll(RegExp(r'[^\w\s]'), ''); // Remove special characters
  }

  /// Get display name for item
  static String getDisplayName<T>(T item, String Function(T) displayStringForOption) {
    try {
      return displayStringForOption(item);
    } catch (e) {
      return item.toString();
    }
  }

  /// Check if item matches query
  static bool itemMatches<T>(
    T item,
    String query,
    String Function(T) displayStringForOption, {
    bool caseSensitive = false,
  }) {
    if (query.isEmpty) return true;
    
    final displayString = displayStringForOption(item);
    if (caseSensitive) {
      return displayString.contains(query);
    } else {
      return displayString.toLowerCase().contains(query.toLowerCase());
    }
  }

  /// Create default display string function
  static String Function(T) defaultDisplayStringForOption<T>() {
    return (item) => item.toString();
  }

  /// Create search suggestions
  static List<String> createSuggestions(
    String query,
    List<String> suggestions,
    int maxSuggestions,
  ) {
    if (query.isEmpty) return suggestions.take(maxSuggestions).toList();
    
    final filtered = suggestions.where((suggestion) =>
      suggestion.toLowerCase().contains(query.toLowerCase())
    ).toList();
    
    return filtered.take(maxSuggestions).toList();
  }

  /// Format item count
  static String formatItemCount(int count, {String singular = 'item', String plural = 'items'}) {
    if (count == 1) {
      return '$count $singular';
    } else {
      return '$count $plural';
    }
  }

  /// Calculate typing speed (characters per minute)
  static double calculateTypingSpeed(
    String text,
    DateTime startTime,
    DateTime endTime,
  ) {
    final duration = endTime.difference(startTime);
    final minutes = duration.inMinutes + (duration.inSeconds % 60) / 60.0;
    return text.length / minutes;
  }

  /// Get keyboard shortcuts
  static Map<String, String> getKeyboardShortcuts() {
    return {
      'ArrowUp': 'Navigate up',
      'ArrowDown': 'Navigate down',
      'Enter': 'Select item',
      'Escape': 'Close suggestions',
      'Tab': 'Focus next element',
      'Shift+Tab': 'Focus previous element',
    };
  }

  /// Create search metadata
  static Map<String, dynamic> createSearchMetadata({
    required String query,
    required int resultCount,
    required Duration searchDuration,
    required List<String> filters,
  }) {
    return {
      'query': query,
      'resultCount': resultCount,
      'searchDuration': searchDuration.inMilliseconds,
      'filters': filters,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Export search history
  static List<Map<String, dynamic>> exportSearchHistory(
    List<Map<String, dynamic>> history,
  ) {
    return history.map((entry) => {
      'query': entry['query'],
      'timestamp': entry['timestamp'],
      'resultCount': entry['resultCount'],
      'selectedItem': entry['selectedItem'],
    }).toList();
  }

  /// Import search history
  static List<Map<String, dynamic>> importSearchHistory(
    List<Map<String, dynamic>> data,
  ) {
    return data.map((entry) => {
      'query': entry['query'] ?? '',
      'timestamp': entry['timestamp'] ?? DateTime.now().toIso8601String(),
      'resultCount': entry['resultCount'] ?? 0,
      'selectedItem': entry['selectedItem'],
    }).toList();
  }
}