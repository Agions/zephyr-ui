import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'rich_editor_theme.dart';
import 'rich_editor_formats.dart';

/// Zephyr Rich Editor Toolbar
/// 
/// A customizable toolbar for the rich text editor with support for
/// various formatting options and actions.
class ZephyrRichEditorToolbar extends StatelessWidget {
  /// The Quill controller
  final quill.QuillController controller;
  
  /// The theme for the toolbar
  final ZephyrRichEditorTheme theme;
  
  /// The available toolbar buttons
  final List<String> buttons;
  
  /// Whether to show the toolbar
  final bool showToolbar;
  
  /// Whether to show tooltips
  final bool showTooltips;
  
  /// The callback for when a button is pressed
  final Function(String)? onButtonPressed;
  
  /// Creates a rich editor toolbar
  const ZephyrRichEditorToolbar({
    Key? key,
    required this.controller,
    required this.theme,
    this.buttons = ZephyrRichEditorFormats.allFormats,
    this.showToolbar = true,
    this.showTooltips = true,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showToolbar) return const SizedBox.shrink();
    
    return Container(
      decoration: BoxDecoration(
        color: theme.toolbarBackgroundColor,
        border: Border.all(
          color: theme.toolbarBorderColor,
          width: 1,
        ),
        borderRadius: theme.toolbarBorderRadius,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: _buildToolbarButtons(),
          ),
        ),
      ),
    );
  }
  
  /// Builds the toolbar buttons
  List<Widget> _buildToolbarButtons() {
    final buttonWidgets = <Widget>[];
    
    // Group buttons by category
    final groupedButtons = <String, List<String>>{};
    for (final button in buttons) {
      String category = 'basic';
      for (final entry in ZephyrRichEditorFormats.toolbarGroups.entries) {
        if (entry.value.contains(button)) {
          category = entry.key;
          break;
        }
      }
      groupedButtons.putIfAbsent(category, () => []).add(button);
    }
    
    // Build buttons for each category
    for (final category in groupedButtons.keys) {
      if (buttonWidgets.isNotEmpty) {
        buttonWidgets.add(const SizedBox(width: 8));
      }
      
      buttonWidgets.add(
        Row(
          children: groupedButtons[category]!
              .map((button) => _buildToolbarButton(button))
              .toList(),
        ),
      );
    }
    
    return buttonWidgets;
  }
  
  /// Builds a single toolbar button
  Widget _buildToolbarButton(String format) {
    IconData icon;
    
    switch (format) {
      case ZephyrRichEditorFormats.bold:
        icon = Icons.format_bold;
        break;
      case ZephyrRichEditorFormats.italic:
        icon = Icons.format_italic;
        break;
      case ZephyrRichEditorFormats.underline:
        icon = Icons.format_underlined;
        break;
      case ZephyrRichEditorFormats.strikethrough:
        icon = Icons.format_strikethrough;
        break;
      case ZephyrRichEditorFormats.header:
        icon = Icons.title;
        break;
      case ZephyrRichEditorFormats.size:
        icon = Icons.format_size;
        break;
      case ZephyrRichEditorFormats.color:
        icon = Icons.format_color_text;
        break;
      case ZephyrRichEditorFormats.background:
        icon = Icons.format_color_fill;
        break;
      case ZephyrRichEditorFormats.align:
        icon = Icons.format_align_left;
        break;
      case ZephyrRichEditorFormats.list:
        icon = Icons.format_list_bulleted;
        break;
      case ZephyrRichEditorFormats.blockQuote:
        icon = Icons.format_quote;
        break;
      case ZephyrRichEditorFormats.codeBlock:
        icon = Icons.code;
        break;
      case ZephyrRichEditorFormats.inlineCode:
        icon = Icons.code_off;
        break;
      case ZephyrRichEditorFormats.link:
        icon = Icons.link;
        break;
      case ZephyrRichEditorFormats.image:
        icon = Icons.image;
        break;
      case ZephyrRichEditorFormats.video:
        icon = Icons.videocam;
        break;
      case ZephyrRichEditorFormats.undo:
        icon = Icons.undo;
        break;
      case ZephyrRichEditorFormats.redo:
        icon = Icons.redo;
        break;
      case ZephyrRichEditorFormats.clean:
        icon = Icons.format_clear;
        break;
      default:
        icon = Icons.help_outline;
        break;
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () => _handleButtonPress(format),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getButtonBackgroundColor(format),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              icon,
              size: 20,
              color: theme.toolbarIconColor,
            ),
          ),
        ),
      ),
    );
  }
  
  /// Gets the background color for a button based on its state
  Color _getButtonBackgroundColor(String format) {
    final selection = controller.selection;
    if (selection.isCollapsed) return theme.toolbarButtonBackgroundColor;
    
    final style = controller.getSelectionStyle();
    
    switch (format) {
      case ZephyrRichEditorFormats.bold:
        return style.attributes[quill.Attribute.bold] != null
            ? theme.toolbarButtonActiveColor
            : theme.toolbarButtonBackgroundColor;
      case ZephyrRichEditorFormats.italic:
        return style.attributes[quill.Attribute.italic] != null
            ? theme.toolbarButtonActiveColor
            : theme.toolbarButtonBackgroundColor;
      case ZephyrRichEditorFormats.underline:
        return style.attributes[quill.Attribute.underline] != null
            ? theme.toolbarButtonActiveColor
            : theme.toolbarButtonBackgroundColor;
      case ZephyrRichEditorFormats.strikethrough:
        return style.attributes[quill.Attribute.strikeThrough] != null
            ? theme.toolbarButtonActiveColor
            : theme.toolbarButtonBackgroundColor;
      case ZephyrRichEditorFormats.codeBlock:
        return style.attributes[quill.Attribute.codeBlock] != null
            ? theme.toolbarButtonActiveColor
            : theme.toolbarButtonBackgroundColor;
      case ZephyrRichEditorFormats.blockQuote:
        return style.attributes[quill.Attribute.blockQuote] != null
            ? theme.toolbarButtonActiveColor
            : theme.toolbarButtonBackgroundColor;
      default:
        return theme.toolbarButtonBackgroundColor;
    }
  }
  
  /// Handles button press actions
  void _handleButtonPress(String format) {
    onButtonPressed?.call(format);
    
    switch (format) {
      case ZephyrRichEditorFormats.bold:
        _formatSelection(quill.Attribute.bold);
        break;
      case ZephyrRichEditorFormats.italic:
        _formatSelection(quill.Attribute.italic);
        break;
      case ZephyrRichEditorFormats.underline:
        _formatSelection(quill.Attribute.underline);
        break;
      case ZephyrRichEditorFormats.strikethrough:
        _formatSelection(quill.Attribute.strikeThrough);
        break;
      case ZephyrRichEditorFormats.codeBlock:
        _formatSelection(quill.Attribute.codeBlock);
        break;
      case ZephyrRichEditorFormats.blockQuote:
        _formatSelection(quill.Attribute.blockQuote);
        break;
      case ZephyrRichEditorFormats.undo:
        controller.undo();
        break;
      case ZephyrRichEditorFormats.redo:
        controller.redo();
        break;
      case ZephyrRichEditorFormats.clean:
        _clearFormat();
        break;
      case ZephyrRichEditorFormats.header:
        _showHeaderDialog();
        break;
      case ZephyrRichEditorFormats.size:
        _showSizeDialog();
        break;
      case ZephyrRichEditorFormats.color:
        _showColorDialog();
        break;
      case ZephyrRichEditorFormats.background:
        _showBackgroundColorDialog();
        break;
      case ZephyrRichEditorFormats.align:
        _showAlignDialog();
        break;
      case ZephyrRichEditorFormats.list:
        _showListDialog();
        break;
      case ZephyrRichEditorFormats.link:
        _showLinkDialog();
        break;
      case ZephyrRichEditorFormats.image:
        _showImageDialog();
        break;
      case ZephyrRichEditorFormats.video:
        _showVideoDialog();
        break;
    }
  }
  
  /// Formats the current selection with the given attribute
  void _formatSelection(quill.Attribute attribute) {
    controller.formatSelection(
      controller.getSelectionStyle().attributes[attribute.key] == null
          ? attribute
          : quill.Attribute.clone(attribute, null),
    );
  }
  
  /// Clears formatting from the current selection
  void _clearFormat() {
    final selection = controller.selection;
    if (selection.isCollapsed) return;
    
    controller.formatSelection(quill.Attribute.clone(
      quill.Attribute.header,
      null,
    ));
  }
  
  /// Shows header selection dialog
  void _showHeaderDialog() {
    // Implementation would show a dialog to select header level
    _formatSelection(quill.Attribute.header);
  }
  
  /// Shows text size selection dialog
  void _showSizeDialog() {
    // Implementation would show a dialog to select text size
    _formatSelection(quill.Attribute.size);
  }
  
  /// Shows color selection dialog
  void _showColorDialog() {
    // Implementation would show a color picker
    _formatSelection(quill.Attribute.color);
  }
  
  /// Shows background color selection dialog
  void _showBackgroundColorDialog() {
    // Implementation would show a color picker
    _formatSelection(quill.Attribute.background);
  }
  
  /// Shows alignment selection dialog
  void _showAlignDialog() {
    // Implementation would show alignment options
    _formatSelection(quill.Attribute.align);
  }
  
  /// Shows list selection dialog
  void _showListDialog() {
    // Implementation would show list options
    _formatSelection(quill.Attribute.list);
  }
  
  /// Shows link insertion dialog
  void _showLinkDialog() {
    // Implementation would show a dialog to insert a link
    _formatSelection(quill.Attribute.link);
  }
  
  /// Shows image insertion dialog
  void _showImageDialog() {
    // Implementation would show a dialog to insert an image
    controller.document.insert(controller.selection.baseOffset, {
      'insert': {'image': 'https://example.com/image.jpg'}
    });
  }
  
  /// Shows video insertion dialog
  void _showVideoDialog() {
    // Implementation would show a dialog to insert a video
    controller.document.insert(controller.selection.baseOffset, {
      'insert': {'video': 'https://example.com/video.mp4'}
    });
  }
}