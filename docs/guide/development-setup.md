# 开发指南

本指南为开发者提供 ZephyrUI 的完整开发指导，包括环境搭建、开发流程、测试、发布等内容。

## 🚀 快速开始

### 环境要求

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- **Node.js**: ^18.0.0 (用于文档开发)
- **Git**: 最新版本

### 项目结构

```
zephyr-ui/
├── lib/                    # 主要源代码
│   └── src/               # 源代码目录
│       ├── components/     # 组件实现
│       ├── core/          # 核心功能
│       ├── theme/         # 主题系统
│       └── utils/         # 工具类
├── example/               # 示例应用
├── test/                  # 测试文件
├── docs/                  # 文档
└── tool/                  # 开发工具
```

### 安装和设置

1. **克隆项目**

```bash
git clone https://github.com/Agions/zephyr-ui.git
cd zephyr-ui
```

2. **安装 Flutter 依赖**

```bash
flutter pub get
```

3. **安装文档依赖**

```bash
cd docs
npm install
```

4. **运行示例应用**

```bash
cd example
flutter run
```

## 📝 开发流程

### 1. 创建新组件

#### 组件目录结构

```
lib/src/components/[category]/
├── [component_name]/          # 组件目录
│   ├── [component_name].dart  # 主组件文件
│   ├── [component_name]_theme.dart  # 主题文件
│   └── index.dart            # 导出文件
└── index.dart                # 分类导出文件
```

#### 组件模板

```dart
// lib/src/components/basic/button/button.dart
import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

class ZephyrButton extends StatelessWidget {
  const ZephyrButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.variant = ZephyrVariant.primary,
    this.size = ZephyrSize.md,
    this.disabled = false,
    this.loading = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final ZephyrVariant variant;
  final ZephyrSize size;
  final bool disabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = ZephyrTheme.of(context);
    
    return ElevatedButton(
      onPressed: disabled || loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.buttonTheme.getBackgroundColor(variant),
        foregroundColor: theme.buttonTheme.getForegroundColor(variant),
        padding: theme.buttonTheme.getPadding(size),
        shape: RoundedRectangleBorder(
          borderRadius: theme.buttonTheme.borderRadius,
        ),
      ),
      child: loading
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.buttonTheme.getForegroundColor(variant),
                ),
              ),
            )
          : child,
    );
  }
}
```

#### 主题文件

```dart
// lib/src/components/basic/button/button_theme.dart
import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

class ZephyrButtonThemeData {
  const ZephyrButtonThemeData({
    this.primaryColor = const Color(0xFF2196F3),
    this.secondaryColor = const Color(0xFF03DAC6),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  final Color primaryColor;
  final Color secondaryColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  Color getBackgroundColor(ZephyrVariant variant) {
    switch (variant) {
      case ZephyrVariant.primary:
        return primaryColor;
      case ZephyrVariant.secondary:
        return secondaryColor;
      case ZephyrVariant.outline:
        return Colors.transparent;
      default:
        return primaryColor;
    }
  }

  Color getForegroundColor(ZephyrVariant variant) {
    switch (variant) {
      case ZephyrVariant.primary:
        return Colors.white;
      case ZephyrVariant.secondary:
        return Colors.black;
      case ZephyrVariant.outline:
        return primaryColor;
      default:
        return Colors.white;
    }
  }

  EdgeInsetsGeometry getPadding(ZephyrSize size) {
    switch (size) {
      case ZephyrSize.sm:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ZephyrSize.md:
        return padding;
      case ZephyrSize.lg:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      default:
        return padding;
    }
  }
}
```

#### 导出文件

```dart
// lib/src/components/basic/button/index.dart
export 'button.dart';
export 'button_theme.dart';
```

### 2. 编写测试

#### 单元测试

```dart
// test/components/button_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrButton', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton(
            onPressed: () {},
            child: Text('Test Button'),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ZephyrButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton(
            onPressed: () {
              pressed = true;
            },
            child: Text('Test Button'),
          ),
        ),
      );

      await tester.tap(find.byType(ZephyrButton));
      await tester.pump();

      expect(pressed, true);
    });

    testWidgets('is disabled when onPressed is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrButton(
            onPressed: null,
            child: Text('Test Button'),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    });
  });
}
```

#### 黄金测试

```dart
// test/components/button_golden_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrButton Golden Tests', () {
    testWidgets('matches golden file', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Center(
              child: ZephyrButton(
                onPressed: () {},
                child: Text('Test Button'),
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(ZephyrButton),
        matchesGoldenFile('goldens/button.png'),
      );
    });
  });
}
```

