/// VelocityUI 文件上传工具
library velocity_upload_utils;

/// 文件上传工具类
class VelocityUploadUtils {
  /// 格式化文件大小
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

  /// 获取文件扩展名
  static String getFileExtension(String fileName) {
    if (fileName.contains('.')) {
      return fileName.split('.').last.toLowerCase();
    }
    return '';
  }

  /// 获取不带扩展名的文件名
  static String getFileNameWithoutExtension(String fileName) {
    // First extract the file name from path if needed
    final baseName = getFileName(fileName);
    if (baseName.contains('.')) {
      return baseName.substring(0, baseName.lastIndexOf('.'));
    }
    return baseName;
  }

  /// 获取文件名（从路径中提取）
  static String getFileName(String filePath) {
    final parts = filePath.split('/');
    return parts.last;
  }

  /// 验证文件类型是否允许
  static bool isFileTypeAllowed(String fileName, List<String> allowedTypes) {
    if (allowedTypes.isEmpty) {
      return true;
    }

    final extension = getFileExtension(fileName);
    final mimeType = _getMimeType(extension);

    for (final type in allowedTypes) {
      if (type == '*/*') {
        return true;
      }
      if (type.endsWith('/*')) {
        final baseType = type.split('/').first;
        if (mimeType.startsWith(baseType)) {
          return true;
        }
      }
      if (type == mimeType || type == extension) {
        return true;
      }
    }

    return false;
  }

  /// 验证文件大小是否有效
  static bool isFileSizeValid(int fileSize, int maxSize) {
    return fileSize <= maxSize;
  }

  /// 验证文件名是否有效
  static bool isFileNameValid(String fileName) {
    // 不允许包含路径分隔符和特殊字符
    return !fileName.contains('/') &&
        !fileName.contains(r'\') &&
        !fileName.contains('*') &&
        !fileName.contains('?') &&
        !fileName.contains('<') &&
        !fileName.contains('>') &&
        !fileName.contains('|');
  }

  /// 清理文件名，移除无效字符
  static String sanitizeFileName(String fileName) {
    return fileName.replaceAll(RegExp(r'[/\\*?<>|]'), '_').trim();
  }

  /// 计算上传进度
  static double calculateProgress(int uploaded, int total) {
    if (total == 0) return 0.0;
    return uploaded / total;
  }

  /// 估算剩余时间
  static Duration estimateRemainingTime(int uploaded, int total, int speedBps) {
    if (speedBps == 0) return Duration.zero;
    final remainingBytes = total - uploaded;
    final remainingSeconds = remainingBytes / speedBps;
    return Duration(seconds: remainingSeconds.ceil());
  }

  /// 格式化持续时间
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
  static String formatUploadSpeed(int bps) {
    if (bps < 1024) {
      return '${bps.toStringAsFixed(1)} B/s';
    } else if (bps < 1024 * 1024) {
      return '${(bps / 1024).toStringAsFixed(1)} KB/s';
    } else {
      return '${(bps / (1024 * 1024)).toStringAsFixed(1)} MB/s';
    }
  }

  /// 按文件类型分组
  static Map<String, List<String>> groupFilesByType(List<String> files) {
    final groups = <String, List<String>>{};

    for (final file in files) {
      final extension = getFileExtension(file);
      String category;

      if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg']
          .contains(extension)) {
        category = '图片';
      } else if (['mp3', 'wav', 'ogg', 'flac', 'aac', 'm4a', 'wma']
          .contains(extension)) {
        category = '音频';
      } else if (['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv']
          .contains(extension)) {
        category = '视频';
      } else if ([
        'txt',
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
        'zip',
        'rar',
        '7z'
      ].contains(extension)) {
        category = '文档';
      } else {
        category = '其他';
      }

      groups.putIfAbsent(category, () => []).add(file);
    }

    return groups;
  }

  /// 生成唯一文件名
  static String generateUniqueFileName(String originalName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = getFileExtension(originalName);
    final baseName = getFileNameWithoutExtension(originalName);

    if (extension.isNotEmpty) {
      return '${baseName}_$timestamp.$extension';
    } else {
      return '${baseName}_$timestamp';
    }
  }

  /// 获取文件MIME类型
  static String _getMimeType(String extension) {
    final mimeTypes = {
      'txt': 'text/plain',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'bmp': 'image/bmp',
      'webp': 'image/webp',
      'svg': 'image/svg+xml',
      'mp3': 'audio/mpeg',
      'wav': 'audio/wav',
      'ogg': 'audio/ogg',
      'flac': 'audio/flac',
      'aac': 'audio/aac',
      'mp4': 'video/mp4',
      'avi': 'video/x-msvideo',
      'mov': 'video/quicktime',
      'wmv': 'video/x-ms-wmv',
      'flv': 'video/x-flv',
      'webm': 'video/webm',
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'application/vnd.ms-excel',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'ppt': 'application/vnd.ms-powerpoint',
      'pptx':
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'zip': 'application/zip',
      'rar': 'application/x-rar-compressed',
      '7z': 'application/x-7z-compressed',
    };

    return mimeTypes[extension] ?? 'application/octet-stream';
  }
}
