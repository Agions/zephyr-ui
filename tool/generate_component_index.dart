import 'dart:io';
import 'dart:convert';

void main() {
  print('📋 生成组件索引...');

  final projectRoot = Directory.current.path;
  final libDir = Directory('$projectRoot/lib');

  if (!libDir.existsSync()) {
    print('❌ lib 目录不存在');
    return;
  }

  final components = <Map<String, dynamic>>[];

  // 扫描组件目录
  final componentDirs = [
    'lib/src/components/basic',
    'lib/src/components/form',
    'lib/src/components/display',
    'lib/src/components/charts',
    'lib/src/components/advanced',
  ];

  for (final dirPath in componentDirs) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;

    print('🔍 扫描目录: $dirPath');

    final files = dir.listSync(recursive: true, followLinks: false);
    for (final file in files) {
      if (file is File && file.path.endsWith('.dart') && !file.path.contains('.g.dart')) {
        final componentInfo = _parseComponentFile(file);
        if (componentInfo != null) {
          components.add(componentInfo);
        }
      }
    }
  }

  // 生成组件索引
  final index = _generateComponentIndex(components);

  // 保存到文件
  final outputFile = File('$projectRoot/doc/components.md');
  outputFile.writeAsStringSync(index);

  print('✅ 组件索引生成完成: ${components.length} 个组件');
  print('📄 输出文件: ${outputFile.path}');
}

Map<String, dynamic>? _parseComponentFile(File file) {
  try {
    final content = file.readAsStringSync();
    final lines = content.split('\n');

    String? className;
    String? description;
    final properties = <String, String>{};
    final methods = <String, String>{};

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      // 查找类定义
      if (line.startsWith('class ') && line.contains('extends')) {
        className = line.split(' ')[1].split(' ')[0];
        continue;
      }

      // 查找描述注释
      if (line.startsWith('///') && !line.startsWith('/// {@')) {
        final desc = line.substring(3).trim();
        if (description == null) {
          description = desc;
        } else {
          description = '$description $desc';
        }
      }

      // 查找属性
      if (line.startsWith('final ') || line.startsWith('late final ')) {
        final parts = line.split(' ');
        if (parts.length >= 3) {
          final type = parts[1];
          final name = parts[2].replaceAll(';', '');
          properties[name] = type;
        }
      }

      // 查找方法
      if (line.contains('void ') || line.contains('Widget ') || line.contains('Future<void>')) {
        if (line.contains('(') && line.contains(')')) {
          final methodMatch = RegExp(r'(?:void|Widget|Future<void>)\s+(\w+)\s*\(').firstMatch(line);
          if (methodMatch != null) {
            final methodName = methodMatch.group(1);
            final returnType = line.contains('void') ? 'void' :
                             line.contains('Widget') ? 'Widget' : 'Future<void>';
            methods[methodName!] = returnType;
          }
        }
      }
    }

    if (className != null) {
      return {
        'name': className,
        'description': description ?? '暂无描述',
        'file': file.path.split('/').last,
        'path': file.path,
        'properties': properties,
        'methods': methods,
        'category': _getCategoryFromPath(file.path),
      };
    }
  } catch (e) {
    print('⚠️ 解析文件失败: ${file.path} - $e');
  }

  return null;
}

String _getCategoryFromPath(String path) {
  if (path.contains('/basic/')) return '基础组件';
  if (path.contains('/form/')) return '表单组件';
  if (path.contains('/display/')) return '数据展示组件';
  if (path.contains('/charts/')) return '图表组件';
  if (path.contains('/advanced/')) return '高级组件';
  return '其他组件';
}

