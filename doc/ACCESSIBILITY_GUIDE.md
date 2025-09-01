# ZephyrUI 无障碍开发指南

## 概述

ZephyrUI 提供了完整的无障碍支持，确保所有组件都符合 WCAG 2.1 AA 标准。本指南将帮助您了解如何使用和实现无障碍功能。

## 快速开始

### 1. 初始化无障碍管理器

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化无障碍管理器
  await ZephyrAccessibilityManager.instance.init(
    config: ZephyrAccessibilityManagerConfig(
      enabled: true,
      autoDetectSystemSettings: true,
      enableRealTimeChecking: false,
      defaultConfig: ZephyrAccessibilityConfig(
        enabledFeatures: {
          ZephyrAccessibilityFeature.screenReader,
          ZephyrAccessibilityFeature.keyboardNavigation,
          ZephyrAccessibilityFeature.highContrast,
        },
      ),
    ),
  );
  
  runApp(MyApp());
}
```

### 2. 使用无障碍组件

#### 基础输入组件

```dart
ZephyrAccessibleInput(
  labelText: '用户名',
  placeholder: '请输入用户名',
  helperText: '用户名长度应为3-20个字符',
  required: true,
  onChanged: (value) {
    print('输入值: $value');
  },
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '用户名不能为空';
    }
    if (value.length < 3) {
      return '用户名至少需要3个字符';
    }
    return null;
  },
  accessibilityConfig: ZephyrAccessibleInputConfig(
    semanticLabel: '用户名输入框',
    semanticHint: '请输入3-20个字符的用户名',
    enableKeyboardNavigation: true,
    enableLiveValidation: true,
    showCharacterCount: true,
  ),
)
```

#### 无障碍按钮

```dart
ZephyrAccessibleButton(
  text: '提交表单',
  onPressed: () {
    // 处理提交逻辑
  },
  icon: Icons.send,
  semanticLabel: '提交表单按钮',
  hint: '点击提交用户注册表单',
)
```

#### 无障碍文本字段

```dart
ZephyrAccessibleTextField(
  controller: _passwordController,
  label: '密码',
  hint: '请输入密码',
  isRequired: true,
  isObscured: true,
  onChanged: (value) {
    // 处理密码输入
  },
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '密码不能为空';
    }
    if (value.length < 8) {
      return '密码至少需要8个字符';
    }
    return null;
  },
)
```

### 3. 使用无障碍包装器

```dart
ZephyrAccessibilityWrapper(
  config: ZephyrAccessibilityWrapperConfig(
    enableSemantics: true,
    enableKeyboardNavigation: true,
    enableFocusIndicator: true,
    semanticData: ZephyrSemanticData(
      label: '可点击区域',
      hint: '点击查看详情',
    ),
  ),
  isInteractive: true,
  child: GestureDetector(
    onTap: () {
      // 处理点击事件
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text('点击我'),
    ),
  ),
)
```

## 无障碍最佳实践

### 1. 语义化标记

#### 为所有交互元素添加语义化标签

```dart
// ✅ 好的做法
Semantics(
  label: '搜索按钮',
  hint: '点击搜索产品',
  button: true,
  child: IconButton(
    icon: const Icon(Icons.search),
    onPressed: () {
      // 搜索逻辑
    },
  ),
)

// ❌ 不好的做法
IconButton(
  icon: const Icon(Icons.search),
  onPressed: () {
    // 搜索逻辑
  },
)
```

#### 为图像提供替代文本

```dart
// ✅ 好的做法
Semantics(
  label: '公司logo',
  image: true,
  child: Image.asset('assets/logo.png'),
)

// ❌ 不好的做法
Image.asset('assets/logo.png')
```

### 2. 键盘导航

#### 确保所有交互元素都可以通过键盘访问

```dart
// ✅ 好的做法
Focus(
  focusNode: _focusNode,
  child: ElevatedButton(
    onPressed: _handlePress,
    child: const Text('提交'),
  ),
)

// ❌ 不好的做法
GestureDetector(
  onTap: _handlePress,
  child: Container(
    child: const Text('提交'),
  ),
)
```

#### 处理键盘事件

```dart
KeyboardListener(
  focusNode: _focusNode,
  onKeyEvent: (event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.space:
          _handlePress();
          break;
        case LogicalKeyboardKey.escape:
          _focusNode.unfocus();
          break;
      }
    }
  },
  child: ElevatedButton(
    onPressed: _handlePress,
    child: const Text('提交'),
  ),
)
```

### 3. 焦点管理

#### 提供清晰的焦点指示器

```dart
Focus(
  focusNode: _focusNode,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _focusNode.hasFocus 
                ? Theme.of(context).primaryColor 
                : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text('可聚焦元素'),
      ),
    )
