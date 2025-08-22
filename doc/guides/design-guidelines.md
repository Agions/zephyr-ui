# ZephyrUI 设计指南

<div align="center">

![设计系统](https://img.shields.io/badge/设计系统-v1.0-blue?style=for-the-badge&logo=design&logoColor=white)
![Material Design 3](https://img.shields.io/badge/Material_Design-3-green?style=for-the-badge&logo=materialdesign&logoColor=white)
![WCAG AA](https://img.shields.io/badge/WCAG-AA_符合-success?style=for-the-badge&logo=w3c&logoColor=white)

**企业级应用专业设计系统**

</div>

---

## 📖 目录

- [🎯 设计原则](#-设计原则)
- [🎨 颜色系统](#-颜色系统)
- [📏 排版](#-排版)
- [📐 间距和布局](#-间距和布局)
- [🔘 形状和边框](#-形状和边框)
- [🎭 图标和图像](#-图标和图像)
- [📱 响应式设计](#-响应式设计)
- [♿ 无障碍](#-无障碍)
- [🎨 组件设计](#-组件设计)
- [🌓 暗色模式](#-暗色模式)
- [🚀 性能](#-性能)

---

## 🎯 设计原则

### 核心价值

1. **一致性**: 所有组件统一的设计语言
2. **清晰性**: 清晰的视觉层次和直观的交互
3. **高效性**: 简化的工作流程和最小的认知负担
4. **无障碍**: 为所有用户提供包容性设计
5. **可扩展性**: 随需求增长的灵活系统

### 设计理念

```
┌─────────────────────────────────────────────────────────────┐
│                   ZephyrUI 设计理念                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🎨 **美学**: 美丽、现代的界面设计                          │
│  🧠 **认知**: 需要最小的心理努力                            │
│  🎯 **目的性**: 每个元素都有明确的目的                      │
│  📱 **适应性**: 在所有设备上无缝工作                        │
│  ⚡ **高性能**: 快速、流畅的交互                            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🎨 颜色系统

### 主要颜色

```dart
// 主要颜色调色板
static const Color primary50 = Color(0xFFF0F9FF);
static const Color primary100 = Color(0xFFE0F2FE);
static const Color primary200 = Color(0xFFBAE6FD);
static const Color primary300 = Color(0xFF7DD3FC);
static const Color primary400 = Color(0xFF38BDF8);
static const Color primary500 = Color(0xFF0EA5E9);  // 主要颜色
static const Color primary600 = Color(0xFF0284C7);
static const Color primary700 = Color(0xFF0369A1);
static const Color primary800 = Color(0xFF075985);
static const Color primary900 = Color(0xFF0C4A6E);
```

### 语义颜色

```dart
// 成功颜色
static const Color success50 = Color(0xFFF0FDF4);
static const Color success100 = Color(0xFFDCFCE7);
static const Color success500 = Color(0xFF22C55E);
static const Color success700 = Color(0xFF15803D);

// 警告颜色
static const Color warning50 = Color(0xFFFFF7ED);
static const Color warning100 = Color(0xFFFFEDD5);
static const Color warning500 = Color(0xFFF97316);
static const Color warning700 = Color(0xFFC2410C);

// 错误颜色
static const Color error50 = Color(0xFFFEF2F2);
static const Color error100 = Color(0xFFFEE2E2);
static const Color error500 = Color(0xFFEF4444);
static const Color error700 = Color(0xFFB91C1C);

// 信息颜色
static const Color info50 = Color(0xFFEFF6FF);
static const Color info100 = Color(0xFFDBEAFE);
static const Color info500 = Color(0xFF3B82F6);
static const Color info700 = Color(0xFF1D4ED8);
```

### 中性颜色

```dart
// 灰度色阶
static const Color gray50 = Color(0xFFF9FAFB);
static const Color gray100 = Color(0xFFF3F4F6);
static const Color gray200 = Color(0xFFE5E7EB);
static const Color gray300 = Color(0xFFD1D5DB);
static const Color gray400 = Color(0xFF9CA3AF);
static const Color gray500 = Color(0xFF6B7280);
static const Color gray600 = Color(0xFF4B5563);
static const Color gray700 = Color(0xFF374151);
static const Color gray800 = Color(0xFF1F2937);
static const Color gray900 = Color(0xFF111827);
```

### 颜色使用指南

#### ✅ 最佳实践

```dart
// 主要操作
ZephyrButton.primary(
  backgroundColor: ZephyrColors.primary500,
  onPressed: () {},
)

// 次要操作
ZephyrButton.secondary(
  backgroundColor: ZephyrColors.gray100,
  onPressed: () {},
)

// 成功状态
ZephyrAlert.success(
  backgroundColor: ZephyrColors.success50,
  borderColor: ZephyrColors.success200,
)

// 错误状态
ZephyrInputField(
  errorText: '无效的邮箱',
  borderColor: ZephyrColors.error500,
)
```

#### ❌ 避免

```dart
// 不要同时使用太多鲜艳的颜色
Container(
  color: Colors.red,  // 避免使用鲜艳的红色背景
  child: Text('警告'),
)

// 不要使用对比度不足的颜色
Text(
  '低对比度文本',
  style: TextStyle(color: Color(0xFFAAAAAA)),  // 对比度差
)
```

---

## 📏 排版

### 字体比例

```dart
class ZephyrTypography {
  // 展示文字
  static const TextStyle displayLarge = TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: -0.02,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: -0.015,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -0.01,
  );

  // 标题
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.01,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.01,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // 标题
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // 正文
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.01,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.01,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.01,
  );

  // 标签
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
  );
}
```

### 排版使用

#### ✅ 最佳实践

```dart
// 页面标题
Text(
  '仪表板概览',
  style: ZephyrTypography.headlineMedium,
)

// 区块标题
Text(
  '最近活动',
  style: ZephyrTypography.titleLarge,
)

// 正文内容
Text(
  '欢迎使用您的个性化仪表板。在这里您可以查看最近的活动并管理您的账户设置。',
  style: ZephyrTypography.bodyMedium,
)

// 标签和说明
Text(
  '邮箱地址',
  style: ZephyrTypography.labelMedium,
)
```

#### ❌ 避免

```dart
// 不要将展示文字用于正文内容
Text(
  '这是常规正文文本',
  style: TextStyle(fontSize: 48),  // 对正文来说太大
)

// 不要混合太多字体粗细
Text(
  '混合粗细',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,  // 对正文来说太粗
  ),
)
```

---

## 📐 间距和布局

### 间距比例

```dart
class ZephyrSpacing {
  static const double xs = 4.0;    // 超小
  static const double sm = 8.0;    // 小
  static const double md = 16.0;   // 中
  static const double lg = 24.0;   // 大
  static const double xl = 32.0;   // 超大
  static const double xxl = 48.0;  // 2倍大
  static const double xxxl = 64.0; // 3倍大
}
```

### 布局网格

```dart
class ZephyrGrid {
  // 断点
  static const double mobile = 600.0;
  static const double tablet = 900.0;
  static const double desktop = 1200.0;

  // 网格列数
  static const int columns = 12;

  // 槽宽度和边距
  static const double gutter = 16.0;
  static const double margin = 24.0;
}
```

### 间距使用

#### ✅ 最佳实践

```dart
// 组件间距
Column(
  children: [
    Header(),
    SizedBox(height: ZephyrSpacing.lg),
    Content(),
    SizedBox(height: ZephyrSpacing.lg),
    Footer(),
  ],
)

// 内边距
Container(
  padding: EdgeInsets.all(ZephyrSpacing.md),
  child: Text('内容'),
)

// 响应式间距
EdgeInsetsGeometry getResponsivePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < ZephyrGrid.mobile) {
    return EdgeInsets.all(ZephyrSpacing.sm);
  } else if (width < ZephyrGrid.tablet) {
    return EdgeInsets.all(ZephyrSpacing.md);
  } else {
    return EdgeInsets.all(ZephyrSpacing.lg);
  }
}
```

#### ❌ 避免

```dart
// 不要使用任意的间距值
SizedBox(height: 17),  // 不在间距比例上

// 不要使用不一致的间距
Column(
  children: [
    Widget1(),
    SizedBox(height: 16),
    Widget2(),
    SizedBox(height: 24),  // 不一致的间距
    Widget3(),
  ],
)
```

---

## 🔘 形状和边框

### 圆角比例

```dart
class ZephyrBorderRadius {
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double full = 9999.0;
}
```

### 边框宽度比例

```dart
class ZephyrBorderWidth {
  static const double none = 0.0;
  static const double thin = 1.0;
  static const double medium = 2.0;
  static const double thick = 4.0;
}
```

### 形状使用

#### ✅ 最佳实践

```dart
// 具有一致圆角的卡片
Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(ZephyrBorderRadius.md),
  ),
  child: Padding(
    padding: EdgeInsets.all(ZephyrSpacing.md),
    child: Text('卡片内容'),
  ),
)

// 具有适当圆角的按钮
ElevatedButton(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ZephyrBorderRadius.sm),
    ),
  ),
  onPressed: () {},
  child: Text('按钮'),
)
```

#### ❌ 避免

```dart
// 不要使用不一致的圆角
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(8),  // 不一致
    ),
  ),
)

