---
title: 故障排除手册
description: ZephyrUI 常见问题解决方案和故障排除指南
version: 1.0.0
last_updated: 2024-08-25
---

# ZephyrUI 故障排除手册

本手册提供了ZephyrUI使用过程中常见问题的解决方案和故障排除指南。

## 🔍 快速诊断

### 常见症状索引

| 症状 | 可能原因 | 解决方案 |
|------|----------|----------|
| 组件不显示 | 依赖问题、导入错误 | [检查依赖](#依赖问题) |
| 主题不生效 | 主题配置错误 | [检查主题配置](#主题配置问题) |
| 性能问题 | 组件使用不当 | [性能优化](#性能问题) |
| 样式错误 | 样式冲突 | [样式问题](#样式问题) |
| 编译错误 | 版本不兼容 | [编译问题](#编译问题) |

## 📦 依赖问题

### 1. ZephyrUI 找不到

**错误信息:**
```
Target of URI doesn't exist: 'package:zephyr_ui/zephyr_ui.dart'
```

**解决方案:**

1. **检查pubspec.yaml**
```yaml
dependencies:
  zephyr_ui: ^0.3.0
```

2. **运行pub get**
```bash
flutter pub get
```

3. **检查Flutter版本**
```bash
flutter --version
# 确保Flutter版本 >= 3.0.0
```

4. **清理项目**
```bash
flutter clean
flutter pub get
```

### 2. 版本冲突

**错误信息:**
```
Because zephyr_ui >=0.2.0 depends on flutter >=3.0.0, version solving failed.
```

**解决方案:**

1. **升级Flutter**
```bash
flutter upgrade
```

2. **检查依赖树**
```bash
flutter pub deps
```

3. **使用兼容版本**
```yaml
dependencies:
  flutter: ^3.0.0
  zephyr_ui: ^0.3.0
```

## 🎨 主题配置问题

### 1. 主题样式不生效

**问题:** 应用ZephyrUI主题后，组件样式没有变化

**解决方案:**

1. **使用ZephyrApp**
```dart
// 错误用法
MaterialApp(
  theme: ZephyrTheme.light(),
  home: MyApp(),
)

// 正确用法
ZephyrApp(
  theme: ZephyrTheme.light(),
  home: MyApp(),
)
```

2. **检查主题数据**
```dart
ZephyrApp(
  theme: ZephyrThemeData(
    primaryColor: Colors.blue,
    secondaryColor: Colors.grey,
  ),
  home: MyApp(),
)
```

### 2. 暗色主题不切换

**问题:** 暗色主题无法正常切换

**解决方案:**

1. **配置暗色主题**
```dart
ZephyrApp(
  theme: ZephyrTheme.light(),
  darkTheme: ZephyrTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

2. **手动切换主题**
```dart
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
```

## 🎯 组件使用问题

### 1. 按钮点击无响应

**问题:** 按钮点击后没有反应

**解决方案:**

1. **检查onPressed回调**
```dart
// 错误用法
ZephyrButton(
  text: '点击我',
  onPressed: () {}, // 空函数
)

// 正确用法
ZephyrButton(
  text: '点击我',
  onPressed: () {
    print('按钮被点击');
    // 执行具体逻辑
  },
)
```

2. **检查按钮状态**
```dart
// 禁用状态
ZephyrButton(
  text: '禁用按钮',
  onPressed: null, // 或 disabled: true
)

// 加载状态
ZephyrButton(
  text: '加载中...',
  loading: true,
  onPressed: () {}, // 在加载状态下会被忽略
)
```

### 2. 输入框验证不工作

**问题:** 输入框验证器没有执行

**解决方案:**

1. **使用Form包装**
```dart
Form(
  key: _formKey,
  child: ZephyrInputField(
    label: '邮箱',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '请输入邮箱';
      }
      return null;
    },
  ),
)

// 验证表单
if (_formKey.currentState!.validate()) {
  // 验证通过
}
```

2. **检查验证器逻辑**
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return '请输入内容';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return '请输入有效的邮箱地址';
  }
  return null; // 返回null表示验证通过
}
```

### 3. 列表性能问题

**问题:** 长列表滚动卡顿

**解决方案:**

1. **使用ListView.builder**
```dart
// 错误用法 - 使用Column
Column(
  children: List.generate(1000, (index) {
    return ZephyrListItem(title: '项目 $index');
  }),
)

// 正确用法 - 使用ListView.builder
ZephyrListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ZephyrListItem(title: '项目 $index');
  },
)
```

2. **使用const构造函数**
```dart
itemBuilder: (context, index) {
  return const ZephyrListItem(
    title: '项目', // 如果是静态文本
  );
}
```

## ⚡ 性能问题

### 1. 应用启动缓慢

**问题:** 应用启动时间过长

**解决方案:**

1. **优化依赖**
```yaml
dependencies:
  zephyr_ui: ^0.3.0
  # 只导入需要的组件
  # zephyr_ui_full: ^0.3.0  # 避免使用完整版
```

2. **延迟加载**
```dart
// 使用FutureBuilder延迟加载组件
FutureBuilder(
  future: _loadComponents(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return ZephyrButton(
        text: '加载完成',
        onPressed: () {},
      );
    } else {
      return ZephyrProgressIndicator();
    }
  },
)
```

### 2. 内存占用过高

**问题:** 应用内存使用量过大

**解决方案:**

1. **正确释放资源**
```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // 释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrInputField(
      controller: _controller,
      label: '输入框',
    );
  }
}
```

2. **使用内存优化的组件**
```dart
// 使用KeepAlive保持组件状态
ZephyrTabs(
  tabs: [
    ZephyrTab(
      text: '标签1',
      content: const _TabContent(), // 使用const
    ),
  ],
)
```

## 🎨 样式问题

### 1. 自定义样式不生效

**问题:** 自定义样式没有被应用

**解决方案:**

1. **检查样式优先级**
```dart
// 直接样式优先级最高
ZephyrButton(
  text: '按钮',
  backgroundColor: Colors.red, // 这会覆盖主题色
  onPressed: () {},
)

// 使用主题样式
ZephyrButton.primary(
  text: '按钮',
  onPressed: () {},
)
```

2. **使用主题扩展**
```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrThemeExtension(
        buttonTheme: ZephyrButtonThemeData(
          primaryColor: Colors.red,
        ),
      ),
    ],
  ),
)
```

### 2. 响应式布局问题

**问题:** 组件在不同屏幕尺寸下显示异常

**解决方案:**

1. **使用响应式组件**
```dart
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceType = ZephyrBreakpoints.getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return const MobileLayout();
      case DeviceType.tablet:
        return const TabletLayout();
      case DeviceType.desktop:
        return const DesktopLayout();
    }
  }
}
```

2. **使用媒体查询**
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return ZephyrButton.small(
        text: '小按钮',
        onPressed: () {},
      );
    } else {
      return ZephyrButton.large(
        text: '大按钮',
        onPressed: () {},
      );
    }
  },
)
```

## 🔧 编译问题

### 1. 编译错误

**错误信息:**
```
error: The method 'ZephyrButton' isn't defined for the class 'MyWidget'.
```

**解决方案:**

1. **检查导入**
```dart
import 'package:zephyr_ui/zephyr_ui.dart';
```

2. **检查组件名称**
```dart
// 错误的组件名称
Zephyrbutton()  // 应该是 ZephyrButton

