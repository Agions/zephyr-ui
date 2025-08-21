# ZephyrUI 组件使用指南

本指南将帮助您快速上手 ZephyrUI 组件库，了解如何使用各种组件构建美观的应用界面。

## 🚀 快速开始

### 1. 安装

在 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  zephyr_ui: ^1.0.0
```

然后运行 `flutter pub get` 安装依赖。

### 2. 基本使用

```dart
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 示例'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrText(
              '欢迎使用 ZephyrUI',
              style: ZephyrTextStyle.headline4,
            ),
            const SizedBox(height: 16),
            ZephyrButton.primary(
              text: '点击我',
              onPressed: () => _showMessage(context, '按钮被点击'),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

## 🎨 基础组件

### 按钮组件

#### 基础用法

```dart
// 基础按钮
ZephyrButton(
  text: '点击我',
  onPressed: () => print('按钮被点击'),
)

// 带图标的按钮
ZephyrButton(
  text: '保存',
  icon: Icons.save,
  onPressed: () => _saveData(),
)
```

#### 按钮类型

```dart
Column(
  children: [
    // 主要按钮
    ZephyrButton.primary(
      text: '主要操作',
      onPressed: () {},
    ),
    
    SizedBox(height: 8),
    
    // 次要按钮
    ZephyrButton.secondary(
      text: '次要操作',
      onPressed: () {},
    ),
    
    SizedBox(height: 8),
    
    // 轮廓按钮
    ZephyrButton.outlined(
      text: '轮廓按钮',
      onPressed: () {},
    ),
    
    SizedBox(height: 8),
    
    // 文本按钮
    ZephyrButton.text(
      text: '文本按钮',
      onPressed: () {},
    ),
  ],
)
```

#### 按钮状态

```dart
Column(
  children: [
    // 正常状态
    ZephyrButton(
      text: '正常按钮',
      onPressed: () {},
    ),
    
    SizedBox(height: 8),
    
    // 禁用状态
    ZephyrButton(
      text: '禁用按钮',
      onPressed: null, // 或 disabled: true
    ),
    
    SizedBox(height: 8),
    
    // 加载状态
    ZephyrButton(
      text: '加载中...',
      loading: true,
      onPressed: () {},
    ),
  ],
)
```

#### 自定义按钮

```dart
ZephyrButton(
  text: '自定义按钮',
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  borderRadius: 20,
  onPressed: () {},
)
```

### 文本组件

#### 基础用法

```dart
// 基础文本
ZephyrText('Hello World')

// 带样式的文本
ZephyrText(
  '标题文本',
  style: ZephyrTextStyle.headline6,
  color: ZephyrColors.primary,
)
```

#### 文本样式

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText('主标题 H1', style: ZephyrTextStyle.headline1),
    ZephyrText('副标题 H2', style: ZephyrTextStyle.headline2),
    ZephyrText('标题 H3', style: ZephyrTextStyle.headline3),
    ZephyrText('标题 H4', style: ZephyrTextStyle.headline4),
    ZephyrText('标题 H5', style: ZephyrTextStyle.headline5),
    ZephyrText('标题 H6', style: ZephyrTextStyle.headline6),
    SizedBox(height: 16),
    ZephyrText('主要正文', style: ZephyrTextStyle.body1),
    ZephyrText('次要正文', style: ZephyrTextStyle.body2),
  ],
)
```

#### 文本装饰

```dart
Column(
  children: [
    ZephyrText(
      '下划线文本',
      decoration: TextDecoration.underline,
    ),
    ZephyrText(
      '删除线文本',
      decoration: TextDecoration.lineThrough,
    ),
    ZephyrText(
      '上划线文本',
      decoration: TextDecoration.overline,
    ),
  ],
)
```

### 图标组件

#### 基础用法

```dart
// 基础图标
ZephyrIcon(
  Icons.star,
  size: 24,
  color: Colors.amber,
)

// 可点击图标
ZephyrIcon(
  Icons.favorite,
  size: 32,
  color: Colors.red,
  onPressed: () => _toggleFavorite(),
)
```

#### 图标尺寸

```dart
Row(
  children: [
    ZephyrIcon(Icons.star, size: 16),
    ZephyrIcon(Icons.star, size: 24),
    ZephyrIcon(Icons.star, size: 32),
    ZephyrIcon(Icons.star, size: 48),
  ],
)
```

#### 图标状态

```dart
class _FavoriteIcon extends StatefulWidget {
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool _isFavorite = false;
  
