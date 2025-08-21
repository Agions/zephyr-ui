/// Zephyr Rich Editor Formats Configuration
/// 
/// Defines the available formatting options for the rich text editor
class ZephyrRichEditorFormats {
  /// Bold formatting
  static const String bold = 'bold';
  
  /// Italic formatting
  static const String italic = 'italic';
  
  /// Underline formatting
  static const String underline = 'underline';
  
  /// Strikethrough formatting
  static const String strikethrough = 'strikethrough';
  
  /// Header formatting
  static const String header = 'header';
  
  /// Size formatting
  static const String size = 'size';
  
  /// Color formatting
  static const String color = 'color';
  
  /// Background color formatting
  static const String background = 'background';
  
  /// Alignment formatting
  static const String align = 'align';
  
  /// List formatting
  static const String list = 'list';
  
  /// Block quote formatting
  static const String blockQuote = 'blockquote';
  
  /// Code block formatting
  static const String codeBlock = 'code-block';
  
  /// Inline code formatting
  static const String inlineCode = 'code';
  
  /// Link formatting
  static const String link = 'link';
  
  /// Image formatting
  static const String image = 'image';
  
  /// Video formatting
  static const String video = 'video';
  
  /// Clean formatting
  static const String clean = 'clean';
  
  /// Undo operation
  static const String undo = 'undo';
  
  /// Redo operation
  static const String redo = 'redo';
  
  /// Header levels
  static const List<String> headerLevels = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'];
  
  /// Text sizes
  static const List<String> textSizes = ['small', 'normal', 'large', 'huge'];
  
  /// Text alignments
  static const List<String> alignments = ['left', 'center', 'right', 'justify'];
  
  /// List types
  static const List<String> listTypes = ['ordered', 'bullet'];
  
  /// Standard formats that are commonly used
  static const List<String> standardFormats = [
    bold,
    italic,
    underline,
    strikethrough,
  ];
  
  /// Advanced formats for more complex styling
  static const List<String> advancedFormats = [
    header,
    size,
    color,
    background,
    align,
    list,
    blockQuote,
    codeBlock,
    inlineCode,
    link,
    image,
    video,
  ];
  
  /// All available formats
  static const List<String> allFormats = [
    ...standardFormats,
    ...advancedFormats,
  ];
  
  /// Toolbar formats grouped by category
  static const Map<String, List<String>> toolbarGroups = {
    'basic': [bold, italic, underline, strikethrough],
    'header': [header],
    'text': [size, color, background],
    'alignment': [align],
    'list': [list],
    'insert': [link, image, video],
    'format': [blockQuote, codeBlock, inlineCode],
    'history': [undo, redo],
    'utility': [clean],
  };
}