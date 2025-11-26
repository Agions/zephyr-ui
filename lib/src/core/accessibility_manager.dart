import 'package:flutter/material.dart';

/// 可访问性功能枚举
enum ZephyrAccessibilityFeature {
  /// 屏幕阅读器
  screenReader,
  /// 字体大小缩放
  fontSizeScaling,
  /// 高对比度模式
  highContrast,
  /// 减少动画
  reduceMotion,
  /// 大文本模式
  largeText,
  /// 颜色盲模式
  colorBlind,
  /// 开关控制
  switchControl,
  /// 语音控制
  voiceControl,
}

/// 可访问性管理器
class ZephyrAccessibilityManager {
  static final ZephyrAccessibilityManager _instance = ZephyrAccessibilityManager._internal();
  
  ZephyrAccessibilityManager._internal();
  
  factory ZephyrAccessibilityManager() => _instance;

  final Map<ZephyrAccessibilityFeature, bool> _features = {};
  final Map<ZephyrAccessibilityFeature, VoidCallback> _featureListeners = {};

  /// 初始化可访问性设置
  void initialize() {
    // 监听系统可访问性设置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSystemSettings();
    });
  }

  /// 更新系统设置
  void _updateSystemSettings() {
    // 屏幕阅读器
    final semanticsEnabled = WidgetsBinding.instance.platformDispatcher.semanticsEnabled;
    updateFeatureStatus(ZephyrAccessibilityFeature.screenReader, semanticsEnabled);

    // 减少动画
    final reduceMotion = WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.reduceMotion;
    updateFeatureStatus(ZephyrAccessibilityFeature.reduceMotion, reduceMotion);

    // 高对比度
    final highContrast = WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.highContrast;
    updateFeatureStatus(ZephyrAccessibilityFeature.highContrast, highContrast);

    // 字体大小缩放
    final textScaleFactor = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    updateFeatureStatus(ZephyrAccessibilityFeature.fontSizeScaling, textScaleFactor > 1.0);
  }

  /// 更新功能状态
  void updateFeatureStatus(ZephyrAccessibilityFeature feature, bool enabled) {
    _features[feature] = enabled;
    
    // 通知监听器
    if (_featureListeners.containsKey(feature)) {
      _featureListeners[feature]!();
    }
  }

  /// 检查功能是否启用
  bool isFeatureEnabled(ZephyrAccessibilityFeature feature) {
    return _features[feature] ?? false;
  }

  /// 注册功能监听器
  void addFeatureListener(ZephyrAccessibilityFeature feature, VoidCallback listener) {
    _featureListeners[feature] = listener;
  }

  /// 移除功能监听器
  void removeFeatureListener(ZephyrAccessibilityFeature feature) {
    _featureListeners.remove(feature);
  }

  /// 获取所有启用的功能
  List<ZephyrAccessibilityFeature> get enabledFeatures {
    return _features.entries.where((entry) => entry.value).map((entry) => entry.key).toList();
  }

  /// 获取推荐的可访问性设置
  Map<ZephyrAccessibilityFeature, bool> getRecommendedSettings() {
    return {
      ZephyrAccessibilityFeature.screenReader: true,
      ZephyrAccessibilityFeature.fontSizeScaling: true,
      ZephyrAccessibilityFeature.reduceMotion: false,
      ZephyrAccessibilityFeature.highContrast: false,
      ZephyrAccessibilityFeature.largeText: false,
      ZephyrAccessibilityFeature.colorBlind: false,
      ZephyrAccessibilityFeature.switchControl: false,
      ZephyrAccessibilityFeature.voiceControl: false,
    };
  }

  /// 应用可访问性设置
  void applySettings(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;
    
    // 根据字体大小设置大文本模式
    updateFeatureStatus(ZephyrAccessibilityFeature.largeText, textScaleFactor > 1.3);
    
    // 应用高对比度主题
    if (isFeatureEnabled(ZephyrAccessibilityFeature.highContrast)) {
      _applyHighContrastTheme(context);
    }
    
    // 应用减少动画设置
    if (isFeatureEnabled(ZephyrAccessibilityFeature.reduceMotion)) {
      _applyReducedMotion(context);
    }
  }

  /// 应用高对比度主题
  void _applyHighContrastTheme(BuildContext context) {
    // 这里可以修改主题以适应高对比度需求
    Theme.of(context);
  }

  /// 应用减少动画设置
  void _applyReducedMotion(BuildContext context) {
    // 这里可以减少或禁用动画
  }

  /// 获取可访问性友好的文本样式
  TextStyle getAccessibleTextStyle(TextStyle originalStyle, {bool highContrast = false}) {
    TextStyle style = originalStyle;
    
    // 如果启用了大文本模式，增加字体大小
    if (isFeatureEnabled(ZephyrAccessibilityFeature.largeText)) {
      style = style.copyWith(fontSize: (style.fontSize ?? 14) * 1.2);
    }
    
    // 如果启用了高对比度，调整颜色
    if (highContrast || isFeatureEnabled(ZephyrAccessibilityFeature.highContrast)) {
      style = style.copyWith(
        color: Colors.black,
        backgroundColor: Colors.white,
        fontWeight: FontWeight.bold,
      );
    }
    
    return style;
  }

  /// 创建可访问性友好的按钮
  Widget createAccessibleButton({
    required String label,
    required VoidCallback onPressed,
    String? hint,
    bool enabled = true,
    Widget? icon,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: true,
      enabled: enabled,
      child: ExcludeSemantics(
        child: TextButton(
          onPressed: enabled ? onPressed : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) icon,
              const SizedBox(width: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  /// 验证可访问性
  void validateAccessibility(BuildContext context) {
    final enabledFeatures = this.enabledFeatures;
    
    // 检查基本可访问性要求
    if (!enabledFeatures.contains(ZephyrAccessibilityFeature.screenReader)) {
      debugPrint('Warning: Screen reader support not enabled');
    }
    
    // 检查文本可读性
    if (!enabledFeatures.contains(ZephyrAccessibilityFeature.fontSizeScaling)) {
      debugPrint('Warning: Font size scaling not enabled');
    }
    
    // 检查动画设置
    if (!enabledFeatures.contains(ZephyrAccessibilityFeature.reduceMotion)) {
      debugPrint('Info: Motion reduction not enabled');
    }
  }
}