import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 基础组件示例 - 图片
class ImageExample extends StatelessWidget {
  const ImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image 图片'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicImage()),
            _buildSection('圆角图片', _buildRoundedImage()),
            _buildSection('加载占位 & 错误', _buildPlaceholderAndError()),
            _buildSection('自定义尺寸', _buildCustomSize()),
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

  Widget _buildBasicImage() {
    return const VelocityImage(
      src: 'https://picsum.photos/300/200',
      width: 300,
      height: 200,
    );
  }

  Widget _buildRoundedImage() {
    return const VelocityImage(
      src: 'https://picsum.photos/300/200',
      width: 300,
      height: 200,
      style: VelocityImageStyle(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }

  Widget _buildPlaceholderAndError() {
    return Column(
      children: [
        const Text('错误图片 (显示默认错误图):'),
        const SizedBox(height: 8),
        const VelocityImage(
          src: 'https://invalid-url.com/image.png',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 16),
        const Text('自定义错误组件:'),
        const SizedBox(height: 8),
        VelocityImage(
          src: 'https://invalid-url.com/image.png',
          width: 100,
          height: 100,
          errorWidget: Container(
            color: Colors.red[50],
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomSize() {
    return const Wrap(
      spacing: 16,
      children: [
        VelocityImage(src: 'https://picsum.photos/100/100', width: 100, height: 100),
        VelocityImage(src: 'https://picsum.photos/100/100', width: 80, height: 80, fit: BoxFit.fill),
      ],
    );
  }
}
