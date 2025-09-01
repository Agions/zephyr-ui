import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// ZephyrUI Signature Pad Utilities
/// 
/// Provides utility functions for signature validation,
/// processing, and export functionality.
class ZephyrSignaturePadUtils {
  /// Validates signature data
  static bool validateSignature(List<List<Offset>> strokes) {
    if (strokes.isEmpty) return false;
    
    // Check if any stroke has meaningful content
    for (final stroke in strokes) {
      if (stroke.length < 2) continue;
      
      // Calculate stroke length
      double totalLength = 0;
      for (int i = 1; i < stroke.length; i++) {
        totalLength += (stroke[i] - stroke[i - 1]).distance;
      }
      
      // Consider valid if stroke has reasonable length
      if (totalLength > 10) return true;
    }
    
    return false;
  }

  /// Calculates signature complexity score
  static double calculateComplexityScore(List<List<Offset>> strokes) {
    if (strokes.isEmpty) return 0.0;
    
    double complexity = 0.0;
    int totalPoints = 0;
    
    for (final stroke in strokes) {
      if (stroke.length < 2) continue;
      
      totalPoints += stroke.length;
      
      // Add complexity for direction changes
      for (int i = 2; i < stroke.length; i++) {
        final angle1 = _calculateAngle(stroke[i - 2], stroke[i - 1]);
        final angle2 = _calculateAngle(stroke[i - 1], stroke[i]);
        final angleDiff = (angle2 - angle1).abs();
        
        if (angleDiff > 0.5) complexity += 1.0;
      }
      
      // Add complexity for stroke length
      double strokeLength = 0;
      for (int i = 1; i < stroke.length; i++) {
        strokeLength += (stroke[i] - stroke[i - 1]).distance;
      }
      complexity += strokeLength / 100;
    }
    
    return complexity / totalPoints;
  }

  /// Calculates angle between two points
  static double _calculateAngle(Offset p1, Offset p2) {
    return math.atan2(p2.dy - p1.dy, p2.dx - p1.dx);
  }

  /// Smooths signature strokes
  static List<List<Offset>> smoothStrokes(List<List<Offset>> strokes, {double smoothingFactor = 0.1}) {
    final smoothedStrokes = <List<Offset>>[];
    
    for (final stroke in strokes) {
      if (stroke.length < 3) {
        smoothedStrokes.add(List<Offset>.from(stroke));
        continue;
      }
      
      final smoothedStroke = <Offset>[stroke.first];
      
      for (int i = 1; i < stroke.length - 1; i++) {
        final prev = stroke[i - 1];
        final current = stroke[i];
        final next = stroke[i + 1];
        
        final smoothed = Offset(
          current.dx + smoothingFactor * (prev.dx + next.dx - 2 * current.dx),
          current.dy + smoothingFactor * (prev.dy + next.dy - 2 * current.dy),
        );
        
        smoothedStroke.add(smoothed);
      }
      
      smoothedStroke.add(stroke.last);
      smoothedStrokes.add(smoothedStroke);
    }
    
    return smoothedStrokes;
  }

  /// Simplifies signature strokes using Douglas-Peucker algorithm
  static List<List<Offset>> simplifyStrokes(List<List<Offset>> strokes, {double tolerance = 2.0}) {
    final simplifiedStrokes = <List<Offset>>[];
    
    for (final stroke in strokes) {
      if (stroke.length < 3) {
        simplifiedStrokes.add(List<Offset>.from(stroke));
        continue;
      }
      
      final simplified = _douglasPeucker(stroke, tolerance);
      simplifiedStrokes.add(simplified);
    }
    
    return simplifiedStrokes;
  }

  /// Douglas-Peucker line simplification algorithm
  static List<Offset> _douglasPeucker(List<Offset> points, double tolerance) {
    if (points.length < 3) return points;
    
    double maxDistance = 0;
    int maxIndex = 0;
    
    for (int i = 1; i < points.length - 1; i++) {
      final distance = _perpendicularDistance(points[i], points.first, points.last);
      if (distance > maxDistance) {
        maxDistance = distance;
        maxIndex = i;
      }
    }
    
    if (maxDistance > tolerance) {
      final left = _douglasPeucker(points.sublist(0, maxIndex + 1), tolerance);
      final right = _douglasPeucker(points.sublist(maxIndex), tolerance);
      
      return [...left.sublist(0, left.length - 1), ...right];
    } else {
      return [points.first, points.last];
    }
  }

  /// Calculates perpendicular distance from point to line
  static double _perpendicularDistance(Offset point, Offset lineStart, Offset lineEnd) {
    final lineLength = (lineEnd - lineStart).distance;
    if (lineLength == 0) return (point - lineStart).distance;
    
    final t = ((point.dx - lineStart.dx) * (lineEnd.dx - lineStart.dx) + 
               (point.dy - lineStart.dy) * (lineEnd.dy - lineStart.dy)) / 
              (lineLength * lineLength);
    
    final projection = lineStart + (lineEnd - lineStart) * t.clamp(0.0, 1.0);
    return (point - projection).distance;
  }

