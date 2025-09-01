# ZephyrSwitch 开关组件

开关组件是一个现代化的切换控件，用于在两个状态之间进行切换。提供了流畅的动画效果和直观的交互体验，支持自定义样式和标签。

## 🎯 组件概述

### 特性
- **流畅动画**: 内置平滑的切换动画效果
- **直观交互**: 提供清晰的视觉反馈
- **自定义样式**: 支持自定义颜色、大小等样式
- **标签支持**: 支持前后标签和描述文本
- **状态管理**: 完整的启用、禁用状态支持
- **主题适配**: 完整的主题系统支持

### 适用场景
- 设置开关
- 功能启用/禁用
- 通知设置
- 主题切换
- 权限控制
- 状态切换

## 🚀 基础用法

### 基本开关

```dart
ZephyrSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
)
```

### 带标签的开关

```dart
ZephyrSwitch(
  label: '推送通知',
  value: _notificationsEnabled,
  onChanged: (value) => setState(() => _notificationsEnabled = value),
)
```

### 带描述的开关

```dart
ZephyrSwitch(
  label: '自动更新',
  description: '自动检查并安装应用更新',
  value: _autoUpdateEnabled,
  onChanged: (value) => setState(() => _autoUpdateEnabled = value),
)
```

### 禁用状态的开关

```dart
ZephyrSwitch(
  label: '系统功能',
  value: true,
  enabled: false,
  description: '此功能由系统管理员控制',
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrSwitch(
      label: '默认样式',
      value: _value1,
      onChanged: (value) => setState(() => _value1 = value),
    ),
    SizedBox(height: 16),
    ZephyrSwitch(
      label: '自定义颜色',
      value: _value2,
      activeColor: Colors.green,
      onChanged: (value) => setState(() => _value2 = value),
    ),
    SizedBox(height: 16),
    ZephyrSwitch(
      label: '大尺寸',
      value: _value3,
      size: 32,
      onChanged: (value) => setState(() => _value3 = value),
    ),
  ],
)
```

### 标签位置

```dart
Column(
  children: [
    ZephyrSwitch(
      label: '前置标签',
      value: _value1,
      labelPosition: ZephyrSwitchLabelPosition.leading,
      onChanged: (value) => setState(() => _value1 = value),
    ),
    SizedBox(height: 16),
    ZephyrSwitch(
      label: '后置标签',
      value: _value2,
      labelPosition: ZephyrSwitchLabelPosition.trailing,
      onChanged: (value) => setState(() => _value2 = value),
    ),
  ],
)
```

## 🔧 高级用法

### 设置页面开关组

```dart
class SettingsSwitches extends StatefulWidget {
  @override
  _SettingsSwitchesState createState() => _SettingsSwitchesState();
}

class _SettingsSwitchesState extends State<SettingsSwitches> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = false;
  bool _pushNotifications = true;
  bool _darkMode = false;
  bool _autoSync = true;
  bool _locationServices = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '通知设置',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ZephyrSwitch(
          label: '推送通知',
          description: '接收应用推送通知',
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
              if (!value) {
                _pushNotifications = false;
              }
            });
          },
        ),
        SizedBox(height: 12),
        ZephyrSwitch(
          label: '邮件通知',
          description: '接收邮件通知',
          value: _emailNotifications,
          enabled: _notificationsEnabled,
          onChanged: (value) => setState(() => _emailNotifications = value),
        ),
        SizedBox(height: 12),
        ZephyrSwitch(
          label: '推送通知',
          description: '接收推送通知',
          value: _pushNotifications,
          enabled: _notificationsEnabled,
          onChanged: (value) => setState(() => _pushNotifications = value),
        ),
        SizedBox(height: 24),
        Text(
          '外观设置',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ZephyrSwitch(
          label: '深色模式',
          description: '启用深色主题',
          value: _darkMode,
          onChanged: (value) => setState(() => _darkMode = value),
        ),
        SizedBox(height: 24),
        Text(
          '隐私设置',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ZephyrSwitch(
          label: '位置服务',
          description: '允许应用访问位置信息',
          value: _locationServices,
          onChanged: (value) => setState(() => _locationServices = value),
        ),
      ],
    );
  }
}
```

### 带图标的开关

```dart
class IconSwitch extends StatelessWidget {
  final String label;
  final String? description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;
  final Color? activeColor;

  const IconSwitch({
    Key? key,
    required this.label,
    this.description,
    required this.value,
    required this.onChanged,
    required this.icon,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: value ? (activeColor ?? Colors.blue).withOpacity(0.1) : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: value ? (activeColor ?? Colors.blue) : Colors.grey[600],
            size: 20,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (description != null)
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 16),
        ZephyrSwitch(
          value: value,
          activeColor: activeColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
```

### 带确认的开关

```dart
class ConfirmSwitch extends StatefulWidget {
  final String label;
  final String? description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? confirmMessage;

  const ConfirmSwitch({
    Key? key,
    required this.label,
    this.description,
    required this.value,
    required this.onChanged,
    this.confirmMessage,
  }) : super(key: key);

  @override
  _ConfirmSwitchState createState() => _ConfirmSwitchState();
}

class _ConfirmSwitchState extends State<ConfirmSwitch> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  Future<void> _handleChange(bool value) async {
    if (value != widget.value) {
      final shouldConfirm = await _showConfirmDialog();
      if (shouldConfirm) {
        setState(() => _currentValue = value);
        widget.onChanged(value);
      } else {
        setState(() => _currentValue = widget.value);
      }
    } else {
      setState(() => _currentValue = value);
      widget.onChanged(value);
    }
  }

  Future<bool> _showConfirmDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认操作'),
        content: Text(widget.confirmMessage ?? '确定要执行此操作吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('确定'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrSwitch(
      label: widget.label,
      description: widget.description,
      value: _currentValue,
      onChanged: _handleChange,
    );
  }
}
```

