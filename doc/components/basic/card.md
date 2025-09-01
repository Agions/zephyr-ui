# ZephyrCard 卡片组件

卡片组件是一个多功能的内容容器，支持多种视觉样式变体，包括标准、扁平、高阴影、填充和轮廓样式。卡片可以包含任何内容，并提供丰富的交互支持。

## 🎯 组件概述

### 特性
- **多种视觉变体**: 支持标准、扁平、高阴影、填充、轮廓五种样式
- **完整的交互支持**: 支持点击、长按、悬停等交互事件
- **灵活的样式定制**: 支持自定义颜色、阴影、边框、圆角等
- **响应式设计**: 支持悬停效果和状态变化
- **无障碍支持**: 完整的语义化标签和键盘导航
- **主题适配**: 完整的主题系统支持

### 适用场景
- 内容展示卡片
- 用户信息卡片
- 产品展示卡片
- 设置项卡片
- 数据统计卡片
- 交互式卡片列表

## 🚀 基础用法

### 标准卡片

```dart
ZephyrCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '卡片标题',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text('这是卡片的内容描述，可以包含任何文本或组件。'),
      ],
    ),
  ),
  onTap: () => print('卡片被点击'),
)
```

### 扁平卡片

```dart
ZephyrCard.flat(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('这是一个扁平卡片，没有阴影效果'),
  ),
  onTap: () => print('扁平卡片被点击'),
)
```

### 高阴影卡片

```dart
ZephyrCard.elevated(
  elevation: 8,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('这是一个高阴影卡片'),
  ),
  onTap: () => print('高阴影卡片被点击'),
)
```

### 填充卡片

```dart
ZephyrCard.filled(
  backgroundColor: Colors.blue[50],
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('这是一个填充卡片，有背景色'),
  ),
)
```

### 轮廓卡片

```dart
ZephyrCard.outlined(
  borderColor: Colors.blue,
  borderWidth: 2,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('这是一个轮廓卡片，只有边框'),
  ),
)
```

## 🎨 样式定制

### 基础样式

```dart
Column(
  children: [
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('默认卡片'),
      ),
    ),
    SizedBox(height: 16),
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('自定义背景色'),
      ),
      backgroundColor: Colors.blue[50],
    ),
    SizedBox(height: 16),
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('自定义圆角'),
      ),
      borderRadius: BorderRadius.circular(16),
    ),
  ],
)
```

### 阴影效果

```dart
Column(
  children: [
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('无阴影'),
      ),
      elevation: 0,
    ),
    SizedBox(height: 16),
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('轻微阴影'),
      ),
      elevation: 2,
    ),
    SizedBox(height: 16),
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('中等阴影'),
      ),
      elevation: 4,
    ),
    SizedBox(height: 16),
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('深阴影'),
      ),
      elevation: 8,
    ),
  ],
)
```

### 边框样式

```dart
Column(
  children: [
    ZephyrCard.outlined(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('默认边框'),
      ),
    ),
    SizedBox(height: 16),
    ZephyrCard.outlined(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('蓝色边框'),
      ),
      borderColor: Colors.blue,
      borderWidth: 2,
    ),
    SizedBox(height: 16),
    ZephyrCard.outlined(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('圆角边框'),
      ),
      borderRadius: BorderRadius.circular(12),
      borderColor: Colors.green,
      borderWidth: 2,
    ),
  ],
)
```

### 尺寸定制

```dart
Column(
  children: [
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('固定宽度'),
      ),
      width: 200,
    ),
    SizedBox(height: 16),
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('固定高度'),
      ),
      height: 100,
    ),
    SizedBox(height: 16),
    ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('固定尺寸'),
      ),
      width: 200,
      height: 150,
    ),
  ],
)
```

## 🔧 高级用法

### 用户信息卡片

```dart
class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String avatar;
  final VoidCallback? onTap;

  const UserCard({
    Key? key,
    required this.name,
    required this.email,
    required this.avatar,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            ZephyrAvatar.image(
              image: AssetImage(avatar),
              size: ZephyrAvatarSize.large,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

// 使用示例
UserCard(
  name: '张三',
  email: 'zhangsan@example.com',
  avatar: 'assets/images/user1.jpg',
  onTap: () => _showUserProfile(),
)
```

### 产品卡片

```dart
class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String image;
  final VoidCallback? onAddToCart;

  const ProductCard({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrCard.elevated(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 产品图片
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '¥$price',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onAddToCart,
                      child: Text('加入购物车'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 使用示例
ProductCard(
  name: '无线耳机',
  description: '高品质无线蓝牙耳机，降噪功能',
  price: 299.99,
  image: 'assets/images/product1.jpg',
  onAddToCart: () => _addToCart(),
)
```

### 设置项卡片

