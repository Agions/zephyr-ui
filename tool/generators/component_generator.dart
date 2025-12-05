import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

/// ZephyrUI 组件代码生成器
/// 
/// 功能：
/// - 自动生成组件代码模板
/// - 生成测试文件
/// - 生成文档
/// - 生成示例代码
class ComponentGenerator {
  
  ComponentGenerator({
    required String templateDir,
    required String outputDir,
  }) : _templateDir = templateDir,
       _outputDir = outputDir;
  final String _templateDir;
  final String _outputDir;
  
  /// 生成新组件
  Future<void> generateComponent({
    required String componentName,
    required String componentType,
    Map<String, dynamic>? customOptions,
  }) async {
    final template = await _loadTemplate(componentType);
    final generatedCode = await _generateCodeFromTemplate(
      template,
      componentName,
      customOptions ?? {},
    );
    
    await _saveGeneratedFiles(componentName, generatedCode);
  }
  
  /// 批量生成组件
  Future<void> generateComponents(List<ComponentConfig> configs) async {
    for (final config in configs) {
      await generateComponent(
        componentName: config.name,
        componentType: config.type,
        customOptions: config.options,
      );
    }
  }
  
  /// 生成主题文件
  Future<void> generateThemeFile(String themeName) async {
    final template = await _loadTemplate('theme');
    final generatedCode = await _generateCodeFromTemplate(
      template,
      themeName,
      {'type': 'theme'},
    );
    
    await _saveThemeFile(themeName, generatedCode);
  }
  
  /// 生成测试文件
  Future<void> generateTestFile(String componentName) async {
    final template = await _loadTemplate('test');
    final generatedCode = await _generateCodeFromTemplate(
      template,
      componentName,
      {'type': 'test'},
    );
    
    await _saveTestFile(componentName, generatedCode);
  }
  
  /// 生成文档
  Future<void> generateDocumentation(String componentName) async {
    final template = await _loadTemplate('documentation');
    final generatedCode = await _generateCodeFromTemplate(
      template,
      componentName,
      {'type': 'documentation'},
    );
    
    await _saveDocumentationFile(componentName, generatedCode);
  }
  
  /// 生成示例代码
  Future<void> generateExampleCode(String componentName) async {
    final template = await _loadTemplate('example');
    final generatedCode = await _generateCodeFromTemplate(
      template,
      componentName,
      {'type': 'example'},
    );
    
    await _saveExampleFile(componentName, generatedCode);
  }
  
  Future<Map<String, dynamic>> _loadTemplate(String templateType) async {
    final templateFile = File(path.join(_templateDir, '$templateType.json'));
    
    if (!await templateFile.exists()) {
      throw Exception('Template not found: $templateType');
    }
    
    final content = await templateFile.readAsString();
    return json.decode(content) as Map<String, dynamic>;
  }
  
  Future<Map<String, String>> _generateCodeFromTemplate(
    Map<String, dynamic> template,
    String componentName,
    Map<String, dynamic> options,
  ) async {
    final generatedFiles = <String, String>{};
    
    // 替换模板变量
    final variables = {
      'component_name': componentName,
      'component_name_camel': _toCamelCase(componentName),
      'component_name_pascal': _toPascalCase(componentName),
      'component_name_snake': _toSnakeCase(componentName),
      'date': DateTime.now().toIso8601String(),
      ...options,
    };
    
    // 生成主组件文件
    if (template['component'] != null) {
      generatedFiles['component.dart'] = _replaceVariables(
        template['component'] as String,
        variables,
      );
    }
    
    // 生成测试文件
    if (template['test'] != null) {
      generatedFiles['component_test.dart'] = _replaceVariables(
        template['test'] as String,
        variables,
      );
    }
    
    // 生成文档文件
    if (template['documentation'] != null) {
      generatedFiles['README.md'] = _replaceVariables(
        template['documentation'] as String,
        variables,
      );
    }
    
    // 生成示例文件
    if (template['example'] != null) {
      generatedFiles['example.dart'] = _replaceVariables(
        template['example'] as String,
        variables,
      );
    }
    
    return generatedFiles;
  }
  