### 3. 文档编写

#### 组件文档

```markdown
# Button 按钮

按钮组件用于触发操作，支持多种样式和状态。

## 基础用法

```dart
ZephyrButton(
  onPressed: () {
    print('按钮被点击');
  },
  child: Text('点击我'),
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| onPressed | VoidCallback? | - | 点击回调函数 |
| child | Widget | - | 按钮内容 |
| variant | ZephyrVariant | ZephyrVariant.primary | 按钮样式 |
| size | ZephyrSize | ZephyrSize.md | 按钮尺寸 |
| disabled | bool | false | 是否禁用 |
| loading | bool | false | 是否显示加载状态 |

## 示例

### 不同样式

```dart
Column(
  children: [
    ZephyrButton(
      onPressed: () {},
      child: Text('主要按钮'),
      variant: ZephyrVariant.primary,
    ),
    ZephyrButton(
      onPressed: () {},
      child: Text('次要按钮'),
      variant: ZephyrVariant.secondary,
    ),
    ZephyrButton(
      onPressed: () {},
      child: Text('轮廓按钮'),
      variant: ZephyrVariant.outline,
    ),
  ],
)
```

### 不同尺寸

```dart
Row(
  children: [
    ZephyrButton(
      onPressed: () {},
      child: Text('小'),
      size: ZephyrSize.sm,
    ),
    ZephyrButton(
      onPressed: () {},
      child: Text('中'),
      size: ZephyrSize.md,
    ),
    ZephyrButton(
      onPressed: () {},
      child: Text('大'),
      size: ZephyrSize.lg,
    ),
  ],
)
```

## 注意事项

- 当 `onPressed` 为 `null` 时，按钮会自动禁用
- 在加载状态下，按钮会显示加载动画并禁用交互
- 建议为按钮提供明确的操作反馈
```

### 4. 代码审查清单

#### 组件开发清单

- [ ] 组件命名符合 ZephyrUI 规范
- [ ] 使用 `const` 构造函数
- [ ] 实现了完整的主题支持
- [ ] 添加了适当的类型注解
- [ ] 编写了单元测试
- [ ] 编写了黄金测试
- [ ] 添加了文档字符串
- [ ] 更新了导出文件
- [ ] 添加了示例代码

#### 代码质量检查

```bash
# 运行静态分析
flutter analyze

# 运行测试
flutter test

# 运行黄金测试
flutter test --update-goldens

# 检查覆盖率
flutter test --coverage
```

## 🧪 测试指南

### 测试策略

#### 1. 单元测试

单元测试用于测试组件的独立功能：

```dart
testWidgets('ZephyrInput 验证输入', (WidgetTester tester) async {
  String? errorText;
  
  await tester.pumpWidget(
    MaterialApp(
      home: ZephyrInput(
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return '请输入内容';
          }
          return null;
        },
        onChanged: (value) {
          errorText = validator(value);
        },
      ),
    ),
  );
  
  // 测试空值验证
  expect(errorText, '请输入内容');
  
  // 测试有效输入
  await tester.enterText(find.byType(ZephyrInput), 'Hello');
  await tester.pump();
  
  expect(errorText, null);
});
```

#### 2. 组件测试

组件测试用于测试组件的交互：

```dart
testWidgets('ZephyrModal 打开和关闭', (WidgetTester tester) async {
  bool isOpen = false;
  
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) {
          return ZephyrButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ZephyrModal(
                  title: '测试模态框',
                  content: Text('这是一个测试模态框'),
                  onClose: () {
                    Navigator.pop(context);
                    isOpen = false;
                  },
                ),
              );
              isOpen = true;
            },
            child: Text('打开模态框'),
          );
        },
      ),
    ),
  );
  
  // 打开模态框
  await tester.tap(find.byType(ZephyrButton));
  await tester.pumpAndSettle();
  
  expect(isOpen, true);
  expect(find.byType(ZephyrModal), findsOneWidget);
  
  // 关闭模态框
  await tester.tap(find.text('关闭'));
  await tester.pumpAndSettle();
  
  expect(isOpen, false);
  expect(find.byType(ZephyrModal), findsNothing);
});
```

#### 3. 集成测试

集成测试用于测试完整的应用流程：

```dart
// test_driver/app_test.dart
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('ZephyrUI App Tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('登录流程测试', () async {
      // 找到用户名输入框
      final usernameField = find.byValueKey('username_field');
      final passwordField = find.byValueKey('password_field');
      final loginButton = find.byValueKey('login_button');

      // 输入用户名和密码
      await driver.tap(usernameField);
      await driver.enterText('test@example.com');
      
      await driver.tap(passwordField);
      await driver.enterText('password123');

      // 点击登录按钮
      await driver.tap(loginButton);

      // 等待导航完成
      await driver.waitFor(find.byValueKey('home_page'));

      // 验证登录成功
      expect(await driver.getText(find.byValueKey('welcome_text')), '欢迎回来！');
    });
  });
}
```

### 测试覆盖率

确保代码覆盖率至少达到 85%：

```bash
# 生成覆盖率报告
flutter test --coverage

