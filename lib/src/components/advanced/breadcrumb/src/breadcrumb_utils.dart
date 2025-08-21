import 'package:flutter/material.dart';

/// Breadcrumb utility functions
/// 
/// Provides helper functions for breadcrumb manipulation and navigation
class ZephyrBreadcrumbUtils {
  /// Generate breadcrumb items from route path
  static List<Map<String, dynamic>> generateFromPath(String path, {String? homeLabel = 'Home'}) {
    final items = <Map<String, dynamic>>[];
    final segments = path.split('/').where((segment) => segment.isNotEmpty).toList();
    
    // Add home item
    items.add({
      'title': homeLabel,
      'route': '/',
      'icon': Icons.home,
    });
    
    // Add path segments
    String currentPath = '';
    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      currentPath += '/$segment';
      
      final isLast = i == segments.length - 1;
      items.add({
        'title': _formatSegmentTitle(segment),
        'route': currentPath,
        'isCurrent': isLast,
        'icon': _getSegmentIcon(segment, isLast),
      });
    }
    
    return items;
  }

  /// Format segment title for display
  static String _formatSegmentTitle(String segment) {
    // Convert kebab-case or snake_case to Title Case
    final formatted = segment
        .replaceAll('-', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
    
    return formatted;
  }

  /// Get appropriate icon for segment
  static IconData _getSegmentIcon(String segment, bool isCurrent) {
    final lowerSegment = segment.toLowerCase();
    
    if (lowerSegment.contains('dashboard') || lowerSegment.contains('home')) {
      return Icons.dashboard;
    } else if (lowerSegment.contains('user') || lowerSegment.contains('profile')) {
      return Icons.person;
    } else if (lowerSegment.contains('setting') || lowerSegment.contains('config')) {
      return Icons.settings;
    } else if (lowerSegment.contains('product') || lowerSegment.contains('item')) {
      return Icons.inventory_2;
    } else if (lowerSegment.contains('order') || lowerSegment.contains('purchase')) {
      return Icons.shopping_cart;
    } else if (lowerSegment.contains('report') || lowerSegment.contains('analytics')) {
      return Icons.analytics;
    } else if (lowerSegment.contains('message') || lowerSegment.contains('chat')) {
      return Icons.message;
    } else if (lowerSegment.contains('notification')) {
      return Icons.notifications;
    } else if (lowerSegment.contains('file') || lowerSegment.contains('document')) {
      return Icons.file_present;
    } else if (lowerSegment.contains('image') || lowerSegment.contains('photo')) {
      return Icons.image;
    } else if (lowerSegment.contains('video')) {
      return Icons.video_library;
    } else if (lowerSegment.contains('audio') || lowerSegment.contains('music')) {
      return Icons.music_note;
    } else if (lowerSegment.contains('folder') || lowerSegment.contains('directory')) {
      return Icons.folder;
    } else if (lowerSegment.contains('search') || lowerSegment.contains('find')) {
      return Icons.search;
    } else if (lowerSegment.contains('help') || lowerSegment.contains('support')) {
      return Icons.help;
    } else if (lowerSegment.contains('info') || lowerSegment.contains('about')) {
      return Icons.info;
    } else if (lowerSegment.contains('security') || lowerSegment.contains('auth')) {
      return Icons.security;
    } else if (lowerSegment.contains('payment') || lowerSegment.contains('billing')) {
      return Icons.payment;
    } else if (lowerSegment.contains('shipping') || lowerSegment.contains('delivery')) {
      return Icons.local_shipping;
    } else if (lowerSegment.contains('return') || lowerSegment.contains('refund')) {
      return Icons.assignment_return;
    } else if (lowerSegment.contains('review') || lowerSegment.contains('rating')) {
      return Icons.star;
    } else if (lowerSegment.contains('category') || lowerSegment.contains('tag')) {
      return Icons.category;
    } else if (lowerSegment.contains('brand') || lowerSegment.contains('manufacturer')) {
      return Icons.branding_watermark;
    } else if (lowerSegment.contains('color') || lowerSegment.contains('variant')) {
      return Icons.palette;
    } else if (lowerSegment.contains('size') || lowerSegment.contains('dimension')) {
      return Icons.straighten;
    } else if (lowerSegment.contains('price') || lowerSegment.contains('cost')) {
      return Icons.attach_money;
    } else if (lowerSegment.contains('quantity') || lowerSegment.contains('amount')) {
      return Icons.exposure_plus_1;
    } else if (lowerSegment.contains('date') || lowerSegment.contains('time')) {
      return Icons.calendar_today;
    } else if (lowerSegment.contains('location') || lowerSegment.contains('address')) {
      return Icons.location_on;
    } else if (lowerSegment.contains('contact') || lowerSegment.contains('email')) {
      return Icons.contact_mail;
    } else if (lowerSegment.contains('social') || lowerSegment.contains('share')) {
      return Icons.share;
    } else if (lowerSegment.contains('blog') || lowerSegment.contains('article')) {
      return Icons.article;
    } else if (lowerSegment.contains('comment') || lowerSegment.contains('review')) {
      return Icons.comment;
    } else if (lowerSegment.contains('like') || lowerSegment.contains('favorite')) {
      return Icons.favorite;
    } else if (lowerSegment.contains('download') || lowerSegment.contains('export')) {
      return Icons.download;
    } else if (lowerSegment.contains('upload') || lowerSegment.contains('import')) {
      return Icons.upload;
    } else if (lowerSegment.contains('print')) {
      return Icons.print;
    } else if (lowerSegment.contains('edit') || lowerSegment.contains('modify')) {
      return Icons.edit;
    } else if (lowerSegment.contains('delete') || lowerSegment.contains('remove')) {
      return Icons.delete;
    } else if (lowerSegment.contains('add') || lowerSegment.contains('create')) {
      return Icons.add;
    } else if (lowerSegment.contains('save')) {
      return Icons.save;
    } else if (lowerSegment.contains('cancel')) {
      return Icons.cancel;
    } else if (lowerSegment.contains('submit') || lowerSegment.contains('send')) {
      return Icons.send;
    } else if (lowerSegment.contains('refresh') || lowerSegment.contains('reload')) {
      return Icons.refresh;
    } else if (lowerSegment.contains('filter')) {
      return Icons.filter_list;
    } else if (lowerSegment.contains('sort')) {
      return Icons.sort;
    } else if (lowerSegment.contains('view') || lowerSegment.contains('display')) {
      return Icons.visibility;
    } else if (lowerSegment.contains('hide') || lowerSegment.contains('invisible')) {
      return Icons.visibility_off;
    } else if (lowerSegment.contains('lock') || lowerSegment.contains('secure')) {
      return Icons.lock;
    } else if (lowerSegment.contains('unlock') || lowerSegment.contains('open')) {
      return Icons.lock_open;
    } else if (lowerSegment.contains('backup') || lowerSegment.contains('restore')) {
      return Icons.backup;
    } else if (lowerSegment.contains('sync') || lowerSegment.contains('update')) {
      return Icons.sync;
    } else if (lowerSegment.contains('warning') || lowerSegment.contains('alert')) {
      return Icons.warning;
    } else if (lowerSegment.contains('error') || lowerSegment.contains('problem')) {
      return Icons.error;
    } else if (lowerSegment.contains('success') || lowerSegment.contains('complete')) {
      return Icons.check_circle;
    } else if (lowerSegment.contains('pending') || lowerSegment.contains('waiting')) {
      return Icons.hourglass_empty;
    } else if (lowerSegment.contains('progress') || lowerSegment.contains('loading')) {
      return Icons.hourglass_bottom;
    } else {
      return isCurrent ? Icons.label : Icons.label_outline;
    }
  }

  /// Truncate breadcrumb items when they exceed maximum length
  static List<Map<String, dynamic>> truncateItems(
    List<Map<String, dynamic>> items, {
    int maxItems = 5,
    String truncatedLabel = '...',
  }) {
    if (items.length <= maxItems) {
      return items;
    }

    final result = <Map<String, dynamic>>[];
    
    // Always show first item
    result.add(items.first);
    
    // Add truncated item
    result.add({
      'title': truncatedLabel,
      'isTruncated': true,
    });
    
    // Show last maxItems - 2 items
    final startIndex = items.length - (maxItems - 2);
    result.addAll(items.sublist(startIndex.clamp(0, items.length), items.length));
    
    return result;
  }

  /// Calculate optimal breadcrumb width based on content
  static double calculateOptimalWidth(
    List<Map<String, dynamic>> items, {
    double itemPadding = 16.0,
    double separatorWidth = 24.0,
    double iconWidth = 20.0,
    double averageCharWidth = 8.0,
    double maxWidth = double.infinity,
  }) {
    double totalWidth = 0;
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final title = item['title'] as String;
      
      // Calculate item width
      double itemWidth = itemPadding * 2; // Padding
      itemWidth += iconWidth; // Icon
      itemWidth += title.length * averageCharWidth; // Text
      
      totalWidth += itemWidth;
      
      // Add separator width (except for last item)
      if (i < items.length - 1) {
        totalWidth += separatorWidth;
      }
      
      // Stop if we exceed max width
      if (totalWidth > maxWidth) {
        break;
      }
    }
    
    return totalWidth.clamp(0, maxWidth);
  }

  /// Generate breadcrumb items from nested structure
  static List<Map<String, dynamic>> generateFromStructure(
    Map<String, dynamic> structure, {
    String? currentPath,
    List<Map<String, dynamic>>? accumulated,
  }) {
    final items = accumulated ?? <Map<String, dynamic>>[];
    final path = currentPath ?? '/';
    
    // Add current item
    items.add({
      'title': structure['title'] ?? 'Untitled',
      'route': path,
      'icon': structure['icon'],
      'isCurrent': structure['isCurrent'] ?? false,
    });
    
    // Process children
    if (structure['children'] != null) {
      final children = structure['children'] as List;
      for (final child in children) {
        final childPath = path == '/' ? '/${child['route']}' : '$path/${child['route']}';
        generateFromStructure(
          child,
          currentPath: childPath,
          accumulated: items,
        );
      }
    }
    
    return items;
  }

  /// Validate breadcrumb items
  static bool validateItems(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return false;
    }
    
    // Check if at least one item is marked as current
    final hasCurrent = items.any((item) => item['isCurrent'] == true);
    
    // Check if only one item is marked as current
    final currentCount = items.where((item) => item['isCurrent'] == true).length;
    
    // Check if all items have required fields
    final allValid = items.every((item) => 
      item['title'] != null && item['title'].toString().isNotEmpty
    );
    
    return hasCurrent && currentCount == 1 && allValid;
  }

  /// Get current item from breadcrumb items
  static Map<String, dynamic>? getCurrentItem(List<Map<String, dynamic>> items) {
    try {
      return items.firstWhere((item) => item['isCurrent'] == true);
    } catch (e) {
      return null;
    }
  }

  /// Get parent items (all items before current)
  static List<Map<String, dynamic>> getParentItems(List<Map<String, dynamic>> items) {
    final current = getCurrentItem(items);
    if (current == null) {
      return [];
    }
    
    final currentIndex = items.indexOf(current);
    return items.sublist(0, currentIndex);
  }

  /// Get sibling items (items at same level as current)
  static List<Map<String, dynamic>> getSiblingItems(List<Map<String, dynamic>> items) {
    final current = getCurrentItem(items);
    if (current == null) {
      return [];
    }
    
    final parentItems = getParentItems(items);
    
    if (parentItems.isEmpty) {
      return [];
    }
    
    // This is a simplified implementation
    // In a real app, you'd need to track the hierarchy level
    return [current];
  }

  /// Create breadcrumb trail from navigation stack
  static List<Map<String, dynamic>> createFromNavigationStack(
    List<Map<String, dynamic>> stack, {
    int maxDepth = 10,
  }) {
    final items = <Map<String, dynamic>>[];
    final effectiveStack = stack.take(maxDepth).toList();
    
    for (int i = 0; i < effectiveStack.length; i++) {
      final item = effectiveStack[i];
      final isLast = i == effectiveStack.length - 1;
      
      items.add({
        'title': item['title'] ?? 'Page ${i + 1}',
        'route': item['route'],
        'icon': item['icon'],
        'isCurrent': isLast,
      });
    }
    
    return items;
  }

  /// Generate SEO-friendly breadcrumb schema
  static Map<String, dynamic> generateSeoSchema(List<Map<String, dynamic>> items) {
    final itemList = <Map<String, dynamic>>[];
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final position = i + 1;
      
      itemList.add({
        '@type': 'ListItem',
        'position': position,
        'name': item['title'],
        'item': item['route'],
      });
    }
    
    return {
      '@context': 'https://schema.org',
      '@type': 'BreadcrumbList',
      'itemListElement': itemList,
    };
  }
}