  Future<void> _saveGeneratedFiles(
    String componentName,
    Map<String, String> generatedFiles,
  ) async {
    final componentDir = Directory(path.join(_outputDir, componentName));
    if (!await componentDir.exists()) {
      await componentDir.create(recursive: true);
    }
    
    for (final entry in generatedFiles.entries) {
      final file = File(path.join(componentDir.path, entry.key));
      await file.writeAsString(entry.value);
    }
  }
  
  Future<void> _saveThemeFile(String themeName, Map<String, String> generatedFiles) async {
    final themeDir = Directory(path.join(_outputDir, 'themes'));
    if (!await themeDir.exists()) {
      await themeDir.create(recursive: true);
    }
    
    final file = File(path.join(themeDir.path, '${themeName}_theme.dart'));
    await file.writeAsString(generatedFiles['component.dart'] ?? '');
  }
  
  Future<void> _saveTestFile(String componentName, Map<String, String> generatedFiles) async {
    final testDir = Directory(path.join(_outputDir, 'test'));
    if (!await testDir.exists()) {
      await testDir.create(recursive: true);
    }
    
    final file = File(path.join(testDir.path, '${componentName}_test.dart'));
    await file.writeAsString(generatedFiles['component_test.dart'] ?? '');
  }
  
  Future<void> _saveDocumentationFile(String componentName, Map<String, String> generatedFiles) async {
    final docDir = Directory(path.join(_outputDir, 'docs'));
    if (!await docDir.exists()) {
      await docDir.create(recursive: true);
    }
    
    final file = File(path.join(docDir.path, '$componentName.md'));
    await file.writeAsString(generatedFiles['README.md'] ?? '');
  }
  
  Future<void> _saveExampleFile(String componentName, Map<String, String> generatedFiles) async {
    final exampleDir = Directory(path.join(_outputDir, 'examples'));
    if (!await exampleDir.exists()) {
      await exampleDir.create(recursive: true);
    }
    
    final file = File(path.join(exampleDir.path, '${componentName}_example.dart'));
    await file.writeAsString(generatedFiles['example.dart'] ?? '');
  }
  
  String _replaceVariables(String template, Map<String, dynamic> variables) {
    var result = template;
    
    for (final entry in variables.entries) {
      result = result.replaceAll('{{${entry.key}}}', entry.value.toString());
    }
    
    return result;
  }
  
  String _toCamelCase(String input) {
    return input[0].toLowerCase() + input.substring(1);
  }
  
  String _toPascalCase(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }
  
  String _toSnakeCase(String input) {
    return input.replaceAllMapped(RegExp(r'(?<=[a-z])(?=[A-Z])'), (match) => '_').toLowerCase();
  }
}

/// 组件配置
class ComponentConfig {
  
  ComponentConfig({
    required this.name,
    required this.type,
    this.options = const {},
  });
  final String name;
  final String type;
  final Map<String, dynamic> options;
}

/// 模板管理器
class TemplateManager {
  
  TemplateManager() {
    _initializeTemplates();
  }
  final Map<String, Map<String, dynamic>> _templates = {};
  
