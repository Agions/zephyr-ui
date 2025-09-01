---
title: ZephyrButton API
description: ZephyrButton 组件的详细 API 文档
---

# ZephyrButton API

`ZephyrButton` 是一个功能丰富的按钮组件，支持多种样式、状态和交互效果。

## 构造函数

### 基本构造函数

```dart
ZephyrButton({
  Key? key,
  required Widget child,
  VoidCallback? onPressed,
  ZephyrVariant variant = ZephyrVariant.primary,
  ZephyrSize size = ZephyrSize.medium,
  bool disabled = false,
  bool loading = false,
  bool fullWidth = false,
  Widget? icon,
  Widget? suffixIcon,
  BoxShape? shape,
  double? elevation,
  Color? color,
  Color? textColor,
  ZephyrButtonStyle? style,
})
```

### 命名构造函数

```dart
// 主要按钮
ZephyrButton.primary({
  Key? key,
  required Widget child,
  VoidCallback? onPressed,
  ZephyrSize size = ZephyrSize.medium,
  // ... 其他参数
})

// 次要按钮
ZephyrButton.secondary({
  Key? key,
  required Widget child,
  VoidCallback? onPressed,
  ZephyrSize size = ZephyrSize.medium,
  // ... 其他参数
})

// 文本按钮
ZephyrButton.text({
  Key? key,
  required Widget child,
  VoidCallback? onPressed,
  ZephyrSize size = ZephyrSize.medium,
  // ... 其他参数
})
```

## 参数详解

### 必需参数

| 参数 | 类型 | 描述 |
|------|------|------|
| `child` | `Widget` | 按钮的主要内容 |

### 可选参数

#### 行为参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onPressed` | `VoidCallback?` | `null` | 按钮点击回调函数，为 `null` 时按钮被禁用 |
| `disabled` | `bool` | `false` | 是否禁用按钮 |
| `loading` | `bool` | `false` | 是否显示加载状态 |

#### 样式参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `variant` | `ZephyrVariant` | `ZephyrVariant.primary` | 按钮样式变体 |
| `size` | `ZephyrSize` | `ZephyrSize.medium` | 按钮尺寸 |
| `fullWidth` | `bool` | `false` | 是否占满父容器宽度 |
| `shape` | `BoxShape?` | `null` | 按钮形状 |
| `elevation` | `double?` | `null` | 阴影高度 |

#### 颜色参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `color` | `Color?` | `null` | 自定义按钮背景色 |
| `textColor` | `Color?` | `null` | 自定义文字颜色 |

#### 图标参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `icon` | `Widget?` | `null` | 前置图标 |
| `suffixIcon` | `Widget?` | `null` | 后置图标 |

#### 主题参数

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `style` | `ZephyrButtonStyle?` | `null` | 自定义按钮样式 |

## 枚举类型

### ZephyrVariant

```dart
enum ZephyrVariant {
  primary,    // 主要按钮
  secondary,  // 次要按钮
  success,    // 成功按钮
  warning,    // 警告按钮
  danger,     // 危险按钮
  ghost,      // 幽灵按钮
  text,       // 文本按钮
}
```

### ZephyrSize

```dart
enum ZephyrSize {
  small,   // 小尺寸
  medium,  // 中尺寸
  large,   // 大尺寸
}
```

## 使用示例

### 基本使用

```dart
// 基本按钮
ZephyrButton(
  onPressed: () {
    print('按钮被点击');
  },
  child: Text('点击我'),
)

// 禁用按钮
ZephyrButton(
  onPressed: null, // 或 disabled: true
  child: Text('禁用按钮'),
)

// 加载状态按钮
ZephyrButton(
  onPressed: () {},
  child: Text('加载中'),
  loading: true,
)
```

### 样式变体

