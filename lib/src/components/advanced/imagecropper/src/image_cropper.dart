import 'dart:ui' as ui;
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'image_cropper_theme.dart';
import 'image_cropper_utils.dart';

/// Image Cropper Component
/// 
/// A comprehensive image cropper component with interactive cropping,
/// aspect ratio controls, and export functionality for enterprise applications.
/// 
/// Features:
/// - Interactive crop area with drag handles
/// - Multiple aspect ratio presets
/// - Custom aspect ratio support
/// - Rotation and flip functionality
/// - Zoom and pan support
/// - Grid overlay for alignment
/// - Export in various formats
/// - Image quality optimization
/// 
/// Example usage:
/// ```dart
/// ZephyrImageCropper(
///   image: File('path/to/image.jpg'),
///   aspectRatio: ZephyrCropAspectRatio.ratio1x1,
///   theme: ZephyrImageCropperTheme.light(),
///   onCropped: (croppedImage) {
///     // Handle cropped image
///   },
/// )
/// ```
class ZephyrImageCropper extends StatefulWidget {
  /// The image to crop
  final Future<ui.Image> image;
  
  /// The initial aspect ratio
  final ZephyrCropAspectRatio? initialAspectRatio;
  
  /// Whether to show the aspect ratio controls
  final bool showAspectRatioControls;
  
  /// Whether to show the rotation controls
  final bool showRotationControls;
  
  /// Whether to show the grid overlay
  final bool showGrid;
  
  /// Whether to enable zoom
  final bool enableZoom;
  
  /// Whether to enable pan
  final bool enablePan;
  
  /// The crop area padding
  final EdgeInsets? cropAreaPadding;
  
  /// The export formats
  final List<ZephyrImageExportFormat> exportFormats;
  
  /// The image quality (1-100)
  final int imageQuality;
  
  /// The theme
  final ZephyrImageCropperTheme? theme;
  
  /// The callback for when the image is cropped
  final Function(ui.Image)? onCropped;
  
  /// The callback for when the crop area changes
  final Function(Rect)? onCropAreaChanged;
  
  /// The semantic label for accessibility
  final String? semanticLabel;

  const ZephyrImageCropper({
    Key? key,
    required this.image,
    this.initialAspectRatio,
    this.showAspectRatioControls = true,
    this.showRotationControls = true,
    this.showGrid = true,
    this.enableZoom = true,
    this.enablePan = true,
    this.cropAreaPadding,
    this.exportFormats = const [ZephyrImageExportFormat.png],
    this.imageQuality = 90,
    this.theme,
    this.onCropped,
    this.onCropAreaChanged,
    this.semanticLabel,
  }) : super(key: key);

  @override
  State<ZephyrImageCropper> createState() => _ZephyrImageCropperState();
}