// 正确的组件名称
ZephyrButton()
```

### 2. 热重载问题

**问题:** 热重载后组件没有更新

**解决方案:**

1. **完全重启应用**
```bash
flutter run -t lib/main.dart
```

2. **使用hot restart**
```bash
# 在调试控制台中按 'R'
# 或使用 VS Code 的热重启功能
```

3. **检查StatefulWidget**
```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;

  void _increment() {
    setState(() { // 确保调用setState
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrButton(
      text: '点击次数: $_counter',
      onPressed: _increment,
    );
  }
}
```

## 🧪 测试问题

### 1. 测试失败

**问题:** 组件测试无法通过

**解决方案:**

1. **正确的测试设置**
```dart
testWidgets('ZephyrButton 测试', (WidgetTester tester) async {
  await tester.pumpWidget(
    ZephyrApp(
      home: ZephyrButton(
        text: '测试按钮',
        onPressed: () {},
      ),
    ),
  );

  // 查找按钮
  expect(find.text('测试按钮'), findsOneWidget);

  // 点击按钮
  await tester.tap(find.text('测试按钮'));
  await tester.pump();
});
```

2. **模拟用户交互**
```dart
testWidgets('输入框测试', (WidgetTester tester) async {
  await tester.pumpWidget(
    ZephyrApp(
      home: ZephyrInputField(
        label: '测试',
        placeholder: '请输入',
      ),
    ),
  );

  // 输入文本
  await tester.enterText(find.byType(ZephyrInputField), 'Hello World');
  await tester.pump();

  // 验证输入
  expect(find.text('Hello World'), findsOneWidget);
});
```

## 📱 平台特定问题

### 1. iOS问题

**问题:** 在iOS上显示异常

**解决方案:**

1. **检查iOS配置**
```bash
cd ios
pod install
cd ..
```

2. **使用Cupertino风格**
```dart
ZephyrButton.ios(
  text: 'iOS按钮',
  onPressed: () {},
)
```

### 2. Android问题

**问题:** 在Android上显示异常

**解决方案:**

1. **检查Android版本**
```bash
flutter doctor --android-licenses
```

2. **使用Material风格**
```dart
ZephyrButton.android(
  text: 'Android按钮',
  onPressed: () {},
)
```

## 🔍 调试工具

### 1. 使用开发者工具

```bash
# 安装开发者工具
flutter pub add zephyr_ui_dev_tools

# 启用调试模式
if (kDebugMode) {
  ZephyrDevTools.initialize();
}
```

### 2. 性能分析

```bash
# 启用性能分析
flutter run --profile

# 在浏览器中打开性能分析器
flutter pub global run devtools
```

### 3. 日志调试

```dart
// 启用调试日志
void main() {
  ZephyrLogger.enable();
  runApp(MyApp());
}

// 使用日志
ZephyrLogger.d('调试信息');
ZephyrLogger.i('普通信息');
ZephyrLogger.w('警告信息');
ZephyrLogger.e('错误信息');
```

## 📞 获取帮助

### 1. 自助诊断

```bash
# 运行诊断工具
flutter pub global activate zephyr_doctor
zephyr_doctor check
```

### 2. 搜索已知问题

- [GitHub Issues](https://github.com/zephyrui/zephyr_ui/issues)
- [常见问题](../faq.md)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/zephyrui)

### 3. 提交问题

```bash
# 生成问题报告
zephyr_doctor report --output=issue.md
```

### 4. 社区支持

- [Discussions](https://github.com/zephyrui/zephyr_ui/discussions)
- [Discord社区](https://discord.gg/zephyrui)
- [QQ群: 123456789](https://qm.qq.com/example)

## 📊 故障排除清单

### 第一步：基础检查

- [ ] 检查Flutter版本兼容性
- [ ] 确认ZephyrUI依赖正确安装
- [ ] 验证导入语句正确
- [ ] 检查pubspec.yaml配置

### 第二步：组件检查

- [ ] 确认组件名称正确
- [ ] 检查必需参数是否提供
- [ ] 验证回调函数不为空
- [ ] 检查组件状态设置

### 第三步：主题检查

- [ ] 确认使用ZephyrApp
- [ ] 检查主题数据配置
- [ ] 验证样式优先级
- [ ] 检查暗色主题设置

### 第四步：性能检查

- [ ] 使用const构造函数
- [ ] 检查内存泄漏
- [ ] 优化列表性能
- [ ] 启用性能分析

### 第五步：平台检查

- [ ] 测试不同平台
- [ ] 检查平台特定配置
- [ ] 验证权限设置
- [ ] 测试不同设备尺寸

---

🎉 **恭喜！** 通过本手册，您应该能够解决大多数ZephyrUI使用过程中的问题。如果问题仍然存在，请寻求社区支持。

**文档版本**: 1.0.0
**最后更新**: 2024年8月25日
