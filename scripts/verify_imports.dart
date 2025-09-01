#!/usr/bin/env dart

import 'dart:io';

/// 验证脚本：检查是否还有相对路径导入
/// 
/// 使用方法：
/// 1. 在项目根目录运行：dart scripts/verify_imports.dart
/// 2. 或者直接运行：dart verify_imports.dart

void main() async {
  print('🔍 验证导入转换结果...\n');
  
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('❌ 错误：找不到 lib 目录');
    return;
  }

  final dartFiles = await _findDartFiles(libDir);
  print('📁 检查 ${dartFiles.length} 个 Dart 文件\n');

  int relativeImportCount = 0;
  int packageImportCount = 0;
  final filesWithRelativeImports = <String>[];

  for (final file in dartFiles) {
    final content = await file.readAsString();
    final lines = content.split('\n');
    
    for (final line in lines) {
      if (line.trimLeft().startsWith('import ')) {
        if (line.contains("'../") || line.contains('"../')) {
          relativeImportCount++;
          if (!filesWithRelativeImports.contains(file.path)) {
            filesWithRelativeImports.add(file.path);
          }
        } else if (line.contains('package:zephyr_ui/')) {
          packageImportCount++;
        }
      }
    }
  }

  print('📊 验证结果：');
  print('   - 相对导入数量：$relativeImportCount');
  print('   - Package导入数量：$packageImportCount');
  print('   - 包含相对导入的文件数：${filesWithRelativeImports.length}');
  
  if (filesWithRelativeImports.isNotEmpty) {
    print('\n⚠️  以下文件仍包含相对导入：');
    for (final file in filesWithRelativeImports) {
      print('   - $file');
    }
    print('\n❌ 验证失败：仍有相对导入需要处理');
  } else {
    print('\n✅ 验证通过：所有相对导入已成功转换为绝对导入！');
  }
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