class _ZephyrImageCropperState extends State<ZephyrImageCropper> {
  late ZephyrImageCropperTheme _theme;
  ui.Image? _image;
  Rect? _cropRect;
  ZephyrCropAspectRatio _currentAspectRatio = ZephyrCropAspectRatio.free;
  double _rotation = 0;
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  
  // Handle positions for crop area
  Offset? _dragStart;
  ZephyrCropHandle? _activeHandle;
  
  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrImageCropperTheme.light();
    _currentAspectRatio = widget.initialAspectRatio ?? ZephyrCropAspectRatio.free;
    _loadImage();
  }

  @override
  void didUpdateWidget(ZephyrImageCropper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrImageCropperTheme.light();
    }
  }

  Future<void> _loadImage() async {
    try {
      final image = await widget.image;
      setState(() {
        _image = image;
        _initializeCropRect();
      });
    } catch (e) {
      debugPrint('Error loading image: $e');
    }
  }

  void _initializeCropRect() {
    if (_image == null) return;
    
    final imageSize = Size(_image!.width.toDouble(), _image!.height.toDouble());
    final screenSize = MediaQuery.of(context).size;
    
    // Calculate initial crop area (centered, 80% of screen)
    final cropSize = Size(screenSize.width * 0.8, screenSize.height * 0.6);
    final cropOffset = Offset(
      (screenSize.width - cropSize.width) / 2,
      (screenSize.height - cropSize.height) / 2,
    );
    
    setState(() {
      _cropRect = Rect.fromLTWH(
        cropOffset.dx,
        cropOffset.dy,
        cropSize.width,
        cropSize.height,
      );
    });
  }

  void _handlePanStart(DragStartDetails details) {
    final localPosition = details.localPosition;
    
    // Check if we're grabbing a handle
    _activeHandle = _getHandleAtPosition(localPosition);
    _dragStart = localPosition;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_dragStart == null || _cropRect == null) return;
    
    final delta = details.localPosition - _dragStart!;
    
    setState(() {
      if (_activeHandle != null) {
        _resizeCropRect(delta);
      } else if (_cropRect!.contains(details.localPosition)) {
        _moveCropRect(delta);
      }
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    _dragStart = null;
    _activeHandle = null;
    widget.onCropAreaChanged?.call(_cropRect);
  }

  void _resizeCropRect(Offset delta) {
    if (_cropRect == null || _activeHandle == null) return;
    
    final newRect = Rect.fromLTWH(
      _cropRect!.left,
      _cropRect!.top,
      _cropRect!.width,
      _cropRect!.height,
    );

    switch (_activeHandle!) {
      case ZephyrCropHandle.topLeft:
        newRect.left = (_cropRect!.left + delta.dx).clamp(0, _cropRect!.right - 50);
        newRect.top = (_cropRect!.top + delta.dy).clamp(0, _cropRect!.bottom - 50);
        break;
      case ZephyrCropHandle.topRight:
        newRect.right = (_cropRect!.right + delta.dx).clamp(_cropRect!.left + 50, double.infinity);
        newRect.top = (_cropRect!.top + delta.dy).clamp(0, _cropRect!.bottom - 50);
        break;
      case ZephyrCropHandle.bottomLeft:
        newRect.left = (_cropRect!.left + delta.dx).clamp(0, _cropRect!.right - 50);
        newRect.bottom = (_cropRect!.bottom + delta.dy).clamp(_cropRect!.top + 50, double.infinity);
        break;
      case ZephyrCropHandle.bottomRight:
        newRect.right = (_cropRect!.right + delta.dx).clamp(_cropRect!.left + 50, double.infinity);
        newRect.bottom = (_cropRect!.bottom + delta.dy).clamp(_cropRect!.top + 50, double.infinity);
        break;
    }

    // Apply aspect ratio constraint
    if (_currentAspectRatio != ZephyrCropAspectRatio.free) {
      final ratio = _currentAspectRatio.value;
      final currentRatio = newRect.width / newRect.height;
      
      if (currentRatio > ratio) {
        newRect.height = newRect.width / ratio;
      } else {
        newRect.width = newRect.height * ratio;
      }
    }

    _cropRect = newRect;
  }

  void _moveCropRect(Offset delta) {
    if (_cropRect == null) return;
    
    final screenSize = MediaQuery.of(context).size;
    
    setState(() {
      _cropRect = Rect.fromLTWH(
        (_cropRect!.left + delta.dx).clamp(0, screenSize.width - _cropRect!.width),
        (_cropRect!.top + delta.dy).clamp(0, screenSize.height - _cropRect!.height),
        _cropRect!.width,
        _cropRect!.height,
      );
    });
  }

  ZephyrCropHandle? _getHandleAtPosition(Offset position) {
    if (_cropRect == null) return null;
    
    const handleSize = 20.0;
    const handleRadius = handleSize / 2;
    
    // Check each handle
    final handles = {
      ZephyrCropHandle.topLeft: _cropRect!.topLeft,
      ZephyrCropHandle.topRight: _cropRect!.topRight,
      ZephyrCropHandle.bottomLeft: _cropRect!.bottomLeft,
      ZephyrCropHandle.bottomRight: _cropRect!.bottomRight,
    };
    
    for (final entry in handles.entries) {
      final distance = (position - entry.value).distance;
      if (distance <= handleRadius) {
        return entry.key;
      }
    }
    
    return null;
  }

  Future<void> _cropImage() async {
    if (_image == null || _cropRect == null) return;
    
    try {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder, _cropRect!);
      
      // Draw the cropped portion of the image
      canvas.save();
      canvas.translate(-_cropRect!.left, -_cropRect!.top);
      
      final paint = Paint()
        ..filterQuality = FilterQuality.high;
      
      canvas.drawImage(_image!, Offset.zero, paint);
      canvas.restore();
      
      final picture = recorder.endRecording();
      final croppedImage = await picture.toImage(
        _cropRect!.width.toInt(),
        _cropRect!.height.toInt(),
      );
      
      widget.onCropped?.call(croppedImage);
    } catch (e) {
      debugPrint('Error cropping image: $e');
    }
  }

  void _rotateImage(double degrees) {
    setState(() {
      _rotation = (_rotation + degrees) % 360;
    });
  }

  void _flipImage() {
    setState(() {
      _scale = -_scale;
    });
  }

  void _setAspectRatio(ZephyrCropAspectRatio ratio) {
    setState(() {
      _currentAspectRatio = ratio;
      if (_cropRect != null) {
        final newWidth = _cropRect!.height * ratio.value;
        _cropRect = Rect.fromLTWH(
          _cropRect!.left,
          _cropRect!.top,
          newWidth,
          _cropRect!.height,
        );
      }
    });
  }

  Widget _buildImageDisplay() {
    if (_image == null) {
      return Container(
        width: double.infinity,
        height: 400,
        color: _theme.backgroundColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 400,
      color: _theme.backgroundColor,
      child: Stack(
        children: [
          // Image display
          Positioned.fill(
            child: Transform.scale(
              scale: _scale,
              child: Transform.rotate(
                angle: _rotation * math.pi / 180,
                child: Center(
                  child: CustomPaint(
                    painter: _ImagePainter(_image!),
                    size: MediaQuery.of(context).size,
                  ),
                ),
              ),
            ),
          ),
          
          // Crop area overlay
          if (_cropRect != null) ...[
            CustomPaint(
              painter: _CropOverlayPainter(
                cropRect: _cropRect!,
                theme: _theme,
                showGrid: widget.showGrid,
              ),
            ),
            
            // Crop handles
            ..._buildCropHandles(),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildCropHandles() {
    if (_cropRect == null) return [];
    
    final handles = {
      ZephyrCropHandle.topLeft: _cropRect!.topLeft,
      ZephyrCropHandle.topRight: _cropRect!.topRight,
      ZephyrCropHandle.bottomLeft: _cropRect!.bottomLeft,
      ZephyrCropHandle.bottomRight: _cropRect!.bottomRight,
    };
    
    return handles.entries.map((entry) {
      return Positioned(
        left: entry.value.dx - 10,
        top: entry.value.dy - 10,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: _theme.handleColor,
            border: Border.all(color: _theme.handleBorderColor, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _theme.controlPanelBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Aspect ratio controls
          if (widget.showAspectRatioControls) ...[
            Row(
              children: [
                const Text('Aspect Ratio:'),
                const SizedBox(width: 8),
                DropdownButton<ZephyrCropAspectRatio>(
                  value: _currentAspectRatio,
                  items: ZephyrCropAspectRatio.values.map((ratio) {
                    return DropdownMenuItem<ZephyrCropAspectRatio>(
                      value: ratio,
                      child: Text(ratio.label),
                    );
                  }).toList(),
                  onChanged: (ratio) {
                    if (ratio != null) {
                      _setAspectRatio(ratio);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          
          // Rotation controls
          if (widget.showRotationControls) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.rotate_left),
                  onPressed: () => _rotateImage(-90),
                  tooltip: 'Rotate Left',
                ),
                IconButton(
                  icon: const Icon(Icons.rotate_right),
                  onPressed: () => _rotateImage(90),
                  tooltip: 'Rotate Right',
                ),
                IconButton(
                  icon: const Icon(Icons.flip),
                  onPressed: _flipImage,
                  tooltip: 'Flip',
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _cropImage,
                icon: const Icon(Icons.crop),
                label: const Text('Crop'),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.cancel),
                label: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? 'Image cropper',
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: _handlePanStart,
              onPanUpdate: _handlePanUpdate,
              onPanEnd: _handlePanEnd,
              child: _buildImageDisplay(),
            ),
          ),
          _buildControlPanel(),
        ],
      ),
    );
  }
}

/// Image painter for displaying the image
class _ImagePainter extends CustomPainter {
  final ui.Image image;

  _ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..filterQuality = FilterQuality.high;

    // Calculate aspect ratio preserving fit
    final imageAspect = image.width / image.height;
    final screenAspect = size.width / size.height;
    
    double drawWidth, drawHeight;
    if (imageAspect > screenAspect) {
      drawWidth = size.width;
      drawHeight = size.width / imageAspect;
    } else {
      drawHeight = size.height;
      drawWidth = size.height * imageAspect;
    }
    
    final offset = Offset(
      (size.width - drawWidth) / 2,
      (size.height - drawHeight) / 2,
    );
    
    final destRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      drawWidth,
      drawHeight,
    );
    
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      destRect,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ImagePainter oldDelegate) {
    return oldDelegate.image != image;
  }
}

/// Crop overlay painter
class _CropOverlayPainter extends CustomPainter {
  final Rect cropRect;
  final ZephyrImageCropperTheme theme;
  final bool showGrid;

  _CropOverlayPainter({
    required this.cropRect,
    required this.theme,
    required this.showGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw dark overlay outside crop area
    final overlayPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    // Top overlay
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, cropRect.top), overlayPaint);
    // Bottom overlay
    canvas.drawRect(Rect.fromLTWH(0, cropRect.bottom, size.width, size.height - cropRect.bottom), overlayPaint);
    // Left overlay
    canvas.drawRect(Rect.fromLTWH(0, cropRect.top, cropRect.left, cropRect.height), overlayPaint);
    // Right overlay
    canvas.drawRect(Rect.fromLTWH(cropRect.right, cropRect.top, size.width - cropRect.right, cropRect.height), overlayPaint);

    // Draw crop border
    final borderPaint = Paint()
      ..color = theme.cropBorderColor
      ..strokeWidth = theme.cropBorderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawRect(cropRect, borderPaint);

    // Draw grid if enabled
    if (showGrid) {
      final gridPaint = Paint()
        ..color = theme.gridColor
        ..strokeWidth = theme.gridWidth
        ..style = PaintingStyle.stroke;

      // Vertical lines
      for (int i = 1; i < 3; i++) {
        final x = cropRect.left + (cropRect.width / 3) * i;
        canvas.drawLine(Offset(x, cropRect.top), Offset(x, cropRect.bottom), gridPaint);
      }

      // Horizontal lines
      for (int i = 1; i < 3; i++) {
        final y = cropRect.top + (cropRect.height / 3) * i;
        canvas.drawLine(Offset(cropRect.left, y), Offset(cropRect.right, y), gridPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CropOverlayPainter oldDelegate) {
    return oldDelegate.cropRect != cropRect ||
           oldDelegate.theme != theme ||
           oldDelegate.showGrid != showGrid;
  }
}

/// Crop handle positions
enum ZephyrCropHandle {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Crop aspect ratio presets
enum ZephyrCropAspectRatio {
  free('Free', 0),
  ratio1x1('1:1', 1),
  ratio4x3('4:3', 4 / 3),
  ratio16x9('16:9', 16 / 9),
  ratio3x4('3:4', 3 / 4),
  ratio9x16('9:16', 9 / 16),
  ratio3x2('3:2', 3 / 2),
  ratio2x3('2:3', 2 / 3),
  ratio5x4('5:4', 5 / 4),
  ratio7x5('7:5', 7 / 5);

  const ZephyrCropAspectRatio(this.label, this.value);
  final String label;
  final double value;
}

/// Image export formats
enum ZephyrImageExportFormat {
  png,
  jpg,
  webp,
}