# ZephyrUI 命名规范

## 概述

本文档描述了 ZephyrUI 组件库的命名规范，确保代码的一致性和可维护性。

## 命名原则

### 1. 统一前缀
- 所有组件必须使用 `Zephyr` 前缀
- 这确保了组件的唯一性和品牌识别

### 2. 清晰语义
- 名称应该清楚地表达组件的功能
- 避免使用缩写和不明确的术语

### 3. 一致性
- 相似功能的组件应该使用相似的命名模式
- 保持命名风格的一致性

## 命名规范

### 组件命名

#### 规则
- 使用 `PascalCase`（大驼峰命名法）
- 必须包含 `Zephyr` 前缀
- 名称应该描述组件的主要功能

#### 示例
```dart
// 正确示例
class ZephyrButton extends StatelessWidget { ... }
class ZephyrInput extends StatelessWidget { ... }
class ZephyrCard extends StatelessWidget { ... }
class ZephyrDatePicker extends StatelessWidget { ... }

// 错误示例
class Button extends StatelessWidget { ... }           // 缺少前缀
class zephyrButton extends StatelessWidget { ... }     // 错误的大小写
class ZephyrBtn extends StatelessWidget { ... }        // 使用了缩写
```

### 文件命名

#### 规则
- 使用 `snake_case`（下划线命名法）
- 文件名应该与组件名称保持一致
- 不需要包含前缀

#### 示例
```dart
// 文件: button.dart
class ZephyrButton extends StatelessWidget { ... }

// 文件: input.dart
class ZephyrInput extends StatelessWidget { ... }

// 文件: date_picker.dart
class ZephyrDatePicker extends StatelessWidget { ... }
```

### 目录结构

#### 规则
- 组件按功能分类存放
- 目录名使用 `snake_case`
- 每个组件目录包含相关文件

#### 示例目录结构
```
lib/
├── components/
│   ├── basic/
│   │   ├── button/
│   │   │   ├── button.dart
│   │   │   ├── button_theme.dart
│   │   │   └── button_utils.dart
│   │   ├── input/
│   │   │   ├── input.dart
│   │   │   ├── input_theme.dart
│   │   │   └── input_utils.dart
│   │   └── ...
│   ├── form/
│   │   ├── checkbox/
│   │   ├── radio/
│   │   └── ...
│   └── advanced/
│       ├── chart/
│       ├── carousel/
│       └── ...
```

### 主题类命名

#### 规则
- 使用 `Zephyr` + 组件名 + `Theme`
- 主题数据类使用 `Zephyr` + 组件名 + `ThemeData`

#### 示例
```dart
class ZephyrButtonTheme extends ThemeExtension<ZephyrButtonTheme> { ... }
class ZephyrButtonThemeData { ... }

class ZephyrInputTheme extends ThemeExtension<ZephyrInputTheme> { ... }
class ZephyrInputThemeData { ... }
```

### 工具类命名

#### 规则
- 使用 `Zephyr` + 组件名 + `Utils`
- 或者使用描述性的功能名称

#### 示例
```dart
class ZephyrButtonUtils { ... }
class ZephyrInputUtils { ... }
class ZephyrDateUtils { ... }
```

### 枚举命名

#### 规则
- 使用 `PascalCase`
- 名称应该描述枚举的用途
- 值使用 `camelCase`

#### 示例
```dart
enum ZephyrButtonType {
  primary,
  secondary,
  outlined,
  text,
}

enum ZephyrInputType {
  text,
  email,
  password,
  number,
}
```

### 常量命名

#### 规则
- 使用 `UPPER_SNAKE_CASE`
- 包含类型前缀

#### 示例
```dart
class ZephyrConstants {
  static const double DEFAULT_BORDER_RADIUS = 8.0;
  static const Duration DEFAULT_ANIMATION_DURATION = Duration(milliseconds: 200);
  static const Color PRIMARY_COLOR = Color(0xFF2196F3);
}
```

### 方法命名

#### 规则
- 使用 `camelCase`
- 方法名应该描述其功能
- 私有方法以下划线开头

#### 示例
```dart
class ZephyrButton extends StatelessWidget {
  void _handlePress() { ... }
  void _handleHover() { ... }
  
  Widget _buildChild() { ... }
  Widget _buildIcon() { ... }
}
```

### 参数命名

#### 规则
- 使用 `camelCase`
- 参数名应该清晰表达其用途
- 避免单字母参数名（除循环变量外）

#### 示例
```dart
class ZephyrButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ZephyrButtonType type;
  final double? width;
  final double? height;
  
  const ZephyrButton({
    required this.text,
    required this.onPressed,
    this.type = ZephyrButtonType.primary,
    this.width,
    this.height,
    super.key,
  });
}
```

## 迁移指南

### 从旧命名规范迁移

#### 组件重命名
```dart
// 旧命名
Button(text: 'Click', onPressed: () {})
Input(placeholder: 'Enter text')

// 新命名
ZephyrButton(text: 'Click', onPressed: () {})
ZephyrInput(placeholder: 'Enter text')
```

#### 文件重命名
```dart
// 旧文件名
button_base.dart
input_field.dart

// 新文件名
button.dart
input.dart
```

#### 导入路径更新
```dart
// 旧导入路径
import 'package:zephyr_ui/src/components/basic/button/button_base.dart';

// 新导入路径
import 'package:zephyr_ui/components/basic/button/button.dart';
```

## 验证工具

### 命名规范检查

使用以下命令检查命名规范：

```bash
# 运行命名规范检查
flutter test test/naming_convention_test.dart

# 检查特定组件
flutter test test/components/button_naming_test.dart
```

### 自动格式化

```bash
# 格式化代码
dart format .

# 检查代码风格
flutter analyze
```

## 最佳实践

### 1. 保持一致性
- 所有新组件必须遵循命名规范
- 定期检查现有代码是否符合规范

### 2. 清晰的命名
- 避免使用模糊的名称
- 名称应该清楚地表达组件的功能

### 3. 避免命名冲突
- 使用唯一的前缀避免与其他库冲突
- 检查现有组件名称，避免重复

### 4. 文档化
- 为每个组件提供清晰的文档
- 包含使用示例和参数说明

## 常见问题

### Q: 为什么要使用 Zephyr 前缀？
A: 使用前缀可以避免与其他库的命名冲突，同时建立品牌识别。

### Q: 如何处理遗留代码？
A: 逐步迁移遗留代码，确保每个版本都兼容旧的命名方式。

### Q: 可以使用缩写吗？
A: 避免使用缩写，除非是广泛认可的缩写（如 URL、API 等）。

### Q: 如何命名复合组件？
A: 使用描述性的名称，如 `ZephyrDatePicker`、`ZephyrColorPicker`。

## 更新日志

### v0.4.0 (2025-08-25)
- 统一所有组件使用 `Zephyr` 前缀
- 重构项目结构，移除冗余的 `src` 目录
- 更新命名规范文档
- 添加迁移指南

## 相关文档

- [组件开发规范](component-development-standards.md)
- [代码风格指南](style-guide.md)
- [主题系统文档](theme-system.md)