# 查看覆盖率报告
open coverage/lcov-report/index.html
```

## 📦 发布流程

### 版本管理

#### 语义化版本

ZephyrUI 遵循语义化版本规范：

- **主版本号**: 不兼容的 API 变更
- **次版本号**: 向后兼容的功能性新增
- **修订版本号**: 向后兼容的问题修复

#### 版本号规则

```yaml
# pubspec.yaml
version: 0.4.0+1  # 版本号 + 构建号
```

### 发布检查清单

- [ ] 所有测试通过
- [ ] 代码覆盖率 ≥ 85%
- [ ] 文档更新完成
- [ ] 更新日志更新
- [ ] 版本号正确
- [ ] 示例应用正常运行

### 发布步骤

1. **更新版本号**

```yaml
# pubspec.yaml
version: 0.4.1+1
```

2. **更新更新日志**

```markdown
## [0.4.1] - 2025-08-31

### Fixed

- 修复了按钮组件在特定情况下的显示问题
- 优化了输入框的验证逻辑
```

3. **运行发布检查**

```bash
# 运行所有测试
flutter test

# 检查代码质量
flutter analyze

# 构建示例应用
cd example
flutter build apk --release
```

4. **发布到 pub.dev**

```bash
# 发布前预检查
flutter pub publish --dry-run

# 正式发布
flutter pub publish
```

## 🎨 设计系统

### 设计原则

#### 1. 一致性

- **视觉一致性**: 统一的颜色、字体、间距
- **交互一致性**: 统一的手势、动画、反馈
- **行为一致性**: 统一的状态变化、错误处理

#### 2. 可访问性

- **颜色对比度**: 至少 4.5:1 的对比度
- **触摸目标**: 最少 44x44 像素的触摸区域
- **屏幕阅读器**: 完整的语义化标签

#### 3. 性能

- **懒加载**: 延迟加载非关键内容
- **缓存**: 合理使用缓存策略
- **优化**: 减少不必要的重绘

### 颜色系统

#### 主题色彩

```dart
class ZephyrColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFB00020);
  static const Color info = Color(0xFF2196F3);
}
```

#### 语义化颜色

```dart
class ZephyrSemanticColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color disabled = Color(0xFF9E9E9E);
}
```

### 字体系统

```dart
class ZephyrTextTheme {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: ZephyrColors.onBackground,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ZephyrColors.onBackground,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: ZephyrColors.onBackground,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ZephyrColors.onBackground,
  );
}
```

### 间距系统

```dart
class ZephyrSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}
```

## 🔧 性能优化

### 组件优化

#### 1. 使用 const 构造函数

```dart
// 好的做法
const ZephyrButton(
  onPressed: null,
  child: Text('按钮'),
)

// 不好的做法
ZephyrButton(
  onPressed: null,
  child: Text('按钮'),
)
```

#### 2. 避免不必要的重建

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ZephyrCard(
      child: Text('静态内容'),
    );
  }
}
```

#### 3. 使用 RepaintBoundary

```dart
RepaintBoundary(
  child: ZephyrImage(
    image: AssetImage('assets/large_image.png'),
  ),
)
```

### 列表优化

#### 1. 使用 ListView.builder

```dart
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ZephyrListItem(
      title: '项目 $index',
      subtitle: '描述 $index',
    );
  },
)
```

#### 2. 项目缓存

```dart
class CachedListItem extends StatelessWidget {
  final int index;

  const CachedListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrListItem(
      key: ValueKey('item_$index'),
      title: '项目 $index',
    );
  }
}
```

### 内存优化

#### 1. 图片优化

```dart
ZephyrImage(
  image: NetworkImage(
    'https://example.com/image.jpg',
  ),
  width: 100,
  height: 100,
  fit: BoxFit.cover,
  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) {
      return child;
    }
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
      child: child,
    );
  },
)
```

#### 2. 状态管理优化

```dart
class OptimizedWidget extends StatefulWidget {
  @override
  _OptimizedWidgetState createState() => _OptimizedWidgetState();
}

class _OptimizedWidgetState extends State<OptimizedWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('计数器: $_counter'),
        ZephyrButton(
          onPressed: _incrementCounter,
          child: Text('增加'),
        ),
        // 静态子组件，不需要重建
        const ZephyrText('这是一个静态文本'),
      ],
    );
  }
}
```

