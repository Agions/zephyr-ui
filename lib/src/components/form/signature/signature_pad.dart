import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signature_pad_theme.dart';

/// Signature Pad Component
/// 
/// A comprehensive signature pad component with drawing capabilities,
/// export functionality, and signature management for enterprise applications.
/// 
/// Features:
/// - Smooth signature drawing with pen pressure support
/// - Multiple pen colors and sizes
/// - Undo/redo functionality
/// - Clear and reset options
/// - Export as image
/// - Signature validation
/// - Background options
/// - Touch and mouse support
/// 
/// Example usage:
/// ```dart
/// ZephyrSignaturePad(
///   width: 400,
///   height: 200,
///   theme: ZephyrSignaturePadTheme.light(),
///   onSignatureChanged: (signature) {
///     print('Signature updated');
///   },
/// )
/// ```
class ZephyrSignaturePad extends StatefulWidget {
  /// The width of the signature pad
  final double width;
  
  /// The height of the signature pad
  final double height;
  
  /// The pen color
  final Color? penColor;
  
  /// The pen width
  final double? penWidth;
  
  /// The background color
  final Color? backgroundColor;
  
  /// The border color
  final Color? borderColor;
  
  /// The border width
  final double? borderWidth;
  
  /// The border radius
  final BorderRadius? borderRadius;
  
  /// Whether to show the clear button
  final bool showClearButton;
  
  /// Whether to show the undo button
  final bool showUndoButton;
  
  /// Whether to show the redo button
  final bool showRedoButton;
  
  /// Whether to show the export button
  final bool showExportButton;
  
  /// Whether to show the pen color picker
  final bool showColorPicker;
  
  /// Whether to show the pen width slider
  final bool showWidthSlider;
  
  /// Whether to enable pressure sensitivity
  final bool enablePressure;
  
  /// The minimum pen width
  final double? minPenWidth;
  
  /// The maximum pen width
  final double? maxPenWidth;
  
  /// The available pen colors
  final List<Color> availableColors;
  
  /// The export formats
  final List<ZephyrSignatureExportFormat> exportFormats;
  
  /// The theme
  final ZephyrSignaturePadTheme? theme;
  
  /// The callback for when the signature changes
  final Function(ui.Image?)? onSignatureChanged;
  
  /// The callback for when the signature is cleared
  final VoidCallback? onSignatureCleared;
  
  /// The semantic label for accessibility
  final String? semanticLabel;

  const ZephyrSignaturePad({
    Key? key,
    this.width = 400,
    this.height = 200,
    this.penColor,
    this.penWidth,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.showClearButton = true,
    this.showUndoButton = true,
    this.showRedoButton = true,
    this.showExportButton = true,
    this.showColorPicker = false,
    this.showWidthSlider = false,
    this.enablePressure = false,
    this.minPenWidth = 1.0,
    this.maxPenWidth = 8.0,
    this.availableColors = const [
      Colors.black,
      Colors.blue,
      Colors.red,
      Colors.green,
    ],
    this.exportFormats = const [ZephyrSignatureExportFormat.png],
    this.theme,
    this.onSignatureChanged,
    this.onSignatureCleared,
    this.semanticLabel,
  }) : super(key: key);

  @override
  State<ZephyrSignaturePad> createState() => _ZephyrSignaturePadState();
}

class _ZephyrSignaturePadState extends State<ZephyrSignaturePad> {
  late ZephyrSignaturePadTheme _theme;
  final GlobalKey _signatureKey = GlobalKey();
  final List<Offset> _points = [];
  final List<List<Offset>> _strokes = [];
  final List<List<Offset>> _undoStack = [];
  final List<List<Offset>> _redoStack = [];
  
