---
title: API 参考
description: VelocityUI 完整 API 文档
---

# API 参考

本页面提供 VelocityUI 组件库的完整 API 参考文档。

## 1. 基础组件

### 1.1 Button 按钮

**构造函数**：

```dart
VelocityButton({
  Key? key,
  required Widget child,
  VoidCallback? onPressed,
  VoidCallback? onLongPress,
  bool? enabled,
  VelocityButtonType? type,
  VelocityButtonSize? size,
  VelocityButtonShape? shape,
  bool? loading,
  Widget? loadingIndicator,
  String? semanticLabel,
  VelocityButtonStyle? style,
});
```

**枚举类型**：

```dart
enum VelocityButtonType {
  primary,  // 主要按钮
  secondary, // 次要按钮
  text,     // 文本按钮
  link,     // 链接按钮
  outline,  // 轮廓按钮
}

enum VelocityButtonSize {
  xs,  // 超小尺寸
  sm,  // 小尺寸
  md,  // 中等尺寸
  lg,  // 大尺寸
  xl,  // 超大尺寸
}

enum VelocityButtonShape {
  rectangle,  // 矩形
  rounded,    // 圆角矩形
  circle,     // 圆形
}
```

**样式类**：

```dart
class VelocityButtonStyle {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? height;
  final TextStyle? textStyle;
  final Color? loadingColor;
  final double? loadingSize;
}
```

### 1.2 Text 文本

**构造函数**：

```dart
VelocityText(
  this.data,
  {
    Key? key,
    VelocityTextSize? size,
    VelocityFontWeight? weight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextStyle? style,
    String? semanticLabel,
  },
);
```

**枚举类型**：

```dart
enum VelocityTextSize {
  xs,  // 超小尺寸
  sm,  // 小尺寸
  md,  // 中等尺寸
  lg,  // 大尺寸
  xl,  // 超大尺寸
  xxl, // 特大尺寸
  xxxl, // 超大特大尺寸
}

enum VelocityFontWeight {
  thin,      // 100
  extraLight, // 200
  light,     // 300
  regular,   // 400
  medium,    // 500
  semiBold,  // 600
  bold,      // 700
  extraBold, // 800
  black,     // 900
}
```

**样式类**：

```dart
class VelocityTextStyle {
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final int? maxLines;
  final TextOverflow? overflow;
}
```

### 1.3 Icon 图标

**构造函数**：

```dart
VelocityIcon(
  this.icon,
  {
    Key? key,
    VelocityIconSize? size,
    Color? color,
    double? customSize,
    String? semanticLabel,
    VelocityIconStyle? style,
  },
);
```

**枚举类型**：

```dart
enum VelocityIconSize {
  xs,  // 超小尺寸
  sm,  // 小尺寸
  md,  // 中等尺寸
  lg,  // 大尺寸
  xl,  // 超大尺寸
}
```

**样式类**：

```dart
class VelocityIconStyle {
  final Color? color;
  final double? size;
  final double? opacity;
}
```

### 1.4 Image 图片

**构造函数**：

```dart
VelocityImage.network(
  this.src,
  {
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Alignment? alignment,
    Color? color,
    BlendMode? colorBlendMode,
    FilterQuality? filterQuality,
    String? semanticLabel,
    VelocityImageStyle? style,
  },
);

VelocityImage.asset(
  this.src,
  {
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Alignment? alignment,
    Color? color,
    BlendMode? colorBlendMode,
    FilterQuality? filterQuality,
    String? semanticLabel,
    VelocityImageStyle? style,
  },
);
```

**样式类**：

```dart
class VelocityImageStyle {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment? alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality? filterQuality;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final BoxShadow? shadow;
}
```

### 1.5 Link 链接

**构造函数**：

```dart
VelocityLink({
  Key? key,
  required Widget child,
  required String href,
  VoidCallback? onTap,
  VelocityLinkType? type,
  String? semanticLabel,
  VelocityLinkStyle? style,
});
```