// 不要使用过大的圆角
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),  // 对大多数情况来说太大
  ),
)
```

---

## 🎭 图标和图像

### 图标系统

```dart
class ZephyrIcons {
  // 具有一致尺寸的 Material Icons
  static const double small = 16.0;
  static const double medium = 24.0;
  static const double large = 32.0;
  static const double xlarge = 48.0;

  // 图标使用
  static Widget create({
    required IconData icon,
    double size = medium,
    Color? color,
  }) {
    return Icon(
      icon,
      size: size,
      color: color ?? ZephyrColors.gray600,
    );
  }
}
```

### 图像指南

#### ✅ 最佳实践

```dart
// 响应式图像
Image.network(
  'https://example.com/image.jpg',
  fit: BoxFit.cover,
  width: double.infinity,
  height: 200,
)

// 加载占位符
Image.network(
  'https://example.com/image.jpg',
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);
  },
)
```

#### ❌ 避免

```dart
// 不要拉伸图像
Image.network(
  'https://example.com/image.jpg',
  fit: BoxFit.fill,  // 扭曲图像宽高比
)

// 不要在没有适当错误处理的情况下使用图像
Image.network(
  'https://example.com/image.jpg',
  // 没有错误处理
)
```

---

## 📱 响应式设计

### 断点系统

```dart
class ZephyrBreakpoints {
  static const double mobile = 600.0;
  static const double tablet = 900.0;
  static const double desktop = 1200.0;

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobile) return DeviceType.mobile;
    if (width < tablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }
}

