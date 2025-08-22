# ZephyrRichEditor 富文本编辑器组件

富文本编辑器组件是ZephyrUI高级组件中的重要组件，提供了强大的文本编辑功能。支持多种文本格式、插入媒体内容、自定义样式等高级功能，是构建内容管理系统、博客编辑器、文档编辑器等场景的理想选择。

## 🎯 组件概述

### 特性
- **丰富的文本格式**: 支持加粗、斜体、下划线、字体大小、颜色等格式
- **媒体内容插入**: 支持图片、链接、表格、列表等内容插入
- **撤销重做**: 完整的撤销和重做功能支持
- **自定义工具栏**: 可自定义的工具栏和快捷键
- **多种编辑模式**: 支持可视化编辑和源码编辑模式
- **主题适配**: 完整的主题系统支持

### 适用场景
- 内容管理系统
- 博客编辑器
- 文档编辑器
- 邮件编辑器
- 评论编辑器
- 产品描述编辑

## 🚀 基础用法

### 基本富文本编辑器

```dart
class BasicRichEditorExample extends StatefulWidget {
  @override
  _BasicRichEditorExampleState createState() => _BasicRichEditorExampleState();
}

class _BasicRichEditorExampleState extends State<BasicRichEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本富文本编辑器'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveContent,
          ),
        ],
      ),
      body: Column(
        children: [
          // 工具栏
          ZephyrRichEditorToolbar(
            controller: _controller,
            showFormatButtons: true,
            showAlignmentButtons: true,
            showListButtons: true,
            showLinkButton: true,
            showImageButton: true,
          ),
          // 编辑器
          Expanded(
            child: ZephyrRichEditor(
              controller: _controller,
              placeholder: '开始输入内容...',
              initialContent: '<p>欢迎使用富文本编辑器！</p>',
              onChanged: (content) {
                print('内容变化: $content');
              },
            ),
          ),
        ],
      ),
    );
  }

  void _saveContent() {
    final content = _controller.getHtml();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('内容已保存'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
```

### 自定义工具栏编辑器

```dart
class CustomToolbarEditorExample extends StatefulWidget {
  @override
  _CustomToolbarEditorExampleState createState() => _CustomToolbarEditorExampleState();
}

class _CustomToolbarEditorExampleState extends State<CustomToolbarEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义工具栏编辑器'),
      ),
      body: Column(
        children: [
          // 自定义工具栏
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Wrap(
              spacing: 4,
              children: [
                // 格式按钮
                ZephyrRichEditorFormatButton(
                  controller: _controller,
                  format: ZephyrRichEditorFormat.bold,
                  icon: Icons.format_bold,
                  tooltip: '加粗',
                ),
                ZephyrRichEditorFormatButton(
                  controller: _controller,
                  format: ZephyrRichEditorFormat.italic,
                  icon: Icons.format_italic,
                  tooltip: '斜体',
                ),
                ZephyrRichEditorFormatButton(
                  controller: _controller,
                  format: ZephyrRichEditorFormat.underline,
                  icon: Icons.format_underlined,
                  tooltip: '下划线',
                ),
                SizedBox(width: 8),
                // 颜色选择
                ZephyrRichEditorColorButton(
                  controller: _controller,
                  icon: Icons.format_color_text,
                  tooltip: '文字颜色',
                ),
                // 对齐按钮
                SizedBox(width: 8),
                ZephyrRichEditorAlignmentButton(
                  controller: _controller,
                  alignment: ZephyrRichEditorAlignment.left,
                  icon: Icons.format_align_left,
                  tooltip: '左对齐',
                ),
                ZephyrRichEditorAlignmentButton(
                  controller: _controller,
                  alignment: ZephyrRichEditorAlignment.center,
                  icon: Icons.format_align_center,
                  tooltip: '居中对齐',
                ),
                ZephyrRichEditorAlignmentButton(
                  controller: _controller,
                  alignment: ZephyrRichEditorAlignment.right,
                  icon: Icons.format_align_right,
                  tooltip: '右对齐',
                ),
                SizedBox(width: 8),
                // 列表按钮
                ZephyrRichEditorListButton(
                  controller: _controller,
                  listType: ZephyrRichEditorListType.unordered,
                  icon: Icons.format_list_bulleted,
                  tooltip: '无序列表',
                ),
                ZephyrRichEditorListButton(
                  controller: _controller,
                  listType: ZephyrRichEditorListType.ordered,
                  icon: Icons.format_list_numbered,
                  tooltip: '有序列表',
                ),
                SizedBox(width: 8),
                // 插入按钮
                ZephyrRichEditorInsertButton(
                  controller: _controller,
                  insertType: ZephyrRichEditorInsertType.link,
                  icon: Icons.link,
                  tooltip: '插入链接',
                ),
                ZephyrRichEditorInsertButton(
                  controller: _controller,
                  insertType: ZephyrRichEditorInsertType.image,
                  icon: Icons.image,
                  tooltip: '插入图片',
                ),
              ],
            ),
          ),
          // 编辑器
          Expanded(
            child: ZephyrRichEditor(
              controller: _controller,
              placeholder: '开始编辑...',
              initialContent: '''
                <h2>欢迎使用自定义工具栏编辑器</h2>
                <p>这是一个功能强大的富文本编辑器，支持：</p>
                <ul>
                  <li>文本格式化</li>
                  <li>颜色设置</li>
                  <li>对齐方式</li>
                  <li>列表创建</li>
                  <li>链接和图片插入</li>
                </ul>
                <p>尽情发挥你的创意吧！</p>
              ''',
            ),
          ),
        ],
      ),
    );
  }
}
```