```dart
// 主要按钮
ZephyrButton(
  onPressed: () {},
  child: Text('主要按钮'),
  variant: ZephyrVariant.primary,
)

// 次要按钮
ZephyrButton(
  onPressed: () {},
  child: Text('次要按钮'),
  variant: ZephyrVariant.secondary,
)

// 成功按钮
ZephyrButton(
  onPressed: () {},
  child: Text('成功按钮'),
  variant: ZephyrVariant.success,
)

// 危险按钮
ZephyrButton(
  onPressed: () {},
  child: Text('危险按钮'),
  variant: ZephyrVariant.danger,
)

// 文本按钮
ZephyrButton(
  onPressed: () {},
  child: Text('文本按钮'),
  variant: ZephyrVariant.text,
)
```

### 尺寸变体

```dart
// 小按钮
ZephyrButton(
  onPressed: () {},
  child: Text('小'),
  size: ZephyrSize.small,
)

// 中按钮
ZephyrButton(
  onPressed: () {},
  child: Text('中'),
  size: ZephyrSize.medium,
)

// 大按钮
ZephyrButton(
  onPressed: () {},
  child: Text('大'),
  size: ZephyrSize.large,
)
```

### 带图标按钮

```dart
// 前置图标
ZephyrButton(
  onPressed: () {},
  child: Text('发送'),
  icon: Icon(Icons.send),
)

// 后置图标
ZephyrButton(
  onPressed: () {},
  child: Text('下一步'),
  suffixIcon: Icon(Icons.arrow_forward),
)

// 仅图标按钮
ZephyrButton(
  onPressed: () {},
  child: Icon(Icons.favorite),
  variant: ZephyrVariant.text,
)
```

### 自定义样式

```dart
// 自定义颜色
ZephyrButton(
  onPressed: () {},
  child: Text('自定义按钮'),
  color: Color(0xFF8B5CF6),
  textColor: Colors.white,
)

// 全宽按钮
ZephyrButton(
  onPressed: () {},
  child: Text('全宽按钮'),
  fullWidth: true,
)

// 圆形按钮
ZephyrButton(
  onPressed: () {},
  child: Icon(Icons.add),
  shape: BoxShape.circle,
)
```

## 事件处理