**枚举类型**：

```dart
enum VelocityLinkType {
  primary,  // 主要链接
  secondary, // 次要链接
  success,  // 成功链接
  warning,  // 警告链接
  error,    // 错误链接
  info,     // 信息链接
}
```

**样式类**：

```dart
class VelocityLinkStyle {
  final Color? color;
  final Color? hoverColor;
  final Color? activeColor;
  final Color? visitedColor;
  final TextStyle? textStyle;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
}
```

## 2. 展示组件

### 2.1 Avatar 头像

**构造函数**：

```dart
VelocityAvatar({
  Key? key,
  String? imageUrl,
  String? name,
  IconData? icon,
  VelocityAvatarSize? size,
  VelocityAvatarShape? shape,
  double? customSize,
  VoidCallback? onTap,
  String? semanticLabel,
  VelocityAvatarStyle? style,
});
```

**枚举类型**：

```dart
enum VelocityAvatarSize {
  xs,  // 24px
  sm,  // 32px
  md,  // 40px
  lg,  // 48px
  xl,  // 64px
}

enum VelocityAvatarShape {
  circle,   // 圆形
  square,   // 方形
  rounded,  // 圆角方形
}
```

**样式类**：

```dart
class VelocityAvatarStyle {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
}
```

### 2.2 Badge 徽章

**构造函数**：

```dart
VelocityBadge({
  Key? key,
  int? count,
  bool? dot,
  bool? showZero,
  int? max,
  VelocityBadgeType? type,
  Offset? offset,
  Widget? child,
  String? semanticLabel,
  VelocityBadgeStyle? style,
});
```

**枚举类型**：

```dart
enum VelocityBadgeType {
  primary,  // 主要颜色
  success,  // 成功颜色
  warning,  // 警告颜色
  error,    // 错误颜色
  info,     // 信息颜色
}
```

**样式类**：

```dart
class VelocityBadgeStyle {
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? minWidth;
  final double? height;
}
```

### 2.3 Card 卡片

**构造函数**：

```dart
VelocityCard({
  Key? key,
  Widget? child,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  String? semanticLabel,
  VelocityCardStyle? style,
});

VelocityOutlinedCard({
  Key? key,
  Widget? child,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  String? semanticLabel,
  VelocityCardStyle? style,
});

VelocityFilledCard({
  Key? key,
  Widget? child,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  String? semanticLabel,
  VelocityCardStyle? style,
});
```

**样式类**：

```dart
class VelocityCardStyle {
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;
  final Color? borderColor;
  final double? borderWidth;
}
```

## 3. 布局组件

### 3.1 Container 容器

**构造函数**：

```dart
VelocityContainer({
  Key? key,
  Widget? child,
  double? width,
  double? height,
  Alignment? alignment,
  EdgeInsets? padding,
  EdgeInsets? margin,
  VelocityContainerStyle? style,
});
```

**样式类**：

```dart
class VelocityContainerStyle {
  final Color? color;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decoration;
  final BoxConstraints? constraints;
  final Matrix4? transform;
}
```

### 3.2 Grid 网格

**构造函数**：

```dart
VelocityGrid({
  Key? key,
  required List<Widget> children,
  int? columns,
  double? spacing,
  double? runSpacing,
  EdgeInsets? padding,
  Axis? scrollDirection,
  bool? reverse,
  ScrollController? controller,
  bool? primary,
  ScrollPhysics? physics,
  bool? shrinkWrap,
  VelocityGridStyle? style,
});
```

**样式类**：

```dart
class VelocityGridStyle {
  final int? columns;
  final double? spacing;
  final double? runSpacing;
  final EdgeInsets? padding;
  final Axis? scrollDirection;
  final bool? reverse;
  final ScrollPhysics? physics;
}
```

### 3.3 Space 间距

**构造函数**：

