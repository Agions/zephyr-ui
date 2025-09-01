# ZephyrModal 模态框组件

模态框组件是ZephyrUI反馈系统中的重要组件，用于显示需要用户注意或操作的对话框。支持多种模态框类型、自定义样式和交互方式，是构建用户友好界面的重要组成部分。

## 🎯 组件概述

### 特性
- **多种模态框类型**: 支持确认框、输入框、选择框等多种类型
- **灵活样式**: 支持自定义大小、位置、动画等样式
- **丰富交互**: 支持点击遮罩关闭、键盘事件、拖拽等交互
- **多种布局**: 支持居中、底部、顶部等多种布局
- **动画效果**: 内置平滑的显示/隐藏动画
- **主题适配**: 完整的主题系统支持

### 适用场景
- 确认对话框
- 输入对话框
- 选择对话框
- 详情展示
- 设置面板
- 表单提交

## 🚀 基础用法

### 基本模态框

```dart
class BasicModalExample extends StatefulWidget {
  @override
  _BasicModalExampleState createState() => _BasicModalExampleState();
}

class _BasicModalExampleState extends State<BasicModalExample> {
  bool _showModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本模态框'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() => _showModal = true);
              },
              child: Text('显示模态框'),
            ),
          ],
        ),
      ),
      // 模态框
      if (_showModal)
        ZephyrModal(
          title: '基本模态框',
          content: Text('这是一个基本的模态框示例'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showModal = false);
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() => _showModal = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('确认按钮被点击')),
                );
              },
              child: Text('确认'),
            ),
          ],
          onDismissed: () {
            setState(() => _showModal = false);
          },
        ),
    );
  }
}
```

### 确认模态框

```dart
class ConfirmModalExample extends StatefulWidget {
  @override
  _ConfirmModalExampleState createState() => _ConfirmModalExampleState();
}

class _ConfirmModalExampleState extends State<ConfirmModalExample> {
  bool _showConfirmModal = false;

  void _showDeleteConfirmation() {
    setState(() => _showConfirmModal = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('确认模态框'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showDeleteConfirmation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('删除项目'),
            ),
          ],
        ),
      ),
      // 确认模态框
      if (_showConfirmModal)
        ZephyrModal(
          type: ZephyrModalType.confirm,
          title: '确认删除',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: Colors.orange,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                '您确定要删除这个项目吗？',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '此操作不可撤销',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showConfirmModal = false);
              },
              child: Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => _showConfirmModal = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('项目已删除')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('删除'),
            ),
          ],
          onDismissed: () {
            setState(() => _showConfirmModal = false);
          },
        ),
    );
  }
}
```

### 输入模态框

```dart
class InputModalExample extends StatefulWidget {
  @override
  _InputModalExampleState createState() => _InputModalExampleState();
}

class _InputModalExampleState extends State<InputModalExample> {
  bool _showInputModal = false;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入模态框'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() => _showInputModal = true);
              },
              child: Text('输入文本'),
            ),
          ],
        ),
      ),
      // 输入模态框
      if (_showInputModal)
        ZephyrModal(
          type: ZephyrModalType.input,
          title: '输入文本',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: '请输入内容',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              SizedBox(height: 16),
              Text(
                '请输入您想要添加的内容',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showInputModal = false);
                _textController.clear();
              },
              child: Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  setState(() => _showInputModal = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('输入内容: ${_textController.text}')),
                  );
                  _textController.clear();
                }
              },
              child: Text('确认'),
            ),
          ],
          onDismissed: () {
            setState(() => _showInputModal = false);
            _textController.clear();
          },
        ),
    );
  }
}
```

## 🎨 样式定制

### 自定义样式模态框

```dart
class CustomStyleModalExample extends StatefulWidget {
  @override
  _CustomStyleModalExampleState createState() => _CustomStyleModalExampleState();
}

class _CustomStyleModalExampleState extends State<CustomStyleModalExample> {
  bool _showModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义样式模态框'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() => _showModal = true);
          },
          child: Text('显示自定义模态框'),
        ),
      ),
      // 自定义样式模态框
      if (_showModal)
        ZephyrModal(
          title: '自定义样式',
          content: Text('这是一个自定义样式的模态框'),
          style: ZephyrModalStyle(
            backgroundColor: Colors.blue[50],
            surfaceTintColor: Colors.blue[100],
            elevation: 8,
            borderRadius: BorderRadius.circular(16),
            padding: EdgeInsets.all(24),
            titleStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
            contentStyle: TextStyle(
              fontSize: 16,
              color: Colors.blue[600],
            ),
            shadowColor: Colors.blue.withOpacity(0.3),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showModal = false);
              },
              child: Text(
                '取消',
                style: TextStyle(color: Colors.blue[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => _showModal = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('自定义模态框已关闭')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text('确认'),
            ),
          ],
          onDismissed: () {
            setState(() => _showModal = false);
          },
        ),
    );
  }
}
```

