# ZephyrUI v0.4.0 迁移指南

## 概述

本文档指导您从 ZephyrUI v0.3.0 或更早版本迁移到 v0.4.0。v0.4.0 版本引入了重要的命名规范变更和项目结构重构。

## 主要变更

### 1. 组件命名规范
- 所有组件现在使用 `Zephyr` 前缀
- 统一使用 PascalCase 命名法
- 移除了冗余的命名模式

### 2. 项目结构重构
- 移除了 `src` 目录层级
- 重新组织了组件分类
- 简化了导入路径

### 3. 主题系统改进
- 完善了主题配置
- 支持更灵活的主题定制

## 迁移步骤

### 步骤 1: 更新依赖

```yaml
# pubspec.yaml
dependencies:
  # 从
  zephyr_ui: ^0.3.0
  
  # 改为
  zephyr_ui: ^0.4.0
```

### 步骤 2: 更新导入路径

#### 旧导入路径
```dart
import 'package:zephyr_ui/src/components/basic/button/button_base.dart';
import 'package:zephyr_ui/src/components/form/input/input.dart';
import 'package:zephyr_ui/src/components/navigation/breadcrumb/breadcrumb.dart';
```

#### 新导入路径
```dart
import 'package:zephyr_ui/components/basic/button.dart';
import 'package:zephyr_ui/components/form/input.dart';
import 'package:zephyr_ui/components/navigation/breadcrumb.dart';
```

### 步骤 3: 更新组件名称

#### 按钮组件
```dart
// 旧用法
Button(
  text: '点击我',
  onPressed: () {},
  type: ButtonType.primary,
)

// 新用法
ZephyrButton(
  text: '点击我',
  onPressed: () {},
  type: ZephyrButtonType.primary,
)
```

#### 输入框组件
```dart
// 旧用法
Input(
  placeholder: '请输入内容',
  onChanged: (value) {},
)

// 新用法
ZephyrInput(
  placeholder: '请输入内容',
  onChanged: (value) {},
)
```

#### 文本组件
```dart
// 旧用法
TextWidget(
  'Hello World',
  style: TextStyles.headline,
)

// 新用法
ZephyrText(
  'Hello World',
  style: ZephyrTextStyle.headlineMedium,
)
```

#### 容器组件
```dart
// 旧用法
ContainerWidget(
  padding: EdgeInsets.all(16),
  child: Text('内容'),
)

// 新用法
ZephyrContainer(
  padding: EdgeInsets.all(16),
  child: Text('内容'),
)
```

### 步骤 4: 更新主题配置

#### 旧主题配置
```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    // 其他主题配置
  ),
)
```

#### 新主题配置
```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrThemeData.light(),
    ],
  ),
  darkTheme: ThemeData(
    extensions: [
      ZephyrThemeData.dark(),
    ],
  ),
)
```

### 步骤 5: 更新枚举类型

```dart
// 旧枚举
enum ButtonType {
  primary,
  secondary,
  outlined,
}

// 新枚举
enum ZephyrButtonType {
  primary,
  secondary,
  outlined,
  text,
}
```

## 组件映射表

### 基础组件

| 旧组件名 | 新组件名 | 变更说明 |
|----------|----------|----------|
| `Button` | `ZephyrButton` | 添加前缀，扩展类型 |
| `Text` | `ZephyrText` | 添加前缀，改进样式 |
| `Icon` | `ZephyrIcon` | 添加前缀 |
| `Input` | `ZephyrInput` | 添加前缀，改进功能 |
| `Card` | `ZephyrCard` | 添加前缀 |
| `Container` | `ZephyrContainer` | 添加前缀，新增功能 |

### 表单组件

| 旧组件名 | 新组件名 | 变更说明 |
|----------|----------|----------|
| `FormField` | `ZephyrInput` | 简化命名 |
| `Select` | `ZephyrSelect` | 添加前缀 |
| `Checkbox` | `ZephyrCheckbox` | 添加前缀 |
| `Radio` | `ZephyrRadio` | 添加前缀 |
| `Switch` | `ZephyrSwitch` | 添加前缀 |

### 导航组件

| 旧组件名 | 新组件名 | 变更说明 |
|----------|----------|----------|
| `Tabs` | `ZephyrTabs` | 添加前缀 |
| `Breadcrumb` | `ZephyrBreadcrumb` | 添加前缀 |
| `Pagination` | `ZephyrPagination` | 添加前缀 |

### 反馈组件

