/// 颜色工具类
/// 
/// 提供颜色相关的工具函数，包括颜色计算、对比度检查、颜色生成等。
library color_utils;

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 颜色工具类
class ZephyrColorUtils {
  ZephyrColorUtils._();

  /// 计算两个颜色之间的对比度
  /// 
  /// 返回值范围为 1.0 到 21.0，值越大对比度越高
  /// WCAG AA 标准要求对比度至少为 4.5:1
  /// WCAG AAA 标准要求对比度至少为 7:1
  static double calculateContrast(Color foreground, Color background) {
    final foregroundLuminance = _calculateLuminance(foreground);
    final backgroundLuminance = _calculateLuminance(background);
    
    final lighter = math.max(foregroundLuminance, backgroundLuminance);
    final darker = math.min(foregroundLuminance, backgroundLuminance);
    
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// 计算颜色的相对亮度
  static double _calculateLuminance(Color color) {
    final r = _linearizeColorComponent(color.red / 255.0);
    final g = _linearizeColorComponent(color.green / 255.0);
    final b = _linearizeColorComponent(color.blue / 255.0);
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// 线性化颜色分量
  static double _linearizeColorComponent(double component) {
    if (component <= 0.03928) {
      return component / 12.92;
    } else {
      return math.pow((component + 0.055) / 1.055, 2.4).toDouble();
    }
  }

  /// 检查颜色对比度是否符合 WCAG AA 标准
  static bool isContrastAA(Color foreground, Color background) {
    return calculateContrast(foreground, background) >= 4.5;
  }

  /// 检查颜色对比度是否符合 WCAG AAA 标准
  static bool isContrastAAA(Color foreground, Color background) {
    return calculateContrast(foreground, background) >= 7.0;
  }

  /// 获取颜色的最佳文本颜色（黑色或白色）
  static Color getBestTextColor(Color backgroundColor) {
    final whiteContrast = calculateContrast(Colors.white, backgroundColor);
    final blackContrast = calculateContrast(Colors.black, backgroundColor);
    
    return whiteContrast > blackContrast ? Colors.white : Colors.black;
  }

  /// 调整颜色亮度
  /// 
  /// [amount] 范围为 -1.0 到 1.0
  /// 正值使颜色变亮，负值使颜色变暗
  static Color adjustBrightness(Color color, double amount) {
    assert(amount >= -1.0 && amount <= 1.0, 'Amount must be between -1.0 and 1.0');
    
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    
    return hsl.withLightness(lightness).toColor();
  }

  /// 调整颜色饱和度
  /// 
  /// [amount] 范围为 -1.0 到 1.0
  /// 正值增加饱和度，负值降低饱和度
  static Color adjustSaturation(Color color, double amount) {
    assert(amount >= -1.0 && amount <= 1.0, 'Amount must be between -1.0 and 1.0');
    
    final hsl = HSLColor.fromColor(color);
    final saturation = (hsl.saturation + amount).clamp(0.0, 1.0);
    
    return hsl.withSaturation(saturation).toColor();
  }

  /// 调整颜色透明度
  /// 
  /// [opacity] 范围为 0.0 到 1.0
  static Color adjustOpacity(Color color, double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0.0 and 1.0');
    
    return color.withValues(alpha: opacity);
  }

  /// 混合两个颜色
  /// 
  /// [ratio] 范围为 0.0 到 1.0
  /// 0.0 返回第一个颜色，1.0 返回第二个颜色
  static Color blendColors(Color color1, Color color2, double ratio) {
    assert(ratio >= 0.0 && ratio <= 1.0, 'Ratio must be between 0.0 and 1.0');
    
    return Color.lerp(color1, color2, ratio)!;
  }

  /// 生成颜色的色调变体
  static List<Color> generateColorShades(Color baseColor, {int count = 9}) {
    final hsl = HSLColor.fromColor(baseColor);
    final shades = <Color>[];
    
    for (int i = 0; i < count; i++) {
      final lightness = 0.95 - (i * 0.1);
      shades.add(hsl.withLightness(lightness.clamp(0.0, 1.0)).toColor());
    }
    
    return shades;
  }

  /// 生成颜色的色调变体（包含原色）
  static Map<int, Color> generateMaterialColorSwatch(Color baseColor) {
    final shades = generateColorShades(baseColor);
    return {
      50: shades[0],
      100: shades[1],
      200: shades[2],
      300: shades[3],
      400: shades[4],
      500: baseColor,
      600: shades[5],
      700: shades[6],
      800: shades[7],
      900: shades[8],
    };
  }

  /// 从十六进制字符串创建颜色
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// 将颜色转换为十六进制字符串
  static String toHex(Color color, {bool includeAlpha = false}) {
    if (includeAlpha) {
      return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    } else {
      return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    }
  }

  /// 检查颜色是否为深色
  static bool isDark(Color color) {
    return _calculateLuminance(color) < 0.5;
  }

  /// 检查颜色是否为浅色
  static bool isLight(Color color) {
    return !isDark(color);
  }

  /// 获取颜色的补色
  static Color getComplementaryColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    final complementaryHue = (hsl.hue + 180) % 360;
    return hsl.withHue(complementaryHue).toColor();
  }

  /// 获取颜色的类似色（三色组合）
  static List<Color> getAnalogousColors(Color color) {
    final hsl = HSLColor.fromColor(color);
    return [
      hsl.withHue((hsl.hue - 30) % 360).toColor(),
      color,
      hsl.withHue((hsl.hue + 30) % 360).toColor(),
    ];
  }

  /// 获取颜色的三角色组合
  static List<Color> getTriadicColors(Color color) {
    final hsl = HSLColor.fromColor(color);
    return [
      color,
      hsl.withHue((hsl.hue + 120) % 360).toColor(),
      hsl.withHue((hsl.hue + 240) % 360).toColor(),
    ];
  }

  /// 创建渐变色
  static LinearGradient createGradient(
    Color startColor,
    Color endColor, {
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    List<double>? stops,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [startColor, endColor],
      stops: stops,
    );
  }

  /// 创建径向渐变色
  static RadialGradient createRadialGradient(
    Color centerColor,
    Color edgeColor, {
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
  }) {
    return RadialGradient(
      center: center,
      radius: radius,
      colors: [centerColor, edgeColor],
      stops: stops,
    );
  }
}
