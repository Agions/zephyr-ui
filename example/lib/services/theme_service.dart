import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ZephyrUI 专业主题服务
/// 
/// 提供企业级的主题管理功能，包括：
/// - 深色/浅色主题切换
/// - 自定义主题颜色配置
/// - 主题持久化存储
/// - 系统主题跟随
/// - 预设主题方案
/// - 动态主题切换动画
class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'zephyr_ui_theme_mode';
  static const String _primaryColorKey = 'zephyr_ui_primary_color';
  static const String _accentColorKey = 'zephyr_ui_accent_color';
  static const String _themePresetKey = 'zephyr_ui_theme_preset';
  
  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = const Color(0xFF6366F1); // Indigo
  Color _accentColor = const Color(0xFFEC4899); // Pink
  int _themePreset = 0;
  
  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;
  Color get accentColor => _accentColor;
  int get themePreset => _themePreset;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;
  
  ThemeService() {
    _loadThemePreferences();
  }
  
  /// 预设主题方案
  static const List<Map<String, Color>> themePresets = [
    {'primary': Color(0xFF6366F1), 'accent': Color(0xFFEC4899)}, // Indigo + Pink
    {'primary': Color(0xFF10B981), 'accent': Color(0xFF14B8A6)}, // Emerald + Teal
    {'primary': Color(0xFFF59E0B), 'accent': Color(0xFFEF4444)}, // Amber + Red
    {'primary': Color(0xFF8B5CF6), 'accent': Color(0xFFEC4899)}, // Violet + Pink
    {'primary': Color(0xFF3B82F6), 'accent': Color(0xFF06B6D4)}, // Blue + Cyan
    {'primary': Color(0xFF84CC16), 'accent': Color(0xFF10B981)}, // Lime + Emerald
    {'primary': Color(0xFFEF4444), 'accent': Color(0xFFF97316)}, // Red + Orange
    {'primary': Color(0xFF6366F1), 'accent': Color(0xFF14B8A6)}, // Indigo + Teal
  ];
  
  /// 从持久化存储加载主题设置
  Future<void> _loadThemePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
      final primaryColorValue = prefs.getInt(_primaryColorKey);
      final accentColorValue = prefs.getInt(_accentColorKey);
      final presetIndex = prefs.getInt(_themePresetKey) ?? 0;
      
      _themeMode = ThemeMode.values[themeIndex];
      _themePreset = presetIndex;
      
      if (primaryColorValue != null) {
        _primaryColor = Color(primaryColorValue);
      }
      if (accentColorValue != null) {
        _accentColor = Color(accentColorValue);
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load theme preferences: $e');
    }
  }
  
  /// 保存主题设置到持久化存储
  Future<void> _saveThemePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, _themeMode.index);
      await prefs.setInt(_primaryColorKey, _primaryColor.value);
      await prefs.setInt(_accentColorKey, _accentColor.value);
      await prefs.setInt(_themePresetKey, _themePreset);
    } catch (e) {
      debugPrint('Failed to save theme preferences: $e');
    }
  }
  
  /// 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _saveThemePreferences();
    notifyListeners();
  }
  
  /// 设置主色调
  Future<void> setPrimaryColor(Color color) async {
    _primaryColor = color;
    await _saveThemePreferences();
    notifyListeners();
  }
  
  /// 设置强调色
  Future<void> setAccentColor(Color color) async {
    _accentColor = color;
    await _saveThemePreferences();
    notifyListeners();
  }
  
  /// 应用预设主题
  Future<void> applyThemePreset(int presetIndex) async {
    if (presetIndex >= 0 && presetIndex < themePresets.length) {
      final preset = themePresets[presetIndex];
      _primaryColor = preset['primary']!;
      _accentColor = preset['accent']!;
      _themePreset = presetIndex;
      await _saveThemePreferences();
      notifyListeners();
    }
  }
  
  /// 切换深色/浅色主题
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await _saveThemePreferences();
    notifyListeners();
  }
  
  /// 获取当前主题数据
  ThemeData getTheme(BuildContext context) {
    final brightness = _getBrightness(context);
    return _buildThemeData(brightness);
  }
  
  /// 获取当前主题亮度
  Brightness _getBrightness(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return MediaQuery.platformBrightnessOf(context);
    }
  }
  
  /// 构建主题数据
  ThemeData _buildThemeData(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      secondary: _accentColor,
      brightness: brightness,
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      
      // 应用栏主题
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
        ),
        actionsIconTheme: IconThemeData(
          color: colorScheme.onSurface,
        ),
      ),
      
      // 卡片主题
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      ),
      
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.12),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        filled: true,
        fillColor: colorScheme.surface,
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        labelStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: TextStyle(
          color: colorScheme.error,
          fontWeight: FontWeight.w500,
        ),
        helperStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        counterStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
      ),
      
      // 芯片主题
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceVariant,
        deleteIconColor: colorScheme.onSurfaceVariant,
        disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
        selectedColor: colorScheme.primaryContainer,
        secondarySelectedColor: colorScheme.primaryContainer,
        shadowColor: Colors.transparent,
        selectedShadowColor: Colors.transparent,
        checkmarkColor: colorScheme.onPrimaryContainer,
        labelStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w500,
        ),
        brightness: brightness,
        elevation: 0,
        pressElevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      
      // 标签页主题
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 3,
          ),
          insets: const EdgeInsets.symmetric(horizontal: 16),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: colorScheme.outline.withValues(alpha: 0.12),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return colorScheme.primary.withValues(alpha: 0.1);
          }
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.primary.withValues(alpha: 0.05);
          }
          return null;
        }),
        splashFactory: InkRipple.splashFactory,
        mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
      ),
      
      // 分割线主题
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withValues(alpha: 0.12),
        space: 1,
        thickness: 1,
        indent: 0,
        endIndent: 0,
      ),
      
      // 列表瓦片主题
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
        leadingAndTrailingTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
        tileColor: Colors.transparent,
        selectedTileColor: colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        horizontalTitleGap: 16,
        minVerticalPadding: 8,
        enableFeedback: true,
        visualDensity: VisualDensity.standard,
        iconColor: colorScheme.onSurfaceVariant,
        textColor: colorScheme.onSurface,
      ),
      
      // 底部导航栏主题
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),
      
      // 浮动操作按钮主题
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        shape: const CircleBorder(),
        iconSize: 24,
        sizeConstraints: const BoxConstraints(
          minWidth: 56,
          minHeight: 56,
          maxWidth: 56,
          maxHeight: 56,
        ),
      ),
      
      // 开关主题
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.38);
          }
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surface;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withValues(alpha: 0.5);
          }
          return colorScheme.onSurface.withValues(alpha: 0.12);
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.transparent;
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return colorScheme.outline.withValues(alpha: 0.12);
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
      ),
      
      // 复选框主题
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: BorderSide(
          color: colorScheme.onSurface.withValues(alpha: 0.38),
          width: 2,
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.38);
          }
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return colorScheme.primary.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.primary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return colorScheme.primary.withValues(alpha: 0.12);
          }
          return null;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.standard,
      ),
      
      // 单选按钮主题
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.38);
          }
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return colorScheme.primary.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.primary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return colorScheme.primary.withValues(alpha: 0.12);
          }
          return null;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.standard,
      ),
      
      // 滑块主题
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withValues(alpha: 0.24),
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
        trackHeight: 6,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        trackShape: const RoundedRectSliderTrackShape(),
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        showValueIndicator: ShowValueIndicator.onlyForDiscrete,
        minThumbSeparation: 0,
      ),
      
      // 进度指示器主题
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.primary.withValues(alpha: 0.24),
        circularTrackColor: colorScheme.primary.withValues(alpha: 0.24),
        refreshBackgroundColor: colorScheme.surface,
        linearMinHeight: 6,
      ),
      
      // 文本主题
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurfaceVariant,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
      ),
      
      // 脚手架背景色
      scaffoldBackgroundColor: colorScheme.surface,
      
      // 对话框主题
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurfaceVariant,
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        alignment: Alignment.center,
      ),
      
      // 底部表单主题
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.primary,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        modalBackgroundColor: colorScheme.surface,
        modalElevation: 0,
        clipBehavior: Clip.antiAlias,
        dragHandleColor: colorScheme.onSurfaceVariant,
        dragHandleSize: const Size(40, 4),
        showDragHandle: true,
      ),
      
      // 扩展颜色
      extensions: <ThemeExtension<dynamic>>[
        _ZephyrThemeExtension(
          success: Colors.green,
          warning: Colors.orange,
          error: Colors.red,
          info: Colors.blue,
        ),
      ],
    );
  }
  
  /// 重置为默认主题
  Future<void> resetToDefault() async {
    _themeMode = ThemeMode.system;
    _primaryColor = const Color(0xFF6366F1);
    _accentColor = const Color(0xFFEC4899);
    _themePreset = 0;
    await _saveThemePreferences();
    notifyListeners();
  }
}

/// ZephyrUI 主题扩展
@immutable
class _ZephyrThemeExtension extends ThemeExtension<_ZephyrThemeExtension> {
  const _ZephyrThemeExtension({
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });
  
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  
  @override
  _ZephyrThemeExtension copyWith({
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return _ZephyrThemeExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }
  
  @override
  _ZephyrThemeExtension lerp(ThemeExtension<_ZephyrThemeExtension>? other, double t) {
    if (other is! _ZephyrThemeExtension) {
      return this;
    }
    return _ZephyrThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}