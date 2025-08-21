import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart' as delta;
import 'rich_editor_theme.dart';
import 'rich_editor_toolbar.dart';
import 'rich_editor_utils.dart';
import 'rich_editor_formats.dart';

/// Zephyr Rich Editor Component
/// 
/// A powerful rich text editor component with comprehensive formatting options,
/// toolbar functionality, and content management capabilities.
/// 
/// Features:
/// - Rich text formatting (bold, italic, underline, etc.)
/// - Headers and text sizing
/// - Color and background color customization
/// - Lists and alignment options
/// - Links, images, and video embedding
/// - Code blocks and quotes
/// - Undo/redo functionality
/// - HTML import/export
/// - Customizable toolbar
/// - Theme support
/// 
/// Example usage:
/// ```dart
/// ZephyrRichEditor(
///   controller: _controller,
///   theme: ZephyrRichEditorTheme.light(),
///   placeholder: '开始输入内容...',
///   minHeight: 200,
///   maxHeight: 400,
///   showToolbar: true,
///   onChanged: (delta) {
///     print('Content changed: ${delta.toJson()}');
///   },
/// )
/// ```
class ZephyrRichEditor extends StatefulWidget {
  /// The Quill controller for the editor
  final quill.QuillController controller;
  
  /// The theme for the editor
  final ZephyrRichEditorTheme theme;
  
  /// The placeholder text
  final String placeholder;
  
  /// The minimum height of the editor
  final double minHeight;
  
  /// The maximum height of the editor
  final double? maxHeight;
  
  /// Whether to show the toolbar
  final bool showToolbar;
  
  /// The available toolbar buttons
  final List<String> toolbarButtons;
  
  /// Whether to show line numbers
  final bool showLineNumbers;
  
  /// Whether to show character count
  final bool showCharacterCount;
  
  /// Whether to show word count
  final bool showWordCount;
  
  /// Whether to enable auto focus
  final bool autoFocus;
  
  /// Whether to enable read-only mode
  final bool readOnly;
  
  /// Whether to enable spell check
  final bool enableSpellCheck;
  
  /// Whether to enable suggestions
  final bool enableSuggestions;
  
  /// The padding of the editor content
  final EdgeInsetsGeometry padding;
  
  /// The callback for when the content changes
  final Function(delta.Delta)? onChanged;
  
  /// The callback for when the editor is focused
  final Function()? onFocus;
  
  /// The callback for when the editor loses focus
  final Function()? onBlur;
  
  /// The callback for when a toolbar button is pressed
  final Function(String)? onToolbarButtonPressed;
  
  /// The callback for when a link is tapped
  final Function(String)? onLinkTap;
  
  /// The callback for when an image is tapped
  final Function(String)? onImageTap;
  
  /// Creates a rich editor
  const ZephyrRichEditor({
    Key? key,
    required this.controller,
    this.theme = const ZephyrRichEditorTheme.light(),
    this.placeholder = '开始输入内容...',
    this.minHeight = 200,
    this.maxHeight,
    this.showToolbar = true,
    this.toolbarButtons = ZephyrRichEditorFormats.allFormats,
    this.showLineNumbers = false,
    this.showCharacterCount = false,
    this.showWordCount = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.enableSpellCheck = true,
    this.enableSuggestions = true,
    this.padding = const EdgeInsets.all(16),
    this.onChanged,
    this.onFocus,
    this.onBlur,
    this.onToolbarButtonPressed,
    this.onLinkTap,
    this.onImageTap,
  }) : super(key: key);

  @override
  State<ZephyrRichEditor> createState() => _ZephyrRichEditorState();
}

