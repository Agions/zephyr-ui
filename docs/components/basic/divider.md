# ZephyrDivider 分割线组件

分割线组件是一个轻量级的 UI 元素，用于在内容之间创建视觉分隔。支持水平、垂直两种方向，并提供丰富的样式定制选项。

## 🎯 组件概述

### 特性
- **双方向支持**: 支持水平和垂直两种方向的分割线
- **丰富的样式定制**: 支持自定义颜色、厚度、缩进等
- **灵活的间距控制**: 支持上下或左右的间距设置
- **文本标签**: 支持带文本的分割线
- **主题适配**: 完整的主题系统支持
- **轻量级**: 极简的实现，性能优秀

### 适用场景
- 内容分组分隔
- 列表项分隔
- 表格单元格分隔
- 表单区域分隔
- 导航项分隔
- 卡片内容分隔

## 🚀 基础用法

### 水平分割线

```dart
Column(
  children: [
    Text('上半部分内容'),
    ZephyrDivider(),
    Text('下半部分内容'),
  ],
)
```

### 垂直分割线

```dart
Row(
  children: [
    Expanded(child: Text('左侧内容')),
    ZephyrDivider.vertical(),
    Expanded(child: Text('右侧内容')),
  ],
)
```

### 带间距的分割线

```dart
Column(
  children: [
    Text('内容 1'),
    ZephyrDivider(
      height: 32,  // 上下间距
    ),
    Text('内容 2'),
    ZephyrDivider(
      height: 48,  // 更大的上下间距
    ),
    Text('内容 3'),
  ],
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    Text('内容 1'),
    ZephyrDivider(), // 默认分割线
    Text('内容 2'),
    SizedBox(height: 16),
    Text('内容 3'),
    ZephyrDivider(
      color: Colors.blue,      // 自定义颜色
      thickness: 2,            // 自定义厚度
      indent: 20,              // 左侧缩进
      endIndent: 20,           // 右侧缩进
    ),
    Text('内容 4'),
  ],
)
```

### 垂直分割线样式

```dart
Row(
  children: [
    Expanded(child: Center(child: Text('左侧'))),
    ZephyrDivider.vertical(
      color: Colors.red,
      thickness: 3,
      height: 50,
    ),
    Expanded(child: Center(child: Text('中间'))),
    ZephyrDivider.vertical(
      color: Colors.green,
      thickness: 2,
      height: 30,
    ),
    Expanded(child: Center(child: Text('右侧'))),
  ],
)
```

### 带间距的分割线

```dart
Column(
  children: [
    Text('内容 1'),
    ZephyrDivider(
      height: 32,  // 上下间距
    ),
    Text('内容 2'),
    ZephyrDivider(
      height: 48,  // 更大的上下间距
    ),
    Text('内容 3'),
  ],
)
```


### 虚线分割线

```dart
Column(
  children: [
    Text('内容 1'),
    SizedBox(height: 16),
    // 使用自定义装饰创建虚线效果
    Container(
      height: 1,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CustomPaint(
        painter: DashedLinePainter(
          color: Colors.grey[400]!,
          dashWidth: 5,
          dashSpace: 3,
        ),
      ),
    ),
    SizedBox(height: 16),
    Text('内容 2'),
  ],
)

// 虚线绘制器
class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
```

## 🔧 高级用法

### 表格分割线

```dart
class TableWithDividers extends StatelessWidget {
  final List<List<String>> data;

  const TableWithDividers({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: data.asMap().entries.map((entry) {
          final rowIndex = entry.key;
          final row = entry.value;

          return Column(
            children: [
              // 行内容
              IntrinsicHeight(
                child: Row(
                  children: row.asMap().entries.map((cellEntry) {
                    final cellIndex = cellEntry.key;
                    final cell = cellEntry.value;

                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        child: Text(cell),
                      ),
                    );
                  }).expand((cell) => [
                    cell,
                    if (cellIndex < row.length - 1)
                      ZephyrDivider.vertical(),
                  ]).toList(),
                ),
              ),
              // 行间分割线
              if (rowIndex < data.length - 1)
                ZephyrDivider(
                  indent: 0,
                  endIndent: 0,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// 使用示例
TableWithDividers(
  data: [
    ['姓名', '年龄', '职业'],
    ['张三', '25', '工程师'],
    ['李四', '30', '设计师'],
    ['王五', '28', '产品经理'],
  ],
)
```

### 导航分隔符

```dart
class NavigationDivider extends StatelessWidget {
  final String title;
  final List<NavItem> items;

  const NavigationDivider({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        // 导航项
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                onTap: item.onTap,
              ),
              // 项间分割线
              if (index < items.length - 1)
                ZephyrDivider(
                  indent: 56,  // 缩进到图标后面
                  endIndent: 16,
                ),
            ],
          );
        }).toList(),
      ],
    );
  }
}

class NavItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const NavItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

// 使用示例
NavigationDivider(
  title: '主要功能',
  items: [
    NavItem(
      icon: Icons.home,
      title: '首页',
      onTap: () => _navigateToHome(),
    ),
    NavItem(
      icon: Icons.person,
      title: '个人中心',
      onTap: () => _navigateToProfile(),
    ),
    NavItem(
      icon: Icons.settings,
      title: '设置',
      onTap: () => _navigateToSettings(),
    ),
  ],
)
```

