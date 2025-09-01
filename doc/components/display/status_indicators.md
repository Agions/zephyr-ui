# ZephyrStatusIndicators 状态指示器组件

状态指示器组件是ZephyrUI展示系统中的重要组件，提供了直观的状态展示功能。支持多种状态指示器模式、自定义样式和动画效果，是构建系统状态、任务状态、数据状态等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种状态模式**: 支持成功、错误、警告、信息等多种状态
- **灵活样式**: 支持自定义颜色、大小、图标等样式
- **丰富交互**: 支持点击、悬停、动画等交互
- **组合使用**: 支持多个状态指示器组合使用
- **动画效果**: 内置平滑的动画效果
- **主题适配**: 完整的主题系统支持

### 适用场景
- 表单验证状态
- 数据加载状态
- 系统运行状态
- 任务执行状态
- 网络连接状态
- 操作结果状态

## 🚀 基础用法

### 基本状态指示器

```dart
class BasicStatusExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 成功状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.success,
              title: '操作成功',
              message: '数据已成功保存',
            ),
            SizedBox(height: 16),
            
            // 错误状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.error,
              title: '操作失败',
              message: '网络连接失败，请重试',
            ),
            SizedBox(height: 16),
            
            // 警告状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.warning,
              title: '注意',
              message: '您的账户余额不足',
            ),
            SizedBox(height: 16),
            
            // 信息状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.info,
              title: '提示',
              message: '新版本可用，请更新',
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带图标的状态指示器

```dart
class IconStatusExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带图标的状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 在线状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.success,
              title: '在线',
              message: '系统正常运行',
              icon: Icon(Icons.check_circle),
            ),
            SizedBox(height: 16),
            
            // 离线状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.error,
              title: '离线',
              message: '系统已断开连接',
              icon: Icon(Icons.error),
            ),
            SizedBox(height: 16),
            
            // 维护状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.warning,
              title: '维护中',
              message: '系统正在维护，预计2小时后恢复',
              icon: Icon(Icons.build),
            ),
            SizedBox(height: 16),
            
            // 更新状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.info,
              title: '更新中',
              message: '正在下载更新包',
              icon: Icon(Icons.system_update),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 紧凑型状态指示器

```dart
class CompactStatusExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紧凑型状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 行内状态指示器
            Row(
              children: [
                Text('用户状态:'),
                SizedBox(width: 8),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  compact: true,
                  message: '在线',
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // 多个紧凑状态
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  compact: true,
                  message: '正常',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.warning,
                  compact: true,
                  message: '警告',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.error,
                  compact: true,
                  message: '错误',
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // 带标签的紧凑状态
            Wrap(
              spacing: 8,
              children: [
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  compact: true,
                  showLabel: true,
                  label: '已连接',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.info,
                  compact: true,
                  showLabel: true,
                  label: '同步中',
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.warning,
                  compact: true,
                  showLabel: true,
                  label: '低电量',
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

## 🎨 样式定制

### 自定义颜色状态指示器

```dart
class CustomColorStatusExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义颜色状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 自定义成功状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.success,
              title: '验证成功',
              message: '所有验证项目已通过',
              backgroundColor: Colors.green[50],
              foregroundColor: Colors.green[800],
              borderColor: Colors.green[200],
            ),
            SizedBox(height: 16),
            
            // 自定义错误状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.error,
              title: '验证失败',
              message: '请检查输入的信息',
              backgroundColor: Colors.red[50],
              foregroundColor: Colors.red[800],
              borderColor: Colors.red[200],
            ),
            SizedBox(height: 16),
            
            // 自定义警告状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.warning,
              title: '存储空间不足',
              message: '剩余空间少于10%',
              backgroundColor: Colors.orange[50],
              foregroundColor: Colors.orange[800],
              borderColor: Colors.orange[200],
            ),
            SizedBox(height: 16),
            
            // 自定义信息状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.info,
              title: '新消息',
              message: '您有3条未读消息',
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

### 圆角状态指示器

