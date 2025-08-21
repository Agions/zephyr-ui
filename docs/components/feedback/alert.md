# ZephyrAlert 警告组件

警告组件是ZephyrUI反馈系统中的重要组件，用于向用户展示重要的提示信息、警告或错误消息。支持多种警告类型、自定义样式和交互方式，是构建用户友好界面的重要组成部分。

## 🎯 组件概述

### 特性
- **多种警告类型**: 支持成功、错误、警告、信息等多种类型
- **灵活样式**: 支持自定义颜色、图标、边框等样式
- **丰富交互**: 支持关闭、点击、动画等交互
- **多种布局**: 支持横向、纵向、紧凑等多种布局
- **动画效果**: 内置平滑的显示/隐藏动画
- **主题适配**: 完整的主题系统支持

### 适用场景
- 表单验证提示
- 操作结果反馈
- 系统状态通知
- 重要信息提醒
- 错误信息展示
- 成功操作确认

## 🚀 基础用法

### 基本警告组件

```dart
class BasicAlertExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 成功警告
            ZephyrAlert(
              type: ZephyrAlertType.success,
              title: '操作成功',
              message: '数据已成功保存到系统中',
            ),
            SizedBox(height: 16),
            
            // 错误警告
            ZephyrAlert(
              type: ZephyrAlertType.error,
              title: '操作失败',
              message: '网络连接失败，请检查网络设置',
            ),
            SizedBox(height: 16),
            
            // 警告提示
            ZephyrAlert(
              type: ZephyrAlertType.warning,
              title: '注意',
              message: '您的账户余额不足，请及时充值',
            ),
            SizedBox(height: 16),
            
            // 信息提示
            ZephyrAlert(
              type: ZephyrAlertType.info,
              title: '系统提示',
              message: '新版本已发布，建议您更新到最新版本',
            ),
          ],
        ),
      ),
    );
  }
}
```

### 可关闭警告组件