  void _initializeTemplates() {
    // 基础组件模板
    _templates['basic'] = {
      'component': '''
import 'package:flutter/material.dart';

/// {{component_name_pascal}} 组件
/// 
/// 描述：{{component_name_pascal}}是一个基础组件
class {{component_name_pascal}} extends StatelessWidget {
  final String? title;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  
  const {{component_name_pascal}}({
    Key? key,
    this.title,
    this.child,
    this.onTap,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            if (child != null) ...[
              const SizedBox(height: 8),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}
''',
      'test': '''
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('{{component_name_pascal}} Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: {{component_name_pascal}}(
              title: 'Test {{component_name}}',
            ),
          ),
        ),
      );
      
      expect(find.text('Test {{component_name}}'), findsOneWidget);
    });
    
    testWidgets('handles tap gesture', (WidgetTester tester) async {
      bool tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: {{component_name_pascal}}(
              title: 'Test {{component_name}}',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType({{component_name_pascal}}));
      await tester.pump();
      
      expect(tapped, isTrue);
    });
  });
}
''',
      'documentation': '''
# {{component_name_pascal}}

{{component_name_pascal}}是一个基础组件，提供简单易用的界面元素。

## 功能特性

- 支持自定义标题
- 支持子组件
- 支持点击事件
- 支持自定义背景色
- 支持自定义内边距

## 使用示例

```dart
{{component_name_pascal}}(
  title: '标题',
  onTap: () {
    print('点击事件');
  },
  child: Text('子组件'),
)
```

## 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| title | String? | 标题文本 |
| child | Widget? | 子组件 |
| onTap | VoidCallback? | 点击回调 |
| backgroundColor | Color? | 背景颜色 |
| padding | EdgeInsetsGeometry? | 内边距 |
''',
      'example': '''
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class {{component_name_pascal}}Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('{{component_name_pascal}} 示例'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            {{component_name_pascal}}(
              title: '基础用法',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('点击了基础用法')),
                );
              },
            ),
            SizedBox(height: 16),
            {{component_name_pascal}}(
              title: '带子组件',
              child: Text('这是一个子组件'),
            ),
            SizedBox(height: 16),
            {{component_name_pascal}}(
              title: '自定义样式',
              backgroundColor: Colors.blue,
              padding: EdgeInsets.all(24),
            ),
          ],
        ),
      ),
    );
  }
}
''',
    };
    
    // 表单组件模板
    _templates['form'] = {
      'component': '''
import 'package:flutter/material.dart';

/// {{component_name_pascal}} 表单组件
/// 
/// 描述：{{component_name_pascal}}是一个表单组件
class {{component_name_pascal}} extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  
  const {{component_name_pascal}}({
    Key? key,
    this.label,
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
  }) : super(key: key);
  
  @override
  _{{component_name_pascal}}State createState() => _{{component_name_pascal}}State();
}

class _{{component_name_pascal}}State extends State<{{component_name_pascal}}> {
  late TextEditingController _controller;
  String? _errorText;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (widget.label != null) const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: _errorText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            _validateField(value);
          },
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
        ),
      ],
    );
  }
  
  void _validateField(String value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }
}
''',
      'test': '''
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('{{component_name_pascal}} Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: {{component_name_pascal}}(
              label: 'Test Label',
              hintText: 'Enter text',
            ),
          ),
        ),
      );
      
      expect(find.text('Test Label'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
    
    testWidgets('handles text input', (WidgetTester tester) async {
      String? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: {{component_name_pascal}}(
              label: 'Test Label',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );
      
      await tester.enterText(find.byType(TextFormField), 'Hello World');
      await tester.pump();
      
      expect(changedValue, 'Hello World');
    });
    
    testWidgets('validates input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: {{component_name_pascal}}(
              label: 'Test Label',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required';
                }
                return null;
              },
            ),
          ),
        ),
      );
      
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();
      
      expect(find.text('Field is required'), findsOneWidget);
    });
  });
}
''',
    };
    
    // 显示组件模板
    _templates['display'] = {
      'component': '''
import 'package:flutter/material.dart';

/// {{component_name_pascal}} 显示组件
/// 
/// 描述：{{component_name_pascal}}是一个显示组件
class {{component_name_pascal}} extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  
  const {{component_name_pascal}}({
    Key? key,
    required this.title,
    this.subtitle = '',
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 16),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
''',
      'test': '''
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('{{component_name_pascal}} Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: {{component_name_pascal}}(
              title: 'Test Title',
              subtitle: 'Test Subtitle',
            ),
          ),
        ),
      );
      
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });
    
    testWidgets('displays leading and trailing widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: {{component_name_pascal}}(
              title: 'Test Title',
              leading: Icon(Icons.star),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );
      
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });
  });
}
''',
    };
  }
  
  Map<String, dynamic> getTemplate(String type) {
    return _templates[type] ?? _templates['basic']!;
  }
}