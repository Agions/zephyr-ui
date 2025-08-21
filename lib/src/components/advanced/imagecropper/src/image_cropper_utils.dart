import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';

/// ZephyrUI Image Cropper Utilities
/// 
/// Provides utility functions for image processing,
/// validation, and export functionality.
class ZephyrImageCropperUtils {
  /// Loads an image from a file
  static Future<ui.Image> loadImageFromFile(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  /// Loads an image from network
  static Future<ui.Image> loadImageFromNetwork(String url) async {
    // This would require http package
    // For now, we'll return a placeholder implementation
    throw UnimplementedError('Network image loading requires additional dependencies');
  }

  /// Validates image format
  static bool isValidImageFormat(String path) {
    final extension = path.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'webp', 'bmp', 'gif'].contains(extension);
  }

  /// Gets image dimensions from file
  static Future<Size> getImageDimensions(File file) async {
    final image = await loadImageFromFile(file);
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  /// Calculates optimal crop dimensions
  static Size calculateOptimalCropSize(
    Size imageSize,
    Size screenSize, {
    ZephyrCropAspectRatio? aspectRatio,
    double padding = 0.8,
  }) {
    final maxWidth = screenSize.width * padding;
    final maxHeight = screenSize.height * padding;
    
    if (aspectRatio == null || aspectRatio == ZephyrCropAspectRatio.free) {
      // Free form - use maximum possible size
      final scale = math.min(maxWidth / imageSize.width, maxHeight / imageSize.height);
      return Size(imageSize.width * scale, imageSize.height * scale);
    } else {
      // Constrained by aspect ratio
      final ratio = aspectRatio.value;
      double width, height;
      
      if (ratio > 1) {
        // Landscape
        width = maxWidth;
        height = width / ratio;
      } else {
        // Portrait or square
        height = maxHeight;
        width = height * ratio;
      }
      
      // Ensure we don't exceed maximum dimensions
      if (width > maxWidth) {
        width = maxWidth;
        height = width / ratio;
      }
      if (height > maxHeight) {
        height = maxHeight;
        width = height * ratio;
      }
      
      return Size(width, height);
    }
  }

  /// Centers crop area in image
  static Rect centerCropArea(
    Size imageSize,
    Size cropSize, {
    double rotation = 0,
  }) {
    // Calculate rotated image bounds
    final rotatedBounds = _getRotatedBounds(imageSize, rotation);
    
    final centerX = rotatedBounds.width / 2;
    final centerY = rotatedBounds.height / 2;
    
    return Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: cropSize.width,
      height: cropSize.height,
    );
  }

  /// Gets bounds of rotated image
  static Size _getRotatedBounds(Size size, double rotation) {
    if (rotation % 180 == 0) return size;
    if (rotation % 90 == 0) return Size(size.height, size.width);
    
    // For arbitrary rotations
    final radians = rotation * math.pi / 180;
    final sinR = math.sin(radians);
    final cosR = math.cos(radians);
    
    final width = (size.width * cosR).abs() + (size.height * sinR).abs();
    final height = (size.width * sinR).abs() + (size.height * cosR).abs();
    
    return Size(width, height);
  }

  /// Applies crop to image
  static Future<ui.Image> applyCrop(
    ui.Image image,
    Rect cropRect, {
    double rotation = 0,
    double scaleX = 1.0,
    double scaleY = 1.0,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, cropRect.size);
    
    // Apply transformations
    canvas.save();
    
    // Move to crop center
    canvas.translate(cropRect.width / 2, cropRect.height / 2);
    
    // Apply rotation
    if (rotation != 0) {
      canvas.rotate(rotation * math.pi / 180);
    }
    
    // Apply scaling
    canvas.scale(scaleX, scaleY);
    
    // Move back and translate to crop position
    canvas.translate(-cropRect.width / 2, -cropRect.height / 2);
    canvas.translate(-cropRect.left, -cropRect.top);
    
    // Draw image
    final paint = Paint()
      ..filterQuality = FilterQuality.high;
    
    canvas.drawImage(image, Offset.zero, paint);
    canvas.restore();
    
    final picture = recorder.endRecording();
    return await picture.toImage(
      cropRect.width.toInt(),
      cropRect.height.toInt(),
    );
  }

  /// Exports image to bytes
  static Future<Uint8List> exportImage(
    ui.Image image,
    ZephyrImageExportFormat format, {
    int quality = 90,
  }) async {
    final byteData = await image.toByteData(
      format: format == ZephyrImageExportFormat.png
          ? ui.ImageByteFormat.png
          : ui.ImageByteFormat.rawRgba,
    );
    
    if (byteData == null) {
      throw Exception('Failed to convert image to bytes');
    }
    
    return byteData.buffer.asUint8List();
  }