```dart
class DismissibleAlertExample extends StatefulWidget {
  @override
  _DismissibleAlertExampleState createState() => _DismissibleAlertExampleState();
}

class _DismissibleAlertExampleState extends State<DismissibleAlertExample> {
  bool _showAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可关闭警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => _showAlerts = true);
                  },
                  child: Text('显示警告'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _showAlerts = false);
                  },
                  child: Text('隐藏警告'),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // 可关闭警告
            if (_showAlerts) ...[
              ZephyrAlert(
                type: ZephyrAlertType.success,
                title: '操作成功',
                message: '数据已成功保存',
                dismissible: true,
                onDismissed: () {
                  setState(() => _showAlerts = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('警告已关闭')),
                  );
                },
              ),
              SizedBox(height: 16),
              
              ZephyrAlert(
                type: ZephyrAlertType.warning,
                title: '系统维护',
                message: '系统将于今晚22:00进行维护',
                dismissible: true,
                showCloseButton: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

### 紧凑型警告组件

```dart
class CompactAlertExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧凑型警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 行内紧凑警告
            Row(
              children: [
                Text('状态:'),
                SizedBox(width: 8),
                ZephyrAlert(
                  type: ZephyrAlertType.success,
                  compact: true,
                  message: '正常',
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // 多个紧凑警告
            Wrap(
              spacing: 8,
              children: [
                ZephyrAlert(
                  type: ZephyrAlertType.success,
                  compact: true,
                  message: '已连接',
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.warning,
                  compact: true,
                  message: '低电量',
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.error,
                  compact: true,
                  message: '连接失败',
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.info,
                  compact: true,
                  message: '新消息',
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // 带标签的紧凑警告
            ZephyrAlert(
              type: ZephyrAlertType.info,
              compact: true,
              showLabel: true,
              label: '系统',
              message: '正在更新',
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义颜色警告组件

```dart
class CustomColorAlertExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义颜色警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 自定义成功警告
            ZephyrAlert(
              type: ZephyrAlertType.success,
              title: '验证通过',
              message: '所有验证项目都已通过',
              backgroundColor: Colors.green[50],
              foregroundColor: Colors.green[800],
              borderColor: Colors.green[200],
            ),
            SizedBox(height: 16),
            
            // 自定义错误警告
            ZephyrAlert(
              type: ZephyrAlertType.error,
              title: '验证失败',
              message: '请检查输入的信息',
              backgroundColor: Colors.red[50],
              foregroundColor: Colors.red[800],
              borderColor: Colors.red[200],
            ),
            SizedBox(height: 16),
            
            // 自定义警告提示
            ZephyrAlert(
              type: ZephyrAlertType.warning,
              title: '存储空间不足',
              message: '剩余空间少于10%',
              backgroundColor: Colors.orange[50],
              foregroundColor: Colors.orange[800],
              borderColor: Colors.orange[200],
            ),
            SizedBox(height: 16),
            
            // 自定义信息提示
            ZephyrAlert(
              type: ZephyrAlertType.info,
              title: '新功能',
              message: '我们推出了新的功能，快来体验吧',
              backgroundColor: Colors.blue[50],
              foregroundColor: Colors.blue[800],
              borderColor: Colors.blue[200],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 圆角警告组件

```dart
class RoundedAlertExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 大圆角警告
            ZephyrAlert(
              type: ZephyrAlertType.success,
              title: '配置完成',
              message: '系统配置已成功保存',
              borderRadius: BorderRadius.circular(16),
              padding: EdgeInsets.all(16),
            ),
            SizedBox(height: 16),
            
            // 中等圆角警告
            ZephyrAlert(
              type: ZephyrAlertType.info,
              title: '数据同步',
              message: '正在同步您的数据',
              borderRadius: BorderRadius.circular(12),
              padding: EdgeInsets.all(12),
            ),
            SizedBox(height: 16),
            
            // 小圆角警告
            ZephyrAlert(
              type: ZephyrAlertType.warning,
              title: '安全提醒',
              message: '检测到异常登录',
              borderRadius: BorderRadius.circular(8),
              padding: EdgeInsets.all(8),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带图标的警告组件

```dart
class IconAlertExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带图标的警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 自定义图标警告
            ZephyrAlert(
              type: ZephyrAlertType.success,
              title: '下载完成',
              message: '文件已成功下载到本地',
              icon: Icon(Icons.download_done),
            ),
            SizedBox(height: 16),
            
            // 自定义图标警告
            ZephyrAlert(
              type: ZephyrAlertType.error,
              title: '上传失败',
              message: '文件上传失败，请重试',
              icon: Icon(Icons.upload_error),
            ),
            SizedBox(height: 16),
            
            // 自定义图标警告
            ZephyrAlert(
              type: ZephyrAlertType.warning,
              title: '电池低电量',
              message: '电池电量低于20%，请连接充电器',
              icon: Icon(Icons.battery_alert),
            ),
            SizedBox(height: 16),
            
            // 自定义图标警告
            ZephyrAlert(
              type: ZephyrAlertType.info,
              title: '系统更新',
              message: '系统有可用更新',
              icon: Icon(Icons.system_update),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 可点击警告组件

```dart
class ClickableAlertExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可点击警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 可点击的成功警告
            ZephyrAlert(
              type: ZephyrAlertType.success,
              title: '备份完成',
              message: '点击查看备份详情',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('查看备份详情')),
                );
              },
            ),
            SizedBox(height: 16),
            
            // 可点击的错误警告
            ZephyrAlert(
              type: ZephyrAlertType.error,
              title: '同步失败',
              message: '点击重试同步',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('正在重试同步...')),
                );
              },
            ),
            SizedBox(height: 16),
            
            // 可点击的警告提示
            ZephyrAlert(
              type: ZephyrAlertType.warning,
              title: '存储空间不足',
              message: '点击清理存储空间',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('打开存储管理')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带动画的警告组件

```dart
class AnimatedAlertExample extends StatefulWidget {
  @override
  _AnimatedAlertExampleState createState() => _AnimatedAlertExampleState();
}

class _AnimatedAlertExampleState extends State<AnimatedAlertExample> {
  bool _showAlert = false;
  ZephyrAlertType _alertType = ZephyrAlertType.info;

  void _showSuccessAlert() {
    setState(() {
      _showAlert = true;
      _alertType = ZephyrAlertType.success;
    });
  }

  void _showErrorAlert() {
    setState(() {
      _showAlert = true;
      _alertType = ZephyrAlertType.error;
    });
  }

  void _hideAlert() {
    setState(() => _showAlert = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带动画的警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _showSuccessAlert,
                  child: Text('显示成功警告'),
                ),
                ElevatedButton(
                  onPressed: _showErrorAlert,
                  child: Text('显示错误警告'),
                ),
                ElevatedButton(
                  onPressed: _hideAlert,
                  child: Text('隐藏警告'),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // 动画警告
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _showAlert
                  ? ZephyrAlert(
                      key: ValueKey(_alertType),
                      type: _alertType,
                      title: _alertType == ZephyrAlertType.success
                          ? '操作成功'
                          : '操作失败',
                      message: _alertType == ZephyrAlertType.success
                          ? '操作已成功完成'
                          : '操作失败，请重试',
                      animate: true,
                      animationDuration: Duration(milliseconds: 500),
                    )
                  : SizedBox.shrink(),
            ),
            SizedBox(height: 24),
            
            // 自动隐藏警告
            ZephyrAlert(
              type: ZephyrAlertType.info,
              title: '自动隐藏警告',
              message: '此警告将在3秒后自动隐藏',
              autoHide: true,
              autoHideDuration: Duration(seconds: 3),
              onAutoHide: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('警告已自动隐藏')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### 警告组组件

```dart
class AlertGroupExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('警告组组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 系统状态警告组
            ZephyrAlertGroup(
              title: '系统状态',
              children: [
                ZephyrAlert(
                  type: ZephyrAlertType.success,
                  title: 'CPU',
                  message: '正常',
                  compact: true,
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.success,
                  title: '内存',
                  message: '正常',
                  compact: true,
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.warning,
                  title: '磁盘',
                  message: '85%',
                  compact: true,
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.success,
                  title: '网络',
                  message: '正常',
                  compact: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // 应用状态警告组
            ZephyrAlertGroup(
              title: '应用状态',
              direction: Axis.horizontal,
              children: [
                ZephyrAlert(
                  type: ZephyrAlertType.success,
                  title: 'Web服务',
                  message: '运行中',
                  compact: true,
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.error,
                  title: '数据库',
                  message: '已停止',
                  compact: true,
                ),
                ZephyrAlert(
                  type: ZephyrAlertType.info,
                  title: '缓存',
                  message: '同步中',
                  compact: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 表单验证警告组件

```dart
class FormValidationAlertExample extends StatefulWidget {
  @override
  _FormValidationAlertExampleState createState() => _FormValidationAlertExampleState();
}

class _FormValidationAlertExampleState extends State<FormValidationAlertExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  ZephyrAlertType? _alertType;
  String? _alertTitle;
  String? _alertMessage;
  bool _showAlert = false;

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _alertType = ZephyrAlertType.success;
        _alertTitle = '验证通过';
        _alertMessage = '表单验证成功，可以提交';
        _showAlert = true;
      });
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
        title: Text('表单验证警告组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 邮箱输入框
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '邮箱',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      _alertType = ZephyrAlertType.error;
                      _alertTitle = '验证失败';
                      _alertMessage = '请输入邮箱地址';
                      _showAlert = true;
                    });
                    return '请输入邮箱地址';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    setState(() {
                      _alertType = ZephyrAlertType.error;
                      _alertTitle = '格式错误';
                      _alertMessage = '请输入有效的邮箱地址';
                      _showAlert = true;
                    });
                    return '请输入有效的邮箱地址';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              // 密码输入框
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '密码',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      _alertType = ZephyrAlertType.error;
                      _alertTitle = '验证失败';
                      _alertMessage = '请输入密码';
                      _showAlert = true;
                    });
                    return '请输入密码';
                  }
                  if (value.length < 6) {
                    setState(() {
                      _alertType = ZephyrAlertType.warning;
                      _alertTitle = '密码强度不足';
                      _alertMessage = '密码长度至少6位';
                      _showAlert = true;
                    });
                    return '密码长度至少6位';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              
              // 验证警告
              if (_showAlert)
                ZephyrAlert(
                  type: _alertType!,
                  title: _alertTitle!,
                  message: _alertMessage!,
                  dismissible: true,
                  onDismissed: () {
                    setState(() => _showAlert = false);
                  },
                ),
              
              SizedBox(height: 24),
              
              // 提交按钮
              ElevatedButton(
                onPressed: _validateForm,
                child: Text('验证表单'),
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

### 构造函数

#### ZephyrAlert()

```dart
const ZephyrAlert({
  Key? key,
  required ZephyrAlertType type,
  String? title,
  String? message,
  Widget? icon,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? borderColor,
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? padding,
  BoxBorder? border,
  BoxDecoration? decoration,
  bool compact = false,
  bool showLabel = false,
  String? label,
  TextStyle? labelStyle,
  bool dismissible = false,
  bool showCloseButton = false,
  VoidCallback? onDismissed,
  VoidCallback? onTap,
  bool animate = false,
  Duration? animationDuration,
  Curve? animationCurve,
  bool autoHide = false,
  Duration? autoHideDuration,
  VoidCallback? onAutoHide,
  String? tooltip,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `type`: 警告类型
- `title`: 标题
- `message`: 消息
- `icon`: 图标
- `backgroundColor`: 背景颜色
- `foregroundColor`: 前景颜色
- `borderColor`: 边框颜色
- `borderRadius`: 边框圆角
- `padding`: 内边距
- `border`: 边框
- `decoration`: 装饰
- `compact`: 是否紧凑模式
- `showLabel`: 是否显示标签
- `label`: 标签文本
- `labelStyle`: 标签样式
- `dismissible`: 是否可关闭
- `showCloseButton`: 是否显示关闭按钮
- `onDismissed`: 关闭回调
- `onTap`: 点击回调
- `animate`: 是否启用动画
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `autoHide`: 是否自动隐藏
- `autoHideDuration`: 自动隐藏持续时间
- `onAutoHide`: 自动隐藏回调
- `tooltip`: 工具提示
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrAlertGroup()

```dart
const ZephyrAlertGroup({
  Key? key,
  String? title,
  Axis direction = Axis.vertical,
  List<Widget> children = const [],
  EdgeInsetsGeometry? padding,
  CrossAxisAlignment? crossAxisAlignment,
  MainAxisAlignment? mainAxisAlignment,
})
```

### 枚举类型

#### ZephyrAlertType

```dart
enum ZephyrAlertType {
  success,  // 成功警告
  error,    // 错误警告
  warning,  // 警告提示
  info,     // 信息提示
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrAlertTheme(
        defaultBackgroundColor: Colors.white,
        defaultForegroundColor: Colors.black87,
        defaultBorderColor: Colors.grey[300],
        defaultBorderRadius: BorderRadius.circular(8),
        defaultPadding: EdgeInsets.all(12),
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        messageStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        successColor: Colors.green,
        errorColor: Colors.red,
        warningColor: Colors.orange,
        infoColor: Colors.blue,
        compactPadding: EdgeInsets.all(4),
        compactTitleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        compactMessageStyle: TextStyle(
          fontSize: 10,
          color: Colors.grey[600],
        ),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        hoverColor: Colors.grey.withOpacity(0.1),
        focusColor: Colors.blue.withOpacity(0.1),
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
- `titleStyle`: 默认标题样式
- `messageStyle`: 默认消息样式
- `successColor`: 成功颜色
- `errorColor`: 错误颜色
- `warningColor`: 警告颜色
- `infoColor`: 信息颜色
- `compactPadding`: 紧凑模式内边距
- `compactTitleStyle`: 紧凑模式标题样式
- `compactMessageStyle`: 紧凑模式消息样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的警告类型选择

```dart
// ✅ 好的做法：根据场景选择合适的警告类型
// 操作成功
ZephyrAlert(
  type: ZephyrAlertType.success,
  title: '保存成功',
  message: '数据已成功保存',
)

// 错误情况
ZephyrAlert(
  type: ZephyrAlertType.error,
  title: '保存失败',
  message: '网络连接失败',
)

// 警告提示
ZephyrAlert(
  type: ZephyrAlertType.warning,
  title: '存储空间不足',
  message: '剩余空间少于10%',
)

// ✅ 好的做法：使用紧凑模式显示简单状态
ZephyrAlert(
  type: ZephyrAlertType.success,
  compact: true,
  message: '在线',
)

// ❌ 避免的做法：警告类型与场景不匹配
ZephyrAlert(
  type: ZephyrAlertType.success,
  title: '错误', // 类型与标题不匹配
  message: '操作失败',
)
```

### 2. 清晰的视觉反馈

```dart
// ✅ 好的做法：使用颜色区分不同警告
ZephyrAlert(
  type: ZephyrAlertType.success,
  backgroundColor: Colors.green[50],
  foregroundColor: Colors.green[800],
)

// ✅ 好的做法：使用图标增强识别性
ZephyrAlert(
  type: ZephyrAlertType.error,
  icon: Icon(Icons.error),
)

// ✅ 好的做法：提供明确的文字说明
ZephyrAlert(
  type: ZephyrAlertType.warning,
  title: '系统警告',
  message: '检测到异常活动，请检查',
)

// ❌ 避免的做法：缺乏视觉区分
ZephyrAlert(
  type: ZephyrAlertType.success,
  // 所有警告看起来一样
)
```

### 3. 用户体验优化

```dart
// ✅ 好的做法：提供关闭选项
ZephyrAlert(
  type: ZephyrAlertType.info,
  dismissible: true,
  onDismissed: () {
    // 处理关闭事件
  },
)

// ✅ 好的做法：支持自动隐藏
ZephyrAlert(
  type: ZephyrAlertType.success,
  autoHide: true,
  autoHideDuration: Duration(seconds: 3),
)

// ✅ 好的做法：为重要警告提供操作
ZephyrAlert(
  type: ZephyrAlertType.error,
  onTap: () {
    // 处理点击事件
  },
)

// ❌ 避免的做法：强制显示不可关闭的警告
ZephyrAlert(
  type: ZephyrAlertType.info,
  dismissible: false, // 用户无法关闭
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrAlert(
  type: ZephyrAlertType.success,
  semanticLabel: '操作成功警告',
  title: '保存成功',
  message: '数据已成功保存',
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为交互提供反馈
ZephyrAlert(
  type: ZephyrAlertType.error,
  onTap: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看错误详情')),
    );
  },
)

// ✅ 好的做法：确保足够的对比度
ZephyrAlert(
  type: ZephyrAlertType.warning,
  backgroundColor: Colors.orange[50],
  foregroundColor: Colors.orange[800],
)

// ❌ 避免的做法：缺乏语义信息
ZephyrAlert(
  type: ZephyrAlertType.info,
  // 缺乏无障碍支持
)
```

## 🔄 相关组件

- **ZephyrToast**: 提示组件
- **ZephyrModal**: 模态框组件
- **ZephyrSnackbar**: 消息条组件
- **ZephyrBanner**: 横幅组件
- **ZephyrNotification**: 通知组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种警告类型
- ✅ 支持自定义样式和动画
- ✅ 支持警告组
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/feedback/alert/`
**示例路径**: `example/lib/components/alert_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日