  @override
  Widget build(BuildContext context) {
    return ZephyrIcon(
      _isFavorite ? Icons.favorite : Icons.favorite_border,
      size: 24,
      color: _isFavorite ? Colors.red : Colors.grey,
      onPressed: () => setState(() => _isFavorite = !_isFavorite),
    );
  }
}
```

## 🎯 表单组件

### 评分组件

#### 基础用法

```dart
ZephyrRating(
  value: 4.5,
  count: 5,
  onRatingChanged: (rating) => print('评分: $rating'),
)
```

#### 只读模式

```dart
ZephyrRating(
  value: 4.0,
  count: 5,
  readonly: true,
)
```

#### 自定义样式

```dart
ZephyrRating(
  value: 3.5,
  count: 5,
  size: 32,
  color: Colors.orange,
  unselectedColor: Colors.grey,
  allowHalf: true,
  onRatingChanged: (rating) => _updateRating(rating),
)
```

### 输入框组件

#### 基础用法

```dart
ZephyrInput(
  placeholder: '请输入用户名',
  onChanged: (value) => print('输入: $value'),
)
```

#### 带标签的输入框

```dart
ZephyrInput(
  label: '邮箱',
  placeholder: '请输入邮箱地址',
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱地址';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  },
)
```

## 🧭 导航组件

### 标签页组件

#### 基础用法

```dart
ZephyrTabs(
  tabs: [
    ZephyrTab(
      text: '首页',
      icon: Icons.home,
    ),
    ZephyrTab(
      text: '搜索',
      icon: Icons.search,
    ),
    ZephyrTab(
      text: '个人',
      icon: Icons.person,
    ),
  ],
  onTabChanged: (index) => print('切换到标签: $index'),
)
```

### 树形组件

#### 基础用法

```dart
final nodes = [
  ZephyrTreeNode(
    id: '1',
    label: '根节点',
    children: [
      ZephyrTreeNode(
        id: '1-1',
        label: '子节点 1',
      ),
      ZephyrTreeNode(
        id: '1-2',
        label: '子节点 2',
      ),
    ],
  ),
];

ZephyrTree(
  nodes: nodes,
  onNodeSelected: (node) => print('选中: ${node.label}'),
)
```

#### 多选模式

```dart
ZephyrTree(
  nodes: nodes,
  multiSelect: true,
  onNodeSelected: (nodes) => print('选中: ${nodes.map((n) => n.label)}'),
)
```

## 💬 反馈组件

### 警告框组件

#### 基础用法

```dart
ZephyrAlert(
  type: ZephyrAlertType.success,
  title: '操作成功',
  message: '您的操作已成功完成',
)
```

#### 不同类型的警告框

```dart
Column(
  children: [
    ZephyrAlert(
      type: ZephyrAlertType.success,
      title: '成功',
      message: '操作成功完成',
    ),
    ZephyrAlert(
      type: ZephyrAlertType.warning,
      title: '警告',
      message: '请注意检查输入信息',
    ),
    ZephyrAlert(
      type: ZephyrAlertType.error,
      title: '错误',
      message: '操作失败，请重试',
    ),
    ZephyrAlert(
      type: ZephyrAlertType.info,
      title: '信息',
      message: '这是一条提示信息',
    ),
  ],
)
```

### 导览组件

#### 基础用法

```dart
final steps = [
  ZephyrTourStep(
    title: '欢迎使用',
    description: '这是功能导览的第一步',
    targetKey: _welcomeKey,
  ),
  ZephyrTourStep(
    title: '主要功能',
    description: '这里展示了应用的主要功能',
    targetKey: _featureKey,
  ),
];

