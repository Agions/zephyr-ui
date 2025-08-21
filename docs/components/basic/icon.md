# ZephyrIcon 图标组件

ZephyrIcon 是一个遵循设计规范的图标组件，提供了预设的尺寸系统和状态样式，便于创建一致的图标效果。

## 🎯 组件概述

### 特性
- **预设尺寸系统**: 支持小、中、大三种标准尺寸
- **状态样式**: 提供正常、主要、次要、错误、警告、成功、信息、禁用八种状态
- **灵活定制**: 支持自定义颜色和尺寸
- **主题适配**: 完整的主题系统支持
- **无障碍支持**: 内置语义标签

### 适用场景
- 导航图标
- 操作按钮图标
- 状态指示图标
- 功能入口图标
- 装饰性图标

## 🚀 基础用法

### 标准图标

```dart
ZephyrIcon(
  Icons.home,
  size: ZephyrIconSize.medium,
  status: ZephyrIconStatus.normal,
)
```

### 尺寸变体

```dart
Row(
  children: [
    ZephyrIcon.small(Icons.home),
    SizedBox(width: 16),
    ZephyrIcon.medium(Icons.home),
    SizedBox(width: 16),
    ZephyrIcon.large(Icons.home),
  ],
)
```

### 状态变体

```dart
Row(
  children: [
    ZephyrIcon.primary(Icons.home),
    SizedBox(width: 16),
    ZephyrIcon.secondary(Icons.info),
    SizedBox(width: 16),
    ZephyrIcon.success(Icons.check_circle),
    SizedBox(width: 16),
    ZephyrIcon.warning(Icons.warning),
    SizedBox(width: 16),
    ZephyrIcon.error(Icons.error),
    SizedBox(width: 16),
    ZephyrIcon.disabled(Icons.home),
  ],
)
```

## 🎨 样式定制

### 自定义颜色和尺寸

```dart
Row(
  children: [
    ZephyrIcon(
      Icons.star,
      size: ZephyrIconSize.medium,
      color: Colors.amber,
    ),
    SizedBox(width: 16),
    ZephyrIcon(
      Icons.favorite,
      size: ZephyrIconSize.large,
      color: Colors.red,
      customSize: 36,  // 覆盖预设尺寸
    ),
  ],
)
```

### 语义化图标

```dart
ZephyrIcon(
  Icons.home,
  size: ZephyrIconSize.medium,
  semanticLabel: '返回首页',
)
```

## 🔧 高级用法

### 可点击图标包装

```dart
class ClickableIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final ZephyrIconSize size;
  final ZephyrIconStatus status;

  const ClickableIcon({
    Key? key,
    required this.icon,
    this.onTap,
    this.size = ZephyrIconSize.medium,
    this.status = ZephyrIconStatus.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[100],
        ),
        child: ZephyrIcon(
          icon,
          size: size,
          status: status,
        ),
      ),
    );
  }
}

// 使用示例
ClickableIcon(
  icon: Icons.search,
  onTap: () => _showSearch(),
  status: ZephyrIconStatus.primary,
)
```

### 状态图标切换

```dart
class ToggleIcon extends StatefulWidget {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final ZephyrIconStatus activeStatus;
  final ZephyrIconStatus inactiveStatus;
  final ValueChanged<bool>? onChanged;

  const ToggleIcon({
    Key? key,
    required this.activeIcon,
    required this.inactiveIcon,
    this.activeStatus = ZephyrIconStatus.primary,
    this.inactiveStatus = ZephyrIconStatus.normal,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ToggleIcon> createState() => _ToggleIconState();
}

class _ToggleIconState extends State<ToggleIcon> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
        widget.onChanged?.call(_isActive);
      },
      child: ZephyrIcon(
        _isActive ? widget.activeIcon : widget.inactiveIcon,
        size: ZephyrIconSize.medium,
        status: _isActive ? widget.activeStatus : widget.inactiveStatus,
      ),
    );
  }
}

// 使用示例
ToggleIcon(
  activeIcon: Icons.favorite,
  inactiveIcon: Icons.favorite_border,
  activeStatus: ZephyrIconStatus.error,
  onChanged: (isActive) => print('收藏状态: $isActive'),
)
```