  /// Saves image to file
  static Future<File> saveImageToFile(
    Uint8List bytes,
    String path, {
    ZephyrImageExportFormat format = ZephyrImageExportFormat.png,
  }) async {
    final file = File(path);
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Generates thumbnail
  static Future<ui.Image> generateThumbnail(
    ui.Image image,
    int maxWidth,
    int maxHeight, {
    bool maintainAspectRatio = true,
  }) async {
    int newWidth, newHeight;
    
    if (maintainAspectRatio) {
      final ratio = math.min(maxWidth / image.width, maxHeight / image.height);
      newWidth = (image.width * ratio).round();
      newHeight = (image.height * ratio).round();
    } else {
      newWidth = maxWidth;
      newHeight = maxHeight;
    }
    
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, newWidth.toDouble(), newHeight.toDouble()));
    
    final paint = Paint()
      ..filterQuality = FilterQuality.high;
    
    final destRect = Rect.fromLTWH(0, 0, newWidth.toDouble(), newHeight.toDouble());
    final srcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    
    canvas.drawImageRect(image, srcRect, destRect, paint);
    
    final picture = recorder.endRecording();
    return await picture.toImage(newWidth, newHeight);
  }

  /// Validates crop area
  static bool validateCropArea(Rect cropRect, Size imageSize) {
    return cropRect.left >= 0 &&
           cropRect.top >= 0 &&
           cropRect.right <= imageSize.width &&
           cropRect.bottom <= imageSize.height &&
           cropRect.width > 0 &&
           cropRect.height > 0;
  }

  /// Suggests crop area based on image content
  static Rect suggestCropArea(
    ui.Image image, {
    double padding = 0.1,
    ZephyrCropAspectRatio? aspectRatio,
  }) {
    // Simple implementation - center crop with padding
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final paddingWidth = imageSize.width * padding;
    final paddingHeight = imageSize.height * padding;
    
    var cropRect = Rect.fromLTWH(
      paddingWidth,
      paddingHeight,
      imageSize.width - 2 * paddingWidth,
      imageSize.height - 2 * paddingHeight,
    );
    
    // Apply aspect ratio if specified
    if (aspectRatio != null && aspectRatio != ZephyrCropAspectRatio.free) {
      final ratio = aspectRatio.value;
      final currentRatio = cropRect.width / cropRect.height;
      
      if (currentRatio > ratio) {
        final newHeight = cropRect.width / ratio;
        cropRect = Rect.fromCenter(
          center: cropRect.center,
          width: cropRect.width,
          height: newHeight,
        );
      } else {
        final newWidth = cropRect.height * ratio;
        cropRect = Rect.fromCenter(
          center: cropRect.center,
          width: newWidth,
          height: cropRect.height,
        );
      }
    }
    
    return cropRect;
  }

  /// Calculates file size estimate
  static int estimateFileSize(
    ui.Image image,
    ZephyrImageExportFormat format, {
    int quality = 90,
  }) {
    // Rough estimation based on image dimensions and format
    final pixels = image.width * image.height;
    
    switch (format) {
      case ZephyrImageExportFormat.png:
        // PNG: ~3-4 bytes per pixel for complex images
        return (pixels * 3.5).round();
      case ZephyrImageExportFormat.jpg:
        // JPEG: ~0.5-2 bytes per pixel depending on quality
        final compressionRatio = 1.0 - (quality / 100.0) * 0.8;
        return (pixels * (0.5 + compressionRatio * 1.5)).round();
      case ZephyrImageExportFormat.webp:
        // WebP: ~0.3-1.5 bytes per pixel
        final compressionRatio = 1.0 - (quality / 100.0) * 0.7;
        return (pixels * (0.3 + compressionRatio * 1.2)).round();
    }
  }

  /// Gets supported formats
  static List<String> getSupportedFormats() {
    return ['jpg', 'jpeg', 'png', 'webp'];
  }

  /// Validates image quality setting
  static bool validateQuality(int quality) {
    return quality >= 1 && quality <= 100;
  }

  /// Applies image filters
  static Future<ui.Image> applyFilter(
    ui.Image image,
    ZephyrImageFilter filter,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
    
    final paint = Paint()
      ..filterQuality = FilterQuality.high;
    
    // Apply filter
    switch (filter) {
      case ZephyrImageFilter.grayscale:
        paint.colorFilter = const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ]);
        break;
      case ZephyrImageFilter.sepia:
        paint.colorFilter = const ColorFilter.matrix(<double>[
          0.393, 0.769, 0.189, 0, 0,
          0.349, 0.686, 0.168, 0, 0,
          0.272, 0.534, 0.131, 0, 0,
          0, 0, 0, 1, 0,
        ]);
        break;
      case ZephyrImageFilter.vintage:
        paint.colorFilter = const ColorFilter.matrix(<double>[
          0.6, 0.3, 0.1, 0, 0,
          0.2, 0.5, 0.1, 0, 0,
          0.2, 0.3, 0.4, 0, 0,
          0, 0, 0, 1, 0,
        ]);
        break;
      case ZephyrImageFilter.none:
        break;
    }
    
    canvas.drawImage(image, Offset.zero, paint);
    
    final picture = recorder.endRecording();
    return await picture.toImage(image.width, image.height);
  }
}

/// Image filter options
enum ZephyrImageFilter {
  none,
  grayscale,
  sepia,
  vintage,
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