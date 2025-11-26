/// ZephyrUI 核心枚举定义
///
/// 提供组件库中使用的所有枚举类型，确保类型安全和代码可读性。

/// 组件尺寸枚举
enum ZephyrSize {
  /// 超小尺寸
  xs,

  /// 小尺寸
  sm,

  /// 中等尺寸
  md,

  /// 大尺寸
  lg,

  /// 超大尺寸
  xl,
}

/// 组件变体枚举
enum ZephyrVariant {
  /// 主要变体
  primary,

  /// 次要变体
  secondary,

  /// 成功变体
  success,

  /// 警告变体
  warning,

  /// 危险变体
  danger,

  /// 信息变体
  info,

  /// 浅色变体
  light,

  /// 深色变体
  dark,

  /// 链接变体
  link,
}

/// 按钮类型枚举
enum ZephyrButtonType {
  /// 实心按钮
  solid,

  /// 轮廓按钮
  outline,

  /// 文本按钮
  text,

  /// 链接按钮
  link,

  /// 幽灵按钮
  ghost,
}

/// 输入框状态枚举
enum ZephyrInputState {
  /// 默认状态
  normal,

  /// 聚焦状态
  focused,

  /// 禁用状态
  disabled,

  /// 只读状态
  readOnly,

  /// 错误状态
  error,

  /// 成功状态
  success,
}

/// 加载状态枚举
enum ZephyrLoadingState {
  /// 未加载
  idle,

  /// 加载中
  loading,

  /// 加载成功
  success,

  /// 加载失败
  error,
}

/// 对话框类型枚举
enum ZephyrDialogType {
  /// 信息对话框
  info,

  /// 确认对话框
  confirm,

  /// 警告对话框
  warning,

  /// 错误对话框
  error,

  /// 成功对话框
  success,
}


/// 菜单项类型枚举
enum ZephyrMenuItemType {
  /// 普通菜单项
  item,

  /// 分组标题
  group,

  /// 分割线
  divider,

  /// 子菜单
  submenu,
}

/// 图标位置枚举
enum ZephyrIconPosition {
  /// 图标在左侧
  left,

  /// 图标在右侧
  right,

  /// 图标在上方
  top,

  /// 图标在下方
  bottom,
}

/// 对齐方式枚举
enum ZephyrAlignment {
  /// 左对齐
  left,

  /// 居中对齐
  center,

  /// 右对齐
  right,

  /// 两端对齐
  justify,
}

/// 垂直对齐方式枚举
enum ZephyrVerticalAlignment {
  /// 顶部对齐
  top,

  /// 居中对齐
  middle,

  /// 底部对齐
  bottom,
}

/// 布局方向枚举
enum ZephyrDirection {
  /// 水平方向
  horizontal,

  /// 垂直方向
  vertical,
}

/// 响应式断点枚举
enum ZephyrBreakpoint {
  /// 超小屏幕 (<576px)
  xs,

  /// 小屏幕 (≥576px)
  sm,

  /// 中等屏幕 (≥768px)
  md,

  /// 大屏幕 (≥992px)
  lg,

  /// 超大屏幕 (≥1200px)
  xl,

  /// 超超大屏幕 (≥1600px)
  xxl,
}

/// 动画类型枚举
enum ZephyrAnimationType {
  /// 淡入淡出
  fade,

  /// 滑入
  slide,

  /// 缩放
  scale,

  /// 旋转
  rotate,

  /// 弹跳
  bounce,

  /// 无动画
  none,
}

/// 阴影级别枚举
enum ZephyrShadowLevel {
  /// 无阴影
  none,

  /// 小阴影
  sm,

  /// 中等阴影
  md,

  /// 大阴影
  lg,

  /// 超大阴影
  xl,
}

/// 圆角级别枚举
enum ZephyrBorderRadius {
  /// 无圆角
  none,

  /// 小圆角
  sm,

  /// 中等圆角
  md,

  /// 大圆角
  lg,

  /// 超大圆角
  xl,

  /// 完全圆形
  full,
}

/// 扩展方法：获取尺寸对应的数值
extension ZephyrSizeExtension on ZephyrSize {
  double get value {
    switch (this) {
      case ZephyrSize.xs:
        return 0.75;
      case ZephyrSize.sm:
        return 0.875;
      case ZephyrSize.md:
        return 1.0;
      case ZephyrSize.lg:
        return 1.125;
      case ZephyrSize.xl:
        return 1.25;
    }
  }

  String get name {
    switch (this) {
      case ZephyrSize.xs:
        return 'extra-small';
      case ZephyrSize.sm:
        return 'small';
      case ZephyrSize.md:
        return 'medium';
      case ZephyrSize.lg:
        return 'large';
      case ZephyrSize.xl:
        return 'extra-large';
    }
  }
}

/// 扩展方法：获取变体对应的颜色
extension ZephyrVariantExtension on ZephyrVariant {
  String get name {
    switch (this) {
      case ZephyrVariant.primary:
        return 'primary';
      case ZephyrVariant.secondary:
        return 'secondary';
      case ZephyrVariant.success:
        return 'success';
      case ZephyrVariant.warning:
        return 'warning';
      case ZephyrVariant.danger:
        return 'danger';
      case ZephyrVariant.info:
        return 'info';
      case ZephyrVariant.light:
        return 'light';
      case ZephyrVariant.dark:
        return 'dark';
      case ZephyrVariant.link:
        return 'link';
    }
  }
}

/// 扩展方法：获取断点对应的数值
extension ZephyrBreakpointExtension on ZephyrBreakpoint {
  double get minWidth {
    switch (this) {
      case ZephyrBreakpoint.xs:
        return 0;
      case ZephyrBreakpoint.sm:
        return 576;
      case ZephyrBreakpoint.md:
        return 768;
      case ZephyrBreakpoint.lg:
        return 992;
      case ZephyrBreakpoint.xl:
        return 1200;
      case ZephyrBreakpoint.xxl:
        return 1600;
    }
  }

  String get name {
    switch (this) {
      case ZephyrBreakpoint.xs:
        return 'extra-small';
      case ZephyrBreakpoint.sm:
        return 'small';
      case ZephyrBreakpoint.md:
        return 'medium';
      case ZephyrBreakpoint.lg:
        return 'large';
      case ZephyrBreakpoint.xl:
        return 'extra-large';
      case ZephyrBreakpoint.xxl:
        return 'extra-extra-large';
    }
  }
}
