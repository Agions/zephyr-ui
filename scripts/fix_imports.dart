#!/usr/bin/env dart

import 'dart:io';

/// 脚本：将相对路径导入转换为 package:zephyr_ui 绝对路径导入
/// 
/// 使用方法：
/// 1. 在项目根目录运行：dart scripts/fix_imports.dart
/// 2. 或者直接运行：dart fix_imports.dart

void main() async {
  print('🔧 开始修复相对路径导入...\n');
  
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('❌ 错误：找不到 lib 目录');
    return;
  }

  final dartFiles = await _findDartFiles(libDir);
  print('📁 找到 ${dartFiles.length} 个 Dart 文件\n');

  int totalChanges = 0;
  int filesChanged = 0;

  for (final file in dartFiles) {
    final changes = await _fixImportsInFile(file);
    if (changes > 0) {
      filesChanged++;
      totalChanges += changes;
      print('✅ ${file.path} - 修复了 $changes 个导入');
    }
  }

  print('\n🎉 导入修复完成！');
  print('📊 统计：');
  print('   - 修改的文件数：$filesChanged');
  print('   - 总修复的导入数：$totalChanges');
}

/// 查找所有 Dart 文件
Future<List<File>> _findDartFiles(Directory directory) async {
  final files = <File>[];
  await for (final entity in directory.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      files.add(entity);
    }
  }
  return files;
}

/// 修复单个文件中的导入
Future<int> _fixImportsInFile(File file) async {
  final content = await file.readAsString();
  final lines = content.split('\n');
  int changes = 0;

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final newLine = _fixImportLine(line, file.path);
    
    if (newLine != line) {
      lines[i] = newLine;
      changes++;
    }
  }

  if (changes > 0) {
    await file.writeAsString(lines.join('\n'));
  }

  return changes;
}

/// 修复单行导入
String _fixImportLine(String line, String filePath) {
  // 简化的匹配逻辑：检查是否以 import 开头并包含相对路径
  if (!line.trimLeft().startsWith('import ')) {
    return line;
  }

  // 检查是否包含相对路径
  if (!line.contains("'../") && !line.contains('"../')) {
    return line;
  }

  // 使用字符串操作提取路径
  final quoteIndex1 = line.indexOf("'");
  final quoteIndex2 = line.indexOf('"');
  
  int quoteStart = -1;
  if (quoteIndex1 != -1 && quoteIndex2 != -1) {
    quoteStart = quoteIndex1 < quoteIndex2 ? quoteIndex1 : quoteIndex2;
  } else if (quoteIndex1 != -1) {
    quoteStart = quoteIndex1;
  } else if (quoteIndex2 != -1) {
    quoteStart = quoteIndex2;
  }
  
  if (quoteStart == -1) {
    return line;
  }

  final quoteEnd = line.indexOf(line[quoteStart], quoteStart + 1);
  if (quoteEnd == -1) {
    return line;
  }

  final relativePath = line.substring(quoteStart + 1, quoteEnd);
  if (!relativePath.startsWith('../')) {
    return line;
  }

  // 提取别名部分
  final aliasMatch = RegExp(r'as\s+(\w+)').firstMatch(line);
  final alias = aliasMatch?.group(1);

  // 计算绝对路径
  final absolutePath = _convertRelativeToAbsolute(relativePath, filePath);
  
  // 构建新的导入语句
  String newImport = "import '$absolutePath'";
  if (alias != null) {
    newImport += ' as $alias';
  }
  newImport += ';';
  
  return newImport;
}

/// 将相对路径转换为绝对路径
String _convertRelativeToAbsolute(String relativePath, String currentFilePath) {
  // 获取当前文件在 lib 目录中的相对路径
  final libIndex = currentFilePath.indexOf('lib/');
  if (libIndex == -1) {
    return relativePath; // 如果不在 lib 目录中，保持原样
  }

  final currentRelativePath = currentFilePath.substring(libIndex + 4); // 去掉 'lib/'
  final currentDir = currentRelativePath.substring(0, currentRelativePath.lastIndexOf('/'));
  
  // 处理相对路径
  List<String> pathParts = currentDir.split('/');
  final relativeParts = relativePath.split('/');
  
  for (final part in relativeParts) {
    if (part == '..') {
      if (pathParts.isNotEmpty) {
        pathParts.removeLast();
      }
    } else if (part != '.') {
      pathParts.add(part);
    }
  }
  
  final absolutePath = pathParts.join('/');
  return 'package:zephyr_ui/$absolutePath';
}