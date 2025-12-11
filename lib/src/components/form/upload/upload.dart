/// VelocityUI 文件上传组件
library velocity_upload;

import 'dart:io';
import 'package:flutter/material.dart';
import 'upload_theme.dart';

/// 文件上传组件
class VelocityUpload extends StatelessWidget {
  /// 创建文件上传组件
  const VelocityUpload({
    required this.onUpload,
    super.key,
    this.multiple = true,
    this.autoUpload = true,
    this.maxFiles,
    this.maxSize,
    this.allowedTypes,
    this.showFileList = true,
    this.showProgress = true,
    this.enableDragAndDrop = true,
    this.theme,
  });

  final Future<void> Function(List<File>) onUpload;
  final bool multiple;
  final bool autoUpload;
  final int? maxFiles;
  final int? maxSize;
  final List<String>? allowedTypes;
  final bool showFileList;
  final bool showProgress;
  final bool enableDragAndDrop;
  final VelocityUploadTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? VelocityUploadTheme.light();

    return Container(
      decoration: BoxDecoration(
        color: effectiveTheme.backgroundColor,
        border: Border.all(color: effectiveTheme.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(Icons.cloud_upload_outlined,
              size: 48, color: effectiveTheme.iconColor),
          const SizedBox(height: 16),
          Text(
            '点击或拖拽文件到此处上传',
            style: effectiveTheme.textStyle,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.attach_file),
            label: const Text('选择文件'),
          ),
        ],
      ),
    );
  }
}