### 底部模态框

```dart
class BottomModalExample extends StatefulWidget {
  @override
  _BottomModalExampleState createState() => _BottomModalExampleState();
}

class _BottomModalExampleState extends State<BottomModalExample> {
  bool _showBottomModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('底部模态框'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() => _showBottomModal = true);
          },
          child: Text('显示底部模态框'),
        ),
      ),
      // 底部模态框
      if (_showBottomModal)
        ZephyrModal(
          type: ZephyrModalType.bottomSheet,
          title: '底部模态框',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text('分享'),
                onTap: () {
                  setState(() => _showBottomModal = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('分享功能')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('复制链接'),
                onTap: () {
                  setState(() => _showBottomModal = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('链接已复制')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('下载'),
                onTap: () {
                  setState(() => _showBottomModal = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('下载功能')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('删除'),
                textColor: Colors.red,
                onTap: () {
                  setState(() => _showBottomModal = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('删除功能')),
                  );
                },
              ),
            ],
          ),
          onDismissed: () {
            setState(() => _showBottomModal = false);
          },
        ),
    );
  }
}
```

### 圆角模态框

```dart
class RoundedModalExample extends StatefulWidget {
  @override
  _RoundedModalExampleState createState() => _RoundedModalExampleState();
}

class _RoundedModalExampleState extends State<RoundedModalExample> {
  bool _showModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆角模态框'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() => _showModal = true);
          },
          child: Text('显示圆角模态框'),
        ),
      ),
      // 圆角模态框
      if (_showModal)
        ZephyrModal(
          title: '圆角模态框',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                '这是一个圆角模态框',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '具有较大的圆角半径',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          style: ZephyrModalStyle(
            borderRadius: BorderRadius.circular(24),
            elevation: 12,
            padding: EdgeInsets.all(24),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showModal = false);
              },
              child: Text('关闭'),
            ),
          ],
          onDismissed: () {
            setState(() => _showModal = false);
          },
        ),
    );
  }
}
```

## 🔧 高级用法

### 可拖拽模态框

```dart
class DraggableModalExample extends StatefulWidget {
  @override
  _DraggableModalExampleState createState() => _DraggableModalExampleState();
}

class _DraggableModalExampleState extends State<DraggableModalExample> {
  bool _showModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可拖拽模态框'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() => _showModal = true);
          },
          child: Text('显示可拖拽模态框'),
        ),
      ),
      // 可拖拽模态框
      if (_showModal)
        ZephyrModal(
          title: '可拖拽模态框',
          content: Text('您可以拖拽这个模态框到任意位置'),
          draggable: true,
          initialPosition: Offset(100, 100),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showModal = false);
              },
              child: Text('关闭'),
            ),
          ],
          onDismissed: () {
            setState(() => _showModal = false);
          },
        ),
    );
  }
}
```

### 可调整大小模态框

```dart
class ResizableModalExample extends StatefulWidget {
  @override
  _ResizableModalExampleState createState() => _ResizableModalExampleState();
}

class _ResizableModalExampleState extends State<ResizableModalExample> {
  bool _showModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可调整大小模态框'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() => _showModal = true);
          },
          child: Text('显示可调整大小模态框'),
        ),
      ),
      // 可调整大小模态框
      if (_showModal)
        ZephyrModal(
          title: '可调整大小模态框',
          content: Container(
            width: 400,
            height: 300,
            child: Column(
              children: [
                Text('您可以拖拽边缘来调整模态框大小'),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    color: Colors.grey[100],
                    child: Center(
                      child: Text('可调整大小的内容区域'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          resizable: true,
          minSize: Size(300, 200),
          maxSize: Size(600, 400),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showModal = false);
              },
              child: Text('关闭'),
            ),
          ],
          onDismissed: () {
            setState(() => _showModal = false);
          },
        ),
    );
  }
}
```

### 全屏模态框