```

#### 管理焦点顺序

```dart
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: _nameFocus,
          onSubmitted: (_) {
            _emailFocus.requestFocus();
          },
          decoration: const InputDecoration(labelText: '姓名'),
        ),
        TextField(
          focusNode: _emailFocus,
          onSubmitted: (_) {
            _passwordFocus.requestFocus();
          },
          decoration: const InputDecoration(labelText: '邮箱'),
        ),
        TextField(
          focusNode: _passwordFocus,
          onSubmitted: (_) {
            _passwordFocus.unfocus();
          },
          decoration: const InputDecoration(labelText: '密码'),
          obscureText: true,
        ),
      ],
    );
  }
}
```

### 4. 颜色对比度

#### 确保足够的颜色对比度

```dart
// ✅ 好的做法 - 高对比度
Text(
  '重要文本',
  style: TextStyle(
    color: Colors.black,
    fontSize: 16,
  ),
)

// ❌ 不好的做法 - 低对比度
Text(
  '重要文本',
  style: TextStyle(
    color: Colors.grey.shade300,
    fontSize: 16,
  ),
)
```

#### 使用颜色对比度检查器

```dart
final contrast = ZephyrColorContrastChecker.calculateContrastRatio(
  Colors.black,
  Colors.white,
);

if (contrast < 4.5) {
  print('对比度不足: ${contrast.toStringAsFixed(2)}:1');
}
```

### 5. 触摸目标尺寸

#### 确保足够的触摸目标尺寸

```dart
// ✅ 好的做法 - 足够大的触摸目标
Container(
  width: 48,
  height: 48,
  child: IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () {},
  ),
)

// ❌ 不好的做法 - 太小的触摸目标
Container(
  width: 20,
  height: 20,
  child: IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () {},
  ),
)
```

### 6. 动画和动效

#### 提供减少动画的选项

```dart
if (ZephyrAccessibilityManager.instance.currentConfig.reduceMotion) {
  // 禁用或简化动画
  child = const Icon(Icons.check);
} else {
  // 使用完整动画
  child = AnimatedIcon(
    icon: AnimatedIcons.menu_close,
    progress: _animationController,
  );
}
```

#### 避免闪烁和快速动画

```dart
// ✅ 好的做法 - 温和的动画
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  // ...
)

// ❌ 不好的做法 - 快速闪烁的动画
AnimatedContainer(
  duration: const Duration(milliseconds: 50),
  curve: Curves.bounceInOut,
  // ...
)
```

## 测试无障碍功能

### 1. 使用内置测试工具

```dart
testWidgets('应该通过无障碍测试', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MyAccessibleWidget(),
    ),
  );

  // 运行完整无障碍测试
  final result = await ZephyrAccessibilityTestTools.runFullAccessibilityTest(
    tester,
    MyAccessibleWidget(),
    componentName: 'MyAccessibleWidget',
  );

  // 验证测试结果
  expect(result.score, greaterThanOrEqualTo(80.0));
  expect(result.complianceStatus, ZephyrAccessibilityComplianceStatus.fullyCompliant);
});
```

### 2. 手动测试清单

#### 屏幕阅读器测试
- [ ] 所有交互元素都有语义化标签
- [ ] 图像有替代文本
- [ ] 状态变化会正确公告
- [ ] 表单字段有正确的标签和描述
- [ ] 错误消息能被屏幕阅读器识别

#### 键盘导航测试
- [ ] 所有交互元素都可以通过Tab键访问
- [ ] 焦点顺序符合逻辑
- [ ] 焦点指示器清晰可见
- [ ] Enter和Space键可以激活交互元素
- [ ] Escape键可以取消操作

#### 视觉测试
- [ ] 文本和背景有足够的对比度
- [ ] 触摸目标至少44x44像素
- [ ] 内容在放大时不会重叠
- [ ] 颜色不是唯一的信息传递方式
- [ ] 动画可以暂停或禁用

### 3. 自动化测试

```dart
// 创建测试套件
void main() {
  group('无障碍测试', () {
    testWidgets('按钮无障碍测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleButton(
            text: '测试按钮',
            onPressed: () {},
          ),
        ),
      );

      // 验证语义化属性
      await tester.expectAccessibility(
        widget: find.byType(ZephyrAccessibleButton),
        label: '测试按钮',
        isButton: true,
        isEnabled: true,
      );
    });

    testWidgets('输入框无障碍测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrAccessibleInput(
            labelText: '用户名',
            onChanged: (value) {},
          ),
        ),
      );

      // 验证键盘导航
      await tester.testKeyboardNavigation(
        widget: find.byType(ZephyrAccessibleInput),
        keys: [LogicalKeyboardKey.tab],
        expectedAction: () {
          expect(tester.widget<FocusNode>(find.byType(FocusNode)).hasFocus, isTrue);
        },
      );
    });
  });
}
```

## 高级功能

### 1. 自定义无障碍配置

```dart
// 创建自定义配置
final customConfig = ZephyrAccessibilityConfig(
  enabled: true,
  enabledFeatures: {
    ZephyrAccessibilityFeature.screenReader,
    ZephyrAccessibilityFeature.keyboardNavigation,
    ZephyrAccessibilityFeature.highContrast,
    ZephyrAccessibilityFeature.reduceMotion,
  },
  textScaleFactor: 1.2,
  highContrast: false,
  reduceMotion: true,
  minTouchTargetSize: 48.0,
  focusColor: Colors.blue,
  focusBorderWidth: 3.0,
);