  /// Extracts signature features for analysis
  static Map<String, dynamic> extractSignatureFeatures(List<List<Offset>> strokes) {
    if (strokes.isEmpty) return {};
    
    final features = <String, dynamic>{};
    
    // Basic metrics
    features['strokeCount'] = strokes.length;
    features['totalPoints'] = strokes.fold(0, (sum, stroke) => sum + stroke.length);
    
    // Calculate total signature area
    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;
    
    for (final stroke in strokes) {
      for (final point in stroke) {
        minX = math.min(minX, point.dx);
        minY = math.min(minY, point.dy);
        maxX = math.max(maxX, point.dx);
        maxY = math.max(maxY, point.dy);
      }
    }
    
    features['width'] = maxX - minX;
    features['height'] = maxY - minY;
    features['area'] = features['width'] * features['height'];
    
    // Calculate average stroke length
    double totalLength = 0;
    int validStrokes = 0;
    
    for (final stroke in strokes) {
      if (stroke.length < 2) continue;
      
      double strokeLength = 0;
      for (int i = 1; i < stroke.length; i++) {
        strokeLength += (stroke[i] - stroke[i - 1]).distance;
      }
      
      if (strokeLength > 0) {
        totalLength += strokeLength;
        validStrokes++;
      }
    }
    
    features['averageStrokeLength'] = validStrokes > 0 ? totalLength / validStrokes : 0;
    features['totalLength'] = totalLength;
    
    // Calculate complexity
    features['complexityScore'] = calculateComplexityScore(strokes);
    
    return features;
  }

  /// Scales signature to fit within specified dimensions
  static List<List<Offset>> scaleSignature(List<List<Offset>> strokes, double maxWidth, double maxHeight) {
    if (strokes.isEmpty) return [];
    
    // Find current bounds
    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;
    
    for (final stroke in strokes) {
      for (final point in stroke) {
        minX = math.min(minX, point.dx);
        minY = math.min(minY, point.dy);
        maxX = math.max(maxX, point.dx);
        maxY = math.max(maxY, point.dy);
      }
    }
    
    final currentWidth = maxX - minX;
    final currentHeight = maxY - minY;
    
    if (currentWidth == 0 || currentHeight == 0) return strokes;
    
    // Calculate scale factors
    final scaleX = maxWidth / currentWidth;
    final scaleY = maxHeight / currentHeight;
    final scale = math.min(scaleX, scaleY);
    
    // Scale strokes
    final scaledStrokes = <List<Offset>>[];
    
    for (final stroke in strokes) {
      final scaledStroke = stroke.map((point) {
        return Offset(
          (point.dx - minX) * scale,
          (point.dy - minY) * scale,
        );
      }).toList();
      
      scaledStrokes.add(scaledStroke);
    }
    
    return scaledStrokes;
  }

  /// Centers signature in the specified area
  static List<List<Offset>> centerSignature(List<List<Offset>> strokes, double width, double height) {
    if (strokes.isEmpty) return [];
    
    // Find current bounds
    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;
    
    for (final stroke in strokes) {
      for (final point in stroke) {
        minX = math.min(minX, point.dx);
        minY = math.min(minY, point.dy);
        maxX = math.max(maxX, point.dx);
        maxY = math.max(maxY, point.dy);
      }
    }
    
    final currentWidth = maxX - minX;
    final currentHeight = maxY - minY;
    
    // Calculate offset to center
    final offsetX = (width - currentWidth) / 2 - minX;
    final offsetY = (height - currentHeight) / 2 - minY;
    
    // Translate strokes
    final centeredStrokes = <List<Offset>>[];
    
    for (final stroke in strokes) {
      final centeredStroke = stroke.map((point) {
        return Offset(
          point.dx + offsetX,
          point.dy + offsetY,
        );
      }).toList();
      
      centeredStrokes.add(centeredStroke);
    }
    
    return centeredStrokes;
  }

  /// Generates signature hash for comparison
  static String generateSignatureHash(List<List<Offset>> strokes) {
    if (strokes.isEmpty) return '';
    
    final buffer = StringBuffer();
    
    for (final stroke in strokes) {
      for (final point in stroke) {
        buffer.write('${point.dx.toStringAsFixed(2)},${point.dy.toStringAsFixed(2)};');
      }
      buffer.write('|');
    }
    
    return buffer.toString();
  }

  /// Estimates signature creation time
  static Duration estimateCreationTime(List<List<Offset>> strokes) {
    // Rough estimation based on stroke count and complexity
    final strokeCount = strokes.length;
    final totalPoints = strokes.fold(0, (sum, stroke) => sum + stroke.length);
    final complexity = calculateComplexityScore(strokes);
    
    // Base time + complexity factor
    final estimatedSeconds = strokeCount * 0.5 + totalPoints * 0.01 + complexity * 2;
    
    return Duration(milliseconds: (estimatedSeconds * 1000).round());
  }
}