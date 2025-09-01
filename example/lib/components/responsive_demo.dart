import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('响应式设计演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '响应式布局示例',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 响应式网格
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '响应式网格布局',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildResponsiveGrid(context),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '响应式组件',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 响应式按钮
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '响应式按钮',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildResponsiveButtons(context),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 响应式文本
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '响应式文本',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildResponsiveText(context),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 响应式卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '响应式卡片布局',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildResponsiveCards(context),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 设备信息显示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '当前设备信息',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildDeviceInfo(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = _getResponsiveGridCount(width);
    
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.0,
      children: [
        _buildGridItem(Icons.home, '首页', Colors.blue),
        _buildGridItem(Icons.search, '搜索', Colors.green),
        _buildGridItem(Icons.person, '个人', Colors.purple),
        _buildGridItem(Icons.settings, '设置', Colors.orange),
        _buildGridItem(Icons.notifications, '通知', Colors.red),
        _buildGridItem(Icons.favorite, '收藏', Colors.pink),
      ],
    );
  }

  Widget _buildGridItem(IconData icon, String label, Color color) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZephyrIcon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveButtons(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 600;
    
    return Column(
      children: [
        if (isSmallScreen) ...[
          // 小屏幕：垂直排列
          ZephyrButton(
            text: '主要操作',
            fullWidth: true,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          ZephyrButton.outlined(
            text: '次要操作',
            fullWidth: true,
            onPressed: () {},
          ),
        ] else ...[
          // 大屏幕：水平排列
          Row(
            children: [
              Expanded(
                child: ZephyrButton(
                  text: '主要操作',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ZephyrButton.outlined(
                  text: '次要操作',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildResponsiveText(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textStyle = _getResponsiveTextStyle(width);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrText(
          '响应式标题文本',
          style: textStyle,
        ),
        const SizedBox(height: 8),
        ZephyrText(
          '这是一段响应式的正文文本，会根据屏幕宽度自动调整字体大小，确保在不同设备上都有良好的阅读体验。',
          style: _getResponsiveBodyStyle(width),
        ),
      ],
    );
  }

  Widget _buildResponsiveCards(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 600;
    
    if (isSmallScreen) {
      // 小屏幕：垂直列表
      return Column(
        children: [
          _buildInfoCard(
            Icons.speed,
            '性能优化',
            '针对不同设备进行性能优化',
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            Icons.palette,
            '主题定制',
            '支持多种主题和自定义样式',
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            Icons.accessibility,
            '无障碍设计',
            '符合WCAG无障碍设计标准',
            Colors.purple,
          ),
        ],
      );
    } else {
      // 大屏幕：网格布局
      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
        children: [
          _buildInfoCard(
            Icons.speed,
            '性能优化',
            '针对不同设备进行性能优化',
            Colors.blue,
          ),
          _buildInfoCard(
            Icons.palette,
            '主题定制',
            '支持多种主题和自定义样式',
            Colors.green,
          ),
          _buildInfoCard(
            Icons.accessibility,
            '无障碍设计',
            '符合WCAG无障碍设计标准',
            Colors.purple,
          ),
        ],
      );
    }
  }

  Widget _buildInfoCard(IconData icon, String title, String description, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrIcon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 12),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfo(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final orientation = mediaQuery.orientation;
    final deviceType = _getDeviceType(width);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('设备类型', deviceType),
        const SizedBox(height: 8),
        _buildInfoRow('屏幕宽度', '${width.toStringAsFixed(0)}px'),
        const SizedBox(height: 8),
        _buildInfoRow('屏幕高度', '${height.toStringAsFixed(0)}px'),
        const SizedBox(height: 8),
        _buildInfoRow('屏幕方向', orientation == Orientation.portrait ? '竖屏' : '横屏'),
        const SizedBox(height: 8),
        _buildInfoRow('设备像素比', mediaQuery.devicePixelRatio.toStringAsFixed(2)),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    );
  }

  int _getResponsiveGridCount(double width) {
    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }

  TextStyle _getResponsiveTextStyle(double width) {
    if (width < 600) return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    if (width < 900) return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  }

  TextStyle _getResponsiveBodyStyle(double width) {
    if (width < 600) return const TextStyle(fontSize: 14);
    if (width < 900) return const TextStyle(fontSize: 15);
    return const TextStyle(fontSize: 16);
  }

  String _getDeviceType(double width) {
    if (width < 600) return '手机';
    if (width < 900) return '平板';
    return '桌面';
  }
}