```dart
VelocitySpace({
  Key? key,
  double? width,
  double? height,
  VelocitySpaceStyle? style,
});
```

**样式类**：

```dart
class VelocitySpaceStyle {
  final double? width;
  final double? height;
}
```

## 4. 导航组件

### 4.1 Navbar 导航栏

**构造函数**：

```dart
VelocityNavbar({
  Key? key,
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
  Color? backgroundColor,
  Color? textColor,
  double? height,
  bool? centerTitle,
  VelocityNavbarStyle? style,
});
```

**样式类**：

```dart
class VelocityNavbarStyle {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? height;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final bool? centerTitle;
  final Border? bottomBorder;
}
```

### 4.2 Tabs 标签页

**构造函数**：

```dart
VelocityTabs({
  Key? key,
  required List<VelocityTab> tabs,
  required List<Widget> children,
  int? initialIndex,
  ValueChanged<int>? onTap,
  VelocityTabsStyle? style,
});
```

**Tab 类**：

```dart
class VelocityTab {
  final Widget? child;
  final String? text;
  final Widget? icon;
  final Widget? iconMargin;
  final bool? disabled;
  
  const VelocityTab({
    this.child,
    this.text,
    this.icon,
    this.iconMargin,
    this.disabled = false,
  });
}
```

**样式类**：

```dart
class VelocityTabsStyle {
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? indicatorHeight;
  final EdgeInsets? indicatorPadding;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final double? tabHeight;
  final EdgeInsets? tabPadding;
}
```

## 5. 表单组件

### 5.1 Input 输入框

**构造函数**：

```dart
VelocityInput({
  Key? key,
  String? initialValue,
  ValueChanged<String>? onChanged,
  VoidCallback? onEditingComplete,
  ValueChanged<String>? onSubmitted,
  FocusNode? focusNode,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  bool? enabled,
  bool? readOnly,
  bool? obscureText,
  int? maxLines,
  int? minLines,
  int? maxLength,
  String? placeholder,
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? semanticLabel,
  VelocityInputStyle? style,
});
```

**样式类**：

```dart
class VelocityInputStyle {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final TextStyle? placeholderStyle;
  final Color? focusedBorderColor;
  final Color? disabledBorderColor;
  final Color? errorBorderColor;
  final double? height;
}
```

### 5.2 Checkbox 复选框

**构造函数**：

```dart
VelocityCheckbox({
  Key? key,
  bool? value,
  ValueChanged<bool?>? onChanged,
  bool? enabled,
  VelocityCheckboxType? type,
  Widget? label,
  String? semanticLabel,
  VelocityCheckboxStyle? style,
});
```

**枚举类型**：

```dart
enum VelocityCheckboxType {
  primary,  // 主要颜色
  success,  // 成功颜色
  warning,  // 警告颜色
  error,    // 错误颜色
  info,     // 信息颜色
}
```

**样式类**：

```dart
class VelocityCheckboxStyle {
  final Color? color;
  final Color? checkColor;
  final double? size;
  final TextStyle? labelStyle;
  final EdgeInsets? labelPadding;
}
```

### 5.3 Radio 单选框

**构造函数**：

```dart
VelocityRadio<T>({
  Key? key,
  required T value,
  required T? groupValue,
  required ValueChanged<T?>? onChanged,
  bool? enabled,
  VelocityRadioType? type,
  Widget? label,
  String? semanticLabel,
  VelocityRadioStyle? style,
});
```

**枚举类型**：

```dart
enum VelocityRadioType {
  primary,  // 主要颜色
  success,  // 成功颜色
  warning,  // 警告颜色
  error,    // 错误颜色
  info,     // 信息颜色
}
```

**样式类**：

```dart
class VelocityRadioStyle {
  final Color? color;
  final double? size;
  final TextStyle? labelStyle;
  final EdgeInsets? labelPadding;
}
```

## 6. 反馈组件

### 6.1 Dialog 对话框