```dart
class RoundedStatusExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 大圆角状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.success,
              title: '配置完成',
              message: '系统配置已成功保存',
              borderRadius: BorderRadius.circular(16),
              padding: EdgeInsets.all(16),
            ),
            SizedBox(height: 16),
            
            // 中等圆角状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.info,
              title: '数据同步',
              message: '正在同步您的数据',
              borderRadius: BorderRadius.circular(12),
              padding: EdgeInsets.all(12),
            ),
            SizedBox(height: 16),
            
            // 小圆角状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.warning,
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

### 带边框的状态指示器

```dart
class BorderedStatusExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带边框的状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 实线边框
            ZephyrStatusIndicator(
              type: ZephyrStatusType.success,
              title: '连接成功',
              message: '已连接到服务器',
              border: Border.all(color: Colors.green, width: 2),
            ),
            SizedBox(height: 16),
            
            // 虚线边框
            ZephyrStatusIndicator(
              type: ZephyrStatusType.info,
              title: '正在加载',
              message: '请稍候...',
              border: Border.all(
                color: Colors.blue,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            SizedBox(height: 16),
            
            // 渐变边框
            ZephyrStatusIndicator(
              type: ZephyrStatusType.warning,
              title: '低电量',
              message: '电池电量低于20%',
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 可点击状态指示器

```dart
class ClickableStatusExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可点击状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 可点击的成功状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.success,
              title: '备份完成',
              message: '点击查看备份详情',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('查看备份详情')),
                );
              },
            ),
            SizedBox(height: 16),
            
            // 可点击的错误状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.error,
              title: '同步失败',
              message: '点击重试同步',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('正在重试同步...')),
                );
              },
            ),
            SizedBox(height: 16),
            
            // 可点击的警告状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.warning,
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

### 带动画的状态指示器

```dart
class AnimatedStatusExample extends StatefulWidget {
  @override
  _AnimatedStatusExampleState createState() => _AnimatedStatusExampleState();
}

class _AnimatedStatusExampleState extends State<AnimatedStatusExample> {
  ZephyrStatusType _currentStatus = ZephyrStatusType.info;
  String _title = '正在处理';
  String _message = '请稍候...';

  Future<void> _simulateStatusChange() async {
    setState(() {
      _currentStatus = ZephyrStatusType.info;
      _title = '正在处理';
      _message = '请稍候...';
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _currentStatus = ZephyrStatusType.success;
      _title = '处理完成';
      _message = '操作已成功完成';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带动画的状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 动画状态指示器
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: ZephyrStatusIndicator(
                key: ValueKey(_currentStatus),
                type: _currentStatus,
                title: _title,
                message: _message,
                animate: true,
                animationDuration: Duration(milliseconds: 500),
              ),
            ),
            SizedBox(height: 32),
            
            // 脉冲动画状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.warning,
              title: '系统警告',
              message: '检测到异常活动',
              animationType: StatusAnimationType.pulse,
            ),
            SizedBox(height: 16),
            
            // 弹性动画状态
            ZephyrStatusIndicator(
              type: ZephyrStatusType.info,
              title: '系统信息',
              message: '正在加载最新数据',
              animationType: StatusAnimationType.elastic,
            ),
            SizedBox(height: 32),
            
            // 控制按钮
            ElevatedButton(
              onPressed: _simulateStatusChange,
              child: Text('模拟状态变化'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 状态组指示器

```dart
class StatusGroupExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态组指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 系统状态组
            ZephyrStatusGroup(
              title: '系统状态',
              children: [
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  title: 'CPU',
                  message: '正常',
                  compact: true,
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  title: '内存',
                  message: '正常',
                  compact: true,
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.warning,
                  title: '磁盘',
                  message: '85%',
                  compact: true,
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  title: '网络',
                  message: '正常',
                  compact: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // 服务状态组
            ZephyrStatusGroup(
              title: '服务状态',
              direction: Axis.horizontal,
              children: [
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  title: 'Web服务',
                  message: '运行中',
                  compact: true,
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.error,
                  title: '数据库',
                  message: '已停止',
                  compact: true,
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.info,
                  title: '缓存',
                  message: '同步中',
                  compact: true,
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // 网络状态组
            ZephyrStatusGroup(
              title: '网络连接',
              layout: StatusGroupLayout.badge,
              children: [
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  title: 'WiFi',
                  message: '已连接',
                  compact: true,
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.success,
                  title: '蓝牙',
                  message: '已连接',
                  compact: true,
                ),
                ZephyrStatusIndicator(
                  type: ZephyrStatusType.error,
                  title: '移动数据',
                  message: '无服务',
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

### 实时状态指示器

```dart
class RealTimeStatusExample extends StatefulWidget {
  @override
  _RealTimeStatusExampleState createState() => _RealTimeStatusExampleState();
}

class _RealTimeStatusExampleState extends State<RealTimeStatusExample> {
  Map<String, ZephyrStatusType> _serviceStatus = {
    'web': ZephyrStatusType.success,
    'database': ZephyrStatusType.success,
    'cache': ZephyrStatusType.info,
    'storage': ZephyrStatusType.warning,
  };
  
  Map<String, String> _serviceMessages = {
    'web': '运行正常',
    'database': '连接正常',
    'cache': '同步中',
    'storage': '空间不足',
  };

  Timer? _statusTimer;

  @override
  void initState() {
    super.initState();
    _startStatusMonitoring();
  }

  void _startStatusMonitoring() {
    _statusTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      _updateRandomStatus();
    });
  }

  void _updateRandomStatus() {
    final services = _serviceStatus.keys.toList();
    final randomService = services[Random().nextInt(services.length)];
    final statuses = [
      ZephyrStatusType.success,
      ZephyrStatusType.warning,
      ZephyrStatusType.error,
      ZephyrStatusType.info,
    ];
    
    setState(() {
      _serviceStatus[randomService] = statuses[Random().nextInt(statuses.length)];
      _serviceMessages[randomService] = _getStatusMessage(_serviceStatus[randomService]!);
    });
  }

  String _getStatusMessage(ZephyrStatusType status) {
    switch (status) {
      case ZephyrStatusType.success:
        return '运行正常';
      case ZephyrStatusType.error:
        return '连接失败';
      case ZephyrStatusType.warning:
        return '需要注意';
      case ZephyrStatusType.info:
        return '正在处理';
      default:
        return '未知状态';
    }
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('实时状态指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 实时状态面板
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '服务监控面板',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '实时监控中',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ..._serviceStatus.entries.map((entry) {
                    final service = entry.key;
                    final status = entry.value;
                    final message = _serviceMessages[service]!;
                    
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: ZephyrStatusIndicator(
                        type: status,
                        title: _getServiceDisplayName(service),
                        message: message,
                        compact: true,
                        animate: true,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: 24),
            
            // 状态统计
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatusCount(ZephyrStatusType.success, '正常'),
                _buildStatusCount(ZephyrStatusType.warning, '警告'),
                _buildStatusCount(ZephyrStatusType.error, '错误'),
                _buildStatusCount(ZephyrStatusType.info, '信息'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getServiceDisplayName(String service) {
    switch (service) {
      case 'web':
        return 'Web服务';
      case 'database':
        return '数据库';
      case 'cache':
        return '缓存服务';
      case 'storage':
        return '存储服务';
      default:
        return service;
    }
  }

  Widget _buildStatusCount(ZephyrStatusType status, String label) {
    final count = _serviceStatus.values.where((s) => s == status).length;
    
    return Column(
      children: [
        ZephyrStatusIndicator(
          type: status,
          compact: true,
          message: count.toString(),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
```

### 表单验证状态指示器

```dart
class FormValidationStatusExample extends StatefulWidget {
  @override
  _FormValidationStatusExampleState createState() => _FormValidationStatusExampleState();
}

class _FormValidationStatusExampleState extends State<FormValidationStatusExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  Map<String, ZephyrStatusType> _fieldStatus = {};
  Map<String, String> _fieldMessages = {};

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }

  void _validateEmail() {
    final email = _emailController.text;
    if (email.isEmpty) {
      _updateFieldStatus('email', ZephyrStatusType.info, '请输入邮箱');
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _updateFieldStatus('email', ZephyrStatusType.error, '邮箱格式不正确');
    } else {
      _updateFieldStatus('email', ZephyrStatusType.success, '邮箱格式正确');
    }
  }

  void _validatePassword() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      _updateFieldStatus('password', ZephyrStatusType.info, '请输入密码');
    } else if (password.length < 6) {
      _updateFieldStatus('password', ZephyrStatusType.error, '密码至少6位');
    } else {
      _updateFieldStatus('password', ZephyrStatusType.success, '密码强度良好');
    }
  }

  void _updateFieldStatus(String field, ZephyrStatusType status, String message) {
    setState(() {
      _fieldStatus[field] = status;
      _fieldMessages[field] = message;
    });
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
        title: Text('表单验证状态指示器'),
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
                  suffixIcon: _fieldStatus.containsKey('email')
                      ? _getStatusIcon(_fieldStatus['email']!)
                      : null,
                ),
              ),
              if (_fieldStatus.containsKey('email')) ...[
                SizedBox(height: 8),
                ZephyrStatusIndicator(
                  type: _fieldStatus['email']!,
                  message: _fieldMessages['email']!,
                  compact: true,
                ),
              ],
              SizedBox(height: 16),
              
              // 密码输入框
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '密码',
                  border: OutlineInputBorder(),
                  suffixIcon: _fieldStatus.containsKey('password')
                      ? _getStatusIcon(_fieldStatus['password']!)
                      : null,
                ),
              ),
              if (_fieldStatus.containsKey('password')) ...[
                SizedBox(height: 8),
                ZephyrStatusIndicator(
                  type: _fieldStatus['password']!,
                  message: _fieldMessages['password']!,
                  compact: true,
                ),
              ],
              SizedBox(height: 24),
              
              // 提交按钮
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('表单提交成功')),
                    );
                  }
                },
                child: Text('提交'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getStatusIcon(ZephyrStatusType status) {
    switch (status) {
      case ZephyrStatusType.success:
        return Icon(Icons.check_circle, color: Colors.green);
      case ZephyrStatusType.error:
        return Icon(Icons.error, color: Colors.red);
      case ZephyrStatusType.warning:
        return Icon(Icons.warning, color: Colors.orange);
      case ZephyrStatusType.info:
        return Icon(Icons.info, color: Colors.blue);
      default:
        return null;
    }
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrStatusIndicator()

```dart
const ZephyrStatusIndicator({
  Key? key,
  required ZephyrStatusType type,
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
  VoidCallback? onTap,
  bool animate = false,
  StatusAnimationType? animationType,
  Duration? animationDuration,
  Curve? animationCurve,
  String? tooltip,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `type`: 状态类型
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
- `onTap`: 点击回调
- `animate`: 是否启用动画
- `animationType`: 动画类型
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `tooltip`: 工具提示
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrStatusGroup()

```dart
const ZephyrStatusGroup({
  Key? key,
  String? title,
  Axis direction = Axis.vertical,
  StatusGroupLayout layout = StatusGroupLayout.list,
  List<Widget> children = const [],
  EdgeInsetsGeometry? padding,
  CrossAxisAlignment? crossAxisAlignment,
  MainAxisAlignment? mainAxisAlignment,
})
```

### 枚举类型

#### ZephyrStatusType

```dart
enum ZephyrStatusType {
  success,  // 成功状态
  error,    // 错误状态
  warning,  // 警告状态
  info,     // 信息状态
}
```

#### StatusAnimationType

```dart
enum StatusAnimationType {
  none,    // 无动画
  fade,    // 淡入淡出
  slide,   // 滑动
  scale,   // 缩放
  pulse,   // 脉冲
  elastic, // 弹性
}
```

#### StatusGroupLayout

```dart
enum StatusGroupLayout {
  list,   // 列表布局
  grid,   // 网格布局
  badge,  // 徽章布局
  row,    // 行布局
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrStatusTheme(
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

### 1. 合理的状态类型选择

```dart
// ✅ 好的做法：根据场景选择合适的状态类型
// 操作成功
ZephyrStatusIndicator(
  type: ZephyrStatusType.success,
  title: '保存成功',
  message: '数据已成功保存',
)

// 错误情况
ZephyrStatusIndicator(
  type: ZephyrStatusType.error,
  title: '保存失败',
  message: '网络连接失败',
)

// 警告提示
ZephyrStatusIndicator(
  type: ZephyrStatusType.warning,
  title: '存储空间不足',
  message: '剩余空间少于10%',
)

// ✅ 好的做法：使用紧凑模式显示简单状态
ZephyrStatusIndicator(
  type: ZephyrStatusType.success,
  compact: true,
  message: '在线',
)

// ❌ 避免的做法：状态类型与场景不匹配
ZephyrStatusIndicator(
  type: ZephyrStatusType.success,
  title: '错误', // 状态与标题不匹配
  message: '操作失败',
)
```

### 2. 清晰的视觉反馈

```dart
// ✅ 好的做法：使用颜色区分不同状态
ZephyrStatusIndicator(
  type: ZephyrStatusType.success,
  backgroundColor: Colors.green[50],
  foregroundColor: Colors.green[800],
)

// ✅ 好的做法：使用图标增强识别性
ZephyrStatusIndicator(
  type: ZephyrStatusType.error,
  icon: Icon(Icons.error),
)

// ✅ 好的做法：提供明确的文字说明
ZephyrStatusIndicator(
  type: ZephyrStatusType.warning,
  title: '系统警告',
  message: '检测到异常活动，请检查',
)

// ❌ 避免的做法：缺乏视觉区分
ZephyrStatusIndicator(
  type: ZephyrStatusType.success,
  // 所有状态看起来一样
)
```

### 3. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整
class ResponsiveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ZephyrStatusIndicator(
      type: ZephyrStatusType.info,
      compact: screenWidth < 400,
      title: screenWidth < 400 ? null : '系统信息',
      message: '正在更新数据',
    );
  }
}

// ✅ 好的做法：在拥挤空间使用紧凑模式
Row(
  children: [
    Text('状态:'),
    SizedBox(width: 8),
    ZephyrStatusIndicator(
      type: ZephyrStatusType.success,
      compact: true,
      message: '正常',
    ),
  ],
)

// ❌ 避免的做法：固定不考虑响应式
ZephyrStatusIndicator(
  type: ZephyrStatusType.info,
  // 在小屏幕上可能显示不全
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrStatusIndicator(
  type: ZephyrStatusType.success,
  semanticLabel: '操作成功状态',
  title: '保存成功',
  message: '数据已成功保存',
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为交互提供反馈
ZephyrStatusIndicator(
  type: ZephyrStatusType.error,
  onTap: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('查看错误详情')),
    );
  },
)

// ✅ 好的做法：确保足够的对比度
ZephyrStatusIndicator(
  type: ZephyrStatusType.warning,
  backgroundColor: Colors.orange[50],
  foregroundColor: Colors.orange[800],
)

// ❌ 避免的做法：缺乏语义信息
ZephyrStatusIndicator(
  type: ZephyrStatusType.info,
  // 缺乏无障碍支持
)
```

## 🔄 相关组件

- **ZephyrProgressIndicators**: 进度指示器组件
- **ZephyrToast**: 提示组件
- **ZephyrAlert**: 警告组件
- **ZephyrBadge**: 徽章组件
- **ZephyrChip**: 芯片组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种状态类型
- ✅ 支持自定义样式和动画
- ✅ 支持状态组
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/status_indicators/`
**示例路径**: `example/lib/components/status_indicators_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日