```dart
class FullScreenModalExample extends StatefulWidget {
  @override
  _FullScreenModalExampleState createState() => _FullScreenModalExampleState();
}

class _FullScreenModalExampleState extends State<FullScreenModalExample> {
  bool _showFullScreenModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全屏模态框'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() => _showFullScreenModal = true);
          },
          child: Text('显示全屏模态框'),
        ),
      ),
      // 全屏模态框
      if (_showFullScreenModal)
        ZephyrModal(
          type: ZephyrModalType.fullScreen,
          title: '全屏模态框',
          content: Column(
            children: [
              Text('这是一个全屏模态框'),
              SizedBox(height: 16),
              Text('占满整个屏幕'),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  color: Colors.grey[100],
                  child: Center(
                    child: Text('全屏内容区域'),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showFullScreenModal = false);
              },
              child: Text('关闭'),
            ),
          ],
          onDismissed: () {
            setState(() => _showFullScreenModal = false);
          },
        ),
    );
  }
}
```

### 表单模态框

```dart
class FormModalExample extends StatefulWidget {
  @override
  _FormModalExampleState createState() => _FormModalExampleState();
}

class _FormModalExampleState extends State<FormModalExample> {
  bool _showFormModal = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _showFormModal = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('表单提交成功')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单模态框'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() => _showFormModal = true);
          },
          child: Text('显示表单模态框'),
        ),
      ),
      // 表单模态框
      if (_showFormModal)
        ZephyrModal(
          type: ZephyrModalType.form,
          title: '用户信息',
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '姓名',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入姓名';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '邮箱',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入邮箱';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return '请输入有效的邮箱地址';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: '电话',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入电话号码';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showFormModal = false);
              },
              child: Text('取消'),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('提交'),
            ),
          ],
          onDismissed: () {
            setState(() => _showFormModal = false);
          },
        ),
    );
  }
}
```

### 图片预览模态框