### 图标组合

```dart
class IconWithBadge extends StatelessWidget {
  final IconData icon;
  final String badgeText;
  final ZephyrIconSize size;

  const IconWithBadge({
    Key? key,
    required this.icon,
    required this.badgeText,
    this.size = ZephyrIconSize.medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ZephyrIcon(icon, size: size),
        Positioned(
          right: -4,
          top: -4,
          child: ZephyrBadge(
            content: badgeText,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

// 使用示例
IconWithBadge(
  icon: Icons.notifications,
  badgeText: '3',
  size: ZephyrIconSize.large,
)
```

### 导航图标组

```dart
class NavigationIcons extends StatelessWidget {
  final List<NavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const NavigationIcons({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onItemSelected(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZephyrIcon(
                item.icon,
                size: ZephyrIconSize.medium,
                status: isSelected 
                    ? ZephyrIconStatus.primary 
                    : ZephyrIconStatus.normal,
              ),
              SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  color: isSelected 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  const NavigationItem({
    required this.icon,
    required this.label,
  });
}

// 使用示例
NavigationIcons(
  items: [
    NavigationItem(icon: Icons.home, label: '首页'),
    NavigationItem(icon: Icons.search, label: '搜索'),
    NavigationItem(icon: Icons.person, label: '我的'),
  ],
  selectedIndex: 0,
  onItemSelected: (index) => _navigateToIndex(index),
)
```

## 🎛️ API 参考

### 构造函数

#### ZephyrIcon()

```dart
const ZephyrIcon(
  this.icon, {
  Key? key,
  this.size = ZephyrIconSize.medium,
  this.status = ZephyrIconStatus.normal,
  this.color,
  this.customSize,
  this.semanticLabel,
  this.theme,
})
```

**参数说明：**
- `icon`: 要显示的图标（必填）
- `size`: 图标尺寸
- `status`: 图标状态
- `color`: 自定义颜色（覆盖状态颜色）
- `customSize`: 自定义尺寸（覆盖预设尺寸）
- `semanticLabel`: 语义标签
- `theme`: 自定义主题

#### 命名构造函数

##### ZephyrIcon.small()

```dart
factory ZephyrIcon.small(
  IconData icon, {
  Key? key,
  ZephyrIconStatus status = ZephyrIconStatus.normal,
  Color? color,
  String? semanticLabel,
  ZephyrIconTheme? theme,
})
```

##### ZephyrIcon.medium()

```dart
factory ZephyrIcon.medium(
  IconData icon, {
  Key? key,
  ZephyrIconStatus status = ZephyrIconStatus.normal,
  Color? color,
  String? semanticLabel,
  ZephyrIconTheme? theme,
})
```

##### ZephyrIcon.large()

```dart
factory ZephyrIcon.large(
  IconData icon, {
  Key? key,
  ZephyrIconStatus status = ZephyrIconStatus.normal,
  Color? color,
  String? semanticLabel,
  ZephyrIconTheme? theme,
})
```

##### 状态构造函数

```dart
factory ZephyrIcon.primary(IconData icon, {...})
factory ZephyrIcon.secondary(IconData icon, {...})
factory ZephyrIcon.error(IconData icon, {...})
factory ZephyrIcon.warning(IconData icon, {...})
factory ZephyrIcon.success(IconData icon, {...})
factory ZephyrIcon.info(IconData icon, {...})
factory ZephyrIcon.disabled(IconData icon, {...})
```

### 枚举类型

#### ZephyrIconSize

```dart
enum ZephyrIconSize {
  small,   // 小尺寸
  medium,  // 中尺寸（默认）
  large,   // 大尺寸
}
```

#### ZephyrIconStatus

```dart
enum ZephyrIconStatus {
  normal,    // 普通状态
  primary,   // 主色状态
  secondary, // 次要色状态
  error,     // 错误状态
  warning,   // 警告状态
  success,   // 成功状态
  info,      // 信息状态
  disabled,  // 禁用状态
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrIconTheme(
        defaultColor: Colors.black,
        primaryColor: Colors.blue,
        secondaryColor: Colors.grey[600],
        errorColor: Colors.red,
        warningColor: Colors.orange,
        successColor: Colors.green,
        infoColor: Colors.blue,
        disabledColor: Colors.grey[400],
        smallSize: 16.0,
        mediumSize: 24.0,
        largeSize: 32.0,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultColor`: 默认颜色
