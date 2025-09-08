import 'package:flutter/material.dart';
import '../config/mobile_config.dart';

/// chromaUI Mobile Theme Configuration
///
/// Mobile-specific theme settings and configurations optimized for iOS and Android
class chromaMobileTheme {
  /// Get mobile-optimized button theme
  static ButtonThemeData getButtonTheme({Color? primaryColor}) {
    return ButtonThemeData(
      minWidth: MobileConfig.defaultButtonMinWidth,
      height: MobileConfig.defaultButtonHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: MobileConfig.defaultPadding,
        vertical: MobileConfig.defaultSpacing,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Get mobile-optimized elevated button theme
  static ElevatedButtonThemeData getElevatedButtonTheme({Color? primaryColor}) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          MobileConfig.defaultButtonMinWidth,
          MobileConfig.defaultButtonHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: MobileConfig.defaultPadding,
          vertical: MobileConfig.defaultSpacing,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Get mobile-optimized text button theme
  static TextButtonThemeData getTextButtonTheme({Color? primaryColor}) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(
          MobileConfig.defaultButtonMinWidth,
          MobileConfig.defaultButtonHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: MobileConfig.defaultPadding,
          vertical: MobileConfig.defaultSpacing,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Get mobile-optimized input decoration theme
  static InputDecorationTheme getInputDecorationTheme({Color? primaryColor}) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: MobileConfig.defaultPadding,
        vertical: MobileConfig.defaultSpacing * 1.5,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: primaryColor ?? Colors.blue,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }

  /// Get mobile-optimized card theme
  static CardTheme getCardTheme() {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: MobileConfig.defaultPadding,
        vertical: MobileConfig.defaultSpacing,
      ),
    );
  }

  /// Get mobile-optimized list tile theme
  static ListTileThemeData getListTileTheme() {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: MobileConfig.defaultPadding,
        vertical: MobileConfig.defaultSpacing,
      ),
      minVerticalPadding: MobileConfig.defaultSpacing,
      horizontalTitleGap: MobileConfig.defaultSpacing,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Get mobile-optimized app bar theme
  static AppBarTheme getAppBarTheme({Color? primaryColor}) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleSpacing: MobileConfig.defaultSpacing,
      toolbarHeight: kToolbarHeight + 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
    );
  }

  /// Get mobile-optimized bottom navigation bar theme
  static BottomNavigationBarThemeData getBottomNavigationBarTheme({Color? primaryColor}) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  /// Get mobile-optimized tab bar theme
  static TabBarTheme getTabBarTheme({Color? primaryColor}) {
    return TabBarTheme(
      labelColor: primaryColor ?? Colors.blue,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: primaryColor ?? Colors.blue,
          width: 3,
        ),
        insets: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  /// Get mobile-optimized floating action button theme
  static FloatingActionButtonThemeData getFloatingActionButtonTheme({Color? primaryColor}) {
    return FloatingActionButtonThemeData(
      elevation: 4,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  /// Get mobile-optimized dialog theme
  static DialogTheme getDialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: MobileConfig.defaultPadding,
        vertical: MobileConfig.defaultSpacing,
      ),
    );
  }

  /// Get mobile-optimized bottom sheet theme
  static BottomSheetThemeData getBottomSheetTheme() {
    return BottomSheetThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      elevation: 8,
      modalBackgroundColor: Colors.white,
      modalElevation: 8,
      clipBehavior: Clip.antiAlias,
    );
  }

  /// Get mobile-optimized chip theme
  static ChipThemeData getChipTheme({Color? primaryColor}) {
    return ChipThemeData(
      padding: const EdgeInsets.symmetric(
        horizontal: MobileConfig.defaultSpacing,
        vertical: MobileConfig.defaultSpacing / 2,
      ),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      backgroundColor: Colors.grey.withOpacity(0.2),
      secondarySelectedColor: primaryColor ?? Colors.blue,
      selectedColor: primaryColor?.withOpacity(0.2) ?? Colors.blue.withOpacity(0.2),
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  /// Get mobile-optimized snackbar theme
  static SnackBarThemeData getSnackBarTheme() {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      contentTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: Colors.blue,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  /// Get mobile-optimized tooltip theme
  static TooltipThemeData getTooltipTheme() {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: MobileConfig.defaultSpacing,
        vertical: MobileConfig.defaultSpacing / 2,
      ),
      margin: const EdgeInsets.all(MobileConfig.defaultSpacing),
      preferBelow: true,
      verticalOffset: 24,
    );
  }

  /// Get mobile-optimized divider theme
  static DividerThemeData getDividerTheme() {
    return const DividerThemeData(
      space: MobileConfig.defaultSpacing,
      thickness: 1,
      indent: MobileConfig.defaultPadding,
      endIndent: MobileConfig.defaultPadding,
    );
  }
}
