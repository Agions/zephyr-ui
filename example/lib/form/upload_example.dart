import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 上传组件
class UploadExample extends StatefulWidget {
  const UploadExample({super.key});

  @override
  State<UploadExample> createState() => _UploadExampleState();
}

class _UploadExampleState extends State<UploadExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload 上传'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicUpload()),
            _buildSection('多文件上传', _buildMultipleUpload()),
            _buildSection('带限制', _buildLimitedUpload()),
            _buildSection('自定义样式', _buildCustomUpload()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: VelocityColors.gray800,
            ),
          ),
        ),
        content,
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }

  Widget _buildBasicUpload() {
    return Column(
      children: [
        VelocityUpload(
          onUpload: (files) async {
            print('上传文件: $files');
          },
        ),
        const SizedBox(height: 16),
        const Text(
          '点击或拖拽文件到虚线区域进行上传',
          style: TextStyle(
            fontSize: 14,
            color: VelocityColors.gray600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMultipleUpload() {
    return Column(
      children: [
        VelocityUpload(
          multiple: true,
          onUpload: (files) async {
            print('上传多个文件: $files');
          },
        ),
        const SizedBox(height: 16),
        const Text(
          '支持同时上传多个文件',
          style: TextStyle(
            fontSize: 14,
            color: VelocityColors.gray600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLimitedUpload() {
    return Column(
      children: [
        VelocityUpload(
          multiple: true,
          maxFiles: 3,
          allowedTypes: const ['image/jpeg', 'image/png', 'image/gif'],
          onUpload: (files) async {
            print('上传文件: $files');
          },
        ),
        const SizedBox(height: 16),
        const Text(
          '最多上传 3 个文件，仅支持 jpg、png、gif 格式',
          style: TextStyle(
            fontSize: 14,
            color: VelocityColors.gray600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCustomUpload() {
    return Column(
      children: [
        VelocityUpload(
          multiple: true,
          maxFiles: 5,
          onUpload: (files) async {
            print('上传文件: $files');
          },
        ),
        const SizedBox(height: 16),
        const Text(
          '自定义样式的上传组件',
          style: TextStyle(
            fontSize: 14,
            color: VelocityColors.gray600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
