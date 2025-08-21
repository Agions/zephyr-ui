import 'package:flutter/material.dart';

/// 给指定颜色添加透明度
Color colorWithOpacity(Color color, double opacity) {
  return color.withValues(alpha: opacity);
}

/// 根据亮度自动计算对比色
Color contrastColor(
  Color backgroundColor, {
  Color lightColor = Colors.white,
  Color darkColor = Colors.black,
  double threshold = 0.5,
}) {
  // 计算颜色亮度 (0-1)
  final brightness = (backgroundColor.r * 299 +
          backgroundColor.g * 587 +
          backgroundColor.b * 114) /
      1000 /
      255;

  // 根据亮度返回适合的对比色
  return brightness > threshold ? darkColor : lightColor;
}

/// 根据主题亮度自动调整颜色
Color adaptiveColor(
    BuildContext context, Color lightModeColor, Color darkModeColor) {
  final brightness = Theme.of(context).brightness;
  return brightness == Brightness.light ? lightModeColor : darkModeColor;
}

/// 创建一个颜色的色调变化集合
Map<int, Color> createColorSwatch(Color baseColor) {
  final hslColor = HSLColor.fromColor(baseColor);
  final lightness = hslColor.lightness;

  // 创建从浅到深的色调变化
  return {
    50: hslColor.withLightness((lightness + .25).clamp(0.0, 1.0)).toColor(),
    100: hslColor.withLightness((lightness + .15).clamp(0.0, 1.0)).toColor(),
    200: hslColor.withLightness((lightness + .10).clamp(0.0, 1.0)).toColor(),
    300: hslColor.withLightness((lightness + .05).clamp(0.0, 1.0)).toColor(),
    400: hslColor.withLightness(lightness).toColor(),
    500: hslColor.withLightness((lightness - .05).clamp(0.0, 1.0)).toColor(),
    600: hslColor.withLightness((lightness - .10).clamp(0.0, 1.0)).toColor(),
    700: hslColor.withLightness((lightness - .15).clamp(0.0, 1.0)).toColor(),
    800: hslColor.withLightness((lightness - .20).clamp(0.0, 1.0)).toColor(),
    900: hslColor.withLightness((lightness - .25).clamp(0.0, 1.0)).toColor(),
  };
}

/// 根据背景色自动计算阴影颜色
Color shadowColorFromBackground(Color backgroundColor) {
  final hslColor = HSLColor.fromColor(backgroundColor);
  return hslColor
      .withLightness((hslColor.lightness - 0.2).clamp(0.0, 1.0))
      .toColor()
      .withValues(alpha: 0.3);
}

/// 混合两种颜色
Color blendColors(Color color1, Color color2, [double weight = 0.5]) {
  return Color.fromARGB(
    255,
    (color1.r * (1 - weight) + color2.r * weight).round(),
    (color1.g * (1 - weight) + color2.g * weight).round(),
    (color1.b * (1 - weight) + color2.b * weight).round(),
  );
}

/// 获取Surface颜色，用于Card等组件
Color getSurfaceColor(Color backgroundColor, {double elevation = 1.0}) {
  // 根据高度计算透明度
  final opacity = 0.05 * elevation.clamp(0.0, 5.0);

  // 白色基础，添加一定透明度的背景色
  return blendColors(Colors.white, backgroundColor, opacity);
}
