# ZephyrBadge 徽章组件

徽章组件是一个轻量级的 UI 元素，用于显示计数、状态指示或标签信息。支持文本、数字和圆点三种模式，提供灵活的样式定制。

## 🎯 组件概述

### 特性
- **多种显示模式**: 支持文本、数字、圆点三种显示模式
- **数字计数**: 智能数字显示，支持最大值限制
- **灵活定位**: 支持四个角落的定位
- **样式定制**: 完整的颜色、边框、圆角等样式控制
- **主题适配**: 完整的主题系统支持
- **轻量级**: 极简的实现，性能优秀

### 适用场景
- 消息通知计数
- 购物车商品数量
- 用户状态指示
- 标签和分类
- 菜单项提示
- 数据统计展示

## 🚀 基础用法

### 文本徽章

```dart
ZephyrBadge(
  content: '新',
  backgroundColor: Colors.red,
  textColor: Colors.white,
)
```

### 数字徽章

```dart
ZephyrBadge.count(
  count: 5,
  maxCount: 99,
  backgroundColor: Colors.blue,
  textColor: Colors.white,
)
```

### 圆点徽章

```dart
ZephyrBadge.dot(
  backgroundColor: Colors.green,
)
```

## 🎨 样式定制

### 基础样式

```dart
Row(
  children: [
    ZephyrBadge(
      content: '默认',
    ),
    SizedBox(width: 8),
    ZephyrBadge(
      content: '自定义',
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    SizedBox(width: 8),
    ZephyrBadge(
      content: '边框',
      backgroundColor: Colors.white,
      textColor: Colors.red,
      borderWidth: 1,
      borderColor: Colors.red,
    ),
  ],
)
```

### 数字徽章变体

```dart
Row(
  children: [
    ZephyrBadge.count(count: 1),
    SizedBox(width: 8),
    ZephyrBadge.count(count: 9),
    SizedBox(width: 8),
    ZephyrBadge.count(count: 99),
    SizedBox(width: 8),
    ZephyrBadge.count(
      count: 100,
      maxCount: 99,
    ),
    SizedBox(width: 8),
    ZephyrBadge.count(
      count: 999,
      maxCount: 99,
    ),
  ],
)
```

### 颜色变体

```dart
Row(
  children: [
    ZephyrBadge(
      content: '默认',
    ),
    SizedBox(width: 8),
    ZephyrBadge(
      content: '成功',
      backgroundColor: Colors.green,
      textColor: Colors.white,
    ),
    SizedBox(width: 8),
    ZephyrBadge(
      content: '警告',
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    ),
    SizedBox(width: 8),
    ZephyrBadge(
      content: '错误',
      backgroundColor: Colors.red,
      textColor: Colors.white,
    ),
    SizedBox(width: 8),
    ZephyrBadge(
      content: '信息',
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    ),
  ],
)
```

### 圆点徽章

```dart
Row(
  children: [
    ZephyrBadge.dot(),
    SizedBox(width: 8),
    ZephyrBadge.dot(backgroundColor: Colors.green),
    SizedBox(width: 8),
    ZephyrBadge.dot(backgroundColor: Colors.orange),
    SizedBox(width: 8),
    ZephyrBadge.dot(backgroundColor: Colors.red),
    SizedBox(width: 8),
    ZephyrBadge.dot(
      backgroundColor: Colors.blue,
      borderWidth: 1,
      borderColor: Colors.blue,
    ),
  ],
)
```

## 🔧 高级用法

### 带徽章的图标

```dart
class BadgedIcon extends StatelessWidget {
  final IconData icon;
  final int? badgeCount;
  final VoidCallback? onTap;

  const BadgedIcon({
    Key? key,
    required this.icon,
    this.badgeCount,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onTap,
        ),
        if (badgeCount != null && badgeCount! > 0)
          Positioned(
            right: -6,
            top: -6,
            child: ZephyrBadge.count(
              count: badgeCount!,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
          ),
      ],
    );
  }
}

// 使用示例
BadgedIcon(
  icon: Icons.notifications,
  badgeCount: 3,
  onTap: () => _showNotifications(),
)
```

### 带徽章的列表项

```dart
class BadgedListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback? onTap;

  const BadgedListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    this.badge,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.inbox),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: badge != null
          ? ZephyrBadge(
              content: badge!,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            )
          : null,
      onTap: onTap,
    );
  }
}

// 使用示例
BadgedListItem(
  title: '收件箱',
  subtitle: '5 封未读邮件',
  badge: '5',
  onTap: () => _openInbox(),
)
```