```dart
class SettingItemCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;

  const SettingItemCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      onTap: enabled ? onTap : null,
      enabled: enabled,
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing ?? Icon(Icons.chevron_right),
        enabled: enabled,
      ),
    );
  }
}

// 使用示例
Column(
  children: [
    SettingItemCard(
      title: '账号设置',
      subtitle: '管理您的账号信息',
      onTap: () => _navigateToAccountSettings(),
    ),
    SizedBox(height: 8),
    SettingItemCard(
      title: '通知设置',
      subtitle: '管理推送通知',
      onTap: () => _navigateToNotificationSettings(),
    ),
    SizedBox(height: 8),
    SettingItemCard(
      title: '隐私设置',
      subtitle: '管理隐私选项',
      onTap: () => _navigateToPrivacySettings(),
    ),
    SizedBox(height: 8),
    SettingItemCard(
      title: '关于',
      subtitle: '版本 1.0.0',
      onTap: () => _showAbout(),
    ),
  ],
)
```

### 统计卡片

```dart
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? change;
  final Color? color;
  final IconData? icon;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    this.change,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                if (icon != null)
                  Icon(
                    icon,
                    color: color ?? Colors.blue,
                    size: 20,
                  ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black,
              ),
            ),
            if (change != null) ...[
              SizedBox(height: 8),
              Text(
                change!,
                style: TextStyle(
                  fontSize: 12,
                  color: change!.startsWith('+') ? Colors.green : Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// 使用示例
Row(
  children: [
    Expanded(
      child: StatCard(
        title: '总用户',
        value: '1,234',
        change: '+12%',
        icon: Icons.people,
        color: Colors.blue,
      ),
    ),
    SizedBox(width: 16),
    Expanded(
      child: StatCard(
        title: '销售额',
        value: '¥56,789',
        change: '+8%',
        icon: Icons.attach_money,
        color: Colors.green,
      ),
    ),
    SizedBox(width: 16),
    Expanded(
      child: StatCard(
        title: '订单数',
        value: '89',
        change: '-3%',
        icon: Icons.shopping_cart,
        color: Colors.orange,
      ),
    ),
  ],
)
```

### 可折叠卡片

```dart
class ExpandableCard extends StatefulWidget {
  final String title;
  final Widget content;
  final bool initiallyExpanded;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            Divider(),
            Padding(
              padding: EdgeInsets.all(16),
              child: widget.content,
            ),
          ],
        ],
      ),
    );
  }
}

// 使用示例
ExpandableCard(
  title: '详细信息',
  initiallyExpanded: true,
  content: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('这是可展开的内容区域'),
      SizedBox(height: 8),
      Text('可以包含任何组件'),
      SizedBox(height: 8),
      Text('例如列表、表单等'),
    ],
  ),
)
```

## 🎛️ API 参考

### 构造函数

#### ZephyrCard()

```dart
const ZephyrCard({
  Key? key,
  Widget? child,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? shadowColor,
  Color? surfaceTintColor,
  double? elevation,
  BorderRadius? borderRadius,
  double? borderWidth,
  Color? borderColor,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  double? width,
  double? height,
  Clip clipBehavior = Clip.antiAlias,
  ZephyrCardVariant variant = ZephyrCardVariant.standard,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  ValueChanged<bool>? onHover,
  String? semanticLabel,
  bool enabled = true,
  Color? splashColor,
  Color? highlightColor,
  FocusNode? focusNode,
  bool autofocus = false,
})
```

**参数说明：**
- `child`: 卡片内容
- `backgroundColor`: 背景颜色
- `foregroundColor`: 前景颜色
- `shadowColor`: 阴影颜色
- `surfaceTintColor`: 表面色调
- `elevation`: 阴影高度
- `borderRadius`: 边框圆角
- `borderWidth`: 边框宽度
- `borderColor`: 边框颜色
- `padding`: 内边距
- `margin`: 外边距
- `width`: 宽度
- `height`: 高度
- `clipBehavior`: 裁剪行为
- `variant`: 卡片变体
- `onTap`: 点击回调
- `onLongPress`: 长按回调
- `onHover`: 悬停回调
- `semanticLabel`: 语义标签
- `enabled`: 是否启用
- `splashColor`: 水波纹颜色
- `highlightColor`: 高亮颜色
- `focusNode`: 焦点节点
- `autofocus`: 是否自动获取焦点

#### 命名构造函数

##### ZephyrCard.flat()

```dart
factory ZephyrCard.flat({
  Key? key,
  Widget? child,
  Color? backgroundColor,
  Color? foregroundColor,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? borderColor,
  double? borderWidth,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  ValueChanged<bool>? onHover,
  String? semanticLabel,
  FocusNode? focusNode,
  bool autofocus = false,
  bool enabled = true,
})
```

##### ZephyrCard.elevated()

```dart
factory ZephyrCard.elevated({
  Key? key,
  Widget? child,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? shadowColor,
  Color? surfaceTintColor,
  double? elevation,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  ValueChanged<bool>? onHover,
  String? semanticLabel,
  FocusNode? focusNode,
  bool autofocus = false,
  bool enabled = true,
})
```

##### ZephyrCard.filled()

```dart
factory ZephyrCard.filled({
  Key? key,
  Widget? child,
  Color? backgroundColor,
  Color? foregroundColor,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  ValueChanged<bool>? onHover,
  String? semanticLabel,
  FocusNode? focusNode,
  bool autofocus = false,
  bool enabled = true,
})
```

