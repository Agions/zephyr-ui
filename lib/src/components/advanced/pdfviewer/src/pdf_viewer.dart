import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pdf_viewer_theme.dart';
import 'pdf_viewer_utils.dart';

/// PDF Viewer Component
/// 
/// A comprehensive PDF viewer component with navigation,
/// zoom controls, and annotation features for enterprise applications.
/// 
/// Features:
/// - PDF document rendering
/// - Page navigation
/// - Zoom controls
/// - Search functionality
/// - Table of contents
/// - Annotations support
/// - Export options
/// - Dark mode support
/// 
/// Example usage:
/// ```dart
/// ZephyrPDFViewer(
///   filePath: 'path/to/document.pdf',
///   theme: ZephyrPDFViewerTheme.light(),
///   onPageChanged: (page) {
///     print('Current page: $page');
///   },
/// )
/// ```
class ZephyrPDFViewer extends StatefulWidget {
  /// The path to the PDF file
  final String filePath;
  
  /// The initial page number (1-based)
  final int initialPage;
  
  /// Whether to show the page navigation controls
  final bool showPageNavigation;
  
  /// Whether to show the zoom controls
  final bool showZoomControls;
  
  /// Whether to show the search controls
  final bool showSearchControls;
  
  /// Whether to show the table of contents
  final bool showTableOfContents;
  
  /// Whether to enable annotations
  final bool enableAnnotations;
  
  /// Whether to enable text selection
  final bool enableTextSelection;
  
  /// Whether to enable zoom
  final bool enableZoom;
  
  /// The zoom levels
  final List<double> zoomLevels;
  
  /// The page spacing
  final double pageSpacing;
  
  /// The theme
  final ZephyrPDFViewerTheme? theme;
  
  /// The callback for when the page changes
  final Function(int)? onPageChanged;
  
  /// The callback for when the zoom level changes
  final Function(double)? onZoomChanged;
  
  /// The callback for when the PDF is loaded
  final Function(int)? onPdfLoaded;
  
  /// The callback for when an error occurs
  final Function(String)? onError;
  
  /// The semantic label for accessibility
  final String? semanticLabel;

  const ZephyrPDFViewer({
    Key? key,
    required this.filePath,
    this.initialPage = 1,
    this.showPageNavigation = true,
    this.showZoomControls = true,
    this.showSearchControls = true,
    this.showTableOfContents = true,
    this.enableAnnotations = false,
    this.enableTextSelection = true,
    this.enableZoom = true,
    this.zoomLevels = const [0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 3.0],
    this.pageSpacing = 16,
    this.theme,
    this.onPageChanged,
    this.onZoomChanged,
    this.onPdfLoaded,
    this.onError,
    this.semanticLabel,
  }) : super(key: key);

  @override
  State<ZephyrPDFViewer> createState() => _ZephyrPDFViewerState();
}

class _ZephyrPDFViewerState extends State<ZephyrPDFViewer> {
  late ZephyrPDFViewerTheme _theme;
  int _currentPage = 1;
  int _totalPages = 0;
  double _currentZoom = 1.0;
  int _currentZoomIndex = 2; // Index of 1.0 in default zoomLevels
  bool _isLoading = true;
  String? _errorMessage;
  bool _isSearchVisible = false;
  String _searchQuery = '';
  List<int> _searchResults = [];
  int _currentSearchResult = 0;
  