### 徽章包装器

```dart
class BadgeWrapper extends StatelessWidget {
  final Widget child;
  final String? badgeContent;
  final int? badgeCount;
  final ZephyrBadgePosition position;
  final Color? badgeColor;

  const BadgeWrapper({
    Key? key,
    required this.child,
    this.badgeContent,
    this.badgeCount,
    this.position = ZephyrBadgePosition.topRight,
    this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (badgeContent != null || badgeCount != null)
          _buildBadge(),
      ],
    );
  }

  Widget _buildBadge() {
    Widget badge;

    if (badgeCount != null) {
      badge = ZephyrBadge.count(
        count: badgeCount!,
        maxCount: 99,
        backgroundColor: badgeColor ?? Colors.red,
        textColor: Colors.white,
      );
    } else if (badgeContent != null) {
      badge = ZephyrBadge(
        content: badgeContent!,
        backgroundColor: badgeColor ?? Colors.red,
        textColor: Colors.white,
      );
    } else {
      badge = ZephyrBadge.dot(
        backgroundColor: badgeColor ?? Colors.red,
      );
    }

    return Positioned(
      right: _getHorizontalOffset(),
      top: _getVerticalOffset(),
      child: badge,
    );
  }

  double _getHorizontalOffset() {
    switch (position) {
      case ZephyrBadgePosition.topRight:
      case ZephyrBadgePosition.bottomRight:
        return -6;
      case ZephyrBadgePosition.topLeft:
      case ZephyrBadgePosition.bottomLeft:
        return 0;
    }
  }

  double _getVerticalOffset() {
    switch (position) {
      case ZephyrBadgePosition.topRight:
      case ZephyrBadgePosition.topLeft:
        return -6;
      case ZephyrBadgePosition.bottomRight:
      case ZephyrBadgePosition.bottomLeft:
        return 0;
    }
  }
}

// 使用示例
BadgeWrapper(
  badgeCount: 3,
  child: ElevatedButton(
    onPressed: () {},
    child: Text('通知'),
  ),
)
```

### 状态指示器

```dart
class StatusIndicator extends StatelessWidget {
  final String label;
  final String status;
  final Color statusColor;

  const StatusIndicator({
    Key? key,
    required this.label,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZephyrBadge.dot(
              backgroundColor: statusColor,
            ),
            const SizedBox(width: 4),
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 使用示例
Column(
  children: [
    StatusIndicator(
      label: '服务器状态',
      status: '在线',
      statusColor: Colors.green,
    ),
    SizedBox(height: 8),
    StatusIndicator(
      label: '数据库状态',
      status: '维护中',
      statusColor: Colors.orange,
    ),
    SizedBox(height: 8),
    StatusIndicator(
      label: 'API 状态',
      status: '离线',
      statusColor: Colors.red,
    ),
  ],
)
```

### 动态徽章

```dart
class DynamicBadge extends StatefulWidget {
  final Widget child;
  final Stream<int> countStream;

  const DynamicBadge({
    Key? key,
    required this.child,
    required this.countStream,
  }) : super(key: key);

  @override
  _DynamicBadgeState createState() => _DynamicBadgeState();
}

class _DynamicBadgeState extends State<DynamicBadge> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    widget.countStream.listen((count) {
      setState(() {
        _count = count;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BadgeWrapper(
      badgeCount: _count > 0 ? _count : null,
      child: widget.child,
    );
  }
}

// 使用示例
DynamicBadge(
  countStream: _notificationCountStream,
  child: Icon(Icons.notifications),
)
```

## 🎛️ API 参考

### 构造函数

#### ZephyrBadge()

```dart
const ZephyrBadge({
  Key? key,
  required String content,
  Color? backgroundColor,
  Color? textColor,
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? padding,
  double? borderWidth,
  Color? borderColor,
})
```

**参数说明：**
- `content`: 徽章显示的文本内容（必填）
- `backgroundColor`: 背景颜色
- `textColor`: 文本颜色
- `borderRadius`: 边框圆角
- `padding`: 内边距
- `borderWidth`: 边框宽度
- `borderColor`: 边框颜色

#### ZephyrBadge.count()

```dart
const ZephyrBadge.count({
  Key? key,
  required int count,
  int? maxCount,
  Color? backgroundColor,
  Color? textColor,
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? padding,
  double? borderWidth,
  Color? borderColor,
})
```

