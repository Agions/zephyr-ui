---
title: 迁移指南
description: 从其他UI库迁移到ZephyrUI的完整指南
version: 1.0.0
last_updated: 2024-08-25
---

# ZephyrUI 迁移指南

本指南将帮助您从其他Flutter UI库迁移到ZephyrUI。我们提供了详细的步骤说明和代码示例，确保迁移过程顺利进行。

## 🎯 支持的迁移源

目前支持从以下UI库迁移：

- **Material Components**: Flutter原生Material组件
- **Cupertino Components**: Flutter原生iOS风格组件
- **Flutter_bloc**: 状态管理集成
- **Provider**: 状态管理集成
- **GetIt**: 依赖注入集成

## 📋 迁移前准备

### 1. 评估项目

在开始迁移之前，请评估您的项目：

```bash
# 检查项目依赖
flutter pub deps

# 检查Flutter版本
flutter --version

# 备份项目
cp -r my_project my_project_backup
```

### 2. 环境要求

确保您的开发环境满足要求：

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- **iOS**: 12.0+
- **Android**: API 21+

## 🚀 迁移步骤

### 步骤1: 添加ZephyrUI依赖

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  zephyr_ui: ^0.3.0

  # 移除旧的UI库依赖
  # flutter_bloc: ^8.0.0
  # provider: ^6.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  zephyr_ui_dev_tools: ^0.3.0