enum DeviceType { mobile, tablet, desktop }
```

### 响应式组件

#### ✅ 最佳实践

```dart
class ResponsiveCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceType = ZephyrBreakpoints.getDeviceType(context);

    return Card(
      child: Padding(
        padding: _getResponsivePadding(deviceType),
        child: Column(
          children: [
            _buildHeader(deviceType),
            SizedBox(height: _getResponsiveSpacing(deviceType)),
            _buildContent(deviceType),
          ],
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getResponsivePadding(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return EdgeInsets.all(ZephyrSpacing.sm);
      case DeviceType.tablet:
        return EdgeInsets.all(ZephyrSpacing.md);
      case DeviceType.desktop:
        return EdgeInsets.all(ZephyrSpacing.lg);
    }
  }

  double _getResponsiveSpacing(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return ZephyrSpacing.sm;
      case DeviceType.tablet:
        return ZephyrSpacing.md;
      case DeviceType.desktop:
        return ZephyrSpacing.lg;
    }
  }
}
```

---

## ♿ 无障碍

### WCAG 合规

#### 颜色对比度

```dart
// 确保足够的对比度
bool hasSufficientContrast(Color foreground, Color background) {
  final contrast = _calculateContrastRatio(foreground, background);
  return contrast >= 4.5; // WCAG AA 标准
}

// 使用语义颜色
Text(
  '重要消息',
  style: TextStyle(
    color: ZephyrColors.error500,
    fontWeight: FontWeight.bold,
  ),
)
```

### 屏幕阅读器支持

#### ✅ 最佳实践

```dart
// 语义标签
ElevatedButton(
  onPressed: () {},
  child: Text('提交表单'),
  semanticLabel: '提交注册表单',
)

// 焦点管理
Focus(
  focusNode: _focusNode,
  child: TextFormField(
    decoration: InputDecoration(
      labelText: '邮箱',
    ),
  ),
)

