/// VelocityUI 文件上传项
library velocity_upload_item;

import 'dart:io';

/// 文件上传状态枚举
enum VelocityUploadStatus {
  /// 等待上传
  pending,

  /// 正在上传
  uploading,

  /// 上传成功
  success,

  /// 上传失败
  failed,
}

/// 文件上传项
class VelocityUploadItem {
  /// 创建文件上传项
  const VelocityUploadItem({
    required this.file,
    required this.name,
    this.size,
    this.type,
    this.mimeType,
    this.url,
    this.progress = 0.0,
    this.status = VelocityUploadStatus.pending,
    this.error,
    this.data = const {},
  });

  final File file;
  final String name;
  final int? size;
  final String? type;
  final String? mimeType;
  final String? url;
  final double progress;
  final VelocityUploadStatus status;
  final String? error;
  final Map<String, dynamic> data;

  /// 获取文件扩展名
  String get extension => name.split('.').last.toLowerCase();

  /// 是否为图片文件
  bool get isImage {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];
    return imageExtensions.contains(extension);
  }

  /// 是否为视频文件
  bool get isVideo {
    final videoExtensions = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv'];
    return videoExtensions.contains(extension);
  }

  /// 是否为音频文件
  bool get isAudio {
    final audioExtensions = ['mp3', 'wav', 'ogg', 'flac', 'aac', 'm4a', 'wma'];
    return audioExtensions.contains(extension);
  }

  /// 是否正在上传
  bool get isUploading => status == VelocityUploadStatus.uploading;

  /// 是否上传成功
  bool get isSuccess => status == VelocityUploadStatus.success;

  /// 是否上传失败
  bool get isFailed => status == VelocityUploadStatus.failed;

  /// 是否处于等待状态
  bool get isPending => status == VelocityUploadStatus.pending;

  /// 是否已完成上传
  bool get isCompleted => status == VelocityUploadStatus.success;

  /// 复制上传项并修改指定属性
  VelocityUploadItem copyWith({
    File? file,
    String? name,
    int? size,
    String? type,
    String? mimeType,
    String? url,
    double? progress,
    VelocityUploadStatus? status,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return VelocityUploadItem(
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

  /// 标记为正在上传状态
  VelocityUploadItem uploading() {
    return copyWith(
      status: VelocityUploadStatus.uploading,
      progress: 0.0,
      error: null,
    );
  }

  /// 更新上传进度
  VelocityUploadItem updateProgress(double progress) {
    return copyWith(
      progress: progress.clamp(0.0, 1.0),
    );
  }

  /// 标记为上传成功状态
  VelocityUploadItem success({String? url}) {
    return copyWith(
      status: VelocityUploadStatus.success,
      progress: 1.0,
      url: url,
      error: null,
    );
  }

  /// 标记为上传失败状态
  VelocityUploadItem failed(String error) {
    return copyWith(
      status: VelocityUploadStatus.failed,
      error: error,
    );
  }

  /// 重置为等待上传状态
  VelocityUploadItem reset() {
    return copyWith(
      status: VelocityUploadStatus.pending,
      progress: 0.0,
      error: '',
      url: null,
    );
  }
}
