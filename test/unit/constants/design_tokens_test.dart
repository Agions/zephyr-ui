/// 设计令牌测试
/// 
/// 测试设计令牌的正确性和一致性。
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/constants/design_tokens.dart';

void main() {
  group('ZephyrColors', () {
    test('主色调应该有正确的值', () {
      expect(ZephyrColors.primary500, const Color(0xFF2196F3));
      expect(ZephyrColors.primary50, const Color(0xFFE3F2FD));
      expect(ZephyrColors.primary900, const Color(0xFF0D47A1));
    });

    test('次要色调应该有正确的值', () {
      expect(ZephyrColors.secondary500, const Color(0xFF009688));
      expect(ZephyrColors.secondary50, const Color(0xFFE0F2F1));
      expect(ZephyrColors.secondary900, const Color(0xFF004D40));
    });

    test('中性色调应该有正确的值', () {
      expect(ZephyrColors.neutral50, const Color(0xFFFAFAFA));
      expect(ZephyrColors.neutral500, const Color(0xFF9E9E9E));
      expect(ZephyrColors.neutral900, const Color(0xFF212121));
    });

    test('语义色调应该有正确的值', () {
      expect(ZephyrColors.success500, const Color(0xFF4CAF50));
      expect(ZephyrColors.warning500, const Color(0xFFFF9800));
      expect(ZephyrColors.error500, const Color(0xFFF44336));
      expect(ZephyrColors.info500, const Color(0xFF03A9F4));
    });
  });

  group('ZephyrSpacing', () {
    test('间距值应该递增', () {
      expect(ZephyrSpacing.xs, 4.0);
      expect(ZephyrSpacing.sm, 8.0);
      expect(ZephyrSpacing.md, 16.0);
      expect(ZephyrSpacing.lg, 24.0);
      expect(ZephyrSpacing.xl, 32.0);
      expect(ZephyrSpacing.xxl, 48.0);
      expect(ZephyrSpacing.xxxl, 64.0);
    });

    test('间距值应该按比例递增', () {
      expect(ZephyrSpacing.sm, ZephyrSpacing.xs * 2);
      expect(ZephyrSpacing.md, ZephyrSpacing.sm * 2);
      expect(ZephyrSpacing.lg, ZephyrSpacing.md * 1.5);
    });
  });

  group('ZephyrRadius', () {
    test('圆角值应该递增', () {
      expect(ZephyrRadius.xs, 2.0);
      expect(ZephyrRadius.sm, 4.0);
      expect(ZephyrRadius.md, 8.0);
      expect(ZephyrRadius.lg, 12.0);
      expect(ZephyrRadius.xl, 16.0);
      expect(ZephyrRadius.xxl, 24.0);
      expect(ZephyrRadius.full, 9999.0);
    });
  });

  group('ZephyrTypography', () {
    test('字体大小应该递增', () {
      expect(ZephyrTypography.fontSize10, 10.0);
      expect(ZephyrTypography.fontSize12, 12.0);
      expect(ZephyrTypography.fontSize14, 14.0);
      expect(ZephyrTypography.fontSize16, 16.0);
      expect(ZephyrTypography.fontSize18, 18.0);
      expect(ZephyrTypography.fontSize20, 20.0);
      expect(ZephyrTypography.fontSize24, 24.0);
      expect(ZephyrTypography.fontSize28, 28.0);
      expect(ZephyrTypography.fontSize32, 32.0);
      expect(ZephyrTypography.fontSize36, 36.0);
      expect(ZephyrTypography.fontSize48, 48.0);
    });

    test('行高值应该合理', () {
      expect(ZephyrTypography.lineHeight1_2, 1.2);
      expect(ZephyrTypography.lineHeight1_4, 1.4);
      expect(ZephyrTypography.lineHeight1_5, 1.5);
      expect(ZephyrTypography.lineHeight1_6, 1.6);
    });

    test('字重值应该正确', () {
      expect(ZephyrTypography.fontWeightLight, FontWeight.w300);
      expect(ZephyrTypography.fontWeightRegular, FontWeight.w400);
      expect(ZephyrTypography.fontWeightMedium, FontWeight.w500);
      expect(ZephyrTypography.fontWeightSemiBold, FontWeight.w600);
      expect(ZephyrTypography.fontWeightBold, FontWeight.w700);
    });
  });

  group('ZephyrShadows', () {
    test('阴影应该有正确的层级', () {
      expect(ZephyrShadows.xs.length, 1);
      expect(ZephyrShadows.sm.length, 2);
      expect(ZephyrShadows.md.length, 2);
      expect(ZephyrShadows.lg.length, 2);
      expect(ZephyrShadows.xl.length, 2);
    });

    test('阴影模糊半径应该递增', () {
      expect(ZephyrShadows.xs.first.blurRadius, 1);
      expect(ZephyrShadows.sm.first.blurRadius, 2);
      expect(ZephyrShadows.md.first.blurRadius, 4);
      expect(ZephyrShadows.lg.first.blurRadius, 8);
      expect(ZephyrShadows.xl.first.blurRadius, 16);
    });
  });

  group('ZephyrAnimations', () {
    test('动画时长应该合理', () {
      expect(ZephyrAnimations.fast, const Duration(milliseconds: 150));
      expect(ZephyrAnimations.normal, const Duration(milliseconds: 250));
      expect(ZephyrAnimations.slow, const Duration(milliseconds: 350));
    });

    test('动画曲线应该正确', () {
      expect(ZephyrAnimations.easeIn, Curves.easeIn);
      expect(ZephyrAnimations.easeOut, Curves.easeOut);
      expect(ZephyrAnimations.easeInOut, Curves.easeInOut);
      expect(ZephyrAnimations.bounceOut, Curves.bounceOut);
    });
  });

  group('ZephyrBreakpoints', () {
    test('断点值应该递增', () {
      expect(ZephyrBreakpoints.xs, 0);
      expect(ZephyrBreakpoints.sm, 576);
      expect(ZephyrBreakpoints.md, 768);
      expect(ZephyrBreakpoints.lg, 992);
      expect(ZephyrBreakpoints.xl, 1200);
      expect(ZephyrBreakpoints.xxl, 1400);
    });

    test('断点值应该符合常见标准', () {
      // 这些值基于 Bootstrap 和其他流行框架的断点
      expect(ZephyrBreakpoints.sm >= 576, true);
      expect(ZephyrBreakpoints.md >= 768, true);
      expect(ZephyrBreakpoints.lg >= 992, true);
      expect(ZephyrBreakpoints.xl >= 1200, true);
    });
  });
}