### 时间线分割线

```dart
class TimelineDivider extends StatelessWidget {
  final List<TimelineItem> items;

  const TimelineDivider({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 时间线
            Column(
              children: [
                // 时间点
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item.color ?? Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                // 垂直分割线
                if (index < items.length - 1)
                  Expanded(
                    child: ZephyrDivider.vertical(
                      color: Colors.grey[300],
                      thickness: 2,
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16),
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  if (index < items.length - 1) ...[
                    SizedBox(height: 16),
                    ZephyrDivider(
                      color: Colors.grey[200],
                    ),
                    SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class TimelineItem {
  final String title;
  final String subtitle;
  final Color? color;

  const TimelineItem({
    required this.title,
    required this.subtitle,
    this.color,
  });
}

// 使用示例
TimelineDivider(
  items: [
    TimelineItem(
      title: '订单创建',
      subtitle: '2024-01-01 10:00',
      color: Colors.green,
    ),
    TimelineItem(
      title: '订单确认',
      subtitle: '2024-01-01 10:30',
      color: Colors.blue,
    ),
    TimelineItem(
      title: '订单发货',
      subtitle: '2024-01-02 14:00',
      color: Colors.orange,
    ),
    TimelineItem(
      title: '订单完成',
      subtitle: '2024-01-03 16:00',
      color: Colors.green,
    ),
  ],
)
```

### 可隐藏分割线

```dart
class HideableDivider extends StatefulWidget {
  final bool isVisible;
  final Widget? child;
  final Duration animationDuration;

  const HideableDivider({
    Key? key,
    this.isVisible = true,
    this.child,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<HideableDivider> createState() => _HideableDividerState();
}

class _HideableDividerState extends State<HideableDivider> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.animationDuration,
      curve: Curves.easeInOut,
      child: widget.isVisible
          ? widget.child ?? ZephyrDivider()
          : SizedBox.shrink(),
    );
  }
}

// 使用示例
class ToggleableDividerDemo extends StatefulWidget {
  @override
  _ToggleableDividerDemoState createState() => _ToggleableDividerDemoState();
}

class _ToggleableDividerDemoState extends State<ToggleableDividerDemo> {
  bool _showDivider = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('上半部分内容'),
        HideableDivider(
          isVisible: _showDivider,
          child: ZephyrDivider(
            color: Colors.blue,
            thickness: 2,
          ),
        ),
        Text('下半部分内容'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showDivider = !_showDivider;
            });
          },
          child: Text(_showDivider ? '隐藏分割线' : '显示分割线'),
        ),
      ],
    );
  }
}
```

### 分组分割线

```dart
class GroupedDivider extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  const GroupedDivider({
    Key? key,
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 分组标题
        Padding(
          padding: padding,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        // 标题下的分割线
        ZephyrDivider(
          indent: padding.horizontal / 2,
          endIndent: padding.horizontal / 2,
        ),
        // 分组内容
        Padding(
          padding: padding,
          child: Column(
            children: children.asMap().entries.map((entry) {
              final index = entry.key;
              final child = entry.value;

              return Column(
                children: [
                  child,
                  if (index < children.length - 1) ...[
                    SizedBox(height: 12),
                    ZephyrDivider(
                      indent: padding.horizontal / 4,
                      endIndent: padding.horizontal / 4,
                    ),
                    SizedBox(height: 12),
                  ],
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// 使用示例
GroupedDivider(
  title: '用户设置',
  children: [
    ListTile(
      leading: Icon(Icons.person),
      title: Text('个人信息'),
      trailing: Icon(Icons.chevron_right),
      onTap: () => _navigateToProfile(),
    ),
    ListTile(
      leading: Icon(Icons.lock),
      title: Text('账号安全'),
      trailing: Icon(Icons.chevron_right),
      onTap: () => _navigateToSecurity(),
    ),
    ListTile(
      leading: Icon(Icons.notifications),
      title: Text('通知设置'),
      trailing: Icon(Icons.chevron_right),
      onTap: () => _navigateToNotifications(),
    ),
  ],
)
```

## 🎛️ API 参考

### 构造函数

#### ZephyrDivider.horizontal()

```dart
const ZephyrDivider.horizontal({
  Key? key,
  Color? color,
  double? thickness,
  double? indent,
  double? endIndent,
  ZephyrDividerTheme? theme,
  double? height,
})
```

**参数说明：**
- `color`: 分割线颜色
- `thickness`: 分割线厚度
- `indent`: 左侧缩进
- `endIndent`: 右侧缩进
- `theme`: 自定义主题
- `height`: 分割线高度（包含间距）

#### ZephyrDivider.vertical()

```dart
const ZephyrDivider.vertical({
  Key? key,
  Color? color,
  double? thickness,
  double? indent,
  double? endIndent,
  ZephyrDividerTheme? theme,
  double? width,
})
```

