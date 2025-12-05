/// 颜色工具测试
///
/// 测试颜色工具类的功能。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/utils/helpers/color_utils.dart';

void main() {
  group('VelocityColorUtils', () {
    group('calculateContrast', () {
      test('should calculate correct contrast ratio', () {
        // 黑白对比度应该是最高的
        final blackWhiteContrast = VelocityColorUtils.calculateContrast(
          Colors.black,
          Colors.white,
        );
        expect(blackWhiteContrast, closeTo(21.0, 0.1));

        // 相同颜色的对比度应该是1
        final sameColorContrast = VelocityColorUtils.calculateContrast(
          Colors.red,
          Colors.red,
        );
        expect(sameColorContrast, closeTo(1.0, 0.1));

        // 测试具体的颜色对比度
        final blueWhiteContrast = VelocityColorUtils.calculateContrast(
          Colors.blue,
          Colors.white,
        );
        expect(blueWhiteContrast, greaterThan(3.0)); // Blue and white have lower contrast
      });
    });

    group('isContrastAA', () {
      test('should correctly identify AA compliant contrast', () {
        expect(
          VelocityColorUtils.isContrastAA(Colors.black, Colors.white),
          true,
        );
        expect(
          VelocityColorUtils.isContrastAA(Colors.white, Colors.white),
          false,
        );
        expect(
          VelocityColorUtils.isContrastAA(Colors.black, Colors.yellow),
          true,
        );
      });
    });

    group('isContrastAAA', () {
      test('should correctly identify AAA compliant contrast', () {
        expect(
          VelocityColorUtils.isContrastAAA(Colors.black, Colors.white),
          true,
        );
        expect(
          VelocityColorUtils.isContrastAAA(Colors.grey, Colors.white),
          false,
        );
      });
    });

    group('getBestTextColor', () {
      test('should return correct text color for background', () {
        expect(
          VelocityColorUtils.getBestTextColor(Colors.white),
          Colors.black,
        );
        expect(
          VelocityColorUtils.getBestTextColor(Colors.black),
          Colors.white,
        );
        expect(
          VelocityColorUtils.getBestTextColor(Colors.yellow),
          Colors.black,
        );
        expect(
          VelocityColorUtils.getBestTextColor(const Color(0xFF1976D2)), // Darker blue
          Colors.white,
        );
      });
    });

    group('adjustBrightness', () {
      test('should correctly adjust brightness', () {
        const originalColor = Colors.blue;
        
        // 增加亮度
        final brighterColor = VelocityColorUtils.adjustBrightness(originalColor, 0.2);
        final brighterHsl = HSLColor.fromColor(brighterColor);
        final originalHsl = HSLColor.fromColor(originalColor);
        expect(brighterHsl.lightness, greaterThan(originalHsl.lightness));

        // 减少亮度
        final darkerColor = VelocityColorUtils.adjustBrightness(originalColor, -0.2);
        final darkerHsl = HSLColor.fromColor(darkerColor);
        expect(darkerHsl.lightness, lessThan(originalHsl.lightness));

        // 边界值测试
        final maxBright = VelocityColorUtils.adjustBrightness(originalColor, 1.0);
        final maxBrightHsl = HSLColor.fromColor(maxBright);
        expect(maxBrightHsl.lightness, closeTo(1.0, 0.01));

        final maxDark = VelocityColorUtils.adjustBrightness(originalColor, -1.0);
        final maxDarkHsl = HSLColor.fromColor(maxDark);
        expect(maxDarkHsl.lightness, closeTo(0.0, 0.01));
      });

      test('should throw assertion error for invalid amount', () {
        expect(
          () => VelocityColorUtils.adjustBrightness(Colors.blue, 1.5),
          throwsAssertionError,
        );
        expect(
          () => VelocityColorUtils.adjustBrightness(Colors.blue, -1.5),
          throwsAssertionError,
        );
      });
    });

    group('adjustSaturation', () {
      test('should correctly adjust saturation', () {
        const originalColor = Colors.blue;
        
        // 增加饱和度
        final moreSaturated = VelocityColorUtils.adjustSaturation(originalColor, 0.2);
        final moreSaturatedHsl = HSLColor.fromColor(moreSaturated);
        final originalHsl = HSLColor.fromColor(originalColor);
        expect(moreSaturatedHsl.saturation, greaterThanOrEqualTo(originalHsl.saturation));

        // 减少饱和度
        final lessSaturated = VelocityColorUtils.adjustSaturation(originalColor, -0.2);
        final lessSaturatedHsl = HSLColor.fromColor(lessSaturated);
        expect(lessSaturatedHsl.saturation, lessThan(originalHsl.saturation));
      });
    });

    group('adjustOpacity', () {
      test('should correctly adjust opacity', () {
        const originalColor = Colors.blue;
        
        final semiTransparent = VelocityColorUtils.adjustOpacity(originalColor, 0.5);
        expect(semiTransparent.a, closeTo(0.5, 0.01));

        final fullyOpaque = VelocityColorUtils.adjustOpacity(originalColor, 1.0);
        expect(fullyOpaque.a, closeTo(1.0, 0.01));

        final fullyTransparent = VelocityColorUtils.adjustOpacity(originalColor, 0.0);
        expect(fullyTransparent.a, closeTo(0.0, 0.01));
      });
    });

    group('blendColors', () {
      test('should correctly blend colors', () {
        const color1 = Color(0xFFFF0000);
        const color2 = Color(0xFF0000FF);
        
        // 0.0 应该返回第一个颜色
        final blend0 = VelocityColorUtils.blendColors(color1, color2, 0.0);
        expect(blend0, color1);

        // 1.0 应该返回第二个颜色
        final blend1 = VelocityColorUtils.blendColors(color1, color2, 1.0);
        expect(blend1, color2);

        // 0.5 应该返回中间值
        final blend05 = VelocityColorUtils.blendColors(color1, color2, 0.5);
        expect(blend05.red, ((color1.red + color2.red) / 2).round());
        expect(blend05.blue, ((color1.blue + color2.blue) / 2).round());
      });
    });

    group('generateColorShades', () {
      test('should generate correct number of shades', () {
        final shades = VelocityColorUtils.generateColorShades(Colors.blue);
        expect(shades.length, 9); // 默认生成9个色调

        final customShades = VelocityColorUtils.generateColorShades(Colors.blue, count: 5);
        expect(customShades.length, 5);
      });

      test('should generate shades with decreasing lightness', () {
        final shades = VelocityColorUtils.generateColorShades(Colors.blue);
        
        for (var i = 1; i < shades.length; i++) {
          final currentHsl = HSLColor.fromColor(shades[i]);
          final previousHsl = HSLColor.fromColor(shades[i - 1]);
          expect(currentHsl.lightness, lessThan(previousHsl.lightness));
        }
      });
    });

    group('generateMaterialColorSwatch', () {
      test('should generate correct material color swatch', () {
        final swatch = VelocityColorUtils.generateMaterialColorSwatch(Colors.blue);
        
        expect(swatch.keys, containsAll([50, 100, 200, 300, 400, 500, 600, 700, 800, 900]));
        expect(swatch[500], Colors.blue); // 500应该是基础颜色
      });
    });

    group('fromHex', () {
      test('should correctly parse hex strings', () {
        expect(VelocityColorUtils.fromHex('#FF0000'), const Color(0xFFFF0000));
        expect(VelocityColorUtils.fromHex('FF0000'), const Color(0xFFFF0000));
        expect(VelocityColorUtils.fromHex('#00FF00'), const Color(0xFF00FF00));
        expect(VelocityColorUtils.fromHex('#0000FF'), const Color(0xFF0000FF));
      });
    });

    group('toHex', () {
      test('should correctly convert colors to hex', () {
        expect(VelocityColorUtils.toHex(const Color(0xFFFF0000)), '#FF0000');
        expect(VelocityColorUtils.toHex(const Color(0xFF00FF00)), '#00FF00');
        expect(VelocityColorUtils.toHex(const Color(0xFF0000FF)), '#0000FF');
        
        // 测试包含alpha通道
        expect(
          VelocityColorUtils.toHex(const Color(0xFFFF0000).withValues(alpha: 0.5), includeAlpha: true),
          contains('80'), // 0.5 * 255 ≈ 128 = 0x80
        );
      });
    });

    group('isDark and isLight', () {
      test('should correctly identify dark and light colors', () {
        expect(VelocityColorUtils.isDark(Colors.black), true);
        expect(VelocityColorUtils.isLight(Colors.black), false);
        
        expect(VelocityColorUtils.isDark(Colors.white), false);
        expect(VelocityColorUtils.isLight(Colors.white), true);
        
        expect(VelocityColorUtils.isDark(const Color(0xFF1976D2)), true); // Darker blue
        expect(VelocityColorUtils.isLight(Colors.yellow), true);
      });
    });

    group('getComplementaryColor', () {
      test('should return correct complementary color', () {
        const red = Colors.red;
        final complementary = VelocityColorUtils.getComplementaryColor(red);
        
        final redHsl = HSLColor.fromColor(red);
        final complementaryHsl = HSLColor.fromColor(complementary);
        
        // 补色的色相应该相差180度
        final hueDifference = (complementaryHsl.hue - redHsl.hue).abs();
        expect(hueDifference, closeTo(180.0, 1.0));
      });
    });

    group('getAnalogousColors', () {
      test('should return three analogous colors', () {
        final colors = VelocityColorUtils.getAnalogousColors(Colors.blue);
        expect(colors.length, 3);
        expect(colors[1], Colors.blue); // 中间的应该是原色
      });
    });

    group('getTriadicColors', () {
      test('should return three triadic colors', () {
        final colors = VelocityColorUtils.getTriadicColors(Colors.blue);
        expect(colors.length, 3);
        expect(colors[0], Colors.blue); // 第一个应该是原色
      });
    });

    group('createGradient', () {
      test('should create linear gradient', () {
        final gradient = VelocityColorUtils.createGradient(
          Colors.red,
          Colors.blue,
        );
        
        expect(gradient.colors, [Colors.red, Colors.blue]);
        expect(gradient.begin, Alignment.topLeft);
        expect(gradient.end, Alignment.bottomRight);
      });
    });

    group('createRadialGradient', () {
      test('should create radial gradient', () {
        final gradient = VelocityColorUtils.createRadialGradient(
          Colors.red,
          Colors.blue,
        );
        
        expect(gradient.colors, [Colors.red, Colors.blue]);
        expect(gradient.center, Alignment.center);
        expect(gradient.radius, 0.5);
      });
    });
  });
}
