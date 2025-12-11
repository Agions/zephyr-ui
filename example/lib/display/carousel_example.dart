import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 轮播图
class CarouselExample extends StatelessWidget {
  const CarouselExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel 轮播图'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicCarousel()),
            _buildSection('自定义高度', _buildCustomHeightCarousel()),
            _buildSection('隐藏指示器 & 关闭自动播放', _buildCustomCarousel()),
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

  Widget _buildBasicCarousel() {
    return VelocityCarousel(
      items: [
        Container(color: Colors.red[100], child: const Center(child: Text('Page 1'))),
        Container(color: Colors.green[100], child: const Center(child: Text('Page 2'))),
        Container(color: Colors.blue[100], child: const Center(child: Text('Page 3'))),
      ],
      onPageChanged: (index) => print('Current page: $index'),
    );
  }

  Widget _buildCustomHeightCarousel() {
    return VelocityCarousel(
      height: 150,
      items: [
        Image.network('https://picsum.photos/seed/1/800/400', fit: BoxFit.cover),
        Image.network('https://picsum.photos/seed/2/800/400', fit: BoxFit.cover),
        Image.network('https://picsum.photos/seed/3/800/400', fit: BoxFit.cover),
      ],
    );
  }

  Widget _buildCustomCarousel() {
    return VelocityCarousel(
      height: 180,
      autoPlay: false,
      showIndicator: false,
      style: const VelocityCarouselStyle(
        borderRadius: BorderRadius.zero,
      ),
      items: [
        Container(color: Colors.purple[100], child: const Center(child: Text('Custom 1'))),
        Container(color: Colors.orange[100], child: const Center(child: Text('Custom 2'))),
      ],
    );
  }
}