- `primaryColor`: 主色状态颜色
- `secondaryColor`: 次要色状态颜色
- `errorColor`: 错误状态颜色
- `warningColor`: 警告状态颜色
- `successColor`: 成功状态颜色
- `infoColor`: 信息状态颜色
- `disabledColor`: 禁用状态颜色
- `smallSize`: 小尺寸
- `mediumSize`: 中尺寸
- `largeSize`: 大尺寸

## 🏆 最佳实践

### 1. 选择合适的尺寸

```dart
// ✅ 好的做法：根据使用场景选择尺寸
// 导航栏使用中等尺寸
ZephyrIcon.medium(Icons.home)

// 按钮内使用小尺寸
ZephyrIcon.small(Icons.search)

// 状态指示使用小尺寸
ZephyrIcon.small(Icons.check_circle)

// ❌ 避免的做法：在不合适的场景使用过大尺寸
ZephyrIcon.large(Icons.home)  // 在导航栏中过于突兀
```

### 2. 状态颜色的使用

```dart
// ✅ 好的做法：基于语义选择状态
ZephyrIcon.success(Icons.check_circle)  // 成功状态
ZephyrIcon.error(Icons.error)           // 错误状态
ZephyrIcon.warning(Icons.warning)       // 警告状态
ZephyrIcon.info(Icons.info)             // 信息状态

// ✅ 主要操作使用主色
ZephyrIcon.primary(Icons.add)           // 添加操作
ZephyrIcon.primary(Icons.search)         // 搜索操作

// ❌ 避免的做法：滥用状态颜色
ZephyrIcon.error(Icons.home)  // 首页图标不应该使用错误状态
```

### 3. 语义化标签

```dart
// ✅ 好的做法：为图标添加语义标签
ZephyrIcon(
  Icons.home,
  semanticLabel: '返回首页',
)

// ✅ 为状态图标添加描述
ZephyrIcon(
  Icons.check_circle,
  status: ZephyrIconStatus.success,
  semanticLabel: '操作成功',
)

// ❌ 避免的做法：忽略语义标签
ZephyrIcon(Icons.search)  // 缺少语义描述
```

### 4. 性能优化

```dart
// ✅ 好的做法：使用 const 构造函数
const iconSize = ZephyrIconSize.medium;
const iconStatus = ZephyrIconStatus.normal;

ZephyrIcon(
  Icons.home,
  size: iconSize,
  status: iconStatus,
)

// ✅ 在列表中使用适当的图标
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      leading: ZephyrIcon.small(items[index].icon),
      title: Text(items[index].title),
    );
  },
)

// ❌ 避免的做法：在大量图标中使用复杂的装饰
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return Container(
      decoration: BoxDecoration(  // 过度装饰影响性能
        gradient: LinearGradient(...),
      ),
      child: ZephyrIcon(Icons.star),
    );
  },
)
```

### 5. 可访问性设计

```dart
// ✅ 好的做法：确保足够的对比度
ZephyrIcon(
  Icons.home,
  color: Colors.black,  // 在白色背景上对比度足够
)

// ✅ 为交互图标提供反馈
class AccessibleIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const AccessibleIconButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onPressed,
        child: ZephyrIcon(icon),
      ),
    );
  }
}

// ❌ 避免的做法：对比度不足
ZephyrIcon(
  Icons.home,
  color: Colors.grey[300],  // 在白色背景上对比度不够
)
```

## 🔄 相关组件

- **ZephyrButton**: 常与图标配合使用
- **ZephyrBadge**: 可在图标上添加徽章
- **ZephyrAvatar**: 图标与头像的组合
- **ZephyrChip**: 图标与标签的组合
- **ZephyrText**: 图标与文本的组合

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持三种预设尺寸
- ✅ 八种状态样式
- ✅ 完整的主题系统支持
- ✅ 语义化标签支持

---

**组件路径**: `lib/src/components/basic/icon/`
**示例路径**: `example/lib/components/icon_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日