##### ZephyrCard.outlined()

```dart
factory ZephyrCard.outlined({
  Key? key,
  Widget? child,
  Color? backgroundColor,
  Color? foregroundColor,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? borderColor,
  double? borderWidth,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  ValueChanged<bool>? onHover,
  String? semanticLabel,
  FocusNode? focusNode,
  bool autofocus = false,
  bool enabled = true,
})
```

### 枚举类型

#### ZephyrCardVariant

```dart
enum ZephyrCardVariant {
  standard,  // 标准卡片
  flat,      // 扁平卡片
  elevated,  // 高阴影卡片
  filled,   // 填充卡片
  outlined,  // 轮廓卡片
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrCardTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(8.0),
        borderWidth: 1.0,
        borderColor: Colors.grey,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.zero,
        hoverElevationDelta: 2.0,
        pressedOpacity: 0.8,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.easeInOut,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `backgroundColor`: 默认背景颜色
- `foregroundColor`: 默认前景颜色
- `shadowColor`: 默认阴影颜色
- `elevation`: 默认阴影高度
- `borderRadius`: 默认边框圆角
- `borderWidth`: 默认边框宽度
- `borderColor`: 默认边框颜色
- `padding`: 默认内边距
- `margin`: 默认外边距
- `hoverElevationDelta`: 悬停时阴影增量
- `pressedOpacity`: 按下时透明度
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线

## 🏆 最佳实践

### 1. 选择合适的卡片变体

```dart
// ✅ 好的做法：根据场景选择合适的变体
// 内容展示使用标准卡片
ZephyrCard(
  child: Text('内容展示'),
)

// 设置项使用扁平卡片
ZephyrCard.flat(
  child: Text('设置项'),
)

// 重要内容使用高阴影卡片
ZephyrCard.elevated(
  child: Text('重要内容'),
  elevation: 4,
)

// ❌ 避免的做法：在不合适的场景使用高阴影
ZephyrCard.elevated(
  child: Text('简单的设置项'),  // 过于突兀
  elevation: 8,
)
```

### 2. 合理的内边距

```dart
// ✅ 好的做法：根据内容密度设置内边距
// 简单内容使用中等内边距
ZephyrCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('简单内容'),
  ),
)

// 复杂内容使用较大的内边距
ZephyrCard(
  child: Padding(
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Text('标题'),
        SizedBox(height: 16),
        Text('详细内容'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: Text('操作'),
        ),
      ],
    ),
  ),
)

// ❌ 避免的做法：内边距过大或过小
ZephyrCard(
  child: Padding(
    padding: EdgeInsets.all(4),  // 过小
    child: Text('内容'),
  ),
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：在列表中使用适当的卡片
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ZephyrCard.flat(
      child: ListTile(
        title: Text(items[index].title),
        subtitle: Text(items[index].subtitle),
      ),
    );
  },
)

// ✅ 使用 const 构造函数
const cardStyle = ZephyrCardVariant.elevated;

ZephyrCard(
  variant: cardStyle,
  child: Text('内容'),
)

// ❌ 避免的做法：在列表中使用复杂的阴影效果
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ZephyrCard.elevated(
      elevation: 8,  // 影响列表滚动性能
      child: Text(items[index].title),
    );
  },
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrCard(
  semanticLabel: '用户信息卡片',
  onTap: () => _showUserProfile(),
  child: Text('用户信息'),
)

// ✅ 为可点击卡片添加适当的提示
ZephyrCard(
  onTap: () => _openSettings(),
  child: Semantics(
    button: true,
    hint: '双击打开设置',
    child: Text('设置'),
  ),
)

// ❌ 避免的做法：忽略无障碍功能
ZephyrCard(
  onTap: () => _handleAction(),  // 缺少语义标签
  child: Text('操作'),
)
```

### 5. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整卡片布局
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      // 平板或桌面布局
      return Row(
        children: [
          Expanded(
            child: ZephyrCard(child: Text('卡片1')),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ZephyrCard(child: Text('卡片2')),
          ),
        ],
      );
    } else {
      // 手机布局
      return Column(
        children: [
          ZephyrCard(child: Text('卡片1')),
          SizedBox(height: 16),
          ZephyrCard(child: Text('卡片2')),
        ],
      );
    }
  },
)

// ❌ 避免的做法：固定宽度不适应不同屏幕
ZephyrCard(
  width: 800,  // 在手机上可能超出屏幕
  child: Text('内容'),
)
```

## 🔄 相关组件

- **ZephyrAvatar**: 常在卡片中用于显示用户头像
- **ZephyrBadge**: 可在卡片上添加徽章信息
- **ZephyrList**: 用于创建卡片列表
- **ZephyrButton**: 在卡片中作为操作按钮
- **ZephyrText**: 卡片中的文本内容

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持 5 种卡片变体
- ✅ 完整的样式定制
- ✅ 交互支持
- ✅ 主题系统支持

---

**组件路径**: `lib/src/components/basic/card/`
**示例路径**: `example/lib/components/card_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日
