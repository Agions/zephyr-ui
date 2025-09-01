#!/usr/bin/env dart

import 'dart:io';

void main() {
  final projectDir = Directory.current;
  final filesToRename = <String, String>{};
  
  print('=== 文件重命名分析工具 ===');
  print('项目目录: ${projectDir.path}');
  print('');
  
  // 分析需要重命名的文件
  _analyzeFiles(projectDir, filesToRename);
  
  if (filesToRename.isEmpty) {
    print('✅ 所有文件名都符合 snake_case 规范');
    return;
  }
  
  print('📋 发现 ${filesToRename.length} 个需要重命名的文件:');
  print('');
  
  filesToRename.forEach((oldPath, newPath) {
    final oldName = oldPath.split('/').last;
    final newName = newPath.split('/').last;
    print('📁 ${oldName} → ${newName}');
    print('   ${oldPath}');
    print('   ${newPath}');
    print('');
  });
  
  // 检查可能的冲突
  _checkConflicts(filesToRename);
  
  // 生成重命名脚本
  _generateRenameScript(filesToRename);
}

void _analyzeFiles(Directory dir, Map<String, String> filesToRename) {
  final entities = dir.listSync(recursive: false, followLinks: false);
  
  for (final entity in entities) {
    if (entity is File) {
      final path = entity.path;
      if (path.endsWith('.dart') && !path.contains('.dart_tool')) {
        final fileName = path.split('/').last;
        final newFileName = _convertToSnakeCase(fileName);
        
        if (fileName != newFileName) {
          filesToRename[path] = path.replaceAll(fileName, newFileName);
        }
      }
    } else if (entity is Directory) {
      final dirName = entity.path.split('/').last;
      final newDirName = _convertToSnakeCase(dirName);
      
      if (dirName != newDirName && !dirName.startsWith('.')) {
        // 递归分析子目录
        _analyzeFiles(entity, filesToRename);
      }
    }
  }
}

String _convertToSnakeCase(String name) {
  // 移除.dart扩展名
  final withoutExtension = name.endsWith('.dart') 
      ? name.substring(0, name.length - 5) 
      : name;
  
  // 转换为snake_case
  final snakeCase = withoutExtension
      .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) => '${match.group(1)}_${match.group(2)}')
      .toLowerCase();
  
  // 重新添加扩展名
  return name.endsWith('.dart') ? '${snakeCase}.dart' : snakeCase;
}

void _checkConflicts(Map<String, String> filesToRename) {
  print('🔍 检查重命名冲突...');
  
  final newPaths = filesToRename.values.toList();
  final conflicts = <String, List<String>>{};
  
  for (int i = 0; i < newPaths.length; i++) {
    for (int j = i + 1; j < newPaths.length; j++) {
      if (newPaths[i] == newPaths[j]) {
        final conflictPath = newPaths[i];
        if (!conflicts.containsKey(conflictPath)) {
          conflicts[conflictPath] = [];
        }
        conflicts[conflictPath]!.add(filesToRename.keys.elementAt(i));
        conflicts[conflictPath]!.add(filesToRename.keys.elementAt(j));
      }
    }
  }
  
  if (conflicts.isNotEmpty) {
    print('❌ 发现 ${conflicts.length} 个冲突:');
    conflicts.forEach((path, oldPaths) {
      print('   冲突路径: ${path}');
      for (final oldPath in oldPaths) {
        print('     - ${oldPath}');
      }
    });
  } else {
    print('✅ 没有发现冲突');
  }
  
  print('');
}

void _generateRenameScript(Map<String, String> filesToRename) {
  var script = '''
#!/bin/bash

# 文件重命名脚本
# 自动生成的重命名命令

echo "开始重命名文件..."

''';
  
  filesToRename.forEach((oldPath, newPath) {
    script += '''
# 重命名: ${oldPath.split('/').last} → ${newPath.split('/').last}
mv "${oldPath}" "${newPath}"
''';
  });
  
  script += '''

echo "重命名完成!"
echo "总共重命名了 ${filesToRename.length} 个文件"
''';
  
  final scriptFile = File('rename_files.sh');
  scriptFile.writeAsStringSync(script);
  
  print('📝 已生成重命名脚本: rename_files.sh');
  print('💡 运行命令: bash rename_files.sh');
  print('');
  print('⚠️  提醒: 重命名文件后，需要更新所有相关的import语句');
}