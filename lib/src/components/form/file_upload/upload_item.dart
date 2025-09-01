import 'dart:io';

/// ZephyrUI 文件上传项
/// 
/// 表示一个待上传或已上传的文件，包含文件的基本信息和状态。
class ZephyrUploadItem {
  /// 文件对象
  final File file;
  
  /// 文件名称
  final String name;
  
  /// 文件大小（字节）
  final int? size;
  
  /// 文件类型/扩展名
  final String? type;
  
  /// 文件MIME类型
  final String? mimeType;
  
  /// 文件URL（已上传后）
  final String? url;
  
  /// 上传进度（0.0 - 1.0）
  final double progress;
  
  /// 上传状态
  final ZephyrUploadStatus status;
  
  /// 错误信息
  final String? error;
  
  /// 附加数据
  final dynamic data;
  
  /// 创建文件上传项
  const ZephyrUploadItem({
    required this.file,
    required this.name,
    this.size,
    this.type,
    this.mimeType,
    this.url,
    this.progress = 0.0,
    this.status = ZephyrUploadStatus.pending,
    this.error,
    this.data,
  });
  
  /// 复制并修改属性
  ZephyrUploadItem copyWith({
    File? file,
    String? name,
    int? size,
    String? type,
    String? mimeType,
    String? url,
    double? progress,
    ZephyrUploadStatus? status,
    String? error,
    dynamic data,
  }) {
    return ZephyrUploadItem(
      file: file ?? this.file,
      name: name ?? this.name,
      size: size ?? this.size,
      type: type ?? this.type,
      mimeType: mimeType ?? this.mimeType,
      url: url ?? this.url,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
  
  /// 设置上传中状态
  ZephyrUploadItem uploading() {
    return copyWith(
      status: ZephyrUploadStatus.uploading,
      progress: 0.0,
      error: null,
    );
  }
  
  /// 更新上传进度
  ZephyrUploadItem updateProgress(double progress) {
    return copyWith(progress: progress);
  }
  
  /// 设置上传成功状态
  ZephyrUploadItem success({String? url}) {
    return copyWith(
      status: ZephyrUploadStatus.success,
      progress: 1.0,
      url: url,
      error: null,
    );
  }
  
  /// 设置上传失败状态
  ZephyrUploadItem failed(String error) {
    return copyWith(
      status: ZephyrUploadStatus.failed,
      error: error,
    );
  }
  
  /// 重置为待上传状态
  ZephyrUploadItem reset() {
    return copyWith(
      status: ZephyrUploadStatus.pending,
      progress: 0.0,
      error: null,
      url: null,
    );
  }
  
  /// 检查是否为图片文件
  bool get isImage {
    if (type == null) return false;
    final imageTypes = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];
    return imageTypes.contains(type!.toLowerCase());
  }
  
  /// 检查是否为视频文件
  bool get isVideo {
    if (type == null) return false;
    final videoTypes = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm'];
    return videoTypes.contains(type!.toLowerCase());
  }
  
  /// 检查是否为音频文件
  bool get isAudio {
    if (type == null) return false;
    final audioTypes = ['mp3', 'wav', 'flac', 'aac', 'ogg', 'wma'];
    return audioTypes.contains(type!.toLowerCase());
  }
  
  /// 检查是否为文档文件
  bool get isDocument {
    if (type == null) return false;
    final docTypes = ['pdf', 'doc', 'docx', 'txt', 'rtf'];
    return docTypes.contains(type!.toLowerCase());
  }
  
  /// 检查是否为压缩文件
  bool get isArchive {
    if (type == null) return false;
    final archiveTypes = ['zip', 'rar', '7z', 'tar', 'gz'];
    return archiveTypes.contains(type!.toLowerCase());
  }
  
  /// 检查是否已完成上传
  bool get isCompleted {
    return status == ZephyrUploadStatus.success;
  }
  
  /// 检查是否正在上传
  bool get isUploading {
    return status == ZephyrUploadStatus.uploading;
  }
  
  /// 检查是否上传失败
  bool get isFailed {
    return status == ZephyrUploadStatus.failed;
  }
  
  /// 检查是否等待上传
  bool get isPending {
    return status == ZephyrUploadStatus.pending;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrUploadItem &&
      other.file == file &&
      other.name == name &&
      other.size == size &&
      other.type == type &&
      other.mimeType == mimeType &&
      other.url == url &&
      other.progress == progress &&
      other.status == status &&
      other.error == error &&
      other.data == data;
  }
  
  @override
  int get hashCode {
    return Object.hashAll([
      file,
      name,
      size,
      type,
      mimeType,
      url,
      progress,
      status,
      error,
      data,
    ]);
  }
  
  @override
  String toString() {
    return 'ZephyrUploadItem(name: $name, size: $size, type: $type, status: $status)';
  }
}

/// 文件上传状态枚举
enum ZephyrUploadStatus {
  /// 等待上传
  pending,
  
  /// 正在上传
  uploading,
  
  /// 上传成功
  success,
  
  /// 上传失败
  failed,
  
  /// 已取消
  cancelled,
}