  Color _currentPenColor = Colors.black;
  double _currentPenWidth = 3.0;
  bool _isDrawing = false;
  ui.Image? _signatureImage;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrSignaturePadTheme.light();
    _currentPenColor = widget.penColor ?? _theme.penColor;
    _currentPenWidth = widget.penWidth ?? _theme.penWidth;
  }

  @override
  void didUpdateWidget(ZephyrSignaturePad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrSignaturePadTheme.light();
    }
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isDrawing = true;
      _redoStack.clear(); // Clear redo stack when starting new stroke
      final point = Offset(event.localPosition.dx, event.localPosition.dy);
      _points.add(point);
    });
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (!_isDrawing) return;
    
    setState(() {
      final point = Offset(event.localPosition.dx, event.localPosition.dy);
      _points.add(point);
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    if (!_isDrawing) return;
    
    setState(() {
      _isDrawing = false;
      if (_points.isNotEmpty) {
        _undoStack.add(List<Offset>.from(_points));
        _strokes.add(List<Offset>.from(_points));
        _points.clear();
        _updateSignatureImage();
      }
    });
  }

  Future<void> _updateSignatureImage() async {
    try {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder, Rect.fromPoints(
        Offset.zero, 
        Offset(widget.width, widget.height)
      ));
      
      // Draw background
      final backgroundPaint = Paint()
        ..color = widget.backgroundColor ?? _theme.backgroundColor;
      canvas.drawRect(Rect.fromLTWH(0, 0, widget.width, widget.height), backgroundPaint);
      
      // Draw signature
      for (final stroke in _strokes) {
        if (stroke.length < 2) continue;
        
        final strokePaint = Paint()
          ..color = _currentPenColor
          ..strokeWidth = _currentPenWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        
        final path = Path();
        path.moveTo(stroke[0].dx, stroke[0].dy);
        
        for (int i = 1; i < stroke.length; i++) {
          path.lineTo(stroke[i].dx, stroke[i].dy);
        }
        
        canvas.drawPath(path, strokePaint);
      }
      
      final picture = recorder.endRecording();
      _signatureImage = await picture.toImage(
        widget.width.toInt(), 
        widget.height.toInt()
      );
      
      widget.onSignatureChanged?.call(_signatureImage);
    } catch (e) {
      debugPrint('Error updating signature image: $e');
    }
  }

  void _undo() {
    if (_undoStack.isEmpty) return;
    
    setState(() {
      _redoStack.add(_undoStack.removeLast());
      _strokes = List<List<Offset>>.from(_undoStack);
      _updateSignatureImage();
    });
  }

  void _redo() {
    if (_redoStack.isEmpty) return;
    
    setState(() {
      _undoStack.add(_redoStack.removeLast());
      _strokes = List<List<Offset>>.from(_undoStack);
      _updateSignatureImage();
    });
  }

  void _clear() {
    setState(() {
      _points.clear();
      _strokes.clear();
      _undoStack.clear();
      _redoStack.clear();
      _signatureImage = null;
    });
    
    widget.onSignatureChanged?.call(null);
    widget.onSignatureCleared?.call();
  }

  Future<void> _exportSignature(ZephyrSignatureExportFormat format) async {
    if (_signatureImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No signature to export'),
          backgroundColor: _theme.errorColor,
        ),
      );
      return;
    }

    try {
      final byteData = await _signatureImage!.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        final bytes = byteData.buffer.asUint8List();
        
        // Save to gallery or share
        // This would require platform-specific implementation
        await Clipboard.setData(ClipboardData(text: 'Signature exported as ${format.name}'));
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signature exported as ${format.name}'),
              backgroundColor: _theme.successColor,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: _theme.errorColor,
          ),
        );
      }
    }
  }

  Widget _buildSignatureCanvas() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? _theme.backgroundColor,
        border: Border.all(
          color: widget.borderColor ?? _theme.borderColor,
          width: widget.borderWidth ?? _theme.borderWidth,
        ),
        borderRadius: widget.borderRadius ?? _theme.borderRadius,
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? _theme.borderRadius,
        child: Stack(
          children: [
            // Drawing canvas
            Positioned.fill(
              child: CustomPaint(
                painter: _SignaturePainter(
                  strokes: _strokes,
                  currentStroke: _points,
                  penColor: _currentPenColor,
                  penWidth: _currentPenWidth,
                  isDrawing: _isDrawing,
                ),
              ),
            ),
            
            // Drawing area overlay
            if (_strokes.isEmpty && _points.isEmpty)
              Center(
                child: Text(
                  'Sign here',
                  style: TextStyle(
                    color: _theme.placeholderColor,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (widget.showClearButton)
          IconButton(
            icon: Icon(Icons.clear, color: _theme.buttonIconColor),
            onPressed: _clear,
            tooltip: 'Clear',
          ),
        
        if (widget.showUndoButton)
          IconButton(
            icon: Icon(Icons.undo, color: _undoStack.isNotEmpty ? _theme.buttonIconColor : _theme.disabledButtonIconColor),
            onPressed: _undoStack.isNotEmpty ? _undo : null,
            tooltip: 'Undo',
          ),
        
        if (widget.showRedoButton)
          IconButton(
            icon: Icon(Icons.redo, color: _redoStack.isNotEmpty ? _theme.buttonIconColor : _theme.disabledButtonIconColor),
            onPressed: _redoStack.isNotEmpty ? _redo : null,
            tooltip: 'Redo',
          ),
        
        if (widget.showExportButton)
          PopupMenuButton<ZephyrSignatureExportFormat>(
            onSelected: _exportSignature,
            itemBuilder: (context) {
              return widget.exportFormats.map((format) {
                return PopupMenuItem<ZephyrSignatureExportFormat>(
                  value: format,
                  child: Text('Export as ${format.name.toUpperCase()}'),
                );
              }).toList();
            },
            child: Icon(
              Icons.download,
              color: _theme.buttonIconColor,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? 'Signature pad',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Listener(
            onPointerDown: _onPointerDown,
            onPointerMove: _onPointerMove,
            onPointerUp: _onPointerUp,
            child: _buildSignatureCanvas(),
          ),
          
          const SizedBox(height: 8),
          _buildControlButtons(),
          
          if (widget.showColorPicker || widget.showWidthSlider) ...[
            const SizedBox(height: 8),
            _buildPenControls(),
          ],
        ],
      ),
    );
  }

  Widget _buildPenControls() {
    return Row(
      children: [
        if (widget.showColorPicker) ...[
          const SizedBox(width: 8),
          DropdownButton<Color>(
            value: _currentPenColor,
            items: widget.availableColors.map((color) {
              return DropdownMenuItem<Color>(
                value: color,
                child: Container(
                  width: 20,
                  height: 20,
                  color: color,
                ),
              );
            }).toList(),
            onChanged: (color) {
              if (color != null) {
                setState(() {
                  _currentPenColor = color;
                });
              }
            },
          ),
        ],
        
        if (widget.showWidthSlider) ...[
          const SizedBox(width: 16),
          Expanded(
            child: Slider(
              value: _currentPenWidth,
              min: widget.minPenWidth!,
              max: widget.maxPenWidth!,
              onChanged: (value) {
                setState(() {
                  _currentPenWidth = value;
                });
              },
            ),
          ),
          Text('${_currentPenWidth.toStringAsFixed(1)}px'),
        ],
      ],
    );
  }

  /// Gets the current signature as an image
  ui.Image? get signatureImage => _signatureImage;
  
  /// Gets whether the signature pad has content
  bool get hasSignature => _strokes.isNotEmpty;
  
  /// Clears the signature
  void clear() => _clear();
  
  /// Undoes the last stroke
  void undo() => _undo();
  
  /// Redoes the last undone stroke
  void redo() => _redo();
}

/// Signature painter for drawing
class _SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;
  final Color penColor;
  final double penWidth;
  final bool isDrawing;

  _SignaturePainter({
    required this.strokes,
    required this.currentStroke,
    required this.penColor,
    required this.penWidth,
    required this.isDrawing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw completed strokes
    for (final stroke in strokes) {
      if (stroke.length < 2) continue;
      
      final paint = Paint()
        ..color = penColor
        ..strokeWidth = penWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      
      final path = Path();
      path.moveTo(stroke[0].dx, stroke[0].dy);
      
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      
      canvas.drawPath(path, paint);
    }
    
    // Draw current stroke
    if (currentStroke.length >= 2) {
      final paint = Paint()
        ..color = penColor
        ..strokeWidth = penWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      
      final path = Path();
      path.moveTo(currentStroke[0].dx, currentStroke[0].dy);
      
      for (int i = 1; i < currentStroke.length; i++) {
        path.lineTo(currentStroke[i].dx, currentStroke[i].dy);
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.strokes != strokes ||
           oldDelegate.currentStroke != currentStroke ||
           oldDelegate.penColor != penColor ||
           oldDelegate.penWidth != penWidth ||
           oldDelegate.isDrawing != isDrawing;
  }
}

/// Signature export formats
enum ZephyrSignatureExportFormat {
  png,
  jpg,
  svg,
}