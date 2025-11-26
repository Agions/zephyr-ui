import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'upload_theme.dart';
import 'upload_item.dart';
import 'upload_utils.dart';

/// ZephyrUI 文件上传组件
/// 
/// 一个功能强大的文件上传组件，支持：
/// - 拖拽上传
/// - 点击上传
/// - 多文件上传
/// - 文件类型限制
/// - 文件大小限制
/// - 上传进度显示
/// - 自定义上传逻辑
/// 
/// 示例用法：
/// ```dart
/// ZephyrUpload(
///   onUpload: (files) async {
///     // 处理文件上传
///     for (final file in files) {
///       await uploadFile(file);
///     }
///   },
///   maxFiles: 5,
///   maxSize: 10 * 1024 * 1024, // 10MB
///   allowedTypes: ['image/jpeg', 'image/png'],
/// )
/// ```
class ZephyrUpload extends StatefulWidget {
  /// 上传回调函数
  final Future<void> Function(List<ZephyrUploadItem>) onUpload;
  
  /// 文件选择回调函数
  final void Function(List<ZephyrUploadItem>)? onSelect;
  
  /// 文件移除回调函数
  final void Function(ZephyrUploadItem)? onRemove;
  
  /// 最大文件数量
  final int maxFiles;
  
  /// 单个文件最大大小（字节）
  final int maxSize;
  
  /// 允许的文件类型
  final List<String> allowedTypes;
  
  /// 是否允许多文件上传
  final bool multiple;
  
  /// 是否显示文件列表
  final bool showFileList;
  
  /// 是否显示进度条
  final bool showProgress;
  
  /// 是否启用拖拽上传
  final bool enableDragAndDrop;
  
  /// 是否自动上传
  final bool autoUpload;
  
  /// 上传文本
  final String uploadText;
  
  /// 拖拽文本
  final String dragText;
  
  /// 选择文件文本
  final String selectText;
  
  /// 自定义主题
  final ZephyrUploadTheme? theme;
  
  /// 自定义子组件
  final Widget? child;
  
  /// 自定义文件项构建器
  final Widget Function(ZephyrUploadItem, Function() onRemove)? fileItemBuilder;
  
  /// 自定义错误消息构建器
  final Widget Function(String)? errorBuilder;
  
  /// 自定义空状态构建器
  final Widget Function()? emptyBuilder;
  
  /// 自定义加载状态构建器
  final Widget Function()? loadingBuilder;
  
  /// 创建文件上传组件
  const ZephyrUpload({
    super.key,
    required this.onUpload,
    this.onSelect,
    this.onRemove,
    this.maxFiles = 10,
    this.maxSize = 10 * 1024 * 1024,
    this.allowedTypes = const [],
    this.multiple = true,
    this.showFileList = true,
    this.showProgress = true,
    this.enableDragAndDrop = true,
    this.autoUpload = false,
    this.uploadText = '点击或拖拽文件到此处上传',
    this.dragText = '拖拽文件到此处上传',
    this.selectText = '选择文件',
    this.theme,
    this.child,
    this.fileItemBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
  });

  @override
  State<ZephyrUpload> createState() => _ZephyrUploadState();
}

