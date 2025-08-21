import 'dart:io';

/// ZephyrUI 文件上传工具类
/// 
/// 提供文件上传相关的工具方法，包括文件格式验证、大小格式化等。
class ZephyrUploadUtils {
  /// 格式化文件大小
  /// 
  /// 将字节转换为易读的格式（KB, MB, GB等）
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
  
  /// 获取文件的MIME类型
  /// 
  /// 根据文件扩展名获取对应的MIME类型
  static String? getMimeType(String path) {
    final extension = getFileExtension(path);
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'bmp':
        return 'image/bmp';
      case 'webp':
        return 'image/webp';
      case 'svg':
        return 'image/svg+xml';
      case 'pdf':
        return 'application/pdf';
      case 'txt':
        return 'text/plain';
      case 'html':
        return 'text/html';
      case 'css':
        return 'text/css';
      case 'js':
        return 'application/javascript';
      case 'json':
        return 'application/json';
      case 'xml':
        return 'application/xml';
      case 'zip':
        return 'application/zip';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'mp4':
        return 'video/mp4';
      case 'avi':
        return 'video/x-msvideo';
      case 'mov':
        return 'video/quicktime';
      case 'wmv':
        return 'video/x-ms-wmv';
      case 'flv':
        return 'video/x-flv';
      case 'webm':
        return 'video/webm';
      default:
        return 'application/octet-stream';
    }
  }
  
  /// 获取文件扩展名
  /// 
  /// 从文件路径中提取扩展名
  static String getFileExtension(String path) {
    final lastDot = path.lastIndexOf('.');
    if (lastDot == -1) return '';
    return path.substring(lastDot + 1).toLowerCase();
  }
  
  /// 获取文件名（不含扩展名）
  /// 
  /// 从文件路径中提取文件名（不含扩展名）
  static String getFileNameWithoutExtension(String path) {
    final fileName = getFileName(path);
    final lastDot = fileName.lastIndexOf('.');
    if (lastDot == -1) return fileName;
    return fileName.substring(0, lastDot);
  }
  
  /// 获取文件名
  /// 
  /// 从文件路径中提取文件名
  static String getFileName(String path) {
    final lastSlash = path.lastIndexOf(Platform.pathSeparator);
    if (lastSlash == -1) return path;
    return path.substring(lastSlash + 1);
  }
  
  /// 验证文件类型
  /// 
  /// 检查文件是否在允许的类型列表中
  static bool isFileTypeAllowed(String path, List<String> allowedTypes) {
    if (allowedTypes.isEmpty) return true;
    
    final extension = getFileExtension(path).toLowerCase();
    final mimeType = getMimeType(path);
    
    return allowedTypes.any((type) {
      final lowerType = type.toLowerCase();
      return extension == lowerType || 
             mimeType?.toLowerCase() == lowerType ||
             lowerType.contains('/*') && 
             mimeType?.toLowerCase().startsWith(lowerType.replaceAll('/*', '')) == true;
    });
  }
  
  /// 验证文件大小
  /// 
  /// 检查文件大小是否在允许的范围内
  static bool isFileSizeValid(int size, int maxSize) {
    return size <= maxSize;
  }
  
  /// 验证文件名
  /// 
  /// 检查文件名是否包含非法字符
  static bool isFileNameValid(String fileName) {
    final invalidChars = ['/', '\\', ':', '*', '?', '"', '<', '>', '|'];
    return !invalidChars.any((char) => fileName.contains(char));
  }
  
  /// 生成安全的文件名
  /// 
  /// 移除文件名中的非法字符
  static String sanitizeFileName(String fileName) {
    final invalidChars = ['/', '\\', ':', '*', '?', '"', '<', '>', '|'];
    var sanitized = fileName;
    
    for (final char in invalidChars) {
      sanitized = sanitized.replaceAll(char, '_');
    }
    
    return sanitized;
  }
  
  /// 计算上传进度百分比
  /// 
  /// 根据已上传字节数计算进度百分比
  static double calculateProgress(int uploaded, int total) {
    if (total == 0) return 0.0;
    return uploaded / total;
  }
  
  /// 估算剩余时间
  /// 
  /// 根据当前上传速度估算剩余时间
  static Duration estimateRemainingTime(int uploaded, int total, double speed) {
    if (speed <= 0) return const Duration(days: 999);
    
    final remaining = total - uploaded;
    final remainingSeconds = remaining / speed;
    
    return Duration(seconds: remainingSeconds.toInt());
  }
  
  /// 格式化持续时间
  /// 
  /// 将持续时间格式化为易读的格式
  static String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}天 ${duration.inHours % 24}小时';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}小时 ${duration.inMinutes % 60}分钟';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}分钟 ${duration.inSeconds % 60}秒';
    } else {
      return '${duration.inSeconds}秒';
    }
  }
  
  /// 格式化上传速度
  /// 
  /// 将上传速度格式化为易读的格式
  static String formatUploadSpeed(double bytesPerSecond) {
    if (bytesPerSecond < 1024) {
      return '${bytesPerSecond.toStringAsFixed(1)} B/s';
    } else if (bytesPerSecond < 1024 * 1024) {
      return '${(bytesPerSecond / 1024).toStringAsFixed(1)} KB/s';
    } else if (bytesPerSecond < 1024 * 1024 * 1024) {
      return '${(bytesPerSecond / (1024 * 1024)).toStringAsFixed(1)} MB/s';
    } else {
      return '${(bytesPerSecond / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB/s';
    }
  }
  
  /// 按类型对文件进行分组
  /// 
  /// 将文件列表按类型分组
  static Map<String, List<String>> groupFilesByType(List<String> filePaths) {
    final groups = <String, List<String>>{};
    
    for (final path in filePaths) {
      final extension = getFileExtension(path);
      final category = _getFileCategory(extension);
      
      if (!groups.containsKey(category)) {
        groups[category] = [];
      }
      groups[category]!.add(path);
    }
    
    return groups;
  }
  
  /// 获取文件分类
  /// 
  /// 根据文件扩展名返回文件分类
  static String _getFileCategory(String extension) {
    final imageTypes = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];
    final videoTypes = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm'];
    final audioTypes = ['mp3', 'wav', 'flac', 'aac', 'ogg', 'wma'];
    final docTypes = ['pdf', 'doc', 'docx', 'txt', 'rtf', 'odt'];
    final spreadsheetTypes = ['xls', 'xlsx', 'csv', 'ods'];
    final presentationTypes = ['ppt', 'pptx', 'odp'];
    final archiveTypes = ['zip', 'rar', '7z', 'tar', 'gz'];
    final codeTypes = ['js', 'ts', 'html', 'css', 'py', 'java', 'cpp', 'c', 'php'];
    
    if (imageTypes.contains(extension)) return '图片';
    if (videoTypes.contains(extension)) return '视频';
    if (audioTypes.contains(extension)) return '音频';
    if (docTypes.contains(extension)) return '文档';
    if (spreadsheetTypes.contains(extension)) return '表格';
    if (presentationTypes.contains(extension)) return '演示文稿';
    if (archiveTypes.contains(extension)) return '压缩包';
    if (codeTypes.contains(extension)) return '代码';
    
    return '其他';
  }
  
  /// 生成唯一文件名
  /// 
  /// 生成一个包含时间戳的唯一文件名
  static String generateUniqueFileName(String originalName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = getFileExtension(originalName);
    final nameWithoutExtension = getFileNameWithoutExtension(originalName);
    
    return '${nameWithoutExtension}_$timestamp${extension.isNotEmpty ? '.$extension' : ''}';
  }
  
  /// 检查文件是否存在
  /// 
  /// 检查指定路径的文件是否存在
  static Future<bool> fileExists(String path) async {
    try {
      final file = File(path);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }
  
  /// 删除文件
  /// 
  /// 删除指定路径的文件
  static Future<bool> deleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// 复制文件
  /// 
  /// 将文件从源路径复制到目标路径
  static Future<bool> copyFile(String sourcePath, String targetPath) async {
    try {
      final sourceFile = File(sourcePath);
      
      if (await sourceFile.exists()) {
        await sourceFile.copy(targetPath);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// 获取文件信息
  /// 
  /// 获取文件的详细信息
  static Future<Map<String, dynamic>> getFileInfo(String path) async {
    try {
      final file = File(path);
      if (!await file.exists()) {
        return {};
      }
      
      final stat = await file.stat();
      return {
        'path': path,
        'name': getFileName(path),
        'size': stat.size,
        'lastModified': stat.modified,
        'lastAccessed': stat.accessed,
        'extension': getFileExtension(path),
        'mimeType': getMimeType(path),
      };
    } catch (e) {
      return {};
    }
  }
}