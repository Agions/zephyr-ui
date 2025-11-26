import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI的全局主题数据
///
/// 包含所有组件主题的容器类，用于统一管理应用的视觉风格。
class ZephyrThemeData {
  /// 创建一个主题数据实例
  const ZephyrThemeData({
    required this.brightness,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.errorColor,
    required this.textTheme,
    required this.buttonTheme,
    required this.zephyrTextTheme,
    required this.dividerTheme,
    required this.iconTheme,
    required this.badgeTheme,
    required this.sideMenuTheme,
    required this.stepperTheme,
    required this.checkboxGroupTheme,
    required this.radioGroupTheme,
    required this.sliderTheme,
    required this.datePickerTheme,
    required this.accordionTheme,
    required this.skeletonTheme,
    required this.paginationTheme,
    required this.ratingTheme,
    required this.treeTheme,
    required this.tourTheme,
    required this.checkboxTheme,
    required this.radioTheme,
    required this.textAreaTheme,
    required this.timePickerTheme,
    required this.spacing,
    this.context,
  });

  /// 创建亮色主题
  ///
  /// 提供明亮背景和适合日间使用的颜色方案。
  factory ZephyrThemeData.light() {
    return ZephyrThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1976D2),
      secondaryColor: const Color(0xFF26A69A),
      backgroundColor: Colors.white,
      errorColor: const Color(0xFFD32F2F),
      textTheme: Typography.material2018().black,
      buttonTheme: const ZephyrButtonTheme(),
      zephyrTextTheme: const ZephyrTextTheme(
        headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121)),
        headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121)),
        headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121)),
        titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121)),
        titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF212121)),
        titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF212121)),
        bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF212121)),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF212121)),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFF212121)),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF212121)),
        labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF212121)),
        labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF212121)),
        primaryColor: Color(0xFF212121),
        secondaryColor: Color(0xFF757575),
        errorColor: Color(0xFFD32F2F),
        disabledColor: Color(0xFFBDBDBD),
      ),
      dividerTheme: const ZephyrDividerTheme(),
      iconTheme: const ZephyrIconTheme(
        defaultColor: Color(0xFF212121),
        primaryColor: Color(0xFF1976D2),
        secondaryColor: Color(0xFF26A69A),
        errorColor: Color(0xFFD32F2F),
        warningColor: Color(0xFFFF9800),
        successColor: Color(0xFF4CAF50),
        infoColor: Color(0xFF03A9F4),
        disabledColor: Color(0xFFBDBDBD),
        defaultSize: 24.0,
        smallSize: 16.0,
        mediumSize: 24.0,
        largeSize: 32.0,
      ),
      badgeTheme: ZephyrBadgeTheme(
        backgroundColor: const Color(0xFFE53935),
        textColor: Colors.white,
        borderRadius: BorderRadius.circular(100),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        borderWidth: 0.0,
        borderColor: Colors.transparent,
      ),
      sideMenuTheme: ZephyrSideMenuTheme(
        backgroundColor: Colors.white,
        width: 240.0,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        itemHeight: 48.0,
        itemSpacing: 4.0,
        itemTextStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
        ),
        activeItemTextStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1976D2),
        ),
        activeItemBackgroundColor:
            const Color(0xFF1976D2).withValues(alpha: 0.12),
        iconColor: Colors.black54,
        activeIconColor: const Color(0xFF1976D2),
        dividerColor: Colors.black12,
        dividerThickness: 1.0,
        headerBackgroundColor: const Color(0xFFF5F5F5),
        headerTextStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        footerBackgroundColor: const Color(0xFFF5F5F5),
        selectedItemColor: const Color(0xFF1976D2),
        unselectedItemColor: Colors.black87,
      ),
      stepperTheme: ZephyrStepperTheme(
        completedColor: Colors.green[600]!,
        activeColor: const Color(0xFF1976D2),
        inactiveColor: Colors.black45,
        errorColor: const Color(0xFFD32F2F),
        borderColor: Colors.black12,
        borderWidth: 1.0,
        textColor: Colors.black87,
        activeTextColor: const Color(0xFF1976D2),
        subtitleColor: Colors.black54,
        stepSize: 32.0,
        borderRadius: 4.0,
        animationDuration: const Duration(milliseconds: 200),
      ),
      checkboxGroupTheme: const ZephyrCheckboxGroupTheme(
        activeColor: Color(0xFF1976D2),
        checkColor: Colors.white,
        borderColor: Color(0xFF757575),
        disabledBorderColor: Color(0xFFBDBDBD),
        textStyle: TextStyle(fontSize: 14, color: Color(0xFF212121)),
        disabledTextStyle: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
        borderWidth: 1.5,
        borderRadius: 4.0,
      ),
      radioGroupTheme: const ZephyrRadioGroupTheme(
        activeColor: Color(0xFF1976D2),
        borderColor: Color(0xFF757575),
        disabledBorderColor: Color(0xFFBDBDBD),
        textStyle: TextStyle(fontSize: 14, color: Color(0xFF212121)),
        selectedTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF212121),
        ),
        disabledTextStyle: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
        borderWidth: 1.5,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      sliderTheme: const ZephyrSliderTheme(
        activeTrackColor: Color(0xFF1976D2),
        inactiveTrackColor: Color(0x52000000), // 32% opacity black
        hoverActiveTrackColor: Color(0xFF1976D2),
        hoverInactiveTrackColor: Color(0xFF757575),
        disabledActiveTrackColor: Color(0xFFBDBDBD),
        disabledInactiveTrackColor: Color(0x1F000000), // 12% opacity black
        thumbColor: Color(0xFF1976D2),
        hoverThumbColor: Color(0xFF1976D2),
        disabledThumbColor: Color(0xFFBDBDBD),
        thumbShadowColor: Colors.black26,
        valueIndicatorColor: Color(0xFF1976D2),
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
        thumbBorderColor: Colors.white,
        hoverThumbBorderColor: Color(0xFF1976D2),
        disabledThumbBorderColor: Color(0xFFBDBDBD),
      ),
      datePickerTheme: ZephyrDatePickerTheme(
        primaryColor: const Color(0xFF1976D2),
        selectedDateBackgroundColor: const Color(0xFF1976D2),
        selectedDateTextColor: Colors.white,
        currentDateBackgroundColor:
            const Color(0xFF1976D2).withValues(alpha: 0.1),
        currentDateTextColor: const Color(0xFF1976D2),
        dateTextColor: Colors.black87,
        disabledDateTextColor: Colors.black38,
        weekendDateTextColor: Colors.red.shade300,
        rangeDateBackgroundColor:
            const Color(0xFF1976D2).withValues(alpha: 0.2),
        headerBackgroundColor: const Color(0xFFE3F2FD),
        headerTextColor: Colors.black87,
        headerYearStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
        headerMonthStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        weekdayStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        dateStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
        selectedDateStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        buttonTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1976D2),
        ),
        disabledButtonTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      accordionTheme: ZephyrAccordionTheme.light(),
      skeletonTheme: ZephyrSkeletonTheme.light(),
      paginationTheme: ZephyrPaginationTheme.light(),
      ratingTheme: ZephyrRatingTheme.light(),
      treeTheme: ZephyrTreeTheme.light(),
      tourTheme: ZephyrTourTheme.light(),
      checkboxTheme: ZephyrCheckboxTheme.light(),
      radioTheme: ZephyrRadioTheme.light(),
      textAreaTheme: ZephyrTextAreaTheme.light(),
      timePickerTheme: ZephyrTimePickerTheme.light(),
      spacing: 16.0,
    );
  }

  /// 创建暗色主题
  ///
  /// 提供深色背景和适合夜间使用的颜色方案。
  factory ZephyrThemeData.dark() {
    return ZephyrThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF90CAF9),
      secondaryColor: const Color(0xFF80CBC4),
      backgroundColor: const Color(0xFF121212),
      errorColor: const Color(0xFFEF5350),
      textTheme: Typography.material2018().white,
      buttonTheme: const ZephyrButtonTheme(
        primaryBackgroundColor: Color(0xFF90CAF9),
        primaryTextColor: Color(0xFF000000),
        secondaryBackgroundColor: Color(0xFF80CBC4),
        secondaryTextColor: Color(0xFF000000),
        disabledBackgroundColor: Color(0xFF424242),
        disabledTextColor: Color(0xFF757575),
      ),
      zephyrTextTheme: const ZephyrTextTheme(
        headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF)),
        headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF)),
        headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF)),
        titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF)),
        titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF)),
        titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF)),
        bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFFFFFFFF)),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFFFFFFFF)),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFFFFFFFF)),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF)),
        labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF)),
        labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF)),
        primaryColor: Color(0xFFFFFFFF),
        secondaryColor: Color(0xB3FFFFFF), // 70% opacity
        errorColor: Color(0xFFEF5350),
        disabledColor: Color(0x80FFFFFF), // 50% opacity
      ),
      dividerTheme: const ZephyrDividerTheme(
        color: Color(0x33FFFFFF), // 20% opacity white
      ),
      iconTheme: const ZephyrIconTheme(
        defaultColor: Color(0xDEFFFFFF), // 87% opacity white
        primaryColor: Color(0xFF90CAF9),
        secondaryColor: Color(0xFF80CBC4),
        errorColor: Color(0xFFEF5350),
        warningColor: Color(0xFFFFB74D),
        successColor: Color(0xFF81C784),
        infoColor: Color(0xFF4FC3F7),
        disabledColor: Color(0x80FFFFFF), // 50% opacity white
        defaultSize: 24.0,
        smallSize: 16.0,
        mediumSize: 24.0,
        largeSize: 32.0,
      ),
      badgeTheme: ZephyrBadgeTheme(
        backgroundColor: const Color(0xFFEF5350),
        textColor: Colors.white,
        borderRadius: BorderRadius.circular(100),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        borderWidth: 0.0,
        borderColor: Colors.transparent,
      ),
      sideMenuTheme: ZephyrSideMenuTheme(
        backgroundColor: const Color(0xFF212121),
        width: 240.0,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        itemHeight: 48.0,
        itemSpacing: 4.0,
        itemTextStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.white70,
        ),
        activeItemTextStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF90CAF9),
        ),
        activeItemBackgroundColor:
            const Color(0xFF90CAF9).withValues(alpha: 0.12),
        iconColor: Colors.white70,
        activeIconColor: const Color(0xFF90CAF9),
        dividerColor: Colors.white24,
        dividerThickness: 1.0,
        headerBackgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: const Color(0xFF90CAF9),
        unselectedItemColor: Colors.white70,
        headerTextStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        footerBackgroundColor: const Color(0xFF1E1E1E),
      ),
      stepperTheme: ZephyrStepperTheme(
        completedColor: Colors.green[300]!,
        activeColor: const Color(0xFF90CAF9),
        inactiveColor: Colors.white60,
        errorColor: const Color(0xFFEF5350),
        borderColor: Colors.white30,
        borderWidth: 1.0,
        textColor: Colors.white70,
        activeTextColor: const Color(0xFF90CAF9),
        subtitleColor: Colors.white60,
        stepSize: 32.0,
        borderRadius: 4.0,
      ),
      checkboxGroupTheme: const ZephyrCheckboxGroupTheme(
        activeColor: Color(0xFF90CAF9),
        checkColor: Color(0xFF000000),
        borderColor: Color(0xB3FFFFFF), // 70% opacity white
        disabledBorderColor: Color(0x80FFFFFF), // 50% opacity white
        textStyle: TextStyle(
            fontSize: 14, color: Color(0xDEFFFFFF)), // 87% opacity white
        disabledTextStyle: TextStyle(
            fontSize: 14, color: Color(0x99FFFFFF)), // 60% opacity white
        borderWidth: 1.5,
        borderRadius: 4.0,
      ),
      radioGroupTheme: const ZephyrRadioGroupTheme(
        activeColor: Color(0xFF90CAF9),
        borderColor: Color(0xB3FFFFFF), // 70% opacity white
        disabledBorderColor: Color(0x80FFFFFF), // 50% opacity white
        textStyle: TextStyle(
            fontSize: 14, color: Color(0xDEFFFFFF)), // 87% opacity white
        selectedTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF212121),
        ),
        disabledTextStyle: TextStyle(
            fontSize: 14, color: Color(0x99FFFFFF)), // 60% opacity white
        borderWidth: 1.5,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      sliderTheme: const ZephyrSliderTheme(
        activeTrackColor: Color(0xFF90CAF9),
        inactiveTrackColor: Color(0x52FFFFFF), // 32% opacity white
        hoverActiveTrackColor: Color(0xFF90CAF9),
        hoverInactiveTrackColor: Color(0xB3FFFFFF), // 70% opacity white
        disabledActiveTrackColor: Color(0x80FFFFFF), // 50% opacity white
        disabledInactiveTrackColor: Color(0x1FFFFFFF), // 12% opacity white
        thumbColor: Color(0xFF90CAF9),
        hoverThumbColor: Color(0xFF90CAF9),
        disabledThumbColor: Color(0x80FFFFFF), // 50% opacity white
        thumbShadowColor: Colors.black54,
        valueIndicatorColor: Color(0xFF90CAF9),
        valueIndicatorTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
        ),
        thumbBorderColor: Colors.black12,
        hoverThumbBorderColor: Color(0xFF90CAF9),
        disabledThumbBorderColor: Color(0x80FFFFFF), // 50% opacity white
      ),
      datePickerTheme: ZephyrDatePickerTheme(
        primaryColor: const Color(0xFF90CAF9),
        selectedDateBackgroundColor: const Color(0xFF90CAF9),
        selectedDateTextColor: Colors.black87,
        currentDateBackgroundColor:
            const Color(0xFF90CAF9).withValues(alpha: 0.3),
        currentDateTextColor: const Color(0xFF90CAF9),
        dateTextColor: Colors.white,
        disabledDateTextColor: Colors.white38,
        weekendDateTextColor: Colors.red.shade200,
        rangeDateBackgroundColor:
            const Color(0xFF90CAF9).withValues(alpha: 0.2),
        headerBackgroundColor: const Color(0xFF1E1E1E),
        headerTextColor: Colors.white,
        headerYearStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white70,
        ),
        headerMonthStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        weekdayStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
        dateStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        selectedDateStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        buttonTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF90CAF9),
        ),
        disabledButtonTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white38,
        ),
      ),
      accordionTheme: ZephyrAccordionTheme.dark(),
      skeletonTheme: ZephyrSkeletonTheme.dark(),
      paginationTheme: ZephyrPaginationTheme.dark(),
      ratingTheme: ZephyrRatingTheme.dark(),
      treeTheme: ZephyrTreeTheme.dark(),
      tourTheme: ZephyrTourTheme.dark(),
      checkboxTheme: ZephyrCheckboxTheme.dark(),
      radioTheme: ZephyrRadioTheme.dark(),
      textAreaTheme: ZephyrTextAreaTheme.dark(),
      timePickerTheme: ZephyrTimePickerTheme.dark(),
      spacing: 16.0,
    );
  }

  /// 亮度，用于区分亮色/暗色主题
  final Brightness brightness;

  /// 主色，应用的品牌色
  final Color primaryColor;

  /// 次要颜色，用于辅助主色
  final Color secondaryColor;

  /// 背景色
  final Color backgroundColor;

  /// 错误状态色
  final Color errorColor;

  /// 文本主题（Flutter原生）
  final TextTheme textTheme;

  /// 按钮主题
  final ZephyrButtonTheme buttonTheme;

  /// Zephyr文本主题
  final ZephyrTextTheme zephyrTextTheme;

  /// 分割线主题
  final ZephyrDividerTheme dividerTheme;

  /// 图标主题
  final ZephyrIconTheme iconTheme;

  /// 徽章主题
  final ZephyrBadgeTheme badgeTheme;

  /// 侧边菜单主题
  final ZephyrSideMenuTheme sideMenuTheme;

  /// 步进器主题
  final ZephyrStepperTheme stepperTheme;

  /// 复选框组主题
  final ZephyrCheckboxGroupTheme checkboxGroupTheme;

  /// 单选框组主题
  final ZephyrRadioGroupTheme radioGroupTheme;

  /// 复选框主题
  final ZephyrCheckboxTheme checkboxTheme;

  /// 单选框主题
  final ZephyrRadioTheme radioTheme;

  /// 文本域主题
  final ZephyrTextAreaTheme textAreaTheme;

  /// 时间选择器主题
  final ZephyrTimePickerTheme timePickerTheme;

  /// 滑块主题
  final ZephyrSliderTheme sliderTheme;

  /// 日期选择器主题
  final ZephyrDatePickerTheme datePickerTheme;

  /// 手风琴主题
  final ZephyrAccordionTheme? accordionTheme;

  /// 骨架屏主题
  final ZephyrSkeletonTheme? skeletonTheme;

  /// 分页主题
  final ZephyrPaginationTheme? paginationTheme;

  /// 评分主题
  final ZephyrRatingTheme ratingTheme;

  /// 树形主题
  final ZephyrTreeTheme treeTheme;

  /// 导览主题
  final ZephyrTourTheme tourTheme;

  /// 默认间距
  final double spacing;

  /// 构建上下文，用于主题解析
  final BuildContext? context;

  /// 创建当前主题的副本，并替换指定字段
  ZephyrThemeData copyWith({
    Brightness? brightness,
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? errorColor,
    TextTheme? textTheme,
    ZephyrButtonTheme? buttonTheme,
    ZephyrTextTheme? zephyrTextTheme,
    ZephyrDividerTheme? dividerTheme,
    ZephyrIconTheme? iconTheme,
    ZephyrBadgeTheme? badgeTheme,
    ZephyrSideMenuTheme? sideMenuTheme,
    ZephyrStepperTheme? stepperTheme,
    ZephyrCheckboxGroupTheme? checkboxGroupTheme,
    ZephyrRadioGroupTheme? radioGroupTheme,
    ZephyrSliderTheme? sliderTheme,
    ZephyrDatePickerTheme? datePickerTheme,
    ZephyrAccordionTheme? accordionTheme,
    ZephyrSkeletonTheme? skeletonTheme,
    ZephyrPaginationTheme? paginationTheme,
    ZephyrRatingTheme? ratingTheme,
    ZephyrTreeTheme? treeTheme,
    ZephyrTourTheme? tourTheme,
    ZephyrCheckboxTheme? checkboxTheme,
    ZephyrRadioTheme? radioTheme,
    ZephyrTextAreaTheme? textAreaTheme,
    ZephyrTimePickerTheme? timePickerTheme,
    double? spacing,
    BuildContext? context,
  }) {
    return ZephyrThemeData(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      errorColor: errorColor ?? this.errorColor,
      textTheme: textTheme ?? this.textTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      zephyrTextTheme: zephyrTextTheme ?? this.zephyrTextTheme,
      dividerTheme: dividerTheme ?? this.dividerTheme,
      iconTheme: iconTheme ?? this.iconTheme,
      badgeTheme: badgeTheme ?? this.badgeTheme,
      sideMenuTheme: sideMenuTheme ?? this.sideMenuTheme,
      stepperTheme: stepperTheme ?? this.stepperTheme,
      checkboxGroupTheme: checkboxGroupTheme ?? this.checkboxGroupTheme,
      radioGroupTheme: radioGroupTheme ?? this.radioGroupTheme,
      sliderTheme: sliderTheme ?? this.sliderTheme,
      datePickerTheme: datePickerTheme ?? this.datePickerTheme,
      accordionTheme: accordionTheme ?? this.accordionTheme,
      skeletonTheme: skeletonTheme ?? this.skeletonTheme,
      paginationTheme: paginationTheme ?? this.paginationTheme,
      ratingTheme: ratingTheme ?? this.ratingTheme,
      treeTheme: treeTheme ?? this.treeTheme,
      tourTheme: tourTheme ?? this.tourTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      textAreaTheme: textAreaTheme ?? this.textAreaTheme,
      timePickerTheme: timePickerTheme ?? this.timePickerTheme,
      spacing: spacing ?? this.spacing,
      context: context ?? this.context,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrThemeData &&
        other.brightness == brightness &&
        other.primaryColor == primaryColor &&
        other.secondaryColor == secondaryColor &&
        other.backgroundColor == backgroundColor &&
        other.errorColor == errorColor &&
        other.textTheme == textTheme &&
        other.buttonTheme == buttonTheme &&
        other.zephyrTextTheme == zephyrTextTheme &&
        other.dividerTheme == dividerTheme &&
        other.iconTheme == iconTheme &&
        other.badgeTheme == badgeTheme &&
        other.sideMenuTheme == sideMenuTheme &&
        other.stepperTheme == stepperTheme &&
        other.checkboxGroupTheme == checkboxGroupTheme &&
        other.radioGroupTheme == radioGroupTheme &&
        other.sliderTheme == sliderTheme &&
        other.datePickerTheme == datePickerTheme &&
        other.ratingTheme == ratingTheme &&
        other.treeTheme == treeTheme &&
        other.tourTheme == tourTheme &&
        other.spacing == spacing;
  }

  @override
  int get hashCode => Object.hashAll([
        brightness,
        primaryColor,
        secondaryColor,
        backgroundColor,
        errorColor,
        textTheme,
        buttonTheme,
        zephyrTextTheme,
        dividerTheme,
        iconTheme,
        badgeTheme,
        sideMenuTheme,
        stepperTheme,
        checkboxGroupTheme,
        radioGroupTheme,
        sliderTheme,
        datePickerTheme,
        ratingTheme,
        treeTheme,
        tourTheme,
        spacing,
      ]);
}