// 图像的替代文本
Image.network(
  'https://example.com/image.jpg',
  semanticLabel: '公司标志',
)
```

### 键盘导航

#### ✅ 最佳实践

```dart
// 键盘快捷键
Shortcuts(
  shortcuts: {
    LogicalKeySet(LogicalKeyboardKey.keyS): const SubmitIntent(),
    LogicalKeySet(LogicalKeyboardKey.escape): const CancelIntent(),
  },
  child: Actions(
    actions: {
      SubmitIntent: CallbackAction<SubmitIntent>(
        onInvoke: (_) => _submitForm(),
      ),
      CancelIntent: CallbackAction<CancelIntent>(
        onInvoke: (_) => _cancelForm(),
      ),
    },
    child: _buildForm(),
  ),
)
```

---

## 🎨 组件设计

### 按钮设计

```dart
class ZephyrButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ZephyrButtonType type;

  const ZephyrButton({
    required this.text,
    this.onPressed,
    this.type = ZephyrButtonType.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(type),
      child: Text(text),
    );
  }

  ButtonStyle _getButtonStyle(ZephyrButtonType type) {
    switch (type) {
      case ZephyrButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: ZephyrColors.primary500,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ZephyrSpacing.lg,
            vertical: ZephyrSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZephyrBorderRadius.sm),
          ),
        );
      case ZephyrButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: ZephyrColors.primary500,
          side: BorderSide(color: ZephyrColors.primary500),
          padding: EdgeInsets.symmetric(
            horizontal: ZephyrSpacing.lg,
            vertical: ZephyrSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZephyrBorderRadius.sm),
          ),
        );
    }
  }
}
```

### 输入字段设计

```dart
class ZephyrInputField extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const ZephyrInputField({
    this.label,
    this.placeholder,
    this.errorText,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: ZephyrTypography.labelMedium,
          ),
          SizedBox(height: ZephyrSpacing.xs),
        ],
        TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ZephyrBorderRadius.sm),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: ZephyrSpacing.md,
              vertical: ZephyrSpacing.md,
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
```

---

## 🌓 暗色模式

### 暗色主题颜色

```dart
class ZephyrDarkTheme {
  static const Color background = Color(0xFF0F0F0F);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceVariant = Color(0xFF2A2A2A);
  static const Color onSurface = Color(0xFFE0E0E0);
  static const Color onSurfaceVariant = Color(0xFFB0B0B0);

  static ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: ZephyrColors.primary500,
      surface: surface,
      background: background,
      onSurface: onSurface,
    ),
  );
}
```

### 主题实现

```dart
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: ZephyrColors.primary500,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ZephyrDarkTheme.theme;
  }
}
```

---

## 🚀 性能

### 优化的组件构建

#### ✅ 最佳实践

```dart
// 尽可能使用 const 构造函数
class OptimizedWidget extends StatelessWidget {
  const OptimizedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('优化');
  }
}

// 为列表项使用键
class OptimizedList extends StatelessWidget {
  final List<String> items;

  const OptimizedList({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey(items[index]),  // 对性能很重要
          title: Text(items[index]),
        );
      },
    );
  }
}
```

### 内存管理

#### ✅ 最佳实践

```dart
// 正确释放控制器
class _FormWidgetState extends State<FormWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();  // 对内存管理很重要
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
    );
  }
}
```

---

## 📝 实现检查清单

### 设计系统实现

- [ ] **颜色**: 定义主要、次要和语义颜色
- [ ] **排版**: 建立字体比例和字体粗细
- [ ] **间距**: 创建一致的间距比例
- [ ] **形状**: 定义圆角和边框宽度
- [ ] **图标**: 建立图标系统和使用指南
- [ ] **组件**: 创建一致的组件设计
- [ ] **无障碍**: 确保 WCAG AA 合规
- [ ] **响应式**: 实现断点系统
- [ ] **暗色模式**: 创建暗色主题变体
- [ ] **性能**: 为性能优化

### 文档

- [ ] **设计指南**: 全面的设计文档
- [ ] **组件示例**: 实时示例和代码片段
- [ ] **使用指南**: 最佳实践和反模式
- [ ] **无障碍指南**: WCAG 合规指南
- [ ] **性能指南**: 优化技术

---

## 🔄 相关资源

- [Material Design 3](https://m3.material.io/)
- [WCAG 指南](https://www.w3.org/WAI/WCAG21/quickref/)
- [Flutter 性能](https://docs.flutter.dev/performance)
- [无障碍检查清单](https://flutter.dev/docs/development/accessibility-and-localization/accessibility)

---

<div align="center">

**遵循 ZephyrUI 设计指南，构建一致、专业的应用**

</div>
