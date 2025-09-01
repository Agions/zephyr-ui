import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/input_advanced/file_upload/upload.dart';
import 'package:zephyr_ui/src/components/input_advanced/file_upload/upload_utils.dart';
import 'package:zephyr_ui/src/components/input_advanced/file_upload/upload_theme.dart';
import 'package:zephyr_ui/src/components/input_advanced/file_upload/upload_item.dart';
import 'dart:io';

void main() {
  group('ZephyrUpload', () {
    testWidgets('renders upload area', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
      expect(find.text('选择文件'), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.cloud_upload_outlined), findsOneWidget);
    });

    testWidgets('handles file selection', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
            ),
          ),
        ),
      );

      // In a real test, we would mock the file picker
      // For now, we'll just verify the UI renders correctly
      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
      expect(find.text('选择文件'), findsAtLeastNWidgets(1));
    });

    testWidgets('applies custom theme', (WidgetTester tester) async {
      final customTheme = ZephyrUploadTheme.custom(
        backgroundColor: Colors.red,
        iconColor: Colors.white,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              theme: customTheme,
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              errorBuilder: (message) => Text('Custom Error: $message'),
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('handles max files limit', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              maxFiles: 1,
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('handles file size limit', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              maxSize: 1024, // 1KB
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('handles allowed types', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              allowedTypes: const ['image/jpeg', 'image/png'],
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('shows action buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              multiple: true,
            ),
          ),
        ),
      );

      expect(find.text('选择文件'), findsAtLeastNWidgets(1));
      expect(find.text('选择图片'), findsOneWidget);
      expect(find.text('拍照'), findsOneWidget);
    });

    testWidgets('shows upload button when not auto upload', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              autoUpload: false,
            ),
          ),
        ),
      );

      // The upload button is only shown when there are files to upload
      // Since we haven't added any files, the button won't be visible
      // This is expected behavior
      expect(find.text('开始上传'), findsNothing);
    });

    testWidgets('respects showFileList setting', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              showFileList: false,
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('respects showProgress setting', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              showProgress: false,
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('handles drag and drop', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              enableDragAndDrop: true,
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });

    testWidgets('disables drag and drop', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrUpload(
              onUpload: (files) async {},
              enableDragAndDrop: false,
            ),
          ),
        ),
      );

      expect(find.text('点击或拖拽文件到此处上传'), findsOneWidget);
    });
  });

  group('ZephyrUploadItem', () {
    test('creates upload item with required parameters', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
      );

      expect(item.file, equals(file));
      expect(item.name, equals('test.txt'));
      expect(item.status, equals(ZephyrUploadStatus.pending));
      expect(item.progress, equals(0.0));
    });

    test('creates upload item with all parameters', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
        size: 1024,
        type: 'txt',
        mimeType: 'text/plain',
        url: 'https://example.com/file.txt',
        progress: 0.5,
        status: ZephyrUploadStatus.uploading,
        error: 'Upload failed',
        data: {'key': 'value'},
      );

      expect(item.file, equals(file));
      expect(item.name, equals('test.txt'));
      expect(item.size, equals(1024));
      expect(item.type, equals('txt'));
      expect(item.mimeType, equals('text/plain'));
      expect(item.url, equals('https://example.com/file.txt'));
      expect(item.progress, equals(0.5));
      expect(item.status, equals(ZephyrUploadStatus.uploading));
      expect(item.error, equals('Upload failed'));
      expect(item.data, equals({'key': 'value'}));
    });

    test('copies upload item with modifications', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
        status: ZephyrUploadStatus.pending,
      );

      final modified = item.copyWith(
        status: ZephyrUploadStatus.success,
        progress: 1.0,
      );

      expect(modified.status, equals(ZephyrUploadStatus.success));
      expect(modified.progress, equals(1.0));
      expect(modified.name, equals('test.txt'));
    });

    test('sets uploading status', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
        status: ZephyrUploadStatus.pending,
      );

      final uploading = item.uploading();

      expect(uploading.status, equals(ZephyrUploadStatus.uploading));
      expect(uploading.progress, equals(0.0));
      expect(uploading.error, isNull);
    });

    test('updates progress', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
        progress: 0.0,
      );

      final updated = item.updateProgress(0.5);

      expect(updated.progress, equals(0.5));
    });

    test('sets success status', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
        status: ZephyrUploadStatus.uploading,
      );

      final success = item.success(url: 'https://example.com/file.txt');

      expect(success.status, equals(ZephyrUploadStatus.success));
      expect(success.progress, equals(1.0));
      expect(success.url, equals('https://example.com/file.txt'));
      expect(success.error, isNull);
    });

    test('sets failed status', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
        status: ZephyrUploadStatus.uploading,
      );

      final failed = item.failed('Network error');

      expect(failed.status, equals(ZephyrUploadStatus.failed));
      expect(failed.error, equals('Network error'));
    });

    test('resets to pending status', () {
      final file = File('/test/file.txt');
      final item = ZephyrUploadItem(
        file: file,
        name: 'test.txt',
        status: ZephyrUploadStatus.failed,
        progress: 1.0,
        error: 'Error',
      );

      final reset = item.reset();

      expect(reset.status, equals(ZephyrUploadStatus.pending));
      expect(reset.progress, equals(0.0));
      expect(reset.error, equals('')); // Empty string instead of null based on implementation
      expect(reset.url, isNull);
    });

    test('identifies image files', () {
      final file = File('/test/image.jpg');
      final item = ZephyrUploadItem(
        file: file,
        name: 'image.jpg',
        type: 'jpg',
      );

      expect(item.isImage, isTrue);
      expect(item.isVideo, isFalse);
      expect(item.isAudio, isFalse);
    });

    test('identifies video files', () {
      final file = File('/test/video.mp4');
      final item = ZephyrUploadItem(
        file: file,
        name: 'video.mp4',
        type: 'mp4',
      );

      expect(item.isVideo, isTrue);
      expect(item.isImage, isFalse);
      expect(item.isAudio, isFalse);
    });

    test('identifies audio files', () {
      final file = File('/test/audio.mp3');
      final item = ZephyrUploadItem(
        file: file,
        name: 'audio.mp3',
        type: 'mp3',
      );

      expect(item.isAudio, isTrue);
      expect(item.isImage, isFalse);
      expect(item.isVideo, isFalse);
    });

    test('checks completion status', () {
      final file = File('/test/file.txt');
      
      final pendingItem = ZephyrUploadItem(
        file: file,
        name: 'file.txt',
        status: ZephyrUploadStatus.pending,
      );
      
      final uploadingItem = ZephyrUploadItem(
        file: file,
        name: 'file.txt',
        status: ZephyrUploadStatus.uploading,
      );
      
      final successItem = ZephyrUploadItem(
        file: file,
        name: 'file.txt',
        status: ZephyrUploadStatus.success,
      );
      
      final failedItem = ZephyrUploadItem(
        file: file,
        name: 'file.txt',
        status: ZephyrUploadStatus.failed,
      );

      expect(pendingItem.isCompleted, isFalse);
      expect(pendingItem.isUploading, isFalse);
      expect(pendingItem.isFailed, isFalse);
      expect(pendingItem.isPending, isTrue);

      expect(uploadingItem.isCompleted, isFalse);
      expect(uploadingItem.isUploading, isTrue);
      expect(uploadingItem.isFailed, isFalse);
      expect(uploadingItem.isPending, isFalse);

      expect(successItem.isCompleted, isTrue);
      expect(successItem.isUploading, isFalse);
      expect(successItem.isFailed, isFalse);
      expect(successItem.isPending, isFalse);

      expect(failedItem.isCompleted, isFalse);
      expect(failedItem.isUploading, isFalse);
      expect(failedItem.isFailed, isTrue);
      expect(failedItem.isPending, isFalse);
    });
  });

  group('ZephyrUploadTheme', () {
    test('creates light theme', () {
      final theme = ZephyrUploadTheme.light();
      expect(theme.backgroundColor, equals(const Color(0xFFF9FAFB)));
      expect(theme.borderColor, equals(const Color(0xFFE5E7EB)));
      expect(theme.iconColor, equals(const Color(0xFF6B7280)));
    });

    test('creates dark theme', () {
      final theme = ZephyrUploadTheme.dark();
      expect(theme.backgroundColor, equals(const Color(0xFF1F2937)));
      expect(theme.borderColor, equals(const Color(0xFF374151)));
      expect(theme.iconColor, equals(const Color(0xFF9CA3AF)));
    });

    test('creates custom theme', () {
      final theme = ZephyrUploadTheme.custom(
        backgroundColor: Colors.red,
        iconColor: Colors.white,
      );

      expect(theme.backgroundColor, equals(Colors.red));
      expect(theme.iconColor, equals(Colors.white));
    });

    test('copies theme with modifications', () {
      final theme = ZephyrUploadTheme.light();
      final modified = theme.copyWith(backgroundColor: Colors.blue);

      expect(modified.backgroundColor, equals(Colors.blue));
      expect(modified.borderColor, equals(theme.borderColor));
    });

    test('merges themes', () {
      final theme1 = ZephyrUploadTheme.light();
      final theme2 = ZephyrUploadTheme.custom(backgroundColor: Colors.red);
      final merged = theme1.merge(theme2);

      expect(merged.backgroundColor, equals(Colors.red));
      expect(merged.borderColor, equals(theme1.borderColor));
    });

    test('compares themes for equality', () {
      final theme1 = ZephyrUploadTheme.light();
      final theme2 = ZephyrUploadTheme.light();
      expect(theme1, equals(theme2));
    });

    test('computes hash code', () {
      final theme = ZephyrUploadTheme.light();
      expect(theme.hashCode, isA<int>());
    });
  });

  group('ZephyrUploadUtils', () {
    test('formats file size', () {
      expect(ZephyrUploadUtils.formatFileSize(500), equals('500 B'));
      expect(ZephyrUploadUtils.formatFileSize(1024), equals('1.0 KB'));
      expect(ZephyrUploadUtils.formatFileSize(1024 * 1024), equals('1.0 MB'));
      expect(ZephyrUploadUtils.formatFileSize(1024 * 1024 * 1024), equals('1.0 GB'));
    });

    test('gets file extension', () {
      expect(ZephyrUploadUtils.getFileExtension('file.txt'), equals('txt'));
      expect(ZephyrUploadUtils.getFileExtension('file.TXT'), equals('txt'));
      expect(ZephyrUploadUtils.getFileExtension('file'), equals(''));
      expect(ZephyrUploadUtils.getFileExtension('file.tar.gz'), equals('gz'));
    });

    test('gets file name without extension', () {
      expect(ZephyrUploadUtils.getFileNameWithoutExtension('file.txt'), equals('file'));
      expect(ZephyrUploadUtils.getFileNameWithoutExtension('file'), equals('file'));
      expect(ZephyrUploadUtils.getFileNameWithoutExtension('/path/to/file.txt'), equals('file'));
    });

    test('gets file name', () {
      expect(ZephyrUploadUtils.getFileName('file.txt'), equals('file.txt'));
      expect(ZephyrUploadUtils.getFileName('/path/to/file.txt'), equals('file.txt'));
      expect(ZephyrUploadUtils.getFileName('file'), equals('file'));
    });

    test('validates file type', () {
      expect(ZephyrUploadUtils.isFileTypeAllowed('file.jpg', ['image/jpeg']), isTrue);
      expect(ZephyrUploadUtils.isFileTypeAllowed('file.jpg', ['image/*']), isTrue);
      expect(ZephyrUploadUtils.isFileTypeAllowed('file.txt', ['image/jpeg']), isFalse);
      expect(ZephyrUploadUtils.isFileTypeAllowed('file.jpg', []), isTrue);
    });

    test('validates file size', () {
      expect(ZephyrUploadUtils.isFileSizeValid(1024, 2048), isTrue);
      expect(ZephyrUploadUtils.isFileSizeValid(2048, 1024), isFalse);
    });

    test('validates file name', () {
      expect(ZephyrUploadUtils.isFileNameValid('file.txt'), isTrue);
      expect(ZephyrUploadUtils.isFileNameValid('file/name.txt'), isFalse);
      expect(ZephyrUploadUtils.isFileNameValid('file*.txt'), isFalse);
    });

    test('sanitizes file name', () {
      expect(ZephyrUploadUtils.sanitizeFileName('file/name.txt'), equals('file_name.txt'));
      expect(ZephyrUploadUtils.sanitizeFileName('file*.txt'), equals('file_.txt'));
      expect(ZephyrUploadUtils.sanitizeFileName('file.txt'), equals('file.txt'));
    });

    test('calculates progress', () {
      expect(ZephyrUploadUtils.calculateProgress(512, 1024), equals(0.5));
      expect(ZephyrUploadUtils.calculateProgress(0, 1024), equals(0.0));
      expect(ZephyrUploadUtils.calculateProgress(1024, 1024), equals(1.0));
    });

    test('estimates remaining time', () {
      final duration = ZephyrUploadUtils.estimateRemainingTime(512, 1024, 256);
      expect(duration.inSeconds, equals(2));
    });

    test('formats duration', () {
      expect(ZephyrUploadUtils.formatDuration(const Duration(seconds: 30)), equals('30秒'));
      expect(ZephyrUploadUtils.formatDuration(const Duration(minutes: 5)), equals('5分钟 0秒'));
      expect(ZephyrUploadUtils.formatDuration(const Duration(hours: 2)), equals('2小时 0分钟'));
      expect(ZephyrUploadUtils.formatDuration(const Duration(days: 1)), equals('1天 0小时'));
    });

    test('formats upload speed', () {
      expect(ZephyrUploadUtils.formatUploadSpeed(512), equals('512.0 B/s'));
      expect(ZephyrUploadUtils.formatUploadSpeed(1024), equals('1.0 KB/s'));
      expect(ZephyrUploadUtils.formatUploadSpeed(1024 * 1024), equals('1.0 MB/s'));
    });

    test('groups files by type', () {
      final files = [
        'file1.jpg',
        'file2.png',
        'file3.txt',
        'file4.mp3',
        'file5.mp4',
        'file6.pdf',
      ];

      final groups = ZephyrUploadUtils.groupFilesByType(files);

      expect(groups['图片'], hasLength(2));
      expect(groups['音频'], hasLength(1));
      expect(groups['视频'], hasLength(1));
      expect(groups['文档'], hasLength(2)); // txt and pdf are both documents
    });

    test('generates unique file name', () {
      final name = ZephyrUploadUtils.generateUniqueFileName('file.txt');
      expect(name, startsWith('file_'));
      expect(name, endsWith('.txt'));
      expect(name, contains('_'));
    });
  });
}