**参数说明：**
- `color`: 分割线颜色
- `thickness`: 分割线厚度
- `indent`: 顶部缩进
- `endIndent`: 底部缩进
- `theme`: 自定义主题
- `width`: 分割线宽度（包含间距）

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrDividerTheme(
        color: Colors.grey[300],
        thickness: 1.0,
        indent: 0.0,
        endIndent: 0.0,
        verticalSpacing: 16.0,
        horizontalSpacing: 16.0,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `color`: 默认分割线颜色
- `thickness`: 默认分割线厚度
- `indent`: 默认缩进
- `endIndent`: 默认终点缩进
- `verticalSpacing`: 垂直间距
- `horizontalSpacing`: 水平间距

## 🏆 最佳实践

### 1. 合理使用分割线

```dart
// ✅ 好的做法：在相关内容之间使用分割线
Column(
  children: [
    Text('标题'),
    SizedBox(height: 8),
    Text('描述内容'),
    SizedBox(height: 16),
    ZephyrDivider(),
    SizedBox(height: 16),
    Text('下一部分'),
  ],
)

// ✅ 在列表项之间使用分割线
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Column(
      children: [
        ListTile(
          title: Text(items[index].title),
        ),
        if (index < items.length - 1)
          ZephyrDivider(),
      ],
    );
  },
)

// ❌ 避免的做法：过度使用分割线
Column(
  children: [
    Text('内容 1'),
    ZephyrDivider(),  // 不必要的分割线
    Text('内容 2'),
    ZephyrDivider(),  // 不必要的分割线
    Text('内容 3'),
  ],
)
```

### 2. 适当的缩进

```dart
// ✅ 好的做法：在有缩进的内容中使用分割线
Column(
  children: [
    Padding(
      padding: EdgeInsets.all(16),
      child: Text('标题'),
    ),
    ZephyrDivider(
      indent: 16,   // 与内容对齐
      endIndent: 16,
    ),
    Padding(
      padding: EdgeInsets.all(16),
      child: Text('内容'),
    ),
  ],
)

// ✅ 在列表中为图标留出空间
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.star),
          title: Text(items[index].title),
        ),
        if (index < items.length - 1)
          ZephyrDivider(
            indent: 56,  // 缩进到图标后面
          ),
      ],
    );
  },
)

// ❌ 避免的做法：缩进不一致
ZephyrDivider(
  indent: 20,  // 与内容不对齐
  endIndent: 0,
)
```

### 3. 颜色和厚度

```dart
// ✅ 好的做法：使用适当的颜色和厚度
ZephyrDivider(
  color: Colors.grey[300],  // 柔和的颜色
  thickness: 1,            // 适当的厚度
)

// ✅ 在强调分隔时使用更明显的样式
ZephyrDivider(
  color: Colors.blue,
  thickness: 2,
)

// ❌ 避免的做法：使用过于突兀的样式
ZephyrDivider(
  color: Colors.red,     // 过于突兀
  thickness: 5,          // 过厚
)
```

### 4. 垂直分割线的使用

```dart
// ✅ 好的做法：在水平布局中使用垂直分割线
Row(
  children: [
    Expanded(child: Text('左侧')),
    ZephyrDivider.vertical(),
    Expanded(child: Text('右侧')),
  ],
)

// ✅ 在导航栏中使用垂直分割线
AppBar(
  title: Text('标题'),
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    ZephyrDivider.vertical(),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
)

// ❌ 避免的做法：在内容过多时使用垂直分割线
Row(
  children: [
    Expanded(
      child: Column(
        children: [
          Text('很长的内容 1'),
          Text('很长的内容 2'),
          Text('很长的内容 3'),
        ],
      ),
    ),
    ZephyrDivider.vertical(),  // 不适合长内容
    Expanded(
      child: Column(
        children: [
          Text('很长的内容 4'),
          Text('很长的内容 5'),
          Text('很长的内容 6'),
        ],
      ),
    ),
  ],
)
```

### 5. 性能优化

```dart
// ✅ 好的做法：使用简单的分割线
ZephyrDivider(),  // 简单高效

// ✅ 在列表中使用条件渲染
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Column(
      children: [
        ListTile(
          title: Text(items[index].title),
        ),
        // 只在需要时显示分割线
        if (index < items.length - 1 && _shouldShowDivider(index))
          ZephyrDivider(),
      ],
    );
  },
)

// ❌ 避免的做法：使用过于复杂的分割线装饰
ZephyrDivider(
  // 复杂的装饰可能影响性能
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.red, Colors.blue, Colors.green],
    ),
  ),
)
```

## 🔄 相关组件

- **ZephyrList**: 常与分割线配合使用
- **ZephyrCard**: 在卡片内部使用分割线
- **ZephyrTable**: 表格中的单元格分割
- **ZephyrNavigation**: 导航项之间的分隔
- **ZephyrForm**: 表单区域之间的分隔

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持水平和垂直分割线
- ✅ 完整的样式定制
- ✅ 主题系统支持
- ✅ 文本标签支持

---

**组件路径**: `lib/src/components/basic/divider/`
**示例路径**: `example/lib/components/divider_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日