### 开关组卡片

```dart
class SwitchGroupCard extends StatelessWidget {
  final String title;
  final List<SwitchItem> items;

  const SwitchGroupCard({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ZephyrSwitch(
                  label: item.label,
                  description: item.description,
                  value: item.value,
                  onChanged: item.onChanged,
                  activeColor: item.activeColor,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class SwitchItem {
  final String label;
  final String? description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;

  SwitchItem({
    required this.label,
    this.description,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrSwitch()

```dart
const ZephyrSwitch({
  Key? key,
  String? label,
  String? description,
  bool value = false,
  ValueChanged<bool>? onChanged,
  bool enabled = true,
  Color? activeColor,
  Color? inactiveColor,
  Color? thumbColor,
  Color? activeThumbColor,
  double? size,
  ZephyrSwitchLabelPosition labelPosition = ZephyrSwitchLabelPosition.trailing,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? labelStyle,
  TextStyle? descriptionStyle,
  String? semanticLabel,
})
```

**参数说明：**
- `label`: 开关标签
- `description`: 描述文本
- `value`: 是否开启
- `onChanged`: 变化回调
- `enabled`: 是否启用
- `activeColor`: 开启时的轨道颜色
- `inactiveColor`: 关闭时的轨道颜色
- `thumbColor`: 滑块颜色
- `activeThumbColor`: 开启时的滑块颜色
- `size`: 开关大小
- `labelPosition`: 标签位置
- `contentPadding`: 内容内边距
- `labelStyle`: 标签样式
- `descriptionStyle`: 描述文本样式
- `semanticLabel`: 语义标签

### 枚举类型

#### ZephyrSwitchLabelPosition

```dart
enum ZephyrSwitchLabelPosition {
  leading,   // 标签在前
  trailing,  // 标签在后
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrSwitchTheme(
        activeColor: Colors.blue,
        inactiveColor: Colors.grey[300],
        thumbColor: Colors.white,
        activeThumbColor: Colors.white,
        disabledColor: Colors.grey[200],
        disabledActiveColor: Colors.grey[400],
        size: 24,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        descriptionStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `activeColor`: 开启时的轨道颜色
- `inactiveColor`: 关闭时的轨道颜色
- `thumbColor`: 滑块颜色
- `activeThumbColor`: 开启时的滑块颜色
- `disabledColor`: 禁用时的轨道颜色
- `disabledActiveColor`: 禁用且开启时的轨道颜色
- `size`: 开关大小
- `labelStyle`: 标签样式
- `descriptionStyle`: 描述文本样式
- `contentPadding`: 内容内边距

## 🏆 最佳实践

### 1. 清晰的状态标识

```dart
// ✅ 好的做法：标签明确表示开关状态
ZephyrSwitch(
  label: '启用通知',
  value: _notificationsEnabled,
  onChanged: (value) => setState(() => _notificationsEnabled = value),
)

// ✅ 好的做法：使用描述文本提供更多信息
ZephyrSwitch(
  label: '自动同步',
  description: '自动同步数据到云端',
  value: _autoSyncEnabled,
  onChanged: (value) => setState(() => _autoSyncEnabled = value),
)

// ❌ 避免的做法：标签不够明确
ZephyrSwitch(
  label: '通知',  // 不够明确
  value: _enabled,
  onChanged: (value) => setState(() => _enabled = value),
)
```

### 2. 合理的默认状态

```dart
// ✅ 好的做法：根据业务需求设置默认状态
ZephyrSwitch(
  label: '推送通知',
  value: true,  // 默认启用，用户可以选择关闭
  onChanged: (value) => _updateNotifications(value),
)

ZephyrSwitch(
  label: '实验性功能',
  value: false,  // 默认关闭，用户可以选择启用
  onChanged: (value) => _updateExperimentalFeatures(value),
)
```

### 3. 分组管理

```dart
// ✅ 好的做法：相关功能分组显示
Column(
  children: [
    Text('通知设置', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    ZephyrSwitch(
      label: '推送通知',
      value: _pushEnabled,
      onChanged: (value) => setState(() => _pushEnabled = value),
    ),
    ZephyrSwitch(
      label: '邮件通知',
      value: _emailEnabled,
      onChanged: (value) => setState(() => _emailEnabled = value),
    ),
    SizedBox(height: 24),
    Text('隐私设置', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    ZephyrSwitch(
      label: '位置服务',
      value: _locationEnabled,
      onChanged: (value) => setState(() => _locationEnabled = value),
    ),
  ],
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrSwitch(
  label: '深色模式',
  semanticLabel: '深色模式开关',
  value: _darkModeEnabled,
  onChanged: (value) => setState(() => _darkModeEnabled = value),
)

// ✅ 好的做法：提供状态变化的反馈
ZephyrSwitch(
  label: '自动更新',
  description: '自动检查并安装更新',
  value: _autoUpdateEnabled,
  onChanged: (value) {
    setState(() => _autoUpdateEnabled = value);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? '自动更新已启用' : '自动更新已禁用'),
      ),
    );
  },
)
```

## 🔄 相关组件

- **ZephyrCheckbox**: 复选框
- **ZephyrRadio**: 单选框
- **ZephyrToggle**: 切换按钮
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本开关功能
- ✅ 流畅的动画效果
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/form/switch/`
**示例路径**: `example/lib/components/switch_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日