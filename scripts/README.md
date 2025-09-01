# 导入路径修复脚本

本项目包含一个自动化脚本，用于将所有相对路径导入转换为 `package:zephyr_ui` 绝对路径导入。

## 脚本文件

- `scripts/fix_imports.dart` - 主要的导入修复脚本
- `scripts/verify_imports.dart` - 验证导入转换结果的脚本

## 转换规则

脚本会将以下相对路径导入转换为对应的绝对路径导入：

### 1. zephyr_ui.dart 导入
- `import '../../../../zephyr_ui.dart';` → `import 'package:zephyr_ui/zephyr_ui.dart';`

### 2. src/ 目录下的导入
- `import '../../../core/theme/theme.dart';` → `import 'package:zephyr_ui/src/core/theme/theme.dart';`
- `import '../../components/basic/button/button.dart';` → `import 'package:zephyr_ui/src/components/basic/button/button.dart';`

### 3. 带别名的导入
- `import '../../../core/constants/enums.dart' as core_enums;` → `import 'package:zephyr_ui/src/core/constants/enums.dart' as core_enums;`

## 使用方法

### 1. 运行修复脚本
在项目根目录运行：
```bash
dart scripts/fix_imports.dart
```

### 2. 验证转换结果
运行验证脚本确保所有相对导入都已转换：
```bash
dart scripts/verify_imports.dart
```

## 转换统计

脚本运行后会显示以下统计信息：
- 扫描的 Dart 文件数量
- 修改的文件数量
- 修复的导入数量

## 验证结果

验证脚本会检查：
- 剩余的相对导入数量
- 正确的 package 导入数量
- 包含相对导入的文件列表

## 注意事项

1. **备份**：运行脚本前建议先备份代码
2. **测试**：转换后运行 `flutter analyze` 确保项目可以正常分析
3. **手动检查**：建议手动检查一些关键文件的导入是否正确

## 示例输出

### 修复脚本输出
```
🔧 开始修复相对路径导入...

📁 找到 261 个 Dart 文件

✅ lib/src/components/basic/button/button.dart - 修复了 1 个导入
✅ lib/src/components/core/theme/theme.dart - 修复了 3 个导入
...

🎉 导入修复完成！
📊 统计：
   - 修改的文件数：66
   - 总修复的导入数：82
```

### 验证脚本输出
```
🔍 验证导入转换结果...

📁 检查 261 个 Dart 文件

📊 验证结果：
   - 相对导入数量：0
   - Package导入数量：94
   - 包含相对导入的文件数：0

✅ 验证通过：所有相对导入已成功转换为绝对导入！
```

## 转换后的优势

1. **一致性**：所有导入都使用统一的 `package:` 格式
2. **可维护性**：不再依赖于文件相对位置
3. **IDE支持**：更好的代码导航和重构支持
4. **发布就绪**：符合 Flutter 包的导入规范