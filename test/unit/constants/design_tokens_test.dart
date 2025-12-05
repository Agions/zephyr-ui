/// 设计令牌测试
/// 
/// 测试设计令牌的正确性和一致性。
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:velocity_ui/src/core/constants/design_tokens.dart';

void main() {
  group('VelocityColors', () {
    test('主色调应该有正确的值', () {
      expect(VelocityColors.primary500, const Color(0xFF2196F3));
      expect(VelocityColors.primary50, const Color(0xFFE3F2FD));
      expect(VelocityColors.primary900, const Color(0xFF0D47A1));
    });

    test('次要色调应该有正确的值', () {
      expect(VelocityColors.secondary500, const Color(0xFF009688));
      expect(VelocityColors.secondary50, const Color(0xFFE0F2F1));
      expect(VelocityColors.secondary900, const Color(0xFF004D40));
    });

    test('中性色调应该有正确的值', () {
      expect(VelocityColors.neutral50, const Color(0xFFFAFAFA));
      expect(VelocityColors.neutral500, const Color(0xFF9E9E9E));
      expect(VelocityColors.neutral900, const Color(0xFF212121));
    });

    test('语义色调应该有正确的值', () {
      expect(VelocityColors.success500, const Color(0xFF4CAF50));
      expect(VelocityColors.warning500, const Color(0xFFFF9800));
      expect(VelocityColors.error500, const Color(0xFFF44336));
      expect(VelocityColors.info500, const Color(0xFF03A9F4));
    });
  });

  group('VelocitySpacing', () {
    test('间距值应该递增', () {
      expect(VelocitySpacing.xs, 4.0);
      expect(VelocitySpacing.sm, 8.0);
      expect(VelocitySpacing.md, 16.0);
      expect(VelocitySpacing.lg, 24.0);
      expect(VelocitySpacing.xl, 32.0);
      expect(VelocitySpacing.xxl, 48.0);
      expect(VelocitySpacing.xxxl, 64.0);
    });

    test('间距值应该按比例递增', () {
      expect(VelocitySpacing.sm, VelocitySpacing.xs * 2);
      expect(VelocitySpacing.md, VelocitySpacing.sm * 2);
      expect(VelocitySpacing.lg, VelocitySpacing.md * 1.5);
    });
  });

  group('VelocityRadius', () {
    test('圆角值应该递增', () {
      expect(VelocityRadius.xs, 2.0);
      expect(VelocityRadius.sm, 4.0);
      expect(VelocityRadius.md, 8.0);
      expect(VelocityRadius.lg, 12.0);
      expect(VelocityRadius.xl, 16.0);
      expect(VelocityRadius.xxl, 24.0);
      expect(VelocityRadius.full, 9999.0);
    });
  });

  group('VelocityFontTokens', () {
    test('字体大小应该递增', () {
      expect(VelocityFontTokens.fontSize10, 10.0);
      expect(VelocityFontTokens.fontSize12, 12.0);
      expect(VelocityFontTokens.fontSize14, 14.0);
      expect(VelocityFontTokens.fontSize16, 16.0);
      expect(VelocityFontTokens.fontSize18, 18.0);
      expect(VelocityFontTokens.fontSize20, 20.0);
      expect(VelocityFontTokens.fontSize24, 24.0);
      expect(VelocityFontTokens.fontSize28, 28.0);
      expect(VelocityFontTokens.fontSize32, 32.0);
      expect(VelocityFontTokens.fontSize36, 36.0);
      expect(VelocityFontTokens.fontSize48, 48.0);
    });

    test('行高值应该合理', () {
      expect(VelocityFontTokens.lineHeight1_2, 1.2);
      expect(VelocityFontTokens.lineHeight1_4, 1.4);
      expect(VelocityFontTokens.lineHeight1_5, 1.5);
      expect(VelocityFontTokens.lineHeight1_6, 1.6);
    });

    test('字重值应该正确', () {
      expect(VelocityFontTokens.fontWeightLight, FontWeight.w300);
      expect(VelocityFontTokens.fontWeightRegular, FontWeight.w400);
      expect(VelocityFontTokens.fontWeightMedium, FontWeight.w500);
      expect(VelocityFontTokens.fontWeightSemiBold, FontWeight.w600);
      expect(VelocityFontTokens.fontWeightBold, FontWeight.w700);
    });
  });

  group('VelocityShadows', () {
    test('阴影应该有正确的层级', () {
      expect(VelocityShadows.xs.length, 1);
      expect(VelocityShadows.sm.length, 2);
      expect(VelocityShadows.md.length, 2);
      expect(VelocityShadows.lg.length, 2);
      expect(VelocityShadows.xl.length, 2);
    });

    test('阴影模糊半径应该递增', () {
      expect(VelocityShadows.xs.first.blurRadius, 1);
      expect(VelocityShadows.sm.first.blurRadius, 2);
      expect(VelocityShadows.md.first.blurRadius, 4);
      expect(VelocityShadows.lg.first.blurRadius, 8);
      expect(VelocityShadows.xl.first.blurRadius, 16);
    });
  });

  group('VelocityAnimations', () {
    test('动画时长应该合理', () {
      expect(VelocityAnimations.fast, const Duration(milliseconds: 150));
      expect(VelocityAnimations.normal, const Duration(milliseconds: 250));
      expect(VelocityAnimations.slow, const Duration(milliseconds: 350));
    });

    test('动画曲线应该正确', () {
      expect(VelocityAnimations.easeIn, Curves.easeIn);
      expect(VelocityAnimations.easeOut, Curves.easeOut);
      expect(VelocityAnimations.easeInOut, Curves.easeInOut);
      expect(VelocityAnimations.bounceOut, Curves.bounceOut);
    });
  });

  group('VelocityBreakpoints', () {
    test('断点值应该递增', () {
      expect(VelocityBreakpoints.xs, 0);
      expect(VelocityBreakpoints.sm, 576);
      expect(VelocityBreakpoints.md, 768);
      expect(VelocityBreakpoints.lg, 992);
      expect(VelocityBreakpoints.xl, 1200);
      expect(VelocityBreakpoints.xxl, 1400);
    });

    test('断点值应该符合常见标准', () {
      // 这些值基于 Bootstrap 和其他流行框架的断点
      expect(VelocityBreakpoints.sm >= 576, true);
      expect(VelocityBreakpoints.md >= 768, true);
      expect(VelocityBreakpoints.lg >= 992, true);
      expect(VelocityBreakpoints.xl >= 1200, true);
    });
  });
}