## 🌍 国际化

### 多语言支持

#### 1. 配置本地化

```dart
MaterialApp(
  localizationsDelegates: [
    ZephyrLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
    const Locale('ja', 'JP'),
    const Locale('ko', 'KR'),
  ],
  locale: Locale('zh', 'CN'),
)
```

#### 2. 本地化字符串

```dart
class ZephyrLocalizations {
  static const LocalizationsDelegate<ZephyrLocalizations> delegate =
      _ZephyrLocalizationsDelegate();

  static ZephyrLocalizations of(BuildContext context) {
    return Localizations.of<ZephyrLocalizations>(context, ZephyrLocalizations)!;
  }

  final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'button.save': 'Save',
      'button.cancel': 'Cancel',
      'button.delete': 'Delete',
      'input.placeholder': 'Please enter...',
      'modal.close': 'Close',
    },
    'zh': {
      'button.save': '保存',
      'button.cancel': '取消',
      'button.delete': '删除',
      'input.placeholder': '请输入...',
      'modal.close': '关闭',
    },
  };

  String get buttonSave {
    return _localizedStrings[locale.languageCode]!['button.save']!;
  }

  String get buttonCancel {
    return _localizedStrings[locale.languageCode]!['button.cancel']!;
  }

  String get inputPlaceholder {
    return _localizedStrings[locale.languageCode]!['input.placeholder']!;
  }
}
```

#### 3. RTL 支持

```dart
MaterialApp(
  locale: Locale('ar', 'SA'),
  textDirection: TextDirection.rtl,
  localizationsDelegates: [
    ZephyrLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('ar', 'SA'),
    const Locale('en', 'US'),
  ],
)
```

## 🐛 调试指南

### 开发者工具

#### 1. Flutter Inspector

```dart
// 在开发模式下启用调试标志
void main() {
  runApp(
    ZephyrApp(
      debugShowCheckedModeBanner: true,
      showPerformanceOverlay: kDebugMode,
      home: MyApp(),
    ),
  );
}
```

#### 2. 日志记录

```dart
import 'package:logging/logging.dart';

final logger = Logger('ZephyrUI');

class ZephyrButton extends StatelessWidget {
  const ZephyrButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    logger.info('Building ZephyrButton');
    
    return ElevatedButton(
      onPressed: () {
        logger.info('Button pressed');
        onPressed?.call();
      },
      child: child,
    );
  }
}
```

#### 3. 性能监控

```dart
import 'package:flutter/foundation.dart';

class PerformanceMonitor {
  static final Stopwatch _stopwatch = Stopwatch();

  static void startTimer() {
    if (kDebugMode) {
      _stopwatch.start();
    }
  }

  static void stopTimer(String operation) {
    if (kDebugMode) {
      _stopwatch.stop();
      debugPrint('$operation took ${_stopwatch.elapsedMilliseconds}ms');
      _stopwatch.reset();
    }
  }
}

// 使用示例
PerformanceMonitor.startTimer();
// 执行操作
PerformanceMonitor.stopTimer('Component Build');
```

### 常见问题

#### 1. 组件不更新

```dart
// 问题：状态更新但组件不重建
class MyWidget extends StatelessWidget {
  final int counter;
  
  const MyWidget({Key? key, required this.counter}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text('Counter: $counter');
  }
}

// 解决方案：使用 StatefulWidget 或状态管理
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;
  
  void _increment() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $_counter'),
        ZephyrButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

#### 2. 内存泄漏

```dart
// 问题：监听器未取消
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = someStream.listen((data) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _subscription?.cancel(); // 取消订阅
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

## 📚 参考资料

### 官方文档

- [Flutter 官方文档](https://flutter.dev/docs)
- [Dart 官方文档](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)

### 相关工具

- [Flutter DevTools](https://flutter.dev/tools/devtools)
- [Dart Code Metrics](https://dartcodemetrics.dev/)
- [Very Good CLI](https://verygood.ventures/very-good-cli)

### 社区资源

- [Flutter Community](https://fluttercommunity.dev/)
- [Flutter Awesome](https://github.com/flutterawesome/flutter-awesome)
- [ZephyrUI GitHub](https://github.com/Agions/zephyr-ui)

---

通过遵循本指南，您可以有效地参与 ZephyrUI 的开发和维护。如有任何问题，请随时通过 GitHub Issues 或 Discussions 与我们联系。