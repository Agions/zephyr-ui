# 按钮 (Button) 组件

按钮是用户界面中最基础的交互元素之一。ZephyrUI 基于Flutter Material Design 3 提供了强大的按钮组件系统。

## 🎯 快速开始

```dart
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

// 基础按钮
ElevatedButton(
  onPressed: () {
    print('按钮被点击');
  },
  child: const Text('点击我'),
)

// 带图标的按钮
ElevatedButton.icon(
  onPressed: () => _saveData(),
  icon: const Icon(Icons.save),
  label: const Text('保存'),
)

// 次要按钮
OutlinedButton(
  onPressed: () {
    print('次要操作');
  },
  child: const Text('次要操作'),
)

// 文本按钮
TextButton(
  onPressed: () {
    print('文本操作');
  },
  child: const Text('文本操作'),
)
```

## 🎨 按钮类型

### 1. ElevatedButton (主要按钮)

用于主要的操作，具有视觉重量感。

```dart
ElevatedButton(
  onPressed: () => _handlePrimaryAction(),
  child: const Text('主要操作'),
)

// 自定义样式
ElevatedButton(
  onPressed: () => _handlePrimaryAction(),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
  child: const Text('自定义样式'),
)
```

### 2. OutlinedButton (次要按钮)

用于次要操作，具有边框但没有背景填充。

```dart
OutlinedButton(
  onPressed: () => _handleSecondaryAction(),
  child: const Text('次要操作'),
)

// 自定义边框颜色
OutlinedButton(
  onPressed: () => _handleSecondaryAction(),
  style: OutlinedButton.styleFrom(
    side: const BorderSide(color: Colors.blue),
  ),
  child: const Text('自定义边框'),
)
```

### 3. TextButton (文本按钮)

用于低重要性的操作，仅显示文本。

```dart
TextButton(
  onPressed: () => _handleTextAction(),
  child: const Text('文本操作'),
)
```

### 4. FloatingActionButton (浮动操作按钮)

用于屏幕上的主要操作。

```dart
FloatingActionButton(
  onPressed: () => _handleFabAction(),
  child: const Icon(Icons.add),
)
```

## 🔧 核心属性

### ElevatedButton 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `onPressed` | `VoidCallback` | 点击回调函数 |
| `onLongPress` | `VoidCallback` | 长按回调函数 |
| `style` | `ButtonStyle` | 按钮样式 |
| `child` | `Widget` | 按钮内容 |
| `autofocus` | `bool` | 是否自动聚焦 |
| `clipBehavior` | `Clip` | 裁剪行为 |

### OutlinedButton 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `onPressed` | `VoidCallback` | 点击回调函数 |
| `style` | `ButtonStyle` | 按钮样式 |
| `child` | `Widget` | 按钮内容 |

### TextButton 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `onPressed` | `VoidCallback` | 点击回调函数 |
| `style` | `ButtonStyle` | 按钮样式 |
| `child` | `Widget` | 按钮内容 |

## 📏 尺寸选项

```dart
// 小号按钮
ZephyrButton(
  text: '小号',
  size: ZephyrButtonSize.small,
  onPressed: () {},
)

// 中号按钮 (默认)
ZephyrButton(
  text: '中号',
  size: ZephyrButtonSize.medium,
  onPressed: () {},
)

// 大号按钮
ZephyrButton(
  text: '大号',
  size: ZephyrButtonSize.large,
  onPressed: () {},
)
```

## 🎭 状态管理

### 禁用状态

```dart
ZephyrButton(
  text: '禁用按钮',
  onPressed: null, // 或 disabled: true
)
```

### 加载状态

```dart
ZephyrButton(
  text: '保存中...',
  loading: true,
  onPressed: () {}, // 在加载状态下会被忽略
)
```

## 🎨 自定义样式

### 自定义颜色

```dart
ZephyrButton(
  text: '自定义颜色',
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  onPressed: () {},
)
```

### 圆角按钮

```dart
ZephyrButton(
  text: '圆角按钮',
  borderRadius: 20,
  onPressed: () {},
)
```

## 🔄 事件处理

### 基础点击事件

```dart
ZephyrButton(
  text: '点击事件',
  onPressed: () {
    // 处理点击逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('按钮被点击')),
    );
  },
)
```

### 带参数的回调

```dart
ZephyrButton(
  text: '删除',
  onPressed: () => _confirmDelete(context),
)

void _confirmDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('确认删除'),
      content: Text('确定要删除这个项目吗？'),
      actions: [
        ZephyrButton.text(
          text: '取消',
          onPressed: () => Navigator.pop(context),
        ),
        ZephyrButton(
          text: '删除',
          onPressed: () {
            Navigator.pop(context);
            _deleteItem();
          },
        ),
      ],
    ),
  );
}
```

## 📱 响应式设计

```dart
// 响应式按钮大小
ZephyrButton(
  text: '响应式按钮',
  size: _getResponsiveSize(context),
  onPressed: () {},
)

ZephyrButtonSize _getResponsiveSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return ZephyrButtonSize.small;
  if (width < 900) return ZephyrButtonSize.medium;
  return ZephyrButtonSize.large;
}
```

## 🎭 最佳实践

### 1. 按钮层级

```dart
Column(
  children: [
    // 主要操作 - 使用 Primary 样式
    ZephyrButton.primary(
      text: '保存更改',
      onPressed: _saveChanges,
    ),
    
    SizedBox(height: 8),
    
    // 次要操作 - 使用 Secondary 样式
    ZephyrButton.secondary(
      text: '取消',
      onPressed: _cancel,
    ),
    
    SizedBox(height: 8),
    
    // 危险操作 - 使用自定义颜色
    ZephyrButton(
      text: '删除',
      backgroundColor: Colors.red,
      textColor: Colors.white,
      onPressed: _delete,
    ),
  ],
)
```

### 2. 按钮组

```dart
Row(
  children: [
    Expanded(
      child: ZephyrButton.outlined(
        text: '上一步',
        onPressed: _goBack,
      ),
    ),
    SizedBox(width: 16),
    Expanded(
      child: ZephyrButton.primary(
        text: '下一步',
        onPressed: _goNext,
      ),
    ),
  ],
)
```

### 3. 加载状态处理

```dart
class _MyWidgetState extends State<MyWidget> {
  bool _isLoading = false;
  
  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    
    try {
      await _saveData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存成功')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存失败: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ZephyrButton(
      text: '提交',
      loading: _isLoading,
      onPressed: _isLoading ? null : _handleSubmit,
    );
  }
}
```

## 🎨 主题集成

```dart
// 在主题中配置按钮样式
ZephyrThemeData(
  buttonTheme: ZephyrButtonThemeData(
    primaryColor: Colors.blue,
    secondaryColor: Colors.grey,
    borderRadius: 8,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
)
```

## 🔍 相关组件

- [图标按钮](../basic/icon.md) - 纯图标按钮
- [文本按钮](../basic/text.md) - 文字样式
- [卡片](../display/card.md) - 卡片布局中的按钮

## 📝 注意事项

1. **可访问性**: 确保按钮文本描述清晰，便于屏幕阅读器识别
2. **状态反馈**: 提供明确的视觉反馈，如加载状态、禁用状态
3. **一致性**: 在同一应用中保持按钮样式的一致性
4. **间距**: 按钮之间保持适当的间距，避免误操作

---

**API 版本**: 1.0.0  
**最后更新**: 2024年8月18日