class _ZephyrRichEditorState extends State<ZephyrRichEditor> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  
  @override
  void initState() {
    super.initState();
    
    if (widget.autoFocus) {
      _focusNode.requestFocus();
    }
    
    _focusNode.addListener(_handleFocusChange);
    widget.controller.changes.listen(_handleContentChange as void Function(quill.DocChange event)?);
  }
  
  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
  
  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
    
    if (_hasFocus) {
      widget.onFocus?.call();
    } else {
      widget.onBlur?.call();
    }
  }
  
  void _handleContentChange(List<quill.DocChange> changes) {
    widget.onChanged?.call(widget.controller.document.toDelta());
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        border: Border.all(
          color: widget.theme.borderColor,
          width: widget.theme.borderWidth,
        ),
        borderRadius: widget.theme.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showToolbar)
            ZephyrRichEditorToolbar(
              controller: widget.controller,
              theme: widget.theme,
              buttons: widget.toolbarButtons,
              onButtonPressed: widget.onToolbarButtonPressed,
            ),
          
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: widget.minHeight,
                maxHeight: widget.maxHeight ?? double.infinity,
              ),
              child: Stack(
                children: [
                  _buildEditor(),
                  if (_shouldShowPlaceholder())
                    _buildPlaceholder(),
                ],
              ),
            ),
          ),
          
          if (widget.showCharacterCount || widget.showWordCount)
            _buildStatusBar(),
        ],
      ),
    );
  }
  
  Widget _buildEditor() {
    return Container(
      padding: widget.padding,
      child: quill.QuillEditor.basic(
        controller: widget.controller,
        focusNode: _focusNode,
        scrollController: ScrollController(),
        configurations: quill.QuillEditorConfigurations(
          padding: EdgeInsets.zero,
          autoFocus: widget.autoFocus,
          expands: true,
          scrollable: true,
          placeholder: widget.placeholder,
          customStyles: quill.DefaultStyles(
            paragraph: quill.DefaultTextBlockStyle(
              widget.theme.bodyStyle,
              const quill.VerticalSpacing(8, 8) as quill.HorizontalSpacing,
              const quill.VerticalSpacing(0, 0),
              const quill.VerticalSpacing(0, 0),
              null,
            ),
            h1: quill.DefaultTextBlockStyle(
              widget.theme.headerStyle,
              const quill.VerticalSpacing(16, 8) as quill.HorizontalSpacing,
              const quill.VerticalSpacing(0, 0),
              const quill.VerticalSpacing(0, 0),
              null,
            ),
            h2: quill.DefaultTextBlockStyle(
              widget.theme.headerStyle.copyWith(fontSize: 20),
              const quill.VerticalSpacing(14, 6) as quill.HorizontalSpacing,
              const quill.VerticalSpacing(0, 0),
              const quill.VerticalSpacing(0, 0),
              null,
            ),
            h3: quill.DefaultTextBlockStyle(
              widget.theme.headerStyle.copyWith(fontSize: 18),
              const quill.VerticalSpacing(12, 4) as quill.HorizontalSpacing,
              const quill.VerticalSpacing(0, 0),
              const quill.VerticalSpacing(0, 0),
              null,
            ),
            code: quill.DefaultTextBlockStyle(
              widget.theme.codeStyle,
              const quill.VerticalSpacing(8, 8) as quill.HorizontalSpacing,
              const quill.VerticalSpacing(0, 0),
              const quill.VerticalSpacing(0, 0),
              BoxDecoration(
                color: widget.theme.codeBlockBackgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            quote: quill.DefaultTextBlockStyle(
              widget.theme.quoteStyle,
              const quill.VerticalSpacing(8, 8) as quill.HorizontalSpacing,
              const quill.VerticalSpacing(0, 0),
              const quill.VerticalSpacing(0, 0),
              BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: widget.theme.quoteBorderColor,
                    width: 4,
                  ),
                ),
                color: widget.theme.quoteBackgroundColor,
              ),
            ),
            link: widget.theme.bodyStyle.copyWith(
              color: widget.theme.linkColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildPlaceholder() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          padding: widget.padding,
          alignment: Alignment.topLeft,
          child: Text(
            widget.placeholder,
            style: widget.theme.placeholderStyle,
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatusBar() {
    final delta = widget.controller.document.toDelta();
    final characterCount = ZephyrRichEditorUtils.getCharacterCount(delta);
    final wordCount = ZephyrRichEditorUtils.getWordCount(delta);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: widget.theme.toolbarBackgroundColor,
        border: Border(
          top: BorderSide(
            color: widget.theme.toolbarBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (widget.showCharacterCount)
            Text(
              '字符: $characterCount',
              style: TextStyle(
                fontSize: 12,
                color: widget.theme.placeholderColor,
              ),
            ),
          if (widget.showCharacterCount && widget.showWordCount)
            const SizedBox(width: 16),
          if (widget.showWordCount)
            Text(
              '单词: $wordCount',
              style: TextStyle(
                fontSize: 12,
                color: widget.theme.placeholderColor,
              ),
            ),
        ],
      ),
    );
  }
  
  bool _shouldShowPlaceholder() {
    return widget.controller.document.toDelta().isEmpty && !_hasFocus;
  }
  
  /// Gets the current content as plain text
  String get plainText {
    return ZephyrRichEditorUtils.deltaToPlainText(widget.controller.document.toDelta());
  }
  
  /// Gets the current content as HTML
  String get html {
    return ZephyrRichEditorUtils.deltaToHtml(widget.controller.document.toDelta());
  }
  
  /// Gets the current content as JSON
  String get json {
    return ZephyrRichEditorUtils.deltaToJson(widget.controller.document.toDelta());
  }
  
  /// Gets the word count
  int get wordCount {
    return ZephyrRichEditorUtils.getWordCount(widget.controller.document.toDelta());
  }
  
  /// Gets the character count
  int get characterCount {
    return ZephyrRichEditorUtils.getCharacterCount(widget.controller.document.toDelta());
  }
  
  /// Sets the content from plain text
  void setPlainText(String text) {
    final delta = ZephyrRichEditorUtils.plainTextToDelta(text);
    widget.controller.document = quill.Document.fromDelta(delta);
  }
  
  /// Sets the content from HTML
  void setHtml(String html) {
    final delta = ZephyrRichEditorUtils.htmlToDelta(html);
    widget.controller.document = quill.Document.fromDelta(delta);
  }
  
  /// Sets the content from JSON
  void setJson(String jsonString) {
    final delta = ZephyrRichEditorUtils.jsonToDelta(jsonString);
    widget.controller.document = quill.Document.fromDelta(delta);
  }
  
  /// Clears the editor content
  void clear() {
    widget.controller.document = quill.Document();
  }
  
  /// Focuses the editor
  void focus() {
    _focusNode.requestFocus();
  }
  
  /// Unfocuses the editor
  void unfocus() {
    _focusNode.unfocus();
  }
  
  /// Inserts text at the current cursor position
  void insertText(String text) {
    widget.controller.document.insert(widget.controller.selection.baseOffset, text);
  }
  
  /// Inserts a link at the current cursor position
  void insertLink(String text, String url) {
    widget.controller.document.insert(
      widget.controller.selection.baseOffset,
      text,
    );
    widget.controller.formatSelection(const quill.StyleAttribute('link'));
  }
  
  /// Inserts an image at the current cursor position
  void insertImage(String imageUrl) {
    widget.controller.document.insert(
      widget.controller.selection.baseOffset,
      {'image': imageUrl},
    );
  }
  
  /// Inserts a video at the current cursor position
  void insertVideo(String videoUrl) {
    widget.controller.document.insert(
      widget.controller.selection.baseOffset,
      {'video': videoUrl},
    );
  }
}