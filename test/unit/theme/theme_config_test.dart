/// 主题配置测试
///
/// 测试主题配置工厂方法和预设主题的功能。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/core/theme/theme_config.dart';
import 'package:velocity_ui/src/core/constants/design_tokens.dart';

void main() {
  group('VelocityThemeConfig', () {
    group('createLightTheme', () {
      test('应该创建默认浅色主题', () {
        final theme = VelocityThemeConfig.createLightTheme();
        
        expect(theme.brightness, Brightness.light);
        expect(theme.primaryColor, VelocityColors.primary500);
        expect(theme.secondaryColor, VelocityColors.secondary500);
        expect(theme.backgroundColor, VelocityColors.neutral50);
        expect(theme.errorColor, VelocityColors.error500);
      });

      test('应该支持自定义颜色', () {
        const customPrimary = Colors.red;
        const customSecondary = Colors.green;
        const customBackground = Colors.blue;
        const customError = Colors.purple;
        
        final theme = VelocityThemeConfig.createLightTheme(
          primaryColor: customPrimary,
          secondaryColor: customSecondary,
          backgroundColor: customBackground,
          errorColor: customError,
        );
        
        expect(theme.primaryColor, customPrimary);
        expect(theme.secondaryColor, customSecondary);
        expect(theme.backgroundColor, customBackground);
        expect(theme.errorColor, customError);
      });

      test('应该包含所有必需的主题配置', () {
        final theme = VelocityThemeConfig.createLightTheme();
        
        expect(theme.textTheme, isNotNull);
        expect(theme.buttonTheme, isNotNull);
        expect(theme.velocityTextTheme, isNotNull);
        expect(theme.dividerTheme, isNotNull);
        expect(theme.iconTheme, isNotNull);
        expect(theme.badgeTheme, isNotNull);
        expect(theme.sideMenuTheme, isNotNull);
        expect(theme.stepperTheme, isNotNull);
        expect(theme.checkboxGroupTheme, isNotNull);
        expect(theme.radioGroupTheme, isNotNull);
        expect(theme.sliderTheme, isNotNull);
        expect(theme.datePickerTheme, isNotNull);
      });
    });

    group('createDarkTheme', () {
      test('应该创建默认深色主题', () {
        final theme = VelocityThemeConfig.createDarkTheme();
        
        expect(theme.brightness, Brightness.dark);
        expect(theme.primaryColor, VelocityColors.primary200);
        expect(theme.secondaryColor, VelocityColors.secondary200);
        expect(theme.backgroundColor, VelocityColors.neutral900);
        expect(theme.errorColor, VelocityColors.error500);
      });

      test('应该支持自定义颜色', () {
        const customPrimary = Colors.red;
        const customSecondary = Colors.green;
        const customBackground = Colors.blue;
        const customError = Colors.purple;
        
        final theme = VelocityThemeConfig.createDarkTheme(
          primaryColor: customPrimary,
          secondaryColor: customSecondary,
          backgroundColor: customBackground,
          errorColor: customError,
        );
        
        expect(theme.primaryColor, customPrimary);
        expect(theme.secondaryColor, customSecondary);
        expect(theme.backgroundColor, customBackground);
        expect(theme.errorColor, customError);
      });

      test('深色主题应该使用合适的文本颜色', () {
        final theme = VelocityThemeConfig.createDarkTheme();
        
        expect(theme.velocityTextTheme.primaryColor, Colors.white);
        expect(theme.velocityTextTheme.secondaryColor, VelocityColors.neutral400);
      });
    });

    group('createEnterpriseTheme', () {
      test('应该创建浅色企业主题', () {
        final theme = VelocityThemeConfig.createEnterpriseTheme(
          brightness: Brightness.light,
        );
        
        expect(theme.brightness, Brightness.light);
        expect(theme.primaryColor, const Color(0xFF1565C0));
        expect(theme.secondaryColor, const Color(0xFF37474F));
      });

      test('应该创建深色企业主题', () {
        final theme = VelocityThemeConfig.createEnterpriseTheme(
          brightness: Brightness.dark,
        );
        
        expect(theme.brightness, Brightness.dark);
        expect(theme.primaryColor, const Color(0xFF1565C0));
        expect(theme.secondaryColor, const Color(0xFF37474F));
      });
    });

    group('createModernTheme', () {
      test('应该创建浅色现代主题', () {
        final theme = VelocityThemeConfig.createModernTheme(
          brightness: Brightness.light,
        );
        
        expect(theme.brightness, Brightness.light);
        expect(theme.primaryColor, const Color(0xFF6366F1));
        expect(theme.secondaryColor, const Color(0xFF8B5CF6));
      });

      test('应该创建深色现代主题', () {
        final theme = VelocityThemeConfig.createModernTheme(
          brightness: Brightness.dark,
        );
        
        expect(theme.brightness, Brightness.dark);
        expect(theme.primaryColor, const Color(0xFF6366F1));
        expect(theme.secondaryColor, const Color(0xFF8B5CF6));
      });
    });

    group('createNatureTheme', () {
      test('应该创建浅色自然主题', () {
        final theme = VelocityThemeConfig.createNatureTheme(
          brightness: Brightness.light,
        );
        
        expect(theme.brightness, Brightness.light);
        expect(theme.primaryColor, const Color(0xFF4CAF50));
        expect(theme.secondaryColor, const Color(0xFF8BC34A));
      });

      test('应该创建深色自然主题', () {
        final theme = VelocityThemeConfig.createNatureTheme(
          brightness: Brightness.dark,
        );
        
        expect(theme.brightness, Brightness.dark);
        expect(theme.primaryColor, const Color(0xFF4CAF50));
        expect(theme.secondaryColor, const Color(0xFF8BC34A));
      });
    });

    group('button theme', () {
      test('浅色主题应该使用正确的按钮颜色', () {
        final theme = VelocityThemeConfig.createLightTheme();
        
        expect(theme.buttonTheme.primaryBackgroundColor, VelocityColors.primary500);
        expect(theme.buttonTheme.primaryTextColor, Colors.white);
        expect(theme.buttonTheme.secondaryBackgroundColor, VelocityColors.secondary500);
        expect(theme.buttonTheme.secondaryTextColor, Colors.white);
      });

      test('深色主题应该使用正确的按钮颜色', () {
        final theme = VelocityThemeConfig.createDarkTheme();
        
        expect(theme.buttonTheme.primaryBackgroundColor, VelocityColors.primary200);
        expect(theme.buttonTheme.primaryTextColor, VelocityColors.neutral900);
        expect(theme.buttonTheme.secondaryBackgroundColor, VelocityColors.secondary200);
        expect(theme.buttonTheme.secondaryTextColor, VelocityColors.neutral900);
      });
    });

    group('text theme', () {
      test('浅色主题应该使用合适的文本颜色', () {
        final theme = VelocityThemeConfig.createLightTheme();
        
        expect(theme.velocityTextTheme.primaryColor, VelocityColors.neutral900);
        expect(theme.velocityTextTheme.secondaryColor, VelocityColors.neutral600);
      });

      test('深色主题应该使用合适的文本颜色', () {
        final theme = VelocityThemeConfig.createDarkTheme();
        
        expect(theme.velocityTextTheme.primaryColor, Colors.white);
        expect(theme.velocityTextTheme.secondaryColor, VelocityColors.neutral400);
      });
    });

    group('font family', () {
      test('应该支持自定义字体', () {
        const customFont = 'Roboto';
        final lightTheme = VelocityThemeConfig.createLightTheme(fontFamily: customFont);
        final darkTheme = VelocityThemeConfig.createDarkTheme(fontFamily: customFont);
        
        expect(lightTheme.textTheme.bodyLarge?.fontFamily, customFont);
        expect(darkTheme.textTheme.bodyLarge?.fontFamily, customFont);
      });

      test('默认主题应该使用系统字体', () {
        final theme = VelocityThemeConfig.createLightTheme();
        
        // 预期可能不为空，因为Flutter默认使用Roboto字体
        expect(theme.textTheme.bodyLarge?.fontFamily, anyOf(isNull, equals('Roboto')));
      });
    });

    group('accessibility', () {
      test('主题颜色应该有合理的对比度', () {
        final lightTheme = VelocityThemeConfig.createLightTheme();
        final darkTheme = VelocityThemeConfig.createDarkTheme();
        
        // 检查按钮颜色是否配置正确（不为空）
        expect(lightTheme.buttonTheme.primaryTextColor, isNotNull);
        expect(lightTheme.buttonTheme.primaryBackgroundColor, isNotNull);
        expect(darkTheme.buttonTheme.primaryTextColor, isNotNull);
        expect(darkTheme.buttonTheme.primaryBackgroundColor, isNotNull);
        
        // 检查文本和背景颜色不同（确保可读性）
        expect(lightTheme.buttonTheme.primaryTextColor, isNot(lightTheme.buttonTheme.primaryBackgroundColor));
        expect(darkTheme.buttonTheme.primaryTextColor, isNot(darkTheme.buttonTheme.primaryBackgroundColor));
      });
    });
  });
}