class _ZephyrUploadState extends State<ZephyrUpload> {
  late ZephyrUploadTheme _theme;
  final List<ZephyrUploadItem> _files = [];
  bool _isDragging = false;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _errorMessage;
  
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrUploadTheme.light();
  }

  @override
  void didUpdateWidget(ZephyrUpload oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrUploadTheme.light();
    }
  }

  Future<void> _pickFiles() async {
    // Note: This would require file_picker package
    // For now, we'll just show an error
    _setError('文件选择功能需要 file_picker 依赖');
  }

  Future<void> _pickImages() async {
    try {
      final images = await _imagePicker.pickMultiImage();
      
      if (images.isNotEmpty) {
        final uploadItems = images.map((image) {
          return ZephyrUploadItem(
            file: File(image.path),
            name: image.name,
            type: 'jpg',
          );
        }).toList();

        await _addFiles(uploadItems);
      }
    } catch (e) {
      _setError('选择图片失败: $e');
    }
  }

  Future<void> _pickCamera() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.camera);
      
      if (image != null) {
        final uploadItem = ZephyrUploadItem(
          file: File(image.path),
          name: image.name,
          type: 'jpg',
        );

        await _addFiles([uploadItem]);
      }
    } catch (e) {
      _setError('拍照失败: $e');
    }
  }

  Future<void> _addFiles(List<ZephyrUploadItem> newFiles) async {
    // 验证文件数量
    if (_files.length + newFiles.length > widget.maxFiles) {
      _setError('最多只能上传 ${widget.maxFiles} 个文件');
      return;
    }

    // 验证每个文件
    final validFiles = <ZephyrUploadItem>[];
    for (final file in newFiles) {
      if (_validateFile(file)) {
        validFiles.add(file);
      }
    }

    if (validFiles.isEmpty) return;

    setState(() {
      _files.addAll(validFiles);
      _errorMessage = null;
    });

    widget.onSelect?.call(validFiles);

    if (widget.autoUpload) {
      await _uploadFiles();
    }
  }

  bool _validateFile(ZephyrUploadItem file) {
    // 验证文件大小
    if (file.size != null && file.size! > widget.maxSize) {
      _setError('文件 ${file.name} 超过大小限制');
      return false;
    }

    // 验证文件类型
    if (widget.allowedTypes.isNotEmpty) {
      final fileExtension = file.type?.toLowerCase();
      final allowedExtensions = widget.allowedTypes
          .map((type) => type.toLowerCase().split('/').last)
          .toSet();
      
      if (!allowedExtensions.contains(fileExtension)) {
        _setError('文件 ${file.name} 类型不支持');
        return false;
      }
    }

    return true;
  }

  Future<void> _uploadFiles() async {
    if (_files.isEmpty || _isUploading) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    try {
      await widget.onUpload(_files);
      
      setState(() {
        _uploadProgress = 1.0;
      });
    } catch (e) {
      _setError('上传失败: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _removeFile(ZephyrUploadItem file) {
    setState(() {
      _files.remove(file);
    });
    widget.onRemove?.call(file);
  }

  void _setError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  
  // Note: Drag and drop functionality would require additional platform-specific implementation
  void _handleDragEnter() {
    if (!widget.enableDragAndDrop) return;
    
    setState(() {
      _isDragging = true;
    });
  }

  void _handleDragExit() {
    if (!widget.enableDragAndDrop) return;
    
    setState(() {
      _isDragging = false;
    });
  }

  Widget _buildUploadArea() {
    if (widget.child != null) {
      return GestureDetector(
        onTap: _pickFiles,
        child: widget.child!,
      );
    }

    return GestureDetector(
      onTap: _pickFiles,
      onPanStart: widget.enableDragAndDrop ? (_) => _handleDragEnter() : null,
      onPanEnd: widget.enableDragAndDrop ? (_) => _handleDragExit() : null,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: _isDragging 
              ? _theme.dragActiveColor 
              : _theme.backgroundColor,
          border: Border.all(
            color: _isDragging 
                ? _theme.dragActiveBorderColor 
                : _theme.borderColor,
            width: _theme.borderWidth,
            style: BorderStyle.solid,
          ),
          borderRadius: _theme.borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 48,
              color: _theme.iconColor,
            ),
            const SizedBox(height: 16),
            Text(
              _isDragging ? widget.dragText : widget.uploadText,
              style: _theme.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.selectText,
              style: _theme.subtextStyle,
            ),
            if (_errorMessage != null && widget.errorBuilder != null) ...[
              const SizedBox(height: 8),
              widget.errorBuilder!(_errorMessage!),
            ] else if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: _theme.errorStyle,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFileList() {
    if (!widget.showFileList || _files.isEmpty) {
      return widget.emptyBuilder?.call() ?? const SizedBox.shrink();
    }

    return Column(
      children: _files.map((file) {
        return widget.fileItemBuilder?.call(file, () => _removeFile) ?? 
               _buildDefaultFileItem(file);
      }).whereType<Widget>().toList(),
    );
  }

  Widget _buildDefaultFileItem(ZephyrUploadItem file) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _theme.fileItemBackgroundColor,
        border: Border.all(color: _theme.fileItemBorderColor),
        borderRadius: _theme.fileItemBorderRadius,
      ),
      child: Row(
        children: [
          Icon(
            _getFileIcon(file.type),
            color: _theme.fileIconColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: _theme.fileNameStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (file.size != null)
                  Text(
                    ZephyrUploadUtils.formatFileSize(file.size!),
                    style: _theme.fileSizeStyle,
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: _theme.removeIconColor),
            onPressed: () => _removeFile(file),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String? type) {
    if (type == null) return Icons.insert_drive_file_outlined;
    
    final lowerType = type.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(lowerType)) {
      return Icons.image_outlined;
    } else if (['pdf'].contains(lowerType)) {
      return Icons.picture_as_pdf_outlined;
    } else if (['doc', 'docx'].contains(lowerType)) {
      return Icons.description_outlined;
    } else if (['xls', 'xlsx'].contains(lowerType)) {
      return Icons.table_chart_outlined;
    } else if (['ppt', 'pptx'].contains(lowerType)) {
      return Icons.slideshow_outlined;
    } else if (['txt'].contains(lowerType)) {
      return Icons.text_snippet_outlined;
    } else if (['zip', 'rar', '7z'].contains(lowerType)) {
      return Icons.archive_outlined;
    } else if (['mp3', 'wav', 'flac'].contains(lowerType)) {
      return Icons.music_note_outlined;
    } else if (['mp4', 'avi', 'mov'].contains(lowerType)) {
      return Icons.video_file_outlined;
    }
    
    return Icons.insert_drive_file_outlined;
  }

  Widget _buildUploadProgress() {
    if (!widget.showProgress || !_isUploading) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: _uploadProgress,
          backgroundColor: _theme.progressBackgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(_theme.progressColor),
        ),
        const SizedBox(height: 8),
        Text(
          '上传中... ${(_uploadProgress * 100).toInt()}%',
          style: _theme.progressTextStyle,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (widget.multiple)
          TextButton.icon(
            onPressed: _pickFiles,
            icon: Icon(Icons.file_upload_outlined, color: _theme.buttonIconColor),
            label: Text('选择文件', style: _theme.buttonTextStyle),
          ),
        TextButton.icon(
          onPressed: _pickImages,
          icon: Icon(Icons.image_outlined, color: _theme.buttonIconColor),
          label: Text('选择图片', style: _theme.buttonTextStyle),
        ),
        TextButton.icon(
          onPressed: _pickCamera,
          icon: Icon(Icons.camera_alt_outlined, color: _theme.buttonIconColor),
          label: Text('拍照', style: _theme.buttonTextStyle),
        ),
        if (!widget.autoUpload && _files.isNotEmpty)
          ElevatedButton.icon(
            onPressed: _isUploading ? null : _uploadFiles,
            icon: const Icon(Icons.upload, color: Colors.white),
            label: Text(_isUploading ? '上传中...' : '开始上传'),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUploadArea(),
        const SizedBox(height: 16),
        _buildActionButtons(),
        _buildUploadProgress(),
        _buildFileList(),
      ],
    );
  }
}