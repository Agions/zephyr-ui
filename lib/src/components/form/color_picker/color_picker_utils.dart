import 'dart:math';
import 'package:flutter/material.dart';

/// Color Picker utility functions
/// 
/// Provides helper functions for color manipulation and conversion
class ZephyrColorPickerUtils {
  /// Convert RGB values to Color
  static Color fromRGB(int r, int g, int b, [int a = 255]) {
    return Color.fromARGB(a, r, g, b);
  }

  /// Convert HSV values to Color
  static Color fromHSV(double h, double s, double v, [int a = 255]) {
    final r = _hueToRGB(h, v, v * (1 - s));
    final g = _hueToRGB(h + 2, v, v * (1 - s));
    final b = _hueToRGB(h + 4, v, v * (1 - s));
    return Color.fromARGB(a, (r * 255).round(), (g * 255).round(), (b * 255).round());
  }

  /// Convert HSL values to Color
  static Color fromHSL(double h, double s, double l, [int a = 255]) {
    final c = (1 - (2 * l - 1).abs()) * s;
    final x = c * (1 - ((h / 60) % 2 - 1).abs());
    final m = l - c / 2;

    double r, g, b;
    if (h >= 0 && h < 60) {
      r = c; g = x; b = 0;
    } else if (h >= 60 && h < 120) {
      r = x; g = c; b = 0;
    } else if (h >= 120 && h < 180) {
      r = 0; g = c; b = x;
    } else if (h >= 180 && h < 240) {
      r = 0; g = x; b = c;
    } else if (h >= 240 && h < 300) {
      r = x; g = 0; b = c;
    } else {
      r = c; g = 0; b = x;
    }

    return Color.fromARGB(
      a,
      ((r + m) * 255).round(),
      ((g + m) * 255).round(),
      ((b + m) * 255).round(),
    );
  }

  /// Convert Color to RGB values
  static Map<String, int> toRGB(Color color) {
    return {
      'r': (color.r * 255).round(),
      'g': (color.g * 255).round(),
      'b': (color.b * 255).round(),
      'a': (color.a * 255).round(),
    };
  }

  /// Convert Color to HSV values
  static Map<String, double> toHSV(Color color) {
    final r = color.r / 255.0;
    final g = color.g / 255.0;
    final b = color.b / 255.0;

    final max = [r, g, b].reduce((a, b) => a > b ? a : b);
    final min = [r, g, b].reduce((a, b) => a < b ? a : b);
    final delta = max - min;

    double h = 0;
    if (delta != 0) {
      if (max == r) {
        h = ((g - b) / delta) % 6;
      } else if (max == g) {
        h = (b - r) / delta + 2;
      } else {
        h = (r - g) / delta + 4;
      }
    }
    h = h * 60;
    if (h < 0) h += 360;

    final s = max == 0 ? 0 : delta / max;
    final v = max;

    return {
      'h': h,
      's': s.toDouble(),
      'v': v,
    };
  }

  /// Convert Color to HSL values
  static Map<String, double> toHSL(Color color) {
    final r = color.r / 255.0;
    final g = color.g / 255.0;
    final b = color.b / 255.0;

    final max = [r, g, b].reduce((a, b) => a > b ? a : b);
    final min = [r, g, b].reduce((a, b) => a < b ? a : b);
    final delta = max - min;

    double h = 0;
    if (delta != 0) {
      if (max == r) {
        h = ((g - b) / delta) % 6;
      } else if (max == g) {
        h = (b - r) / delta + 2;
      } else {
        h = (r - g) / delta + 4;
      }
    }
    h = h * 60;
    if (h < 0) h += 360;

    final l = (max + min) / 2;
    final s = delta == 0 ? 0 : delta / (1 - (2 * l - 1).abs());

    return {
      'h': h,
      's': s.toDouble(),
      'l': l,
    };
  }

  /// Convert Color to Hex string
  static String toHex(Color color, {bool includeAlpha = true}) {
    if (includeAlpha) {
      return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    } else {
      return '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
    }
  }