**构造函数**：

```dart
VelocityDialog({
  Key? key,
  Widget? title,
  Widget? content,
  List<Widget>? actions,
  bool? barrierDismissible,
  Color? barrierColor,
  String? semanticLabel,
  VelocityDialogStyle? style,
});
```

**静态方法**：

```dart
// 显示对话框
static Future<T?> show<T>(
  BuildContext context,
  VelocityDialog dialog,
  {
    bool barrierDismissible = true,
    Color barrierColor = Colors.black54,
  },
);

// 显示警告对话框
static Future<bool?> showAlert(
  BuildContext context,
  {
    String? title,
    String? content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  },
);
```

**样式类**：

```dart
class VelocityDialogStyle {
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final double? elevation;
  final BoxShadow? shadow;
}
```

### 6.2 Toast 轻提示

**静态方法**：

```dart
// 显示 Toast
static void show(
  BuildContext context,
  String message,
  {
    VelocityToastType? type,
    Duration? duration,
    VelocityToastPosition? position,
    Widget? icon,
    VelocityToastStyle? style,
  },
);

// 显示成功 Toast
static void success(
  BuildContext context,
  String message,
  {
    Duration? duration,
    VelocityToastPosition? position,
  },
);

// 显示错误 Toast
static void error(
  BuildContext context,
  String message,
  {
    Duration? duration,
    VelocityToastPosition? position,
  },
);
```

**枚举类型**：

```dart
enum VelocityToastType {
  success,  // 成功
  error,    // 错误
  warning,  // 警告
  info,     // 信息
}

enum VelocityToastPosition {
  top,    // 顶部
  center, // 居中
  bottom, // 底部
}
```

**样式类**：

```dart
class VelocityToastStyle {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? elevation;
  final BoxShadow? shadow;
  final EdgeInsets? margin;
}
```

## 7. 主题系统

### 7.1 VelocityThemeData

**构造函数**：

```dart
VelocityThemeData({
  Color? primaryColor,
  Color? secondaryColor,
  Color? successColor,
  Color? warningColor,
  Color? errorColor,
  Color? infoColor,
  Color? backgroundColor,
  Color? textColor,
  Color? disabledColor,
  VelocityButtonTheme? buttonTheme,
  VelocityTextTheme? textTheme,
  VelocityCardTheme? cardTheme,
  VelocityInputTheme? inputTheme,
  VelocityBadgeTheme? badgeTheme,
  VelocityDialogTheme? dialogTheme,
  VelocityToastTheme? toastTheme,
});
```

### 7.2 组件主题类

每个组件都有对应的主题类，例如：

- `VelocityButtonTheme`
- `VelocityTextTheme`
- `VelocityCardTheme`
- `VelocityInputTheme`
- `VelocityBadgeTheme`
- `VelocityDialogTheme`
- `VelocityToastTheme`

## 8. HTTP 客户端

### 8.1 VelocityHttpClient

**构造函数**：

```dart
VelocityHttpClient({
  String? baseUrl,
  Map<String, String>? defaultHeaders,
  Duration? timeout,
  List<VelocityHttpRequestInterceptor>? requestInterceptors,
  List<VelocityHttpResponseInterceptor>? responseInterceptors,
  List<VelocityHttpErrorInterceptor>? errorInterceptors,
});
```

**拦截器类型**：

```dart
typedef VelocityHttpRequestInterceptor = Future<VelocityHttpRequestConfig> Function(VelocityHttpRequestConfig config);
typedef VelocityHttpResponseInterceptor = Future<VelocityHttpResponse> Function(VelocityHttpResponse response);
typedef VelocityHttpErrorInterceptor = Future<VelocityHttpResponse> Function(dynamic error);
```

**请求方法**：