ZephyrTour(
  steps: steps,
  onTourCompleted: () => print('导览完成'),
)
```

#### 自动开始导览

```dart
ZephyrTour(
  steps: steps,
  autoStart: true,
  onTourCompleted: () => print('导览完成'),
  onTourSkipped: () => print('跳过导览'),
)
```

## 🎨 布局组件

### 卡片组件

#### 基础用法

```dart
ZephyrCard(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrText(
          '卡片标题',
          style: ZephyrTextStyle.headline6,
        ),
        SizedBox(height: 8),
        ZephyrText(
          '这是卡片的内容描述，可以包含文本、图片等元素。',
          style: ZephyrTextStyle.body2,
        ),
      ],
    ),
  ),
)
```

#### 带操作的卡片

```dart
ZephyrCard(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ZephyrText(
                '卡片标题',
                style: ZephyrTextStyle.headline6,
              ),
            ),
            ZephyrIcon(
              Icons.more_vert,
              onPressed: () => _showMenu(),
            ),
          ],
        ),
        SizedBox(height: 8),
        ZephyrText(
          '卡片内容描述...',
          style: ZephyrTextStyle.body2,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            ZephyrButton.text(
              text: '取消',
              onPressed: () {},
            ),
            Spacer(),
            ZephyrButton(
              text: '确认',
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  ),
)
```

### 网格组件

#### 基础用法

```dart
ZephyrGrid(
  crossAxisCount: 2,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  children: [
    _buildGridItem(Icons.home, '首页'),
    _buildGridItem(Icons.search, '搜索'),
    _buildGridItem(Icons.person, '个人'),
    _buildGridItem(Icons.settings, '设置'),
  ],
)
```

#### 响应式网格

```dart
Widget _buildResponsiveGrid(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final crossAxisCount = width < 600 ? 2 : width < 900 ? 3 : 4;
  
  return ZephyrGrid(
    crossAxisCount: crossAxisCount,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    children: List.generate(8, (index) => 
      _buildGridItem(Icons.grid_view, '项目 $index'),
    ),
  );
}
```

## 🎨 主题定制

### 基础主题

```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: true,
  ),
  home: MyApp(),
)
```

### 自定义主题

```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: true,
    extensions: [
      ZephyrThemeData(
        primaryColor: Colors.blue,
        secondaryColor: Colors.grey,
        textTheme: ZephyrTextTheme(
          headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          body1: TextStyle(fontSize: 16),
          body2: TextStyle(fontSize: 14),
        ),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 暗色主题

```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: true,
    brightness: Brightness.light,
  ),
  darkTheme: ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: true,
    brightness: Brightness.dark,
  ),
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

## 🚀 高级用法

### 表单验证

```dart
class _FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ZephyrInput(
            controller: _emailController,
            label: '邮箱',
            placeholder: '请输入邮箱地址',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入邮箱地址';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ZephyrInput(
            controller: _passwordController,
            label: '密码',
            placeholder: '请输入密码',
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              if (value.length < 6) {
                return '密码长度不能少于6位';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          ZephyrButton(
            text: '提交',
            fullWidth: true,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submitForm();
              }
            },
          ),
        ],
      ),
    );
  }
}
```

### 列表展示

```dart
class _UserList extends StatelessWidget {
  final List<User> users = [
    User(name: '张三', email: 'zhangsan@example.com'),
    User(name: '李四', email: 'lisi@example.com'),
    User(name: '王五', email: 'wangwu@example.com'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: ZephyrIcon(Icons.person),
            ),
            title: ZephyrText(user.name),
            subtitle: ZephyrText(
              user.email,
              style: ZephyrTextStyle.body2,
            ),
            trailing: ZephyrIcon(Icons.chevron_right),
            onTap: () => _showUserDetails(user),
          ),
        );
      },
    );
  }
}
```

## 📝 总结

ZephyrUI 提供了丰富的组件库，帮助您快速构建美观的 Flutter 应用。通过本指南，您已经了解了：

- 基础组件的使用方法
- 表单组件的验证和交互
- 导航和反馈组件的实现
- 布局组件的响应式设计
- 主题定制的各种方式

接下来，您可以：

1. 查看更多 [API 文档](../api/components.md)
2. 学习 [最佳实践](../guides/best-practices.md)
3. 体验 [完整示例](../../example)

如果您在使用过程中遇到问题，请查看 [常见问题](../faq.md) 或提交 [GitHub Issue](https://github.com/your-repo/zephyr-ui/issues)。

---

**文档版本**: 1.0.0  
**最后更新**: 2024年8月18日