**参数说明：**
- `count`: 徽章显示的数字（必填）
- `maxCount`: 最大显示值，超过时显示为 "maxCount+"
- 其他参数同标准徽章

#### ZephyrBadge.dot()

```dart
const ZephyrBadge.dot({
  Key? key,
  Color? backgroundColor,
  BorderRadius? borderRadius,
  double? borderWidth,
  Color? borderColor,
})
```

**参数说明：**
- `backgroundColor`: 圆点颜色
- `borderRadius`: 圆点圆角（默认为圆形）
- `borderWidth`: 边框宽度
- `borderColor`: 边框颜色

### 枚举类型

#### ZephyrBadgePosition

```dart
enum ZephyrBadgePosition {
  topRight,   // 右上角
  topLeft,    // 左上角
  bottomRight,// 右下角
  bottomLeft, // 左下角
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrThemeData(
        badgeTheme: ZephyrBadgeTheme(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          borderWidth: 0,
          borderColor: Colors.transparent,
        ),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `backgroundColor`: 默认背景颜色
- `textColor`: 默认文本颜色
- `borderRadius`: 默认边框圆角
- `padding`: 默认内边距
- `borderWidth`: 默认边框宽度
- `borderColor`: 默认边框颜色

## 🏆 最佳实践

### 1. 数字徽章的使用

```dart
// ✅ 好的做法：设置合理的最大值
ZephyrBadge.count(
  count: messageCount,
  maxCount: 99,
)

// ✅ 好的做法：对于大量数据，使用更大的最大值
ZephyrBadge.count(
  count: productCount,
  maxCount: 999,
)

// ❌ 避免的做法：不设置最大值
ZephyrBadge.count(
  count: 1000,  // 可能显示为很长的数字
)
```

### 2. 颜色选择

```dart
// ✅ 基于语义选择颜色
ZephyrBadge(
  content: '错误',
  backgroundColor: Colors.red,
)

ZephyrBadge(
  content: '成功',
  backgroundColor: Colors.green,
)

ZephyrBadge(
  content: '警告',
  backgroundColor: Colors.orange,
)

// ✅ 确保对比度足够
ZephyrBadge(
  content: '标签',
  backgroundColor: Colors.blue,
  textColor: Colors.white,
)

// ❌ 避免对比度不足
ZephyrBadge(
  content: '标签',
  backgroundColor: Colors.grey[300]!,
  textColor: Colors.grey[400]!,  // 对比度不够
)
```

### 3. 徽章位置

```dart
// ✅ 合理的徽章位置
Stack(
  children: [
    Icon(Icons.notifications),
    Positioned(
      right: -6,  // 稍微超出边界
      top: -6,
      child: ZephyrBadge.count(count: 3),
    ),
  ],
)

// ❌ 徽章位置过于偏移
Stack(
  children: [
    Icon(Icons.notifications),
    Positioned(
      right: -20,  // 过于偏移
      top: -20,
      child: ZephyrBadge.count(count: 3),
    ),
  ],
)
```

### 4. 性能优化

```dart
// ✅ 避免不必要的重建
class OptimizedBadge extends StatelessWidget {
  final int count;

  const OptimizedBadge({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BadgeWrapper(
      badgeCount: count > 0 ? count : null,  // 零值时不显示徽章
      child: Icon(Icons.notifications),
    );
  }
}

// ✅ 使用常量样式
const badgeStyle = ZephyrBadgeStyle(
  backgroundColor: Colors.red,
  textColor: Colors.white,
);

ZephyrBadge(
  content: '新',
  style: badgeStyle,
)
```

### 5. 无障碍设计

```dart
// ✅ 添加语义信息
Semantics(
  label: '通知，有 3 条未读消息',
  child: BadgeWrapper(
    badgeCount: 3,
    child: Icon(Icons.notifications),
  ),
)

// ✅ 为状态指示器添加描述
Semantics(
  label: '服务器状态：在线',
  child: StatusIndicator(
    label: '服务器',
    status: '在线',
    statusColor: Colors.green,
  ),
)
```

## 🔄 相关组件

- **ZephyrAvatar**: 常与徽章组件配合使用
- **ZephyrIcon**: 图标上添加徽章
- **ZephyrButton**: 按钮上添加徽章
- **ZephyrList**: 列表项中使用徽章

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持文本、数字、圆点三种模式
- ✅ 完整的样式定制
- ✅ 主题系统支持
- ✅ 灵活的定位选项

---

**组件路径**: `lib/src/components/basic/badge/`
**示例路径**: `example/lib/components/badge_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日
