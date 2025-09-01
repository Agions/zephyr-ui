/// ZephyrUI 设计令牌系统
/// 
/// 基于 Material Design 3 规范的统一设计令牌系统
/// 包含颜色、间距、字体、阴影、动画等完整的设计系统
library design_tokens;

import 'package:flutter/material.dart';

/// 颜色令牌系统 - 基于 Material Design 3
class ZephyrColorTokens {
  ZephyrColorTokens._();

  // 主色调系列
  static const Color primary0 = Color(0xFF000000);
  static const Color primary10 = Color(0xFF001F3F);
  static const Color primary20 = Color(0xFF003366);
  static const Color primary30 = Color(0xFF004080);
  static const Color primary40 = Color(0xFF0052A3);
  static const Color primary50 = Color(0xFF0066CC);
  static const Color primary60 = Color(0xFF0073E6);
  static const Color primary70 = Color(0xFF0080FF);
  static const Color primary80 = Color(0xFF3399FF);
  static const Color primary90 = Color(0xFF66B2FF);
  static const Color primary95 = Color(0xFF99CCFF);
  static const Color primary99 = Color(0xFFE6F2FF);
  static const Color primary100 = Color(0xFFFFFFFF);

  // 次要色调系列
  static const Color secondary0 = Color(0xFF000000);
  static const Color secondary10 = Color(0xFF001A1A);
  static const Color secondary20 = Color(0xFF003333);
  static const Color secondary30 = Color(0xFF004D4D);
  static const Color secondary40 = Color(0xFF006666);
  static const Color secondary50 = Color(0xFF008080);
  static const Color secondary60 = Color(0xFF009999);
  static const Color secondary70 = Color(0xFF00B3B3);
  static const Color secondary80 = Color(0xFF33CCCC);
  static const Color secondary90 = Color(0xFF66D9D9);
  static const Color secondary95 = Color(0xFF99E6E6);
  static const Color secondary99 = Color(0xFFE6F7F7);
  static const Color secondary100 = Color(0xFFFFFFFF);

  // 中性色调系列
  static const Color neutral0 = Color(0xFF000000);
  static const Color neutral4 = Color(0xFF0F0F0F);
  static const Color neutral6 = Color(0xFF171717);
  static const Color neutral10 = Color(0xFF1F1F1F);
  static const Color neutral12 = Color(0xFF242424);
  static const Color neutral17 = Color(0xFF2C2C2C);
  static const Color neutral20 = Color(0xFF333333);
  static const Color neutral22 = Color(0xFF383838);
  static const Color neutral24 = Color(0xFF3D3D3D);
  static const Color neutral30 = Color(0xFF4D4D4D);
  static const Color neutral40 = Color(0xFF666666);
  static const Color neutral50 = Color(0xFF808080);
  static const Color neutral60 = Color(0xFF999999);
  static const Color neutral70 = Color(0xFFB3B3B3);
  static const Color neutral80 = Color(0xFFCCCCCC);
  static const Color neutral90 = Color(0xFFE6E6E6);
  static const Color neutral94 = Color(0xFFEFEFEF);
  static const Color neutral95 = Color(0xFFF2F2F2);
  static const Color neutral96 = Color(0xFFF5F5F5);
  static const Color neutral98 = Color(0xFAFAFA);
  static const Color neutral99 = Color(0xFFFBFBFB);
  static const Color neutral100 = Color(0xFFFFFFFF);

  // 语义色调系列
  static const Color error0 = Color(0xFF000000);
  static const Color error10 = Color(0xFF330000);
  static const Color error20 = Color(0xFF660000);
  static const Color error30 = Color(0xFF990000);
  static const Color error40 = Color(0xFFCC0000);
  static const Color error50 = Color(0xFFFF0000);
  static const Color error60 = Color(0xFFFF3333);
  static const Color error70 = Color(0xFFFF6666);
  static const Color error80 = Color(0xFFFF9999);
  static const Color error90 = Color(0xFFFFCCCC);
  static const Color error95 = Color(0xFFFFE6E6);
  static const Color error99 = Color(0xFFFFF5F5);
  static const Color error100 = Color(0xFFFFFFFF);

  static const Color success0 = Color(0xFF000000);
  static const Color success10 = Color(0xFF003300);
  static const Color success20 = Color(0xFF006600);
  static const Color success30 = Color(0xFF009900);
  static const Color success40 = Color(0xFF00CC00);
  static const Color success50 = Color(0xFF00FF00);
  static const Color success60 = Color(0xFF33FF33);
  static const Color success70 = Color(0xFF66FF66);
  static const Color success80 = Color(0xFF99FF99);
  static const Color success90 = Color(0xFFCCFFCC);
  static const Color success95 = Color(0xFFE6FFE6);
  static const Color success99 = Color(0xFFF5FFF5);
  static const Color success100 = Color(0xFFFFFFFF);

  static const Color warning0 = Color(0xFF000000);
  static const Color warning10 = Color(0xFF332200);
  static const Color warning20 = Color(0xFF664400);
  static const Color warning30 = Color(0xFF996600);
  static const Color warning40 = Color(0xFFCC8800);
  static const Color warning50 = Color(0xFFFFAA00);
  static const Color warning60 = Color(0xFFFFBB33);
  static const Color warning70 = Color(0xFFFFCC66);
  static const Color warning80 = Color(0xFFFFDD99);
  static const Color warning90 = Color(0xFFFFEECC);
  static const Color warning95 = Color(0xFFFFF6E6);
  static const Color warning99 = Color(0xFFFFFBF5);
  static const Color warning100 = Color(0xFFFFFFFF);