### 简洁模式编辑器

```dart
class SimpleEditorExample extends StatefulWidget {
  @override
  _SimpleEditorExampleState createState() => _SimpleEditorExampleState();
}

class _SimpleEditorExampleState extends State<SimpleEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简洁模式编辑器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: Column(
            children: [
              // 简洁工具栏
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    ZephyrRichEditorFormatButton(
                      controller: _controller,
                      format: ZephyrRichEditorFormat.bold,
                      icon: Icons.format_bold,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    ZephyrRichEditorFormatButton(
                      controller: _controller,
                      format: ZephyrRichEditorFormat.italic,
                      icon: Icons.format_italic,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    ZephyrRichEditorFormatButton(
                      controller: _controller,
                      format: ZephyrRichEditorFormat.underline,
                      icon: Icons.format_underlined,
                      size: 20,
                    ),
                    Spacer(),
                    ZephyrRichEditorInsertButton(
                      controller: _controller,
                      insertType: ZephyrRichEditorInsertType.link,
                      icon: Icons.link,
                      size: 20,
                    ),
                  ],
                ),
              ),
              // 编辑器
              Expanded(
                child: ZephyrRichEditor(
                  controller: _controller,
                  placeholder: '写下你的想法...',
                  toolbar: false,
                  initialContent: '<p>这是一个简洁的富文本编辑器，适合评论和简单的内容编辑。</p>',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义样式编辑器

```dart
class CustomStyleEditorExample extends StatefulWidget {
  @override
  _CustomStyleEditorExampleState createState() => _CustomStyleEditorExampleState();
}

