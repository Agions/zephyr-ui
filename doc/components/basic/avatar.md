# ZephyrAvatar 头像组件

头像组件用于展示用户或实体的图像标识，支持图片、文字和图标三种模式，以及圆形、方形两种形状。

## 🎯 组件概述

### 特性
- **多种展示模式**: 支持图片、文字、图标三种内容模式
- **灵活的尺寸**: 提供 5 种预设尺寸（超小、小、中、大、超大）
- **多种形状**: 支持圆形和方形（圆角）两种形状
- **自定义样式**: 支持自定义背景色、前景色、边框等
- **交互支持**: 支持点击事件，可用作用户头像入口
- **主题适配**: 完整的主题系统支持

### 适用场景
- 用户头像展示
- 用户列表中的头像
- 评论和消息中的用户标识
- 团队成员展示
- 用户资料页面
- 导航菜单中的用户头像

## 🚀 基础用法

### 图片头像

```dart
ZephyrAvatar.image(
  image: AssetImage('assets/images/user1.jpg'),
  size: ZephyrAvatarSize.medium,
  onTap: () => _showUserProfile(),
)
```

### 文字头像

```dart
ZephyrAvatar.text(
  text: '张三',
  size: ZephyrAvatarSize.large,
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
)
```

### 图标头像

```dart
ZephyrAvatar.icon(
  icon: Icons.person,
  size: ZephyrAvatarSize.medium,
  backgroundColor: Colors.green,
  foregroundColor: Colors.white,
)
```

### 基础头像

```dart
ZephyrAvatar(
  child: Icon(Icons.person, size: 24),
  size: ZephyrAvatarSize.medium,
  backgroundColor: Colors.purple,
  onTap: () => _showUserProfile(),
)
```

## 🎨 样式定制

### 尺寸变体

```dart
Row(
  children: [
    ZephyrAvatar.text(
      text: 'XS',
      size: ZephyrAvatarSize.extraSmall,
    ),
    SizedBox(width: 8),
    ZephyrAvatar.text(
      text: 'S',
      size: ZephyrAvatarSize.small,
    ),
    SizedBox(width: 8),
    ZephyrAvatar.text(
      text: 'M',
      size: ZephyrAvatarSize.medium,
    ),
    SizedBox(width: 8),
    ZephyrAvatar.text(
      text: 'L',
      size: ZephyrAvatarSize.large,
    ),
    SizedBox(width: 8),
    ZephyrAvatar.text(
      text: 'XL',
      size: ZephyrAvatarSize.extraLarge,
    ),
  ],
)
```

### 形状变体

```dart
Row(
  children: [
    ZephyrAvatar.text(
      text: '圆',
      shape: ZephyrAvatarShape.circle,
    ),
    SizedBox(width: 16),
    ZephyrAvatar.text(
      text: '方',
      shape: ZephyrAvatarShape.square,
    ),
  ],
)
```

### 边框和阴影

```dart
ZephyrAvatar.text(
  text: '边框',
  size: ZephyrAvatarSize.large,
  borderWidth: 2,
  borderColor: Colors.blue,
  elevation: 4,
  shadowColor: Colors.blue.withOpacity(0.3),
)
```

### 自定义颜色

```dart
Row(
  children: [
    ZephyrAvatar.text(
      text: 'A',
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
    SizedBox(width: 8),
    ZephyrAvatar.text(
      text: 'B',
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    SizedBox(width: 8),
    ZephyrAvatar.text(
      text: 'C',
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    SizedBox(width: 8),
    ZephyrAvatar.text(
      text: 'D',
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
  ],
)
```

## 🔧 高级用法

### 用户列表中的头像

```dart
class UserList extends StatelessWidget {
  final List<User> users = [
    User(name: '张三', avatar: 'assets/images/user1.jpg'),
    User(name: '李四', avatar: null),
    User(name: '王五', avatar: 'assets/images/user3.jpg'),
    User(name: '赵六', avatar: null),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: user.avatar != null
              ? ZephyrAvatar.image(
                  image: AssetImage(user.avatar!),
                  size: ZephyrAvatarSize.medium,
                  onTap: () => _showUserProfile(user),
                )
              : ZephyrAvatar.text(
                  text: user.name,
                  size: ZephyrAvatarSize.medium,
                  onTap: () => _showUserProfile(user),
                ),
          title: Text(user.name),
          subtitle: Text('用户简介...'),
          trailing: Icon(Icons.chevron_right),
          onTap: () => _showUserProfile(user),
        );
      },
    );
  }
}
```

### 头像组（用户群组）