  static const Color info0 = Color(0xFF000000);
  static const Color info10 = Color(0xFF001133);
  static const Color info20 = Color(0xFF002266);
  static const Color info30 = Color(0xFF003399);
  static const Color info40 = Color(0xFF0044CC);
  static const Color info50 = Color(0xFF0055FF);
  static const Color info60 = Color(0xFF3377FF);
  static const Color info70 = Color(0xFF6699FF);
  static const Color info80 = Color(0xFF99BBFF);
  static const Color info90 = Color(0xFFCCDDFF);
  static const Color info95 = Color(0xFFE6F2FF);
  static const Color info99 = Color(0xFFF5FAFF);
  static const Color info100 = Color(0xFFFFFFFF);

  // 容器颜色
  static const Color containerLowest = Color(0x05000000);
  static const Color containerLow = Color(0x0F000000);
  static const Color containerMedium = Color(0x19000000);
  static const Color containerHigh = Color(0x24000000);
  static const Color containerHighest = Color(0x2E000000);
}

/// 间距令牌系统
class ZephyrSpacingTokens {
  ZephyrSpacingTokens._();

  // 基础间距
  static const double nano = 2.0;
  static const double micro = 4.0;
  static const double tiny = 6.0;
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double regular = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
  static const double huge = 48.0;
  static const double massive = 64.0;
  static const double gigantic = 96.0;

  // 组件间距
  static const double componentGap = 8.0;
  static const double sectionGap = 24.0;
  static const double pagePadding = 16.0;
  static const double dialogPadding = 24.0;
}

/// 圆角令牌系统
class ZephyrRadiusTokens {
  ZephyrRadiusTokens._();

  static const double none = 0.0;
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double extraLarge = 20.0;
  static const double circular = 9999.0;
}

/// 字体令牌系统
class ZephyrTypographyTokens {
  ZephyrTypographyTokens._();

  // 字体大小
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 11.0;

  // 行高
  static const double lineHeightTight = 1.15;
  static const double lineHeightNormal = 1.25;
  static const double lineHeightRelaxed = 1.5;
  static const double lineHeightLoose = 1.75;

  // 字重
  static const FontWeight weightThin = FontWeight.w100;
  static const FontWeight weightExtraLight = FontWeight.w200;
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtraBold = FontWeight.w800;
  static const FontWeight weightBlack = FontWeight.w900;

  // 字母间距
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingExtraWide = 1.0;
}

/// 阴影令牌系统
class ZephyrShadowTokens {
  ZephyrShadowTokens._();

  static const List<BoxShadow> none = [];
  
  static const List<BoxShadow> extraSmall = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> small = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x15000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> large = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> extraLarge = [
    BoxShadow(
      color: Color(0x28000000),
      blurRadius: 32,
      offset: Offset(0, 16),
    ),
  ];
}

/// 动画令牌系统
class ZephyrAnimationTokens {
  ZephyrAnimationTokens._();

  // 持续时间
  static const Duration ultraFast = Duration(milliseconds: 50);
  static const Duration extraFast = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);
  static const Duration extraSlow = Duration(milliseconds: 500);
  static const Duration ultraSlow = Duration(milliseconds: 750);

  // 缓动曲线
  static const Curve linear = Curves.linear;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeInQuad = Curves.easeInQuad;
  static const Curve easeOutQuad = Curves.easeOutQuad;
  static const Curve easeInOutQuad = Curves.easeInOutQuad;
  static const Curve easeInCubic = Curves.easeInCubic;
  static const Curve easeOutCubic = Curves.easeOutCubic;
  static const Curve easeInOutCubic = Curves.easeInOutCubic;
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticIn = Curves.elasticIn;
  static const Curve elasticOut = Curves.elasticOut;
}

/// 断点令牌系统
class ZephyrBreakpointTokens {
  ZephyrBreakpointTokens._();

  static const double xs = 0;
  static const double sm = 576;
  static const double md = 768;
  static const double lg = 992;
  static const double xl = 1200;
  static const double xxl = 1400;
}

/// 高度令牌系统
class ZephyrElevationTokens {
  ZephyrElevationTokens._();

  static const double level0 = 0.0;
  static const double level1 = 1.0;
  static const double level2 = 2.0;
  static const double level3 = 4.0;
  static const double level4 = 8.0;
  static const double level5 = 16.0;
}

/// 边框令牌系统
class ZephyrBorderTokens {
  ZephyrBorderTokens._();

  static const double none = 0.0;
  static const double hairline = 1.0;
  static const double thin = 2.0;
  static const double medium = 3.0;
  static const double thick = 4.0;
  static const double extraThick = 6.0;
}

/// 透明度令牌系统
class ZephyrOpacityTokens {
  ZephyrOpacityTokens._();

  static const double invisible = 0.0;
  static const double low = 0.25;
  static const double medium = 0.5;
  static const double high = 0.75;
  static const double visible = 1.0;
}