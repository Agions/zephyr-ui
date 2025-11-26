/// ZephyrUI 枚举定义
///
/// 定义了组件库中使用的所有枚举类型，确保类型安全和一致性。
library enums;

/// 组件尺寸
enum ZephyrSize {
  /// 超小尺寸
  xs,

  /// 小尺寸
  sm,

  /// 中等尺寸（默认）
  md,

  /// 大尺寸
  lg,

  /// 超大尺寸
  xl,
}

/// 组件变体
enum ZephyrVariant {
  /// 主要变体
  primary,

  /// 次要变体
  secondary,

  /// 成功变体
  success,

  /// 警告变体
  warning,

  /// 错误变体
  error,

  /// 信息变体
  info,

  /// 中性变体
  neutral,

  /// 轮廓变体
  outline,

  /// 幽灵变体
  ghost,

  /// 链接变体
  link,
}

/// 组件状态
enum ZephyrState {
  /// 默认状态
  normal,

  /// 悬停状态
  hover,

  /// 聚焦状态
  focus,

  /// 激活状态
  active,

  /// 禁用状态
  disabled,

  /// 加载状态
  loading,

  /// 错误状态
  error,
}

/// 对齐方式
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

/// 方向
enum ZephyrDirection {
  /// 水平方向
  horizontal,

  /// 垂直方向
  vertical,
}

/// 位置
enum ZephyrPosition {
  /// 顶部
  top,

  /// 右侧
  right,

  /// 底部
  bottom,

  /// 左侧
  left,

  /// 顶部左侧
  topLeft,

  /// 顶部右侧
  topRight,

  /// 底部左侧
  bottomLeft,

  /// 底部右侧
  bottomRight,
}

/// 密度
enum ZephyrDensity {
  /// 紧凑密度
  compact,

  /// 标准密度
  standard,

  /// 舒适密度
  comfortable,
}

/// 响应式断点
enum ZephyrBreakpoint {
  /// 超小屏幕
  xs,

  /// 小屏幕
  sm,

  /// 中等屏幕
  md,

  /// 大屏幕
  lg,

  /// 超大屏幕
  xl,

  /// 超超大屏幕
  xxl,
}

/// 主题模式
enum ZephyrThemeMode {
  /// 浅色主题
  light,

  /// 深色主题
  dark,

  /// 系统主题
  system,
}

/// 输入类型
enum ZephyrInputType {
  /// 文本输入
  text,

  /// 密码输入
  password,

  /// 邮箱输入
  email,

  /// 数字输入
  number,

  /// 电话输入
  phone,

  /// URL输入
  url,

  /// 搜索输入
  search,

  /// 多行文本输入
  textarea,
}

/// 按钮类型
enum ZephyrButtonType {
  /// 填充按钮
  filled,

  /// 轮廓按钮
  outlined,

  /// 文本按钮
  text,

  /// 图标按钮
  icon,

  /// 浮动操作按钮
  fab,
}

/// 图标位置
enum ZephyrIconPosition {
  /// 左侧
  left,

  /// 右侧
  right,

  /// 顶部
  top,

  /// 底部
  bottom,
}

/// 加载状态
enum ZephyrLoadingState {
  /// 空闲状态
  idle,

  /// 加载中
  loading,

  /// 成功
  success,

  /// 错误
  error,
}

/// 表格排序方向
enum ZephyrSortDirection {
  /// 升序
  ascending,

  /// 降序
  descending,

  /// 无排序
  none,
}

/// 通知类型
enum ZephyrNotificationType {
  /// 成功通知
  success,

  /// 警告通知
  warning,

  /// 错误通知
  error,

  /// 信息通知
  info,
}

/// 模态框类型
enum ZephyrModalType {
  /// 对话框
  dialog,

  /// 抽屉
  drawer,

  /// 底部表单
  bottomSheet,

  /// 全屏模态
  fullscreen,
}

/// 步骤状态
enum ZephyrStepState {
  /// 等待状态
  waiting,

  /// 进行中状态
  active,

  /// 完成状态
  completed,

  /// 错误状态
  error,

  /// 禁用状态
  disabled,
}

/// 消息位置
enum ZephyrMessagePosition {
  /// 顶部
  top,

  /// 底部
  bottom,
}

/// 通知位置
enum ZephyrNotificationPosition {
  /// 右上角
  topRight,

  /// 左上角
  topLeft,

  /// 右下角
  bottomRight,

  /// 左下角
  bottomLeft,
}

/// 气泡确认框位置
enum ZephyrPopconfirmPlacement {
  /// 上方
  top,

  /// 下方
  bottom,

  /// 左侧
  left,

  /// 右侧
  right,

  /// 左上角
  topLeft,

  /// 右上角
  topRight,

  /// 左下角
  bottomLeft,

  /// 右下角
  bottomRight,
}

/// 气泡确认框触发模式
enum ZephyrPopconfirmTriggerMode {
  /// 点击触发
  click,

  /// 长按触发
  longPress,
}

/// 加载指示器尺寸
enum ZephyrSpinSize {
  /// 小尺寸
  small,

  /// 中等尺寸
  medium,

  /// 大尺寸
  large,
}

/// 扩展方法，为枚举添加实用功能
extension ZephyrSizeExtension on ZephyrSize {
  /// 获取尺寸对应的数值
  double get value {
    switch (this) {
      case ZephyrSize.xs:
        return 24.0;
      case ZephyrSize.sm:
        return 32.0;
      case ZephyrSize.md:
        return 40.0;
      case ZephyrSize.lg:
        return 48.0;
      case ZephyrSize.xl:
        return 56.0;
    }
  }

  /// 获取尺寸对应的内边距
  double get padding {
    switch (this) {
      case ZephyrSize.xs:
        return 8.0;
      case ZephyrSize.sm:
        return 12.0;
      case ZephyrSize.md:
        return 16.0;
      case ZephyrSize.lg:
        return 20.0;
      case ZephyrSize.xl:
        return 24.0;
    }
  }
}

extension ZephyrBreakpointExtension on ZephyrBreakpoint {
  /// 获取断点对应的像素值
  double get value {
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
        return 1400;
    }
  }
}
