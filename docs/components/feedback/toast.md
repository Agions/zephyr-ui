# ZephyrToast 提示组件

提示组件是ZephyrUI反馈系统中的重要组件，用于显示简短的操作反馈信息。支持多种提示类型、自定义样式和动画效果，是构建用户友好界面的重要组成部分。

## 🎯 组件概述

### 特性
- **多种提示类型**: 支持成功、错误、警告、信息等多种类型
- **灵活样式**: 支持自定义颜色、图标、位置等样式
- **丰富交互**: 支持点击、滑动、自动隐藏等交互
- **多种位置**: 支持顶部、底部、居中等多种位置
- **动画效果**: 内置平滑的显示/隐藏动画
- **主题适配**: 完整的主题系统支持

### 适用场景
- 操作结果反馈
- 状态提示
- 错误信息
- 成功确认
- 简短通知
- 用户引导

## 🚀 基础用法

### 基本提示组件

```dart
class BasicToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '操作成功',
                  type: ZephyrToastType.success,
                );
              },
              child: Text('显示成功提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '操作失败',
                  type: ZephyrToastType.error,
                );
              },
              child: Text('显示错误提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '请注意',
                  type: ZephyrToastType.warning,
                );
              },
              child: Text('显示警告提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '系统提示',
                  type: ZephyrToastType.info,
                );
              },
              child: Text('显示信息提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 自定义位置提示组件

```dart
class PositionToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义位置提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '顶部提示',
                  position: ZephyrToastPosition.top,
                );
              },
              child: Text('显示顶部提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '底部提示',
                  position: ZephyrToastPosition.bottom,
                );
              },
              child: Text('显示底部提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '居中提示',
                  position: ZephyrToastPosition.center,
                );
              },
              child: Text('显示居中提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带图标的提示组件

```dart
class IconToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带图标的提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '保存成功',
                  type: ZephyrToastType.success,
                  icon: Icon(Icons.save),
                );
              },
              child: Text('显示保存成功提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '删除成功',
                  type: ZephyrToastType.success,
                  icon: Icon(Icons.delete),
                );
              },
              child: Text('显示删除成功提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '发送成功',
                  type: ZephyrToastType.success,
                  icon: Icon(Icons.send),
                );
              },
              child: Text('显示发送成功提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义颜色提示组件

```dart
class CustomColorToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义颜色提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '自定义颜色提示',
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                );
              },
              child: Text('显示紫色提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '自定义颜色提示',
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                );
              },
              child: Text('显示青色提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '自定义颜色提示',
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                );
              },
              child: Text('显示琥珀色提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 圆角提示组件

```dart
class RoundedToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '大圆角提示',
                  borderRadius: BorderRadius.circular(20),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                );
              },
              child: Text('显示大圆角提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '中等圆角提示',
                  borderRadius: BorderRadius.circular(12),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                );
              },
              child: Text('显示中等圆角提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '小圆角提示',
                  borderRadius: BorderRadius.circular(8),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                );
              },
              child: Text('显示小圆角提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带边框的提示组件

```dart
class BorderedToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带边框的提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '带边框提示',
                  border: Border.all(color: Colors.blue, width: 2),
                );
              },
              child: Text('显示蓝色边框提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '带边框提示',
                  border: Border.all(color: Colors.green, width: 2),
                );
              },
              child: Text('显示绿色边框提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '带边框提示',
                  border: Border.all(color: Colors.red, width: 2),
                );
              },
              child: Text('显示红色边框提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 可点击提示组件

```dart
class ClickableToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可点击提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '点击查看详情',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('提示被点击了')),
                    );
                  },
                );
              },
              child: Text('显示可点击提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '点击撤销操作',
                  type: ZephyrToastType.warning,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('操作已撤销')),
                    );
                  },
                );
              },
              child: Text('显示撤销提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 可滑动关闭提示组件

```dart
class DismissibleToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可滑动关闭提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '滑动可关闭',
                  dismissible: true,
                  onDismissed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('提示被滑动关闭了')),
                    );
                  },
                );
              },
              child: Text('显示可滑动关闭提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '长消息内容，可以向左滑动关闭此提示',
                  dismissible: true,
                  duration: Duration(seconds: 5),
                );
              },
              child: Text('显示长消息可滑动关闭提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带动作按钮的提示组件

```dart
class ActionToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带动作按钮的提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '网络连接失败',
                  type: ZephyrToastType.error,
                  action: ZephyrToastAction(
                    label: '重试',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('正在重试...')),
                      );
                    },
                  ),
                );
              },
              child: Text('显示重试提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '新版本可用',
                  type: ZephyrToastType.info,
                  action: ZephyrToastAction(
                    label: '更新',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('正在更新...')),
                      );
                    },
                  ),
                );
              },
              child: Text('显示更新提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '项目已删除',
                  type: ZephyrToastType.success,
                  action: ZephyrToastAction(
                    label: '撤销',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('已撤销删除操作')),
                      );
                    },
                  ),
                );
              },
              child: Text('显示撤销提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 队列提示组件

```dart
class QueueToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('队列提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // 显示多个提示，它们会按顺序显示
                ZephyrToast.show(
                  context: context,
                  message: '第一个提示',
                  queueMode: true,
                );
                
                ZephyrToast.show(
                  context: context,
                  message: '第二个提示',
                  queueMode: true,
                );
                
                ZephyrToast.show(
                  context: context,
                  message: '第三个提示',
                  queueMode: true,
                );
              },
              child: Text('显示队列提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                // 显示不同类型的提示
                ZephyrToast.show(
                  context: context,
                  message: '操作成功',
                  type: ZephyrToastType.success,
                  queueMode: true,
                );
                
                ZephyrToast.show(
                  context: context,
                  message: '请注意',
                  type: ZephyrToastType.warning,
                  queueMode: true,
                );
                
                ZephyrToast.show(
                  context: context,
                  message: '操作完成',
                  type: ZephyrToastType.info,
                  queueMode: true,
                );
              },
              child: Text('显示混合类型队列提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 自定义动画提示组件

```dart
class AnimatedToastExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义动画提示组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '淡入淡出动画',
                  animationType: ToastAnimationType.fade,
                  animationDuration: Duration(milliseconds: 500),
                );
              },
              child: Text('显示淡入淡出动画提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '滑动动画',
                  animationType: ToastAnimationType.slide,
                  animationDuration: Duration(milliseconds: 300),
                );
              },
              child: Text('显示滑动动画提示'),
            ),
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                ZephyrToast.show(
                  context: context,
                  message: '缩放动画',
                  animationType: ToastAnimationType.scale,
                  animationDuration: Duration(milliseconds: 400),
                );
              },
              child: Text('显示缩放动画提示'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 表单验证提示组件

```dart
class FormValidationToastExample extends StatefulWidget {
  @override
  _FormValidationToastExampleState createState() => _FormValidationToastExampleState();
}

class _FormValidationToastExampleState extends State<FormValidationToastExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ZephyrToast.show(
        context: context,
        message: '表单验证成功',
        type: ZephyrToastType.success,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单验证提示组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '邮箱',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ZephyrToast.show(
                      context: context,
                      message: '请输入邮箱地址',
                      type: ZephyrToastType.error,
                    );
                    return '请输入邮箱地址';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    ZephyrToast.show(
                      context: context,
                      message: '请输入有效的邮箱地址',
                      type: ZephyrToastType.error,
                    );
                    return '请输入有效的邮箱地址';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '密码',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ZephyrToast.show(
                      context: context,
                      message: '请输入密码',
                      type: ZephyrToastType.error,
                    );
                    return '请输入密码';
                  }
                  if (value.length < 6) {
                    ZephyrToast.show(
                      context: context,
                      message: '密码长度至少6位',
                      type: ZephyrToastType.warning,
                    );
                    return '密码长度至少6位';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('提交表单'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 静态方法

#### ZephyrToast.show()

```dart
static void show({
  required BuildContext context,
  required String message,
  ZephyrToastType type = ZephyrToastType.info,
  Widget? icon,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? borderColor,
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? padding,
  BoxBorder? border,
  ZephyrToastPosition position = ZephyrToastPosition.bottom,
  Duration? duration,
  bool dismissible = false,
  VoidCallback? onDismissed,
  VoidCallback? onTap,
  ZephyrToastAction? action,
  bool queueMode = false,
  ToastAnimationType? animationType,
  Duration? animationDuration,
  Curve? animationCurve,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `context`: 上下文
- `message`: 消息内容
- `type`: 提示类型
- `icon`: 图标
- `backgroundColor`: 背景颜色
- `foregroundColor`: 前景颜色
- `borderColor`: 边框颜色
- `borderRadius`: 边框圆角
- `padding`: 内边距
- `border`: 边框
- `position`: 显示位置
- `duration`: 显示持续时间
- `dismissible`: 是否可关闭
- `onDismissed`: 关闭回调
- `onTap`: 点击回调
- `action`: 动作按钮
- `queueMode`: 队列模式
- `animationType`: 动画类型
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 辅助类

#### ZephyrToastAction

```dart
class ZephyrToastAction {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  
  const ZephyrToastAction({
    required this.label,
    required this.onPressed,
    this.textStyle,
  });
}
```

### 枚举类型

#### ZephyrToastType

```dart
enum ZephyrToastType {
  success,  // 成功提示
  error,    // 错误提示
  warning,  // 警告提示
  info,     // 信息提示
}
```

#### ZephyrToastPosition

```dart
enum ZephyrToastPosition {
  top,     // 顶部
  bottom,  // 底部
  center,  // 居中
}
```

#### ToastAnimationType

```dart
enum ToastAnimationType {
  fade,   // 淡入淡出
  slide,  // 滑动
  scale,  // 缩放
  none,   // 无动画
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrToastTheme(
        defaultBackgroundColor: Colors.black87,
        defaultForegroundColor: Colors.white,
        defaultBorderColor: Colors.transparent,
        defaultBorderRadius: BorderRadius.circular(4),
        defaultPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        messageStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        successColor: Colors.green,
        errorColor: Colors.red,
        warningColor: Colors.orange,
        infoColor: Colors.blue,
        defaultDuration: Duration(seconds: 3),
        defaultPosition: ZephyrToastPosition.bottom,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        actionTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
        iconSize: 20,
        elevation: 4,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultBackgroundColor`: 默认背景颜色
- `defaultForegroundColor`: 默认前景颜色
- `defaultBorderColor`: 默认边框颜色
- `defaultBorderRadius`: 默认边框圆角
- `defaultPadding`: 默认内边距
- `messageStyle`: 默认消息样式
- `successColor`: 成功颜色
- `errorColor`: 错误颜色
- `warningColor`: 警告颜色
- `infoColor`: 信息颜色
- `defaultDuration`: 默认显示持续时间
- `defaultPosition`: 默认显示位置
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `actionTextStyle`: 动作按钮样式
- `iconSize`: 图标尺寸
- `elevation`: 阴影高度

## 🏆 最佳实践

### 1. 合理的提示类型选择

```dart
// ✅ 好的做法：根据场景选择合适的提示类型
// 操作成功
ZephyrToast.show(
  context: context,
  message: '保存成功',
  type: ZephyrToastType.success,
)

// 错误情况
ZephyrToast.show(
  context: context,
  message: '网络连接失败',
  type: ZephyrToastType.error,
)

// 警告提示
ZephyrToast.show(
  context: context,
  message: '存储空间不足',
  type: ZephyrToastType.warning,
)

// ✅ 好的做法：使用合适的显示时长
ZephyrToast.show(
  context: context,
  message: '操作成功',
  duration: Duration(seconds: 2), // 短消息使用短时长
)

// ❌ 避免的做法：提示类型与场景不匹配
ZephyrToast.show(
  context: context,
  message: '错误',
  type: ZephyrToastType.success, // 类型与内容不匹配
)
```

### 2. 清晰的提示内容

```dart
// ✅ 好的做法：简洁明了的消息
ZephyrToast.show(
  context: context,
  message: '保存成功',
)

// ✅ 好的做法：具体的信息
ZephyrToast.show(
  context: context,
  message: '3个文件已保存',
)

// ✅ 好的做法：提供操作反馈
ZephyrToast.show(
  context: context,
  message: '点击查看详情',
  onTap: () => _showDetails(),
)

// ❌ 避免的做法：过长或模糊的消息
ZephyrToast.show(
  context: context,
  message: '这是一个非常长的消息，可能无法在屏幕上完全显示，用户可能无法完整阅读', // 消息过长
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供动作按钮
ZephyrToast.show(
  context: context,
  message: '网络连接失败',
  action: ZephyrToastAction(
    label: '重试',
    onPressed: () => _retry(),
  ),
)

// ✅ 好的做法：支持关闭
ZephyrToast.show(
  context: context,
  message: '重要提示',
  dismissible: true,
)

// ✅ 好的做法：使用队列模式
ZephyrToast.show(
  context: context,
  message: '操作成功',
  queueMode: true,
)

// ❌ 避免的做法：强制显示不可关闭的提示
ZephyrToast.show(
  context: context,
  message: '提示',
  dismissible: false, // 用户无法关闭
  duration: Duration(seconds: 10), // 时间过长
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrToast.show(
  context: context,
  message: '操作成功',
  semanticLabel: '操作成功提示',
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为操作提供描述
ZephyrToast.show(
  context: context,
  message: '点击查看详情',
  onTap: () => _showDetails(),
)

// ✅ 好的做法：确保足够的对比度
ZephyrToast.show(
  context: context,
  message: '提示',
  backgroundColor: Colors.black87,
  foregroundColor: Colors.white,
)

// ❌ 避免的做法：缺乏语义信息
ZephyrToast.show(
  context: context,
  message: '提示',
  // 缺乏无障碍支持
)
```

## 🔄 相关组件

- **ZephyrSnackbar**: 消息条组件
- **ZephyrAlert**: 警告组件
- **ZephyrNotification**: 通知组件
- **ZephyrBanner**: 横幅组件
- **ZephyrPopup**: 弹出组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种提示类型
- ✅ 支持自定义样式和动画
- ✅ 支持动作按钮
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/feedback/toast/`
**示例路径**: `example/lib/components/toast_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日