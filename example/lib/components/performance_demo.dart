import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/example_card.dart';

class PerformanceDemo extends StatelessWidget {
  const PerformanceDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('性能优化演示'),
        elevation: 0,
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          _buildOptimizationTechniques(),
          const SizedBox(height: 32),
          _buildLazyLoadingDemo(),
          const SizedBox(height: 32),
          _buildMemoryOptimization(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildOptimizationTechniques(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildLazyLoadingDemo(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildMemoryOptimization(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildOptimizationTechniques(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildLazyLoadingDemo(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildMemoryOptimization(),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '性能优化演示',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ZephyrUI 内置了多种性能优化技术，确保应用在各种设备上都能流畅运行。',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildOptimizationTechniques() {
    return ExampleCard(
      title: '性能优化技术',
      code: '''// 使用 const 构造函数
const Text('Hello World')

// 使用 ListView.builder 替代 ListView
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ListTile(title: Text('Item $index'));
  },
)

// 使用 Image.network 的缓存
Image.network(
  'https://example.com/image.jpg',
  cacheWidth: 100,
  cacheHeight: 100,
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '优化策略',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildOptimizationItem(
                    '避免不必要的重建',
                    '使用 const 构造函数和 StatelessWidget',
                    Icons.refresh,
                    Colors.blue,
                  ),
                  Divider(),
                  _buildOptimizationItem(
                    '懒加载',
                    '只在需要时加载组件和数据',
                    Icons.downloading,
                    Colors.green,
                  ),
                  Divider(),
                  _buildOptimizationItem(
                    '图片优化',
                    '压缩图片和使用缓存',
                    Icons.image,
                    Colors.orange,
                  ),
                  Divider(),
                  _buildOptimizationItem(
                    '内存管理',
                    '及时释放不再使用的资源',
                    Icons.memory,
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationItem(
      String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLazyLoadingDemo() {
    return ExampleCard(
      title: '懒加载演示',
      code: '''// 懒加载组件
Visibility(
  visible: _isVisible,
  child: HeavyWidget(),
)

// ListView.builder 懒加载
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return LazyItemWidget(item: items[index]);
  },
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '懒加载示例',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.downloading, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('懒加载演示区域'),
                  Text('内容将在滚动到可视区域时加载'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text('懒加载项目 ${index + 1}'),
                  subtitle: const Text('这个项目在需要时才会渲染'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryOptimization() {
    return ExampleCard(
      title: '内存优化',
      code: '''// 及时释放资源
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

// 使用缓存策略
imageCache.maximumSize = 100;
imageCache.maximumSizeBytes = 50 * 1024 * 1024;''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '内存优化策略',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMemoryMetric(
                          '内存使用',
                          '45 MB',
                          Icons.memory,
                          Colors.blue,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildMemoryMetric(
                          '缓存大小',
                          '12 MB',
                          Icons.storage,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMemoryMetric(
                          '图片缓存',
                          '8 MB',
                          Icons.image,
                          Colors.orange,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildMemoryMetric(
                          '对象池',
                          '156',
                          Icons.pool,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '内存使用正常，未发现内存泄漏',
                    style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryMetric(
      String label, String value, IconData icon, Color color) {
    return const Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