```

### 步骤2: 安装依赖

```bash
flutter pub get
flutter clean
flutter pub get
```

### 步骤3: 更新主题配置

#### 从Material组件迁移

**之前的代码:**
```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    accentColor: Colors.blueAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  home: MyApp(),
)
```

**迁移后的代码:**
```dart
ZephyrApp(
  title: '我的应用',
  theme: ZephyrTheme.light(),
  darkTheme: ZephyrTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

### 步骤4: 组件迁移

#### 按钮组件迁移

**Material按钮:**
```dart
ElevatedButton(
  onPressed: () {},
  child: Text('点击我'),
)

OutlinedButton(
  onPressed: () {},
  child: Text('次要操作'),
)

TextButton(
  onPressed: () {},
  child: Text('文本按钮'),
)
```

**ZephyrUI按钮:**
```dart
ZephyrButton.primary(
  text: '点击我',
  onPressed: () {},
)

ZephyrButton.secondary(
  text: '次要操作',
  onPressed: () {},
)

ZephyrButton.text(
  text: '文本按钮',
  onPressed: () {},
)
```

#### 输入框组件迁移

**Material输入框:**
```dart
TextFormField(
  decoration: InputDecoration(
    labelText: '用户名',
    hintText: '请输入用户名',
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }
    return null;
  },
)
```

**ZephyrUI输入框:**
```dart
ZephyrInputField(
  label: '用户名',
  placeholder: '请输入用户名',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }
    return null;
  },
)
```

#### 卡片组件迁移

**Material卡片:**
```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '卡片标题',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8),
        Text('卡片内容描述'),
      ],
    ),
  ),
)
```

**ZephyrUI卡片:**
```dart
ZephyrCard(
  title: '卡片标题',
  content: Text('卡片内容描述'),
)
```

### 步骤5: 状态管理迁移

#### 从Provider迁移

**Provider代码:**
```dart
class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MyApp(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);

    return Column(
      children: [
        Text('计数: ${counter.count}'),
        ElevatedButton(
          onPressed: counter.increment,
          child: Text('增加'),
        ),
      ],
    );
  }
}
```

**ZephyrUI + Provider:**
```dart
void main() {
  runApp(
    ZephyrApp(
      title: '我的应用',
      theme: ZephyrTheme.light(),
      home: ChangeNotifierProvider(
        create: (context) => CounterModel(),
        child: MyApp(),
      ),
    ),
  );
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();

    return Column(
      children: [
        ZephyrText(
          '计数: ${counter.count}',
          style: ZephyrTextStyle.headline6,
        ),
        ZephyrButton.primary(
          text: '增加',
          onPressed: counter.increment,
        ),
      ],
    );
  }
}
```

### 步骤6: 主题定制迁移

**Material主题:**
```dart
ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  accentColor: Colors.blueAccent,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
)
```

**ZephyrUI主题:**
```dart
ZephyrThemeData(
  primaryColor: Colors.blue,
  secondaryColor: Colors.blueAccent,
  textTheme: ZephyrTextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    body1: TextStyle(fontSize: 16),
  ),
  buttonTheme: ZephyrButtonThemeData(
    primaryColor: Colors.blue,
    secondaryColor: Colors.grey,
  ),
)
```

## 🔧 自动化迁移工具

我们提供了自动化迁移工具来帮助您快速迁移：

```bash
# 安装迁移工具
flutter pub global activate zephyr_migration_tool

# 运行迁移检查
zephyr_migration check

# 执行自动迁移
zephyr_migration migrate --source=material --target=zephyr

# 生成迁移报告
zephyr_migration report
```

## 🎨 样式映射表

### 颜色映射

| Material Color | ZephyrUI Color | 用途 |
|---|---|---|
| `Colors.blue` | `ZephyrColors.primary` | 主色调 |
| `Colors.grey` | `ZephyrColors.secondary` | 次要色 |
| `Colors.red` | `ZephyrColors.error` | 错误色 |
| `Colors.green` | `ZephyrColors.success` | 成功色 |
| `Colors.orange` | `ZephyrColors.warning` | 警告色 |

### 文本样式映射

| Material Style | ZephyrUI Style | 用途 |
|---|---|---|
| `headline1` | `headline1` | 主标题1 |
| `headline2` | `headline2` | 主标题2 |
| `headline3` | `headline3` | 主标题3 |
| `headline4` | `headline4` | 主标题4 |
| `headline5` | `headline5` | 主标题5 |
| `headline6` | `headline6` | 主标题6 |
| `bodyText1` | `body1` | 正文1 |
| `bodyText2` | `body2` | 正文2 |
| `subtitle1` | `subtitle1` | 副标题1 |
| `subtitle2` | `subtitle2` | 副标题2 |

### 间距映射

| Material Spacing | ZephyrUI Spacing | 用途 |
|---|---|---|
| `4.0` | `ZephyrSpacing.xs` | 超小间距 |
| `8.0` | `ZephyrSpacing.sm` | 小间距 |
| `16.0` | `ZephyrSpacing.md` | 中等间距 |
| `24.0` | `ZephyrSpacing.lg` | 大间距 |
| `32.0` | `ZephyrSpacing.xl` | 超大间距 |

## 🧪 测试迁移

### 单元测试迁移

**Material测试:**
```dart
testWidgets('ElevatedButton 点击测试', (WidgetTester tester) async {
  bool clicked = false;

  await tester.pumpWidget(
    MaterialApp(
      home: ElevatedButton(
        onPressed: () => clicked = true,
        child: Text('点击我'),
      ),
    ),
  );

  await tester.tap(find.text('点击我'));
  await tester.pump();

  expect(clicked, true);
});
```

**ZephyrUI测试:**
```dart
testWidgets('ZephyrButton 点击测试', (WidgetTester tester) async {
  bool clicked = false;

  await tester.pumpWidget(
    ZephyrApp(
      home: ZephyrButton(
        text: '点击我',
        onPressed: () => clicked = true,
      ),
    ),
  );

  await tester.tap(find.text('点击我'));
  await tester.pump();

  expect(clicked, true);
});
```

## 🚨 常见问题

### 1. 主题不生效

**问题**: 迁移后主题样式没有应用

**解决方案**:
```dart
// 确保使用ZephyrApp而不是MaterialApp
ZephyrApp(
  theme: ZephyrTheme.light(),
  home: MyApp(),
)
```

### 2. 组件找不到

**问题**: 迁移后组件无法找到

**解决方案**:
```dart
// 确保正确导入
import 'package:zephyr_ui/zephyr_ui.dart';

// 检查组件名称
ZephyrButton.primary()  // 不是 Button.primary()
```

### 3. 样式不一致

**问题**: 迁移后样式与预期不符

**解决方案**:
```dart
// 使用ZephyrUI的样式系统
ZephyrText(
  '标题',
  style: ZephyrTextStyle.headline6,
)
```

### 4. 性能问题

**问题**: 迁移后应用性能下降

**解决方案**:
```dart
// 使用const构造函数
const ZephyrButton(
  text: '按钮',
  onPressed: null,
)

// 使用性能优化的组件
ZephyrListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ZephyrListItem(title: items[index]);
  },
)
```

## 📊 迁移检查清单

### 迁移前

- [ ] 备份项目
- [ ] 检查依赖兼容性
- [ ] 评估迁移复杂度
- [ ] 制定迁移计划

### 迁移中

- [ ] 添加ZephyrUI依赖
- [ ] 更新主题配置
- [ ] 迁移基础组件
- [ ] 迁移表单组件
- [ ] 迁移导航组件
- [ ] 迁移状态管理
- [ ] 更新测试代码

### 迁移后

- [ ] 运行应用测试
- [ ] 检查主题样式
- [ ] 验证功能完整性
- [ ] 性能测试
- [ ] 用户验收测试

## 🎯 最佳实践

### 1. 渐进式迁移

```dart
// 混合使用Material和ZephyrUI组件
class HybridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrApp(
      theme: ZephyrTheme.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('混合应用'),
        ),
        body: Column(
          children: [
            // 保留的Material组件
            MaterialButton(
              onPressed: () {},
              child: Text('Material按钮'),
            ),

            // 新的ZephyrUI组件
            ZephyrButton.primary(
              text: 'ZephyrUI按钮',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. 组件封装

```dart
// 封装兼容性组件
class CompatibleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;

  const CompatibleButton({
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return ZephyrButton.primary(
          text: text,
          onPressed: onPressed,
        );
      case ButtonType.secondary:
        return ZephyrButton.secondary(
          text: text,
          onPressed: onPressed,
        );
      case ButtonType.text:
        return ZephyrButton.text(
          text: text,
          onPressed: onPressed,
        );
    }
  }
}
```

### 3. 主题适配

```dart
// 主题适配器
class ThemeAdapter {
  static ZephyrThemeData fromMaterial(ThemeData materialTheme) {
    return ZephyrThemeData(
      primaryColor: materialTheme.primaryColor,
      secondaryColor: materialTheme.colorScheme.secondary,
      backgroundColor: materialTheme.scaffoldBackgroundColor,
      textTheme: ZephyrTextTheme.fromMaterial(materialTheme.textTheme),
    );
  }
}
```

## 📞 获取帮助

如果在迁移过程中遇到问题：

1. **查看文档**: [完整文档](../README.md)
2. **搜索已知问题**: [GitHub Issues](https://github.com/zephyrui/zephyr_ui/issues)
3. **提交问题**: 创建新的Issue
4. **社区支持**: [Discussions](https://github.com/zephyrui/zephyr_ui/discussions)
5. **专业支持**: [contact@zephyrui.com](mailto:contact@zephyrui.com)

---

🎉 **恭喜！** 您已经完成了从其他UI库到ZephyrUI的迁移。继续探索ZephyrUI的强大功能，构建更精美的应用吧！

**文档版本**: 1.0.0
**最后更新**: 2024年8月25日