// 应用配置
ZephyrAccessibilityManager.instance.updateConfig(customConfig);
```

### 2. 动态无障碍调整

```dart
class AdaptiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = ZephyrAccessibilityManager.instance.currentConfig;
    
    return Container(
      padding: EdgeInsets.all(config.highContrast ? 24 : 16),
      decoration: BoxDecoration(
        color: config.highContrast ? Colors.black : Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '自适应文本',
        style: TextStyle(
          fontSize: 16 * config.textScaleFactor,
          color: config.highContrast ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
```

### 3. 无障碍事件监听

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    
    // 监听无障碍配置变化
    ZephyrAccessibilityManager.instance.addConfigListener((config) {
      // 配置变化时更新UI
      setState(() {});
    });
  }

  @override
  void dispose() {
    ZephyrAccessibilityManager.instance.removeConfigListener((config) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = ZephyrAccessibilityManager.instance.currentConfig;
    
    return Container(
      // 根据配置构建UI
    );
  }
}
```

## 常见问题和解决方案

### 1. 问题：组件没有语义化标签

**解决方案**：
```dart
ZephyrAccessibilityWrapper(
  config: ZephyrAccessibilityWrapperConfig(
    semanticData: ZephyrSemanticData(
      label: '描述性标签',
      hint: '操作提示',
    ),
  ),
  child: YourWidget(),
)
```

### 2. 问题：键盘导航不工作

**解决方案**：
```dart
ZephyrAccessibilityWrapper(
  config: ZephyrAccessibilityWrapperConfig(
    enableKeyboardNavigation: true,
    keyboardCallbacks: {
      'onEnter': () => _handleAction(),
      'onSpace': () => _handleAction(),
    },
  ),
  isInteractive: true,
  child: YourWidget(),
)
```

### 3. 问题：触摸目标太小

**解决方案**：
```dart
ZephyrAccessibilityWrapper(
  config: ZephyrAccessibilityWrapperConfig(
    minTouchTargetSize: 44.0,
  ),
  isInteractive: true,
  child: YourWidget(),
)
```

### 4. 问题：颜色对比度不足

**解决方案**：
```dart
// 使用高对比度主题
ThemeData(
  colorScheme: ColorScheme.highContrastLight(),
)

// 或手动设置高对比度颜色
Text(
  '重要文本',
  style: TextStyle(
    color: Colors.black,
    fontSize: 16,
  ),
)
```

## 性能优化

### 1. 按需启用无障碍功能

```dart
// 只在需要时启用特定功能
ZephyrAccessibilityManager.instance.enableFeature(
  ZephyrAccessibilityFeature.screenReader,
);
```

### 2. 避免过度使用语义化包装

```dart
// ✅ 只在必要时使用
if (widget.isInteractive) {
  return ZephyrAccessibilityWrapper(
    config: config,
    child: widget.child,
  );
} else {
  return widget.child;
}
```

### 3. 使用缓存和延迟加载

```dart
// 缓存无障碍配置
final cachedConfig = ZephyrAccessibilityManager.instance.currentConfig;

// 延迟加载复杂组件
Widget build(BuildContext context) {
  return FutureBuilder(
    future: _loadAccessibleContent(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return ZephyrAccessibilityWrapper(
          config: config,
          child: snapshot.data!,
        );
      }
      return const CircularProgressIndicator();
    },
  );
}
```

## 资源和工具

### 1. 推荐工具
- **Flutter DevTools**: 内置无障碍检查器
- **Accessibility Scanner**: Android无障碍测试工具
- **Accessibility Inspector**: iOS无障碍测试工具
- **WAVE Web Accessibility Evaluator**: Web无障碍测试工具

### 2. 学习资源
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Flutter Accessibility Documentation](https://flutter.dev/docs/development/accessibility-and-localization/accessibility)
- [Material Design Accessibility](https://material.io/design/usability/accessibility.html)

### 3. 测试工具
- ZephyrUI内置测试工具
- Flutter测试框架
- 集成测试工具
- 平台特定测试工具

## 总结

ZephyrUI 提供了完整的无障碍支持，通过使用本指南中的最佳实践和工具，您可以创建符合WCAG 2.1 AA标准的无障碍应用。记住，无障碍不仅是技术要求，更是对所有人的包容和尊重。

通过持续测试和改进，您可以确保您的应用对所有用户都是可用和友好的。