| 旧组件名 | 新组件名 | 变更说明 |
|----------|----------|----------|
| `Alert` | `ZephyrAlert` | 添加前缀 |
| `Toast` | `ZephyrToast` | 添加前缀 |
| `Modal` | `ZephyrModal` | 添加前缀 |
| `Progress` | `ZephyrProgress` | 添加前缀 |

## 文件结构变更

### 旧结构
```
lib/
├── src/
│   ├── components/
│   │   ├── basic/
│   │   │   ├── button/
│   │   │   │   ├── button_base.dart
│   │   │   │   ├── button_theme.dart
│   │   │   │   └── button_utils.dart
│   │   │   └── input/
│   │   │       ├── input.dart
│   │   │       └── input_theme.dart
│   │   └── ...
│   └── theme/
└── zephyr_ui.dart
```

### 新结构
```
lib/
├── components/
│   ├── basic/
│   │   ├── button/
│   │   │   ├── button.dart
│   │   │   ├── button_theme.dart
│   │   │   └── button_utils.dart
│   │   └── input/
│   │       ├── input.dart
│   │       └── input_theme.dart
│   └── ...
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
└── zephyr_ui.dart
```

## 代码示例

### 完整迁移示例

#### 迁移前
```dart
import 'package:zephyr_ui/src/components/basic/button/button_base.dart';
import 'package:zephyr_ui/src/components/form/input/input.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
          text: '提交',
          onPressed: () {},
          type: ButtonType.primary,
        ),
        Input(
          placeholder: '请输入内容',
          onChanged: (value) {},
        ),
      ],
    );
  }
}
```

#### 迁移后
```dart
import 'package:zephyr_ui/components/basic/button.dart';
import 'package:zephyr_ui/components/form/input.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrButton(
          text: '提交',
          onPressed: () {},
          type: ZephyrButtonType.primary,
        ),
        ZephyrInput(
          placeholder: '请输入内容',
          onChanged: (value) {},
        ),
      ],
    );
  }
}
```

## 常见问题

### Q: 我需要一次性迁移所有代码吗？
A: 建议分批迁移，先迁移核心页面，再逐步迁移其他页面。

### Q: 新版本是否向后兼容？
A: v0.4.0 是一个重大更新，不向后兼容。请按照本指南进行迁移。

### Q: 迁移过程中遇到问题怎么办？
A: 请查看以下资源：
- [常见问题解答](../faq.md)
- [GitHub Issues](https://github.com/agions/zephyr-ui/issues)
- [社区讨论](https://github.com/agions/zephyr-ui/discussions)

### Q: 如何测试迁移后的代码？
A: 运行以下命令确保代码质量：
```bash
# 运行测试
flutter test

# 代码分析
flutter analyze

# 格式化代码
dart format .
```

## 迁移检查清单

- [ ] 更新 pubspec.yaml 中的版本号
- [ ] 更新所有导入路径
- [ ] 更新所有组件名称
- [ ] 更新枚举类型名称
- [ ] 更新主题配置
- [ ] 运行测试确保功能正常
- [ ] 检查 UI 显示是否正确
- [ ] 测试所有交互功能

## 工具和脚本

### 自动迁移脚本

我们提供了自动迁移脚本来帮助您完成部分迁移工作：

```bash
# 运行自动迁移脚本
dart run zephyr_ui:migrate

# 检查迁移结果
dart run zephyr_ui:check-migration
```

### 手动检查工具

```bash
# 检查未更新的组件引用
grep -r "Button(" lib/ --include="*.dart"
grep -r "Input(" lib/ --include="*.dart"

# 检查旧的导入路径
grep -r "src/components" lib/ --include="*.dart"
```

## 获取帮助

如果您在迁移过程中遇到问题，可以通过以下方式获取帮助：

1. **文档资源**
   - [命名规范文档](naming-conventions.md)
   - [组件 API 参考](../api/components.md)
   - [主题系统文档](theme-system.md)

2. **社区支持**
   - [GitHub Issues](https://github.com/agions/zephyr-ui/issues)
   - [GitHub Discussions](https://github.com/agions/zephyr-ui/discussions)

3. **技术支持**
   - 邮件: support@zephyrui.dev
   - QQ群: 123456789

## 版本历史

### v0.4.0 (2025-08-25)
- 统一组件命名规范
- 重构项目结构
- 改进主题系统
- 新增迁移工具

### v0.3.0 (2025-08-25)
- 依赖重构
- 性能优化
- 基础组件完善

---

祝您迁移顺利！如有任何问题，请随时联系我们的技术支持团队。