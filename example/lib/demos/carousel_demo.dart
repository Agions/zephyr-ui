import 'package:flutter/material.dart';
import 'src/carousel.dart';
import 'src/carousel_types.dart';

/// 轮播图组件示例页面
class CarouselDemo extends StatelessWidget {
  const CarouselDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('轮播图组件示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('基础轮播图'),
            _buildBasicCarousel(),
            const SizedBox(height: 32),
            _buildSectionTitle('自动播放轮播图'),
            _buildAutoPlayCarousel(),
            const SizedBox(height: 32),
            _buildSectionTitle('带指示器的轮播图'),
            _buildIndicatorCarousel(),
            const SizedBox(height: 32),
            _buildSectionTitle('自定义指示器'),
            _buildCustomIndicatorCarousel(),
            const SizedBox(height: 32),
            _buildSectionTitle('卡片式轮播图'),
            _buildCardCarousel(context),
          ],
        ),
      ),
    );
  }

  /// 构建区域标题
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 构建基础轮播图
  Widget _buildBasicCarousel() {
    final items = [
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              '第一页',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '第一页',
      ),
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '第二页',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '第二页',
      ),
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '第三页',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '第三页',
      ),
    ];

    return const SizedBox(
      height: 200,
      child: ZephyrCarousel(
        items: items,
        config: ZephyrCarouselConfig(
          autoPlay: false,
          showIndicator: true,
          showNavigationButtons: true,
          enableSwipe: true,
        ),
        onPageChanged: (index) {
          debugPrint('当前页面: $index');
        },
      ),
    );
  }

  /// 构建自动播放轮播图
  Widget _buildAutoPlayCarousel() {
    final items = [
      ZephyrCarouselItem(
        child: Image.network(
          'https://picsum.photos/400/200?random=1',
          fit: BoxFit.cover,
        ),
        label: '风景 1',
      ),
      ZephyrCarouselItem(
        child: Image.network(
          'https://picsum.photos/400/200?random=2',
          fit: BoxFit.cover,
        ),
        label: '风景 2',
      ),
      ZephyrCarouselItem(
        child: Image.network(
          'https://picsum.photos/400/200?random=3',
          fit: BoxFit.cover,
        ),
        label: '风景 3',
      ),
      ZephyrCarouselItem(
        child: Image.network(
          'https://picsum.photos/400/200?random=4',
          fit: BoxFit.cover,
        ),
        label: '风景 4',
      ),
    ];

    return const SizedBox(
      height: 200,
      child: ZephyrCarousel(
        items: items,
        config: ZephyrCarouselConfig(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          showIndicator: true,
          showNavigationButtons: false,
          enableSwipe: true,
          loop: true,
        ),
      ),
    );
  }

  /// 构建带指示器的轮播图
  Widget _buildIndicatorCarousel() {
    final items = [
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.pink],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '紫色渐变',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '紫色渐变',
      ),
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '蓝色渐变',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '蓝色渐变',
      ),
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '绿色渐变',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '绿色渐变',
      ),
    ];

    return const SizedBox(
      height: 200,
      child: ZephyrCarousel(
        items: items,
        config: ZephyrCarouselConfig(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          showIndicator: true,
          indicatorType: ZephyrCarouselIndicatorType.fraction,
          showNavigationButtons: true,
          enableSwipe: true,
        ),
      ),
    );
  }

  /// 构建自定义指示器轮播图
  Widget _buildCustomIndicatorCarousel() {
    final items = [
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '红色',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '红色',
        customIndicator: const Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'R',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '绿色',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '绿色',
        customIndicator: const Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'G',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      ZephyrCarouselItem(
        child: const Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '蓝色',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        label: '蓝色',
        customIndicator: const Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'B',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];

    return const SizedBox(
      height: 200,
      child: ZephyrCarousel(
        items: items,
        config: ZephyrCarouselConfig(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 4),
          showIndicator: true,
          indicatorType: ZephyrCarouselIndicatorType.custom,
          showNavigationButtons: true,
          enableSwipe: true,
        ),
      ),
    );
  }

  /// 构建卡片式轮播图
  Widget _buildCardCarousel(BuildContext context) {
    const items = [
      ZephyrCarouselItem(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 48, color: Colors.amber),
                SizedBox(height: 16),
                Text(
                  '五星服务',
                  style: TextStyle(),
                ),
                SizedBox(height: 8),
                Text('为您提供最优质的服务体验'),
              ],
            ),
          ),
        ),
        label: '五星服务',
      ),
      ZephyrCarouselItem(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.security, size: 48, color: Colors.green),
                SizedBox(height: 16),
                Text(
                  '安全可靠',
                  style: TextStyle(),
                ),
                SizedBox(height: 8),
                Text('数据安全，隐私保护'),
              ],
            ),
          ),
        ),
        label: '安全可靠',
      ),
      ZephyrCarouselItem(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.speed, size: 48, color: Colors.blue),
                SizedBox(height: 16),
                Text(
                  '快速高效',
                  style: TextStyle(),
                ),
                SizedBox(height: 8),
                Text('响应迅速，性能卓越'),
              ],
            ),
          ),
        ),
        label: '快速高效',
      ),
    ];

    return const SizedBox(
      height: 300,
      child: ZephyrCarousel(
        items: items,
        config: ZephyrCarouselConfig(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          showIndicator: true,
          indicatorType: ZephyrCarouselIndicatorType.dots,
          showNavigationButtons: true,
          enableSwipe: true,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