  /// Parse Hex string to Color
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    } else if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    } else if (hex.length == 3) {
      final r = hex[0] * 2;
      final g = hex[1] * 2;
      final b = hex[2] * 2;
      return Color(int.parse('FF$r$g$b', radix: 16));
    } else {
      throw ArgumentError('Invalid hex color format');
    }
  }

  /// Generate color palette
  static List<Color> generatePalette(Color baseColor, int count) {
    final hsl = toHSL(baseColor);
    final palette = <Color>[];

    for (int i = 0; i < count; i++) {
      final factor = (i - count / 2) / (count / 2);
      final lightness = (hsl['l']! + factor * 0.3).clamp(0.0, 1.0);
      palette.add(fromHSL(hsl['h']!, hsl['s']!, lightness, (baseColor.a * 255).round()));
    }

    return palette;
  }

  /// Generate complementary colors
  static List<Color> getComplementaryColors(Color color) {
    final hsl = toHSL(color);
    return [
      color,
      fromHSL((hsl['h']! + 180) % 360, hsl['s']!, hsl['l']!, (color.a * 255).round()),
    ];
  }

  /// Generate triadic colors
  static List<Color> getTriadicColors(Color color) {
    final hsl = toHSL(color);
    return [
      color,
      fromHSL((hsl['h']! + 120) % 360, hsl['s']!, hsl['l']!, (color.a * 255).round()),
      fromHSL((hsl['h']! + 240) % 360, hsl['s']!, hsl['l']!, (color.a * 255).round()),
    ];
  }

  /// Generate analogous colors
  static List<Color> getAnalogousColors(Color color) {
    final hsl = toHSL(color);
    return [
      fromHSL((hsl['h']! - 30) % 360, hsl['s']!, hsl['l']!, (color.a * 255).round()),
      color,
      fromHSL((hsl['h']! + 30) % 360, hsl['s']!, hsl['l']!, (color.a * 255).round()),
    ];
  }

  /// Check if color is dark
  static bool isDark(Color color) {
    final luminance = (0.299 * color.r + 0.587 * color.g + 0.114 * color.b) / 255;
    return luminance < 0.5;
  }

  /// Get contrasting text color
  static Color getContrastingTextColor(Color color) {
    return isDark(color) ? Colors.white : Colors.black;
  }

  /// Blend two colors
  static Color blend(Color color1, Color color2, double ratio) {
    ratio = ratio.clamp(0.0, 1.0);
    return Color.fromARGB(
      (color1.a * 255).round(),
      ((color1.r * 255) * (1 - ratio) + (color2.r * 255) * ratio).round(),
      ((color1.g * 255) * (1 - ratio) + (color2.g * 255) * ratio).round(),
      ((color1.b * 255) * (1 - ratio) + (color2.b * 255) * ratio).round(),
    );
  }

  /// Get color brightness
  static double getBrightness(Color color) {
    return (0.299 * color.r + 0.587 * color.g + 0.114 * color.b) / 255;
  }

  /// Lighten color
  static Color lighten(Color color, double amount) {
    final hsl = toHSL(color);
    final lightness = (hsl['l']! + amount).clamp(0.0, 1.0);
    return fromHSL(hsl['h']!, hsl['s']!, lightness, (color.a * 255).round());
  }

  /// Darken color
  static Color darken(Color color, double amount) {
    final hsl = toHSL(color);
    final lightness = (hsl['l']! - amount).clamp(0.0, 1.0);
    return fromHSL(hsl['h']!, hsl['s']!, lightness, (color.a * 255).round());
  }

  /// Saturate color
  static Color saturate(Color color, double amount) {
    final hsl = toHSL(color);
    final saturation = (hsl['s']! + amount).clamp(0.0, 1.0);
    return fromHSL(hsl['h']!, saturation, hsl['l']!, (color.a * 255).round());
  }

  /// Desaturate color
  static Color desaturate(Color color, double amount) {
    final hsl = toHSL(color);
    final saturation = (hsl['s']! - amount).clamp(0.0, 1.0);
    return fromHSL(hsl['h']!, saturation, hsl['l']!, (color.a * 255).round());
  }

  /// Get color temperature (warm/cool)
  static String getColorTemperature(Color color) {
    final r = color.r;
    final g = color.g;
    final b = color.b;

    if (r > g && r > b) {
      return 'warm';
    } else if (b > r && b > g) {
      return 'cool';
    } else {
      return 'neutral';
    }
  }

  /// Helper function for HSV conversion
  static double _hueToRGB(double h, double m1, double m2) {
    h = h % 6;
    if (h < 1) return m1 + (m2 - m1) * h;
    if (h < 3) return m2;
    if (h < 4) return m1 + (m2 - m1) * (4 - h);
    return m1;
  }

  /// Validate hex color string
  static bool isValidHex(String hex) {
    final pattern = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8}|[A-Fa-f0-9]{3})$');
    return pattern.hasMatch(hex);
  }

  /// Get color name (basic implementation)
  static String getColorName(Color color) {
    final rgb = toRGB(color);
    final r = rgb['r']!;
    final g = rgb['g']!;
    final b = rgb['b']!;

    if (r > 200 && g < 100 && b < 100) return 'Red';
    if (g > 200 && r < 100 && b < 100) return 'Green';
    if (b > 200 && r < 100 && g < 100) return 'Blue';
    if (r > 200 && g > 200 && b < 100) return 'Yellow';
    if (r > 200 && b > 200 && g < 100) return 'Magenta';
    if (g > 200 && b > 200 && r < 100) return 'Cyan';
    if (r > 200 && g > 200 && b > 200) return 'White';
    if (r < 50 && g < 50 && b < 50) return 'Black';
    if (r > 150 && g > 150 && b > 150) return 'Gray';
    if (r > g && r > b) return 'Reddish';
    if (g > r && g > b) return 'Greenish';
    if (b > r && b > g) return 'Bluish';
    return 'Unknown';
  }

  /// Sort colors by brightness
  static List<Color> sortByBrightness(List<Color> colors) {
    return colors..sort((a, b) => getBrightness(a).compareTo(getBrightness(b)));
  }

  /// Sort colors by hue
  static List<Color> sortByHue(List<Color> colors) {
    return colors..sort((a, b) => toHSV(a)['h']!.compareTo(toHSV(b)['h']!));
  }

  /// Filter colors by similarity
  static List<Color> filterBySimilarity(List<Color> colors, Color target, double threshold) {
    return colors.where((color) {
      final distance = _colorDistance(color, target);
      return distance <= threshold;
    }).toList();
  }

  /// Calculate color distance (Euclidean distance in RGB space)
  static double _colorDistance(Color color1, Color color2) {
    final dr = color1.r - color2.r;
    final dg = color1.g - color2.g;
    final db = color1.b - color2.b;
    return sqrt(dr * dr + dg * dg + db * db);
  }
}