class _CustomStyleEditorExampleState extends State<CustomStyleEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义样式编辑器'),
      ),
      body: ZephyrRichEditor(
        controller: _controller,
        placeholder: '开始编辑...',
        initialContent: '''
          <div style="background-color: #f0f8ff; padding: 20px; border-radius: 8px;">
            <h1 style="color: #2c5aa0; text-align: center;">自定义样式示例</h1>
            <p style="color: #333; line-height: 1.6;">
              这个编辑器支持自定义CSS样式，你可以为文本设置各种样式效果。
            </p>
            <blockquote style="border-left: 4px solid #2c5aa0; padding-left: 16px; margin: 16px 0; font-style: italic; color: #666;">
              这是一个引用块的示例，展示了自定义边框和颜色。
            </blockquote>
          </div>
        ''',
        style: ZephyrRichEditorStyle(
          backgroundColor: Colors.white,
          toolbarBackgroundColor: Colors.blue[50],
          toolbarBorderColor: Colors.blue[200],
          buttonColor: Colors.blue[700],
          buttonHoverColor: Colors.blue[800],
          placeholderColor: Colors.grey[400],
          focusBorderColor: Colors.blue[400],
          contentPadding: EdgeInsets.all(16),
          editorBorder: Border.all(color: Colors.grey[300]!),
          editorBorderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
```

### 深色主题编辑器

```dart
class DarkThemeEditorExample extends StatefulWidget {
  @override
  _DarkThemeEditorExampleState createState() => _DarkThemeEditorExampleState();
}

class _DarkThemeEditorExampleState extends State<DarkThemeEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('深色主题编辑器'),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: ZephyrRichEditor(
        controller: _controller,
        placeholder: '在深色主题中编辑...',
        initialContent: '''
          <h2 style="color: #64b5f6;">深色主题编辑器</h2>
          <p style="color: #e0e0e0;">
            这是一个专为深色主题设计的富文本编辑器。在暗光环境下提供舒适的编辑体验。
          </p>
          <pre style="background-color: #1e1e1e; color: #d4d4d4; padding: 12px; border-radius: 4px; overflow-x: auto;">
            <code>console.log('Hello, Dark Theme!');</code>
          </pre>
        ''',
        style: ZephyrRichEditorStyle(
          backgroundColor: Colors.grey[900],
          toolbarBackgroundColor: Colors.grey[800],
          toolbarBorderColor: Colors.grey[700],
          buttonColor: Colors.grey[300],
          buttonHoverColor: Colors.white,
          placeholderColor: Colors.grey[500],
          focusBorderColor: Colors.blue[400],
          contentPadding: EdgeInsets.all(16),
          editorBorder: Border.all(color: Colors.grey[700]!),
          editorBorderRadius: BorderRadius.circular(8),
          defaultTextStyle: TextStyle(
            color: Colors.grey[200],
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 博客编辑器

```dart
class BlogEditorExample extends StatefulWidget {
  @override
  _BlogEditorExampleState createState() => _BlogEditorExampleState();
}

class _BlogEditorExampleState extends State<BlogEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  bool _isPreviewMode = false;

  @override
  void dispose() {
    _titleController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('博客编辑器'),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              setState(() => _isPreviewMode = !_isPreviewMode);
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBlog,
          ),
        ],
      ),
      body: _isPreviewMode ? _buildPreview() : _buildEditor(),
    );
  }

  Widget _buildEditor() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题输入
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: '文章标题',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // 标签输入
          TextField(
            controller: _tagsController,
            decoration: InputDecoration(
              labelText: '标签 (用逗号分隔)',
              border: OutlineInputBorder(),
              hintText: '技术, 编程, Flutter',
            ),
          ),
          SizedBox(height: 24),
          // 富文本编辑器
          Card(
            child: Column(
              children: [
                // 博客专用工具栏
                ZephyrRichEditorToolbar(
                  controller: _controller,
                  showFormatButtons: true,
                  showHeadingButtons: true,
                  showListButtons: true,
                  showLinkButton: true,
                  showImageButton: true,
                  showCodeButton: true,
                  showQuoteButton: true,
                  customButtons: [
                    ZephyrRichEditorCustomButton(
                      icon: Icons.read_more,
                      tooltip: '插入阅读更多',
                      onPressed: _insertReadMore,
                    ),
                  ],
                ),
                // 编辑器
                Container(
                  height: 400,
                  child: ZephyrRichEditor(
                    controller: _controller,
                    placeholder: '开始撰写你的博客文章...',
                    initialContent: '''
                      <h2>文章标题</h2>
                      <p>在这里开始写你的文章内容...</p>
                      <h3>小标题</h3>
                      <p>继续你的内容...</p>
                    ''',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    final title = _titleController.text.isNotEmpty
        ? _titleController.text
        : '无标题';
    final content = _controller.getHtml();
    final tags = _tagsController.text.split(',').map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题
              Text(
                title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // 标签
              Wrap(
                spacing: 8,
                children: tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    backgroundColor: Colors.blue[100],
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
              // 内容
              Divider(),
              SizedBox(height: 24),
              // HTML内容预览
              Container(
                width: double.infinity,
                child: HtmlWidget(content),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _insertReadMore() {
    _controller.insertHtml('<!--read_more-->');
  }

  void _saveBlog() {
    final blog = {
      'title': _titleController.text,
      'content': _controller.getHtml(),
      'tags': _tagsController.text.split(',').map((tag) => tag.trim()).toList(),
      'createdAt': DateTime.now().toIso8601String(),
    };
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('博客文章已保存'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
```

### 邮件编辑器

```dart
class EmailEditorExample extends StatefulWidget {
  @override
  _EmailEditorExampleState createState() => _EmailEditorExampleState();
}

class _EmailEditorExampleState extends State<EmailEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _ccController = TextEditingController();

  @override
  void dispose() {
    _toController.dispose();
    _subjectController.dispose();
    _ccController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('邮件编辑器'),
        actions: [
          IconButton(
            icon: Icons.send,
            onPressed: _sendEmail,
          ),
        ],
      ),
      body: Column(
        children: [
          // 收件人
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: '收件人',
                border: OutlineInputBorder(),
                hintText: 'example@email.com',
              ),
            ),
          ),
          // 抄送
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _ccController,
              decoration: InputDecoration(
                labelText: '抄送',
                border: OutlineInputBorder(),
                hintText: 'cc@email.com',
              ),
            ),
          ),
          // 主题
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: '主题',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Divider(),
          // 邮件内容编辑器
          Expanded(
            child: ZephyrRichEditor(
              controller: _controller,
              placeholder: '邮件内容...',
              initialContent: '''
                <p>您好，</p>
                <p></p>
                <p>祝好，<br>
                [您的名字]</p>
              ''',
              style: ZephyrRichEditorStyle(
                toolbarBackgroundColor: Colors.grey[50],
                buttonColor: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendEmail() {
    final email = {
      'to': _toController.text,
      'cc': _ccController.text,
      'subject': _subjectController.text,
      'content': _controller.getHtml(),
      'sentAt': DateTime.now().toIso8601String(),
    };
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('邮件已发送'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
```

### 产品描述编辑器

```dart
class ProductDescriptionEditorExample extends StatefulWidget {
  @override
  _ProductDescriptionEditorExampleState createState() => _ProductDescriptionEditorExampleState();
}

class _ProductDescriptionEditorExampleState extends State<ProductDescriptionEditorExample> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final List<String> _features = [];
  final TextEditingController _featureController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _featureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('产品描述编辑器'),
        actions: [
          IconButton(
            icon: Icons.save,
            onPressed: _saveProduct,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 产品基本信息
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _productNameController,
                      decoration: InputDecoration(
                        labelText: '产品名称',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: '价格',
                        border: OutlineInputBorder(),
                        prefixText: '¥',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // 产品特性
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '产品特性',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _featureController,
                            decoration: InputDecoration(
                              labelText: '添加特性',
                              border: OutlineInputBorder(),
                              hintText: '例如：防水、长续航',
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addFeature,
                          child: Text('添加'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _features.map((feature) {
                        return InputChip(
                          label: Text(feature),
                          onDeleted: () => _removeFeature(feature),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // 产品描述编辑器
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '产品描述',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 产品专用工具栏
                  ZephyrRichEditorToolbar(
                    controller: _controller,
                    showFormatButtons: true,
                    showListButtons: true,
                    showLinkButton: true,
                    showImageButton: true,
                    customButtons: [
                      ZephyrRichEditorCustomButton(
                        icon: Icons.star,
                        tooltip: '插入产品亮点',
                        onPressed: _insertProductHighlight,
                      ),
                      ZephyrRichEditorCustomButton(
                        icon: Icons.specs,
                        tooltip: '插入规格参数',
                        onPressed: _insertSpecifications,
                      ),
                    ],
                  ),
                  // 编辑器
                  Container(
                    height: 300,
                    child: ZephyrRichEditor(
                      controller: _controller,
                      placeholder: '详细描述您的产品...',
                      initialContent: '''
                        <h3>产品概述</h3>
                        <p>在这里描述您的产品的主要特点和优势...</p>
                        
                        <h3>产品亮点</h3>
                        <ul>
                          <li>亮点1</li>
                          <li>亮点2</li>
                          <li>亮点3</li>
                        </ul>
                      ''',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addFeature() {
    if (_featureController.text.isNotEmpty) {
      setState(() {
        _features.add(_featureController.text);
        _featureController.clear();
      });
    }
  }

  void _removeFeature(String feature) {
    setState(() {
      _features.remove(feature);
    });
  }

  void _insertProductHighlight() {
    _controller.insertHtml('''
      <div style="background-color: #fff3cd; padding: 12px; border-radius: 4px; margin: 8px 0;">
        <strong>产品亮点：</strong> 在这里描述产品的突出特点
      </div>
    ''');
  }

  void _insertSpecifications() {
    _controller.insertHtml('''
      <div style="background-color: #f8f9fa; padding: 12px; border-radius: 4px; margin: 8px 0;">
        <h4>规格参数：</h4>
        <ul>
          <li>参数1：数值</li>
          <li>参数2：数值</li>
          <li>参数3：数值</li>
        </ul>
      </div>
    ''');
  }

  void _saveProduct() {
    final product = {
      'name': _productNameController.text,
      'price': _priceController.text,
      'features': _features,
      'description': _controller.getHtml(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('产品信息已保存'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrRichEditor()

```dart
const ZephyrRichEditor({
  Key? key,
  required ZephyrRichEditorController controller,
  String? placeholder,
  String? initialContent,
  ValueChanged<String>? onChanged,
  ZephyrRichEditorStyle? style,
  bool toolbar = true,
  Widget? customToolbar,
  EdgeInsetsGeometry? padding,
  FocusNode? focusNode,
  bool autoFocus = false,
  int? minLines,
  int? maxLines,
  bool expands = false,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `controller`: 编辑器控制器
- `placeholder`: 占位符文本
- `initialContent`: 初始内容
- `onChanged`: 内容变化回调
- `style`: 编辑器样式
- `toolbar`: 是否显示工具栏
- `customToolbar`: 自定义工具栏
- `padding`: 内边距
- `focusNode`: 焦点节点
- `autoFocus`: 是否自动获取焦点
- `minLines`: 最小行数
- `maxLines`: 最大行数
- `expands`: 是否扩展填充
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrRichEditorController

```dart
class ZephyrRichEditorController {
  // 获取HTML内容
  String getHtml();
  
  // 设置HTML内容
  void setHtml(String html);
  
  // 获取纯文本内容
  String getText();
  
  // 插入HTML
  void insertHtml(String html);
  
  // 插入文本
  void insertText(String text);
  
  // 执行格式化命令
  void formatText(ZephyrRichEditorFormat format);
  
  // 撤销
  void undo();
  
  // 重做
  void redo();
  
  // 清空内容
  void clear();
  
  // 是否为空
  bool isEmpty();
  
  // 是否有撤销历史
  bool get canUndo;
  
  // 是否有重做历史
  bool get canRedo;
}
```

### 枚举类型

#### ZephyrRichEditorFormat

```dart
enum ZephyrRichEditorFormat {
  bold,          // 加粗
  italic,        // 斜体
  underline,     // 下划线
  strikethrough, // 删除线
  superscript,   // 上标
  subscript,     // 下标
}
```

#### ZephyrRichEditorAlignment

```dart
enum ZephyrRichEditorAlignment {
  left,    // 左对齐
  center,  // 居中对齐
  right,   // 右对齐
  justify, // 两端对齐
}
```

#### ZephyrRichEditorListType

```dart
enum ZephyrRichEditorListType {
  unordered, // 无序列表
  ordered,   // 有序列表
}
```

#### ZephyrRichEditorInsertType

```dart
enum ZephyrRichEditorInsertType {
  link,   // 链接
  image,  // 图片
  table,  // 表格
  video,  // 视频
  hr,     // 分割线
}
```

### 样式类

#### ZephyrRichEditorStyle

```dart
class ZephyrRichEditorStyle {
  final Color? backgroundColor;
  final Color? toolbarBackgroundColor;
  final Color? toolbarBorderColor;
  final Color? buttonColor;
  final Color? buttonHoverColor;
  final Color? placeholderColor;
  final Color? focusBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final BoxBorder? editorBorder;
  final BorderRadius? editorBorderRadius;
  final TextStyle? defaultTextStyle;
  final double? toolbarHeight;
  final double? buttonSize;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrRichEditorTheme(
        backgroundColor: Colors.white,
        toolbarBackgroundColor: Colors.grey[50],
        toolbarBorderColor: Colors.grey[300],
        buttonColor: Colors.grey[700],
        buttonHoverColor: Colors.grey[900],
        placeholderColor: Colors.grey[400],
        focusBorderColor: Colors.blue[400],
        contentPadding: EdgeInsets.all(16),
        editorBorder: Border.all(color: Colors.grey[300]),
        editorBorderRadius: BorderRadius.circular(4),
        defaultTextStyle: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Colors.black87,
        ),
        toolbarHeight: 48,
        buttonSize: 24,
        selectionColor: Colors.blue.withOpacity(0.2),
        linkColor: Colors.blue,
        codeBackgroundColor: Colors.grey[100],
        codeTextColor: Colors.grey[800],
        quoteBorderColor: Colors.grey[400],
        quoteBackgroundColor: Colors.grey[50],
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `backgroundColor`: 背景颜色
- `toolbarBackgroundColor`: 工具栏背景颜色
- `toolbarBorderColor`: 工具栏边框颜色
- `buttonColor`: 按钮颜色
- `buttonHoverColor`: 按钮悬停颜色
- `placeholderColor`: 占位符颜色
- `focusBorderColor`: 焦点边框颜色
- `contentPadding`: 内容内边距
- `editorBorder`: 编辑器边框
- `editorBorderRadius`: 编辑器边框圆角
- `defaultTextStyle`: 默认文本样式
- `toolbarHeight`: 工具栏高度
- `buttonSize`: 按钮大小
- `selectionColor`: 选择颜色
- `linkColor`: 链接颜色
- `codeBackgroundColor`: 代码背景颜色
- `codeTextColor`: 代码文本颜色
- `quoteBorderColor`: 引用边框颜色
- `quoteBackgroundColor`: 引用背景颜色

## 🏆 最佳实践

### 1. 合理的编辑器配置

```dart
// ✅ 好的做法：根据使用场景配置编辑器
ZephyrRichEditor(
  controller: _controller,
  toolbar: true, // 博客编辑器需要完整的工具栏
)

ZephyrRichEditor(
  controller: _controller,
  toolbar: false, // 评论编辑器可以隐藏工具栏
)

// ❌ 避免的做法：配置与场景不匹配
ZephyrRichEditor(
  controller: _controller,
  toolbar: false, // 博客编辑器需要工具栏但被隐藏
)
```

### 2. 内容验证和处理

```dart
// ✅ 好的做法：验证内容
bool _validateContent(String content) {
  if (content.trim().isEmpty) {
    return false;
  }
  
  // 检查是否有恶意脚本
  if (content.contains('<script>') || content.contains('javascript:')) {
    return false;
  }
  
  return true;
}

// ✅ 好的做法：清理HTML内容
String _sanitizeHtml(String html) {
  // 移除危险的HTML标签和属性
  return html.replaceAll(RegExp(r'<script[^>]*>.*?</script>', ''), '');
}

// ❌ 避免的做法：直接保存用户输入
void _saveContent() {
  final content = _controller.getHtml();
  _database.save(content); // 可能包含恶意内容
}
```

### 3. 性能优化

```dart
// ✅ 好的做法：使用防抖处理内容变化
class DebouncedEditor extends StatefulWidget {
  @override
  _DebouncedEditorState createState() => _DebouncedEditorState();
}

class _DebouncedEditorState extends State<DebouncedEditor> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();
  Timer? _debounceTimer;
  
  @override
  Widget build(BuildContext context) {
    return ZephyrRichEditor(
      controller: _controller,
      onChanged: (content) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(Duration(milliseconds: 500), () {
          _saveContent(content);
        });
      },
    );
  }
}

// ✅ 好的做法：限制内容长度
ZephyrRichEditor(
  controller: _controller,
  maxLines: 10, // 限制最大行数
)

// ❌ 避免的做法：频繁保存和处理
class BadPerformanceEditor extends StatefulWidget {
  @override
  _BadPerformanceEditorState createState() => _BadPerformanceEditorState();
}

class _BadPerformanceEditorState extends State<BadPerformanceEditor> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();
  
  @override
  Widget build(BuildContext context) {
    return ZephyrRichEditor(
      controller: _controller,
      onChanged: (content) {
        _saveContent(content); // 每次输入都保存，影响性能
      },
    );
  }
}
```

### 4. 用户体验

```dart
// ✅ 好的做法：提供自动保存
class AutoSaveEditor extends StatefulWidget {
  @override
  _AutoSaveEditorState createState() => _AutoSaveEditorState();
}

class _AutoSaveEditorState extends State<AutoSaveEditor> {
  final ZephyrRichEditorController _controller = ZephyrRichEditorController();
  DateTime? _lastSaved;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrRichEditor(
          controller: _controller,
          onChanged: (content) {
            _autoSave(content);
          },
        ),
        if (_lastSaved != null)
          Text(
            '最后保存: ${_formatTime(_lastSaved!)}',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
      ],
    );
  }
  
  void _autoSave(String content) {
    final now = DateTime.now();
    if (_lastSaved == null || now.difference(_lastSaved!).inSeconds > 30) {
      _saveContent(content);
      setState(() => _lastSaved = now);
    }
  }
}

// ✅ 好的做法：提供撤销/重做提示
ZephyrRichEditor(
  controller: _controller,
  toolbar: true,
)

// ❌ 避免的做法：缺乏用户反馈
ZephyrRichEditor(
  controller: _controller,
  // 用户不知道内容是否已保存
)
```

### 5. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrRichEditor(
  semanticLabel: '文章内容编辑器',
  enableAccessibilityFeatures: true,
  controller: _controller,
)

// ✅ 好的做法：为工具栏按钮提供提示
ZephyrRichEditorFormatButton(
  controller: _controller,
  format: ZephyrRichEditorFormat.bold,
  icon: Icons.format_bold,
  tooltip: '加粗文本',
)

// ✅ 好的做法：支持键盘快捷键
ZephyrRichEditor(
  controller: _controller,
  enableAccessibilityFeatures: true,
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrRichEditor(
  controller: _controller,
  // 缺乏语义信息和键盘支持
)
```

## 🔄 相关组件

- **ZephyrInput**: 输入框组件
- **ZephyrButton**: 按钮组件
- **ZephyrToolbar**: 工具栏组件
- **ZephyrDialog**: 对话框组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本富文本编辑功能
- ✅ 支持自定义工具栏和样式
- ✅ 支持多种内容插入和格式化
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/advanced/rich_editor/`
**示例路径**: `example/lib/components/rich_editor_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日