```dart
Future<VelocityHttpResponse> request({
  required String path,
  String? method,
  dynamic data,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers,
  Duration? timeout,
});

// 快捷方法
Future<VelocityHttpResponse> get({
  required String path,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers,
  Duration? timeout,
});

Future<VelocityHttpResponse> post({
  required String path,
  dynamic data,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers,
  Duration? timeout,
});

Future<VelocityHttpResponse> put({
  required String path,
  dynamic data,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers,
  Duration? timeout,
});

Future<VelocityHttpResponse> delete({
  required String path,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers,
  Duration? timeout,
});
```

**请求配置类**：

```dart
class VelocityHttpRequestConfig {
  final String path;
  final String method;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final Map<String, String>? headers;
  final String? baseUrl;
  final Duration? timeout;
}
```

**响应类**：

```dart
class VelocityHttpResponse {
  final int statusCode;
  final String statusMessage;
  final dynamic data;
  final Map<String, String> headers;
  final dynamic requestConfig;
}
```

## 9. 工具类

### 9.1 VelocityResponsive

**响应式工具类**：

```dart
// 响应式尺寸
class VelocityResponsiveDouble {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  
  const VelocityResponsiveDouble({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });
  
  double value(BuildContext context);
}

// 响应式边距
class VelocityResponsiveEdgeInsets {
  final EdgeInsets xs;
  final EdgeInsets sm;
  final EdgeInsets md;
  final EdgeInsets lg;
  final EdgeInsets xl;
  
  const VelocityResponsiveEdgeInsets({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });
  
  EdgeInsets value(BuildContext context);
}
```

### 9.2 VelocityUtils

**工具方法**：

```dart
// 颜色工具
static Color hexToColor(String hexString);
static String colorToHex(Color color);
static Color darken(Color color, [double amount = 0.1]);
static Color lighten(Color color, [double amount = 0.1]);
static Color withOpacity(Color color, double opacity);

// 文本工具
static String truncate(String text, int maxLength, {String suffix = '...'});
static String capitalize(String text);
static String camelToSnake(String text);
static String snakeToCamel(String text);

// 尺寸工具
static double screenWidth(BuildContext context);
static double screenHeight(BuildContext context);
static double screenPixelRatio(BuildContext context);
static double statusBarHeight(BuildContext context);
static double bottomBarHeight(BuildContext context);
```

## 10. 无障碍支持

所有 VelocityUI 组件都提供了无障碍支持，主要通过以下属性：

- `semanticLabel`：语义化标签
- `aria-label`：ARIA 标签
- `focusNode`：焦点节点
- 键盘导航支持
- 屏幕阅读器优化

## 11. 类型定义

### 11.1 回调类型

```dart
typedef VelocityValueChanged<T> = void Function(T value);
typedef VelocityVoidCallback = void Function();
typedef VelocityFutureCallback = Future<void> Function();
```

### 11.2 样式类型

```dart
typedef VelocityColorBuilder = Color Function(BuildContext context);
typedef VelocityDoubleBuilder = double Function(BuildContext context);
typedef VelocityWidgetBuilder = Widget Function(BuildContext context);
```

## 12. 版本兼容性

| VelocityUI 版本 | Flutter 版本 | Dart 版本 |
|----------------|--------------|-----------|
| 1.0.0+          | 3.0.0+       | 3.0.0+    |

## 13. 迁移指南

### 13.1 从 ZephyrUI 迁移

- 组件名称从 `ZephyrXxx` 改为 `VelocityXxx`
- 样式类从 `ZephyrXxxStyle` 改为 `VelocityXxxStyle`
- 主题类从 `ZephyrThemeData` 改为 `VelocityThemeData`
- 移除了一些已废弃的 API

### 13.2 从 v0.x 迁移到 v1.x

- 重构了主题系统
- 改进了样式合并机制
- 新增了响应式支持
- 完善了无障碍功能
- 优化了组件性能

---

以上是 VelocityUI 组件库的完整 API 参考文档。如需了解更多详情，请查看各个组件的单独文档页面。