String _generateComponentIndex(List<Map<String, dynamic>> components) {
  final buffer = StringBuffer();

  buffer.writeln('# chromaUI 组件索引');
  buffer.writeln('');
  buffer.writeln('## 概述');
  buffer.writeln('');
  buffer.writeln('本文档列出了 chromaUI 中的所有组件，包含其描述、属性和方法。');
  buffer.writeln('');
  buffer.writeln('## 组件统计');
  buffer.writeln('');
  buffer.writeln('- 总组件数: ${components.length}');

  // 按类别统计
  final categories = <String, int>{};
  for (final component in components) {
    final category = component['category'] as String;
    categories[category] = (categories[category] ?? 0) + 1;
  }

  for (final entry in categories.entries) {
    buffer.writeln('- $entry.key: ${entry.value}');
  }

  buffer.writeln('');

  // 按类别分组
  final groupedComponents = <String, List<Map<String, dynamic>>>{};
  for (final component in components) {
    final category = component['category'] as String;
    groupedComponents.putIfAbsent(category, () => []).add(component);
  }

  // 生成各类别的组件列表
  for (final category in groupedComponents.keys) {
    buffer.writeln('## $category');
    buffer.writeln('');

    final categoryComponents = groupedComponents[category]!;
    for (final component in categoryComponents) {
      buffer.writeln('### ${component['name']}');
      buffer.writeln('');
      buffer.writeln('**描述**: ${component['description']}');
      buffer.writeln('');
      buffer.writeln('**文件**: `${component['file']}`');
      buffer.writeln('');

      final properties = component['properties'] as Map<String, dynamic>;
      if (properties.isNotEmpty) {
        buffer.writeln('**属性**:');
        buffer.writeln('');
        for (final prop in properties.entries) {
          buffer.writeln('- `${prop.key}`: `${prop.value}`');
        }
        buffer.writeln('');
      }

      final methods = component['methods'] as Map<String, dynamic>;
      if (methods.isNotEmpty) {
        buffer.writeln('**方法**:');
        buffer.writeln('');
        for (final method in methods.entries) {
          buffer.writeln('- `${method.key}`(): `${method.value}`');
        }
        buffer.writeln('');
      }

      buffer.writeln('---');
      buffer.writeln('');
    }
  }

  // 生成快速索引
  buffer.writeln('## 快速索引');
  buffer.writeln('');
  buffer.writeln('| 组件名 | 类别 | 描述 |');
  buffer.writeln('|--------|------|------|');

  for (final component in components) {
    final name = component['name'] as String;
    final category = component['category'] as String;
    final description = component['description'] as String;
    final shortDesc = description.length > 50 ? '${description.substring(0, 50)}...' : description;

    buffer.writeln('| [`$name`](#${name.toLowerCase()}) | $category | $shortDesc |');
  }

  buffer.writeln('');

  // 生成使用示例
  buffer.writeln('## 使用示例');
  buffer.writeln('');
  buffer.writeln('### 基础使用');
  buffer.writeln('```dart');
  buffer.writeln('import \'package:chroma_ui/chroma_ui.dart\';');
  buffer.writeln('');
  buffer.writeln('class MyWidget extends StatelessWidget {');
  buffer.writeln('  @override');
  buffer.writeln('  Widget build(BuildContext context) {');
  buffer.writeln('    return chromaContainer(');
  buffer.writeln('      child: chromaText(\'Hello, chromaUI!\'),');
  buffer.writeln('    );');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln('```');
  buffer.writeln('');

  buffer.writeln('### 组件查找');
  buffer.writeln('');
  buffer.writeln('如果需要查找特定组件，可以：');
  buffer.writeln('1. 使用浏览器的查找功能 (Ctrl+F)');
  buffer.writeln('2. 查看快速索引表');
  buffer.writeln('3. 按类别浏览组件');
  buffer.writeln('');

  buffer.writeln('### 贡献');
  buffer.writeln('');
  buffer.writeln('如果发现组件信息有误或需要补充，请：');
  buffer.writeln('1. 在组件源码中添加或更新注释');
  buffer.writeln('2. 重新运行组件索引生成脚本');
  buffer.writeln('3. 提交 PR 到仓库');
  buffer.writeln('');

  buffer.writeln('---');
  buffer.writeln('');
  buffer.writeln('*此文档由脚本自动生成，最后更新时间: ${DateTime.now().toIso8601String()}*');

  return buffer.toString();
}