### 点击事件

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _clickCount = 0;
  
  @override
  Widget build(BuildContext context) {
    return ZephyrButton(
      onPressed: _handleClick,
      child: Text('点击次数: $_clickCount'),
    );
  }
  
  void _handleClick() {
    setState(() {
      _clickCount++;
    });
    
    // 显示提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('按钮被点击了 $_clickCount 次'),
      ),
    );
  }
}
```

### 条件点击

```dart
class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ZephyrInput(
            placeholder: '请输入邮箱',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入邮箱';
              }
              return null;
            },
            onChanged: (value) {
              _email = value;
            },
          ),
          
          SizedBox(height: 16),
          
          ZephyrButton(
            onPressed: _canSubmit ? _handleSubmit : null,
            child: Text('提交'),
            variant: ZephyrVariant.primary,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
  
  bool get _canSubmit {
    return _email.isNotEmpty && _formKey.currentState?.validate() == true;
  }
  
  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // 提交逻辑
      print('提交邮箱: $_email');
    }
  }
}
```

## 主题定制

### 全局主题

```dart
final theme = ZephyrThemeData(
  buttonTheme: ZephyrButtonThemeData(
    // 默认样式
    defaultStyle: ZephyrButtonStyle(
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      elevation: 2,
    ),
    
    // 变体样式
    variants: {
      ZephyrVariant.primary: ZephyrButtonStyle(
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      ),
      ZephyrVariant.secondary: ZephyrButtonStyle(
        backgroundColor: Colors.transparent,
        textColor: Colors.blue,
        borderColor: Colors.blue,
      ),
      ZephyrVariant.danger: ZephyrButtonStyle(
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
    },
    
    // 尺寸样式
    sizes: {
      ZephyrSize.small: ZephyrButtonStyle(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        fontSize: 14,
        borderRadius: BorderRadius.circular(6),
      ),
      ZephyrSize.medium: ZephyrButtonStyle(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        fontSize: 16,
        borderRadius: BorderRadius.circular(8),
      ),
      ZephyrSize.large: ZephyrButtonStyle(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        fontSize: 18,
        borderRadius: BorderRadius.circular(10),
      ),
    },
  ),
);

// 应用主题
ZephyrApp(
  theme: theme,
  home: MyApp(),
)
```

### 局部样式

```dart
ZephyrButton(
  onPressed: () {},
  child: Text('自定义样式'),
  style: ZephyrButtonStyle(
    backgroundColor: Colors.purple,
    textColor: Colors.white,
    borderRadius: BorderRadius.circular(20),
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    elevation: 4,
    border: Border.all(color: Colors.purple, width: 2),
  ),
)
```

## 性能优化

### 使用 const 构造函数

```dart
// ✅ 好的做法
const ZephyrButton(
  onPressed: null,
  child: Text('按钮'),
)

// ❌ 避免的做法
ZephyrButton(
  onPressed: null,
  child: Text('按钮'),
)
```

### 避免重建

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ZephyrButton(
      onPressed: () => _handleAction(context),
      child: const Text('操作按钮'),
      variant: ZephyrVariant.primary,
    );
  }
  
  void _handleAction(BuildContext context) {
    // 处理逻辑
  }
}
```

## 无障碍支持

### 语义化标签

```dart
ZephyrButton(
  onPressed: () {},
  child: Text('删除'),
  variant: ZephyrVariant.danger,
  // 语义化提示
  semanticsLabel: '删除项目',
)
```

### 键盘导航

```dart
ZephyrButton(
  onPressed: () {},
  child: Text('提交表单'),
  // 自动聚焦
  autofocus: true,
  // 键盘快捷键
  focusNode: FocusNode(),
)
```

## 常见问题

### Q: 如何禁用按钮？

A: 有两种方式禁用按钮：

```dart
// 方式1：设置 onPressed 为 null
ZephyrButton(
  onPressed: null,
  child: Text('禁用按钮'),
)

// 方式2：设置 disabled 为 true
ZephyrButton(
  onPressed: () {},
  child: Text('禁用按钮'),
  disabled: true,
)
```

### Q: 如何自定义按钮颜色？

A: 使用 `color` 和 `textColor` 参数：

```dart
ZephyrButton(
  onPressed: () {},
  child: Text('自定义按钮'),
  color: Color(0xFF8B5CF6),
  textColor: Colors.white,
)
```

### Q: 如何创建图标按钮？

A: 使用 `icon` 参数或仅传入图标作为 child：

```dart
// 带文字的图标按钮
ZephyrButton(
  onPressed: () {},
  child: Text('发送'),
  icon: Icon(Icons.send),
)

// 仅图标按钮
ZephyrButton(
  onPressed: () {},
  child: Icon(Icons.favorite),
  variant: ZephyrVariant.text,
)
```

### Q: 如何处理加载状态？

A: 使用 `loading` 参数：

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    return ZephyrButton(
      onPressed: _isLoading ? null : _handleAction,
      child: Text(_isLoading ? '加载中...' : '点击我'),
      loading: _isLoading,
    );
  }
  
  Future<void> _handleAction() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // 模拟异步操作
      await Future.delayed(Duration(seconds: 2));
      
      // 操作完成
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('操作完成')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
```

## 相关类型

- [ZephyrButtonThemeData](../theme/zephyr-button-theme-data) - 按钮主题数据
- [ZephyrButtonStyle](../theme/zephyr-button-style) - 按钮样式
- [ZephyrVariant](../types/zephyr-variant) - 组件变体枚举
- [ZephyrSize](../types/zephyr-size) - 组件尺寸枚举

## 相关组件

- [ZephyrText](./zephyr-text) - 文本组件
- [ZephyrIcon](./zephyr-icon) - 图标组件
- [ZephyrInput](./zephyr-input) - 输入框组件