```dart
class ImagePreviewModalExample extends StatefulWidget {
  @override
  _ImagePreviewModalExampleState createState() => _ImagePreviewModalExampleState();
}

class _ImagePreviewModalExampleState extends State<ImagePreviewModalExample> {
  bool _showImageModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片预览模态框'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() => _showImageModal = true);
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.image,
                  size: 64,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('点击图片查看大图'),
          ],
        ),
      ),
      // 图片预览模态框
      if (_showImageModal)
        ZephyrModal(
          type: ZephyrModalType.imagePreview,
          title: '图片预览',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.image,
                  size: 64,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'image-preview.jpg',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1920x1080 • 2.5MB',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showImageModal = false);
              },
              child: Text('关闭'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => _showImageModal = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('下载功能')),
                );
              },
              child: Text('下载'),
            ),
          ],
          onDismissed: () {
            setState(() => _showImageModal = false);
          },
        ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrModal()

```dart
const ZephyrModal({
  Key? key,
  String? title,
  Widget? content,
  List<Widget>? actions,
  ZephyrModalType type = ZephyrModalType.dialog,
  ZephyrModalStyle? style,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  VoidCallback? onDismissed,
  bool draggable = false,
  Offset? initialPosition,
  bool resizable = false,
  Size? minSize,
  Size? maxSize,
  bool animate = true,
  Duration? animationDuration,
  Curve? animationCurve,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `title`: 标题
- `content`: 内容
- `actions`: 操作按钮
- `type`: 模态框类型
- `style`: 模态框样式
- `barrierDismissible`: 是否点击遮罩关闭
- `barrierColor`: 遮罩颜色
- `barrierLabel`: 遮罩标签
- `onDismissed`: 关闭回调
- `draggable`: 是否可拖拽
- `initialPosition`: 初始位置
- `resizable`: 是否可调整大小
- `minSize`: 最小尺寸
- `maxSize`: 最大尺寸
- `animate`: 是否启用动画
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrModalType

```dart
enum ZephyrModalType {
  dialog,       // 对话框
  confirm,      // 确认框
  input,        // 输入框
  bottomSheet,  // 底部弹窗
  fullScreen,   // 全屏
  form,         // 表单
  imagePreview, // 图片预览
}
```

### 样式类

#### ZephyrModalStyle

```dart
class ZephyrModalStyle {
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final Color? shadowColor;
  final BoxBorder? border;
  final EdgeInsetsGeometry? actionsPadding;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrModalTheme(
        defaultBackgroundColor: Colors.white,
        defaultSurfaceTintColor: Colors.transparent,
        defaultElevation: 24,
        defaultBorderRadius: BorderRadius.circular(8),
        defaultPadding: EdgeInsets.all(24),
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
        ),
        defaultBarrierColor: Colors.black54,
        actionsPadding: EdgeInsets.symmetric(horizontal: 24),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        shadowColor: Colors.black,
        minSize: Size(280, 200),
        maxSize: Size(double.infinity, double.infinity),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultBackgroundColor`: 默认背景颜色
- `defaultSurfaceTintColor`: 默认表面色调
- `defaultElevation`: 默认阴影高度
- `defaultBorderRadius`: 默认边框圆角
- `defaultPadding`: 默认内边距
- `titleStyle`: 默认标题样式
- `contentStyle`: 默认内容样式
- `defaultBarrierColor`: 默认遮罩颜色
- `actionsPadding`: 操作按钮内边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `shadowColor`: 阴影颜色
- `minSize`: 最小尺寸
- `maxSize`: 最大尺寸

## 🏆 最佳实践

### 1. 合理的模态框类型选择

```dart
// ✅ 好的做法：根据场景选择合适的模态框类型
// 确认操作
ZephyrModal(
  type: ZephyrModalType.confirm,
  title: '确认删除',
  content: Text('确定要删除这个项目吗？'),
)

// 输入信息
ZephyrModal(
  type: ZephyrModalType.input,
  title: '输入文本',
  content: TextField(...),
)

// 底部操作菜单
ZephyrModal(
  type: ZephyrModalType.bottomSheet,
  content: ListView(...),
)

// ✅ 好的做法：使用合适的模态框大小
ZephyrModal(
  type: ZephyrModalType.dialog,
  content: Text('简单提示'), // 简单内容使用小模态框
)

// ❌ 避免的做法：模态框类型不匹配
ZephyrModal(
  type: ZephyrModalType.fullScreen,
  content: Text('简单提示'), // 简单提示不需要全屏
)
```

### 2. 用户体验优化

```dart
// ✅ 好的做法：提供明确的操作按钮
ZephyrModal(
  title: '确认操作',
  content: Text('确定要执行此操作吗？'),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('取消'),
    ),
    ElevatedButton(
      onPressed: () => _handleConfirm(),
      child: Text('确认'),
    ),
  ],
)

// ✅ 好的做法：支持点击遮罩关闭
ZephyrModal(
  barrierDismissible: true,
  onDismissed: () => _handleDismiss(),
)

// ✅ 好的做法：提供视觉反馈
ZephyrModal(
  animate: true,
  animationDuration: Duration(milliseconds: 300),
)

// ❌ 避免的做法：缺乏用户控制
ZephyrModal(
  barrierDismissible: false, // 用户无法关闭
  // 缺乏操作按钮
)
```

### 3. 内容设计

```dart
// ✅ 好的做法：内容简洁明了
ZephyrModal(
  title: '操作成功',
  content: Text('数据已成功保存'),
)

// ✅ 好的做法：重要信息使用图标强调
ZephyrModal(
  title: '警告',
  content: Column(
    children: [
      Icon(Icons.warning, color: Colors.orange),
      SizedBox(height: 16),
      Text('此操作不可撤销'),
    ],
  ),
)

// ✅ 好的做法：长内容使用滚动
ZephyrModal(
  content: SingleChildScrollView(
    child: Column(
      children: _buildLongContent(),
    ),
  ),
)

// ❌ 避免的做法：内容过多且无滚动
ZephyrModal(
  content: Column(
    children: _buildVeryLongContent(), // 内容可能超出屏幕
  ),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrModal(
  title: '用户设置',
  semanticLabel: '用户设置对话框',
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为操作提供描述
ZephyrModal(
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('取消'),
      tooltip: '取消操作',
    ),
    ElevatedButton(
      onPressed: () => _handleConfirm(),
      child: Text('确认'),
      tooltip: '确认操作',
    ),
  ],
)

// ✅ 好的做法：确保足够的对比度
ZephyrModal(
  style: ZephyrModalStyle(
    backgroundColor: Colors.white,
    titleStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  ),
)

// ❌ 避免的做法：缺乏语义信息
ZephyrModal(
  title: '设置',
  // 缺乏无障碍支持
)
```

## 🔄 相关组件

- **ZephyrAlert**: 警告组件
- **ZephyrDialog**: 对话框组件
- **ZephyrBottomSheet**: 底部弹窗组件
- **ZephyrPopup**: 弹出组件
- **ZephyrTooltip**: 工具提示组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种模态框类型
- ✅ 支持拖拽和调整大小
- ✅ 支持动画效果
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/feedback/modal/`
**示例路径**: `example/lib/components/modal_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日