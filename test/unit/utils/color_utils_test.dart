/// 颜色工具测试
///
/// 测试颜色工具类的功能。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/utils/helpers/color_utils.dart';

void main() {
  group('ZephyrColorUtils', () {
    group('calculateContrast', () {
      test('should calculate correct contrast ratio', () {
        // 黑白对比度应该是最高的
        final blackWhiteContrast = ZephyrColorUtils.calculateContrast(
          Colors.black,
          Colors.white,
        );
        expect(blackWhiteContrast, closeTo(21.0, 0.1));

        // 相同颜色的对比度应该是1
        final sameColorContrast = ZephyrColorUtils.calculateContrast(
          Colors.red,
          Colors.red,
        );
        expect(sameColorContrast, closeTo(1.0, 0.1));

        // 测试具体的颜色对比度
        final blueWhiteContrast = ZephyrColorUtils.calculateContrast(
          Colors.blue,
          Colors.white,
        );
        expect(blueWhiteContrast, greaterThan(3.0)); // Blue and white have lower contrast
      });
    });

    group('isContrastAA', () {
      test('should correctly identify AA compliant contrast', () {
        expect(
          ZephyrColorUtils.isContrastAA(Colors.black, Colors.white),
          true,
        );
        expect(
          ZephyrColorUtils.isContrastAA(Colors.white, Colors.white),
          false,
        );
        expect(
          ZephyrColorUtils.isContrastAA(Colors.black, Colors.yellow),
          true,
        );
      });
    });

    group('isContrastAAA', () {
      test('should correctly identify AAA compliant contrast', () {
        expect(
          ZephyrColorUtils.isContrastAAA(Colors.black, Colors.white),
          true,
        );
        expect(
          ZephyrColorUtils.isContrastAAA(Colors.grey, Colors.white),
          false,
        );
      });
    });

    group('getBestTextColor', () {
      test('should return correct text color for background', () {
        expect(
          ZephyrColorUtils.getBestTextColor(Colors.white),
          Colors.black,
        );
        expect(
          ZephyrColorUtils.getBestTextColor(Colors.black),
          Colors.white,
        );
        expect(
          ZephyrColorUtils.getBestTextColor(Colors.yellow),
          Colors.black,
        );
        expect(
          ZephyrColorUtils.getBestTextColor(const Color(0xFF1976D2)), // Darker blue
          Colors.white,
        );
      });
    });

    group('adjustBrightness', () {
      test('should correctly adjust brightness', () {
        const originalColor = Colors.blue;
        
        // 增加亮度
        final brighterColor = ZephyrColorUtils.adjustBrightness(originalColor, 0.2);
        final brighterHsl = HSLColor.fromColor(brighterColor);
        final originalHsl = HSLColor.fromColor(originalColor);
        expect(brighterHsl.lightness, greaterThan(originalHsl.lightness));

        // 减少亮度
        final darkerColor = ZephyrColorUtils.adjustBrightness(originalColor, -0.2);
        final darkerHsl = HSLColor.fromColor(darkerColor);
        expect(darkerHsl.lightness, lessThan(originalHsl.lightness));

        // 边界值测试
        final maxBright = ZephyrColorUtils.adjustBrightness(originalColor, 1.0);
        final maxBrightHsl = HSLColor.fromColor(maxBright);
        expect(maxBrightHsl.lightness, closeTo(1.0, 0.01));

        final maxDark = ZephyrColorUtils.adjustBrightness(originalColor, -1.0);
        final maxDarkHsl = HSLColor.fromColor(maxDark);
        expect(maxDarkHsl.lightness, closeTo(0.0, 0.01));
      });

      test('should throw assertion error for invalid amount', () {
        expect(
          () => ZephyrColorUtils.adjustBrightness(Colors.blue, 1.5),
          throwsAssertionError,
        );
        expect(
          () => ZephyrColorUtils.adjustBrightness(Colors.blue, -1.5),
          throwsAssertionError,
        );
      });
    });

    group('adjustSaturation', () {
      test('should correctly adjust saturation', () {
        const originalColor = Colors.blue;
        
        // 增加饱和度
        final moreSaturated = ZephyrColorUtils.adjustSaturation(originalColor, 0.2);
        final moreSaturatedHsl = HSLColor.fromColor(moreSaturated);
        final originalHsl = HSLColor.fromColor(originalColor);
        expect(moreSaturatedHsl.saturation, greaterThanOrEqualTo(originalHsl.saturation));

        // 减少饱和度
        final lessSaturated = ZephyrColorUtils.adjustSaturation(originalColor, -0.2);
        final lessSaturatedHsl = HSLColor.fromColor(lessSaturated);
        expect(lessSaturatedHsl.saturation, lessThan(originalHsl.saturation));
      });
    });

    group('adjustOpacity', () {
      test('should correctly adjust opacity', () {
        const originalColor = Colors.blue;
        
        final semiTransparent = ZephyrColorUtils.adjustOpacity(originalColor, 0.5);
        expect(semiTransparent.a, closeTo(0.5, 0.01));

        final fullyOpaque = ZephyrColorUtils.adjustOpacity(originalColor, 1.0);
        expect(fullyOpaque.a, closeTo(1.0, 0.01));

        final fullyTransparent = ZephyrColorUtils.adjustOpacity(originalColor, 0.0);
        expect(fullyTransparent.a, closeTo(0.0, 0.01));
      });
    });

    group('blendColors', () {
      test('should correctly blend colors', () {
        const color1 = Color(0xFFFF0000);
        const color2 = Color(0xFF0000FF);
        
        // 0.0 应该返回第一个颜色
        final blend0 = ZephyrColorUtils.blendColors(color1, color2, 0.0);
        expect(blend0, color1);

        // 1.0 应该返回第二个颜色
        final blend1 = ZephyrColorUtils.blendColors(color1, color2, 1.0);
        expect(blend1, color2);

        // 0.5 应该返回中间值
        final blend05 = ZephyrColorUtils.blendColors(color1, color2, 0.5);
        expect(blend05.red, ((color1.red + color2.red) / 2).round());
        expect(blend05.blue, ((color1.blue + color2.blue) / 2).round());
      });
    });

    group('generateColorShades', () {
      test('should generate correct number of shades', () {
        final shades = ZephyrColorUtils.generateColorShades(Colors.blue);
        expect(shades.length, 9); // 默认生成9个色调

        final customShades = ZephyrColorUtils.generateColorShades(Colors.blue, count: 5);
        expect(customShades.length, 5);
      });

      test('should generate shades with decreasing lightness', () {
        final shades = ZephyrColorUtils.generateColorShades(Colors.blue);
        
        for (int i = 1; i < shades.length; i++) {
          final currentHsl = HSLColor.fromColor(shades[i]);
          final previousHsl = HSLColor.fromColor(shades[i - 1]);
          expect(currentHsl.lightness, lessThan(previousHsl.lightness));
        }
      });
    });

    group('generateMaterialColorSwatch', () {
      test('should generate correct material color swatch', () {
        final swatch = ZephyrColorUtils.generateMaterialColorSwatch(Colors.blue);
        
        expect(swatch.keys, containsAll([50, 100, 200, 300, 400, 500, 600, 700, 800, 900]));
        expect(swatch[500], Colors.blue); // 500应该是基础颜色
      });
    });

    group('fromHex', () {
      test('should correctly parse hex strings', () {
        expect(ZephyrColorUtils.fromHex('#FF0000'), const Color(0xFFFF0000));
        expect(ZephyrColorUtils.fromHex('FF0000'), const Color(0xFFFF0000));
        expect(ZephyrColorUtils.fromHex('#00FF00'), const Color(0xFF00FF00));
        expect(ZephyrColorUtils.fromHex('#0000FF'), const Color(0xFF0000FF));
      });
    });

    group('toHex', () {
      test('should correctly convert colors to hex', () {
        expect(ZephyrColorUtils.toHex(const Color(0xFFFF0000)), '#FF0000');
        expect(ZephyrColorUtils.toHex(const Color(0xFF00FF00)), '#00FF00');
        expect(ZephyrColorUtils.toHex(const Color(0xFF0000FF)), '#0000FF');
        
        // 测试包含alpha通道
        expect(
          ZephyrColorUtils.toHex(const Color(0xFFFF0000).withValues(alpha: 0.5), includeAlpha: true),
          contains('80'), // 0.5 * 255 ≈ 128 = 0x80
        );
      });
    });

    group('isDark and isLight', () {
      test('should correctly identify dark and light colors', () {
        expect(ZephyrColorUtils.isDark(Colors.black), true);
        expect(ZephyrColorUtils.isLight(Colors.black), false);
        
        expect(ZephyrColorUtils.isDark(Colors.white), false);
        expect(ZephyrColorUtils.isLight(Colors.white), true);
        
        expect(ZephyrColorUtils.isDark(const Color(0xFF1976D2)), true); // Darker blue
        expect(ZephyrColorUtils.isLight(Colors.yellow), true);
      });
    });

    group('getComplementaryColor', () {
      test('should return correct complementary color', () {
        const red = Colors.red;
        final complementary = ZephyrColorUtils.getComplementaryColor(red);
        
        final redHsl = HSLColor.fromColor(red);
        final complementaryHsl = HSLColor.fromColor(complementary);
        
        // 补色的色相应该相差180度
        final hueDifference = (complementaryHsl.hue - redHsl.hue).abs();
        expect(hueDifference, closeTo(180.0, 1.0));
      });
    });

    group('getAnalogousColors', () {
      test('should return three analogous colors', () {
        final colors = ZephyrColorUtils.getAnalogousColors(Colors.blue);
        expect(colors.length, 3);
        expect(colors[1], Colors.blue); // 中间的应该是原色
      });
    });

    group('getTriadicColors', () {
      test('should return three triadic colors', () {
        final colors = ZephyrColorUtils.getTriadicColors(Colors.blue);
        expect(colors.length, 3);
        expect(colors[0], Colors.blue); // 第一个应该是原色
      });
    });

    group('createGradient', () {
      test('should create linear gradient', () {
        final gradient = ZephyrColorUtils.createGradient(
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
        final gradient = ZephyrColorUtils.createRadialGradient(
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