  // Mock PDF data - in real implementation, this would use pdf rendering library
  final List<String> _pdfPages = [];
  final List<Map<String, dynamic>> _tableOfContents = [];

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrPDFViewerTheme.light();
    _currentPage = widget.initialPage;
    _loadPdf();
  }

  @override
  void didUpdateWidget(ZephyrPDFViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrPDFViewerTheme.light();
    }
  }

  Future<void> _loadPdf() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Mock PDF loading - in real implementation, this would:
      // 1. Use pdf rendering library to load the PDF
      // 2. Extract page count and metadata
      // 3. Parse table of contents
      
      // Simulate loading delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      _totalPages = 10;
      _pdfPages.clear();
      _tableOfContents.clear();
      
      for (int i = 1; i <= _totalPages; i++) {
        _pdfPages.add('Page $i content');
      }
      
      // Mock table of contents
      _tableOfContents.addAll([
        {'title': 'Introduction', 'page': 1},
        {'title': 'Chapter 1', 'page': 2},
        {'title': 'Chapter 2', 'page': 4},
        {'title': 'Chapter 3', 'page': 6},
        {'title': 'Conclusion', 'page': 8},
        {'title': 'Appendix', 'page': 9},
      ]);
      
      setState(() {
        _isLoading = false;
        _totalPages = _totalPages;
      });
      
      widget.onPdfLoaded?.call(_totalPages);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load PDF: $e';
      });
      
      widget.onError?.call(_errorMessage!);
    }
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages) return;
    
    setState(() {
      _currentPage = page;
    });
    
    widget.onPageChanged?.call(_currentPage);
  }

  void _previousPage() {
    if (_currentPage > 1) {
      _goToPage(_currentPage - 1);
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages) {
      _goToPage(_currentPage + 1);
    }
  }

  void _zoomIn() {
    if (_currentZoomIndex < widget.zoomLevels.length - 1) {
      _currentZoomIndex++;
      _currentZoom = widget.zoomLevels[_currentZoomIndex];
      widget.onZoomChanged?.call(_currentZoom);
    }
  }

  void _zoomOut() {
    if (_currentZoomIndex > 0) {
      _currentZoomIndex--;
      _currentZoom = widget.zoomLevels[_currentZoomIndex];
      widget.onZoomChanged?.call(_currentZoom);
    }
  }

  void _setZoomLevel(int index) {
    if (index >= 0 && index < widget.zoomLevels.length) {
      _currentZoomIndex = index;
      _currentZoom = widget.zoomLevels[index];
      widget.onZoomChanged?.call(_currentZoom);
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchQuery = '';
        _searchResults.clear();
        _currentSearchResult = 0;
      }
    });
  }

  void _performSearch() {
    if (_searchQuery.isEmpty) {
      setState(() {
        _searchResults.clear();
        _currentSearchResult = 0;
      });
      return;
    }
    
    // Mock search implementation
    setState(() {
      _searchResults = [1, 3, 5, 7, 9]; // Mock results
      _currentSearchResult = 0;
    });
    
    if (_searchResults.isNotEmpty) {
      _goToSearchResult(0);
    }
  }

  void _goToSearchResult(int index) {
    if (index >= 0 && index < _searchResults.length) {
      _currentSearchResult = index;
      _goToPage(_searchResults[index]);
    }
  }

  void _nextSearchResult() {
    if (_searchResults.isEmpty) return;
    _currentSearchResult = (_currentSearchResult + 1) % _searchResults.length;
    _goToSearchResult(_currentSearchResult);
  }

  void _previousSearchResult() {
    if (_searchResults.isEmpty) return;
    _currentSearchResult = (_currentSearchResult - 1) % _searchResults.length;
    _goToSearchResult(_currentSearchResult);
  }

  Widget _buildPdfContent() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(_theme.primaryColor),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading PDF...',
              style: TextStyle(
                color: _theme.textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: _theme.errorColor,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: TextStyle(
                color: _theme.errorColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPdf,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Search bar
        if (_isSearchVisible) _buildSearchBar(),
        
        // PDF content
        Expanded(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 800 * _currentZoom,
                maxHeight: 1000 * _currentZoom,
              ),
              child: Card(
                elevation: 4,
                color: _theme.pageBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Page $_currentPage of $_totalPages',
                        style: TextStyle(
                          fontSize: 14 * _currentZoom,
                          color: _theme.textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Center(
                          child: Text(
                            _pdfPages[_currentPage - 1],
                            style: TextStyle(
                              fontSize: 16 * _currentZoom,
                              color: _theme.textColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _theme.searchBarBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: _theme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search in document...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  onSubmitted: (_) => _performSearch(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _performSearch,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: _toggleSearch,
              ),
            ],
          ),
          if (_searchResults.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${_currentSearchResult + 1} of ${_searchResults.length} results',
                  style: TextStyle(
                    color: _theme.textColor,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: _previousSearchResult,
                  iconSize: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: _nextSearchResult,
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _theme.controlBarBackgroundColor,
        border: Border(
          top: BorderSide(
            color: _theme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Page navigation
          if (widget.showPageNavigation) _buildPageNavigation(),
          
          const SizedBox(height: 8),
          
          // Zoom controls
          if (widget.showZoomControls) _buildZoomControls(),
          
          const SizedBox(height: 8),
          
          // Action buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPageNavigation() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.first_page),
          onPressed: _currentPage > 1 ? () => _goToPage(1) : null,
          tooltip: 'First page',
        ),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _currentPage > 1 ? _previousPage : null,
          tooltip: 'Previous page',
        ),
        Expanded(
          child: Center(
            child: Text(
              'Page $_currentPage of $_totalPages',
              style: TextStyle(
                color: _theme.textColor,
                fontSize: 14,
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _currentPage < _totalPages ? _nextPage : null,
          tooltip: 'Next page',
        ),
        IconButton(
          icon: const Icon(Icons.last_page),
          onPressed: _currentPage < _totalPages ? () => _goToPage(_totalPages) : null,
          tooltip: 'Last page',
        ),
      ],
    );
  }

  Widget _buildZoomControls() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.zoom_out),
          onPressed: _currentZoomIndex > 0 ? _zoomOut : null,
          tooltip: 'Zoom out',
        ),
        Expanded(
          child: Center(
            child: DropdownButton<int>(
              value: _currentZoomIndex,
              items: widget.zoomLevels.asMap().entries.map((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text('${(entry.value * 100).round()}%'),
                );
              }).toList(),
              onChanged: (index) {
                if (index != null) {
                  _setZoomLevel(index);
                }
              },
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.zoom_in),
          onPressed: _currentZoomIndex < widget.zoomLevels.length - 1 ? _zoomIn : null,
          tooltip: 'Zoom in',
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (widget.showSearchControls)
          IconButton(
            icon: Icon(_isSearchVisible ? Icons.search_off : Icons.search),
            onPressed: _toggleSearch,
            tooltip: 'Search',
          ),
        if (widget.showTableOfContents)
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: _showTableOfContents,
            tooltip: 'Table of contents',
          ),
        IconButton(
          icon: const Icon(Icons.download),
          onPressed: _exportPdf,
          tooltip: 'Export',
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: _sharePdf,
          tooltip: 'Share',
        ),
      ],
    );
  }

  void _showTableOfContents() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _theme.modalBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Table of Contents',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _theme.textColor,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _tableOfContents.length,
                  itemBuilder: (context, index) {
                    final item = _tableOfContents[index];
                    return ListTile(
                      title: Text(
                        item['title'],
                        style: TextStyle(
                          color: _theme.textColor,
                        ),
                      ),
                      trailing: Text(
                        'Page ${item['page']}',
                        style: TextStyle(
                          color: _theme.secondaryTextColor,
                        ),
                      ),
                      onTap: () {
                        _goToPage(item['page']);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _exportPdf() {
    // Mock export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('PDF export functionality would be implemented here'),
        backgroundColor: _theme.successColor,
      ),
    );
  }

  void _sharePdf() {
    // Mock share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('PDF share functionality would be implemented here'),
        backgroundColor: _theme.successColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? 'PDF viewer',
      child: Column(
        children: [
          Expanded(
            child: _buildPdfContent(),
          ),
          _buildControlBar(),
        ],
      ),
    );
  }
}