```dart
class AvatarGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 主要用户头像
        ZephyrAvatar.text(
          text: '主',
          size: ZephyrAvatarSize.medium,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        // 重叠的其他用户头像
        ...List.generate(3, (index) {
          return Positioned(
            left: 20.0 * (index + 1),
            child: ZephyrAvatar.text(
              text: '${index + 1}',
              size: ZephyrAvatarSize.small,
              backgroundColor: Colors.grey[400],
              foregroundColor: Colors.white,
              borderWidth: 2,
              borderColor: Colors.white,
            ),
          );
        }),
        // 更多指示器
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Text(
              '+5',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

### 状态指示器头像

```dart
class StatusAvatar extends StatelessWidget {
  final String name;
  final bool isOnline;
  final VoidCallback? onTap;

  const StatusAvatar({
    Key? key,
    required this.name,
    this.isOnline = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ZephyrAvatar.text(
          text: name,
          size: ZephyrAvatarSize.medium,
          onTap: onTap,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isOnline ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
```

### 可编辑头像

```dart
class EditableAvatar extends StatefulWidget {
  final String? initialImage;
  final String? initialText;
  final ValueChanged<String?> onImageChanged;
  final ValueChanged<String?> onTextChanged;

  const EditableAvatar({
    Key? key,
    this.initialImage,
    this.initialText,
    required this.onImageChanged,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  _EditableAvatarState createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  String? currentImage;
  String? currentText;

  @override
  void initState() {
    super.initState();
    currentImage = widget.initialImage;
    currentText = widget.initialText;
  }

  Future<void> _pickImage() async {
    // 实现图片选择逻辑
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        currentImage = image.path;
      });
      widget.onImageChanged(currentImage);
    }
  }

  void _changeText() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('设置头像文字'),
        content: TextField(
          decoration: InputDecoration(
            labelText: '请输入文字（最多2个字符）',
          ),
          maxLength: 2,
          onChanged: (value) {
            setState(() {
              currentText = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              widget.onTextChanged(currentText);
              Navigator.pop(context);
            },
            child: Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        currentImage != null
            ? ZephyrAvatar.image(
                image: FileImage(File(currentImage!)),
                size: ZephyrAvatarSize.large,
              )
            : ZephyrAvatar.text(
                text: currentText ?? '用户',
                size: ZephyrAvatarSize.large,
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.edit, color: Colors.white, size: 16),
              onSelected: (value) {
                if (value == 'image') {
                  _pickImage();
                } else if (value == 'text') {
                  _changeText();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'image',
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(width: 8),
                      Text('选择图片'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'text',
                  child: Row(
                    children: [
                      Icon(Icons.text_fields),
                      SizedBox(width: 8),
                      Text('设置文字'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrAvatar()

```dart
const ZephyrAvatar({
  Key? key,
  Widget? child,
  ImageProvider? image,
  String? text,
  Color? backgroundColor,
  Color? foregroundColor,
  ZephyrAvatarSize size = ZephyrAvatarSize.medium,
  ZephyrAvatarShape shape = ZephyrAvatarShape.circle,
  double? borderWidth,
  Color? borderColor,
  double? elevation,
  Color? shadowColor,
  VoidCallback? onTap,
})
```

**参数说明：**
- `child`: 自定义头像内容（与 image、text 互斥）
- `image`: 头像图片（与 child、text 互斥）
- `text`: 头像文字（与 child、image 互斥）
- `backgroundColor`: 背景颜色
- `foregroundColor`: 前景颜色（文字或图标颜色）
- `size`: 头像尺寸
- `shape`: 头像形状
- `borderWidth`: 边框宽度
- `borderColor`: 边框颜色
- `elevation`: 阴影高度
- `shadowColor`: 阴影颜色
- `onTap`: 点击回调

#### 命名构造函数

##### ZephyrAvatar.image()

```dart
factory ZephyrAvatar.image({
  Key? key,
  required ImageProvider image,
  ZephyrAvatarSize size = ZephyrAvatarSize.medium,
  ZephyrAvatarShape shape = ZephyrAvatarShape.circle,
  double? borderWidth,
  Color? borderColor,
  double? elevation,
  Color? shadowColor,
  VoidCallback? onTap,
})
```

##### ZephyrAvatar.text()

```dart
factory ZephyrAvatar.text({
  Key? key,
  required String text,
  Color? backgroundColor,
  Color? foregroundColor,
  ZephyrAvatarSize size = ZephyrAvatarSize.medium,
  ZephyrAvatarShape shape = ZephyrAvatarShape.circle,
  double? borderWidth,
  Color? borderColor,
  double? elevation,
  Color? shadowColor,
  VoidCallback? onTap,
})
```

##### ZephyrAvatar.icon()

```dart
factory ZephyrAvatar.icon({
  Key? key,
  required IconData icon,
  Color? backgroundColor,
  Color? foregroundColor,
  ZephyrAvatarSize size = ZephyrAvatarSize.medium,
  ZephyrAvatarShape shape = ZephyrAvatarShape.circle,
  double? borderWidth,
  Color? borderColor,
  double? elevation,
  Color? shadowColor,
  VoidCallback? onTap,
})
```

### 枚举类型

#### ZephyrAvatarSize

```dart
enum ZephyrAvatarSize {
  extraSmall,  // 24px
  small,       // 32px
  medium,      // 48px
  large,       // 64px
  extraLarge,  // 96px
}
```

#### ZephyrAvatarShape

```dart
enum ZephyrAvatarShape {
  circle,  // 圆形
  square,   // 方形（圆角）
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrAvatarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        borderWidth: 0.0,
        borderColor: Colors.grey,
        elevation: 0.0,
        shadowColor: Colors.black,
        squareBorderRadius: 8.0,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `backgroundColor`: 默认背景颜色
- `foregroundColor`: 默认前景颜色
- `borderWidth`: 默认边框宽度
- `borderColor`: 默认边框颜色
- `elevation`: 默认阴影高度
- `shadowColor`: 默认阴影颜色
- `squareBorderRadius`: 方形头像的圆角半径

## 🏆 最佳实践

### 1. 文字头像的使用

```dart
// ✅ 好的做法：使用用户姓名的首字母
ZephyrAvatar.text(
  text: '张三',  // 显示为 "张"
  size: ZephyrAvatarSize.medium,
)

// ✅ 好的做法：对于英文用户名，使用首字母
ZephyrAvatar.text(
  text: 'John Doe',  // 显示为 "JD"
  size: ZephyrAvatarSize.medium,
)

// ❌ 避免的做法：使用过长的文字
ZephyrAvatar.text(
  text: '这是一个很长的名字',  // 只显示前2个字符
  size: ZephyrAvatarSize.medium,
)
```

### 2. 尺寸选择

```dart
// ✅ 用户列表中使用小尺寸
ListView.builder(
  itemBuilder: (context, index) => ListTile(
    leading: ZephyrAvatar.text(
      text: users[index].name,
      size: ZephyrAvatarSize.small,
    ),
  ),
)

// ✅ 用户详情页面使用大尺寸
ZephyrAvatar.text(
  text: user.name,
  size: ZephyrAvatarSize.extraLarge,
)

// ✅ 导航栏中使用中等尺寸
AppBar(
  title: Text('用户中心'),
  actions: [
    ZephyrAvatar.text(
      text: currentUser.name,
      size: ZephyrAvatarSize.medium,
    ),
  ],
)
```

### 3. 颜色使用

```dart
// ✅ 基于用户名生成一致的颜色
Color _generateAvatarColor(String name) {
  final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
  final index = name.hashCode % colors.length;
  return colors[index];
}

ZephyrAvatar.text(
  text: userName,
  backgroundColor: _generateAvatarColor(userName),
  foregroundColor: Colors.white,
)

// ❌ 避免使用过于相似的颜色
ZephyrAvatar.text(
  text: '用户1',
  backgroundColor: Colors.blue[100]!,  // 太浅，对比度不够
  foregroundColor: Colors.grey[800]!,
)
```

### 4. 性能优化

```dart
// ✅ 使用 cached_network_image 处理网络图片
ZephyrAvatar.image(
  image: CachedNetworkImageProvider(
    'https://example.com/avatar.jpg',
  ),
  size: ZephyrAvatarSize.medium,
)

// ✅ 对于列表中的头像，使用适当的尺寸
ListView.builder(
  itemBuilder: (context, index) => ListTile(
    leading: ZephyrAvatar.text(
      text: users[index].name,
      size: ZephyrAvatarSize.small,  // 列表使用小尺寸
    ),
  ),
)

// ❌ 避免在列表中使用大尺寸头像
ListView.builder(
  itemBuilder: (context, index) => ListTile(
    leading: ZephyrAvatar.text(
      text: users[index].name,
      size: ZephyrAvatarSize.extraLarge,  // 过大，影响性能
    ),
  ),
)
```

### 5. 无障碍设计

```dart
// ✅ 为头像添加语义标签
ZephyrAvatar.text(
  text: '张三',
  size: ZephyrAvatarSize.medium,
  onTap: () => _showUserProfile(),
  // 添加语义信息
  child: Semantics(
    label: '用户张三的头像',
    button: true,
    child: Text('张'),
  ),
)

// ✅ 为头像组添加描述
Semantics(
  label: '用户组，包含5个成员',
  child: AvatarGroup(),
)
```

## 🔄 相关组件

- **ZephyrBadge**: 用于在头像上显示徽章信息
- **ZephyrCard**: 用于创建包含头像的用户卡片
- **ZephyrList**: 用于创建用户列表
- **ZephyrIcon**: 用于创建图标头像

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持图片、文字、图标三种模式
- ✅ 支持 5 种尺寸和 2 种形状
- ✅ 完整的主题系统支持
- ✅ 支持边框、阴影等样式定制

---

**组件路径**: `lib/src/components/basic/avatar/`
**示例路径**: `example/lib/components/avatar_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月19日
