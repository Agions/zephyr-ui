import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 基础组件示例 - 图标
class IconExample extends StatelessWidget {
  const IconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon 图标'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('图标尺寸', _buildIconSizes()),
            _buildSection('图标颜色', _buildIconColors()),
            _buildSection('常用图标', _buildCommonIcons()),
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

  Widget _buildIconSizes() {
    return const Wrap(
      spacing: 24,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          children: [
            VelocityIcon(Icons.home, size: VelocityIconSize.xs),
            SizedBox(height: 4),
            Text('XS', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocityIcon(Icons.home, size: VelocityIconSize.sm),
            SizedBox(height: 4),
            Text('SM', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocityIcon(Icons.home, size: VelocityIconSize.md),
            SizedBox(height: 4),
            Text('MD', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocityIcon(Icons.home, size: VelocityIconSize.lg),
            SizedBox(height: 4),
            Text('LG', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocityIcon(Icons.home, size: VelocityIconSize.xl),
            SizedBox(height: 4),
            Text('XL', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildIconColors() {
    return const Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        VelocityIcon(Icons.favorite, color: VelocityColors.primary),
        VelocityIcon(Icons.favorite, color: VelocityColors.secondary),
        VelocityIcon(Icons.favorite, color: VelocityColors.success),
        VelocityIcon(Icons.favorite, color: VelocityColors.warning),
        VelocityIcon(Icons.favorite, color: VelocityColors.error),
        VelocityIcon(Icons.favorite, color: VelocityColors.gray500),
      ],
    );
  }

  Widget _buildCommonIcons() {
    final icons = [
      {'icon': Icons.home, 'label': 'home'},
      {'icon': Icons.settings, 'label': 'settings'},
      {'icon': Icons.person, 'label': 'person'},
      {'icon': Icons.search, 'label': 'search'},
      {'icon': Icons.add, 'label': 'add'},
      {'icon': Icons.edit, 'label': 'edit'},
      {'icon': Icons.delete, 'label': 'delete'},
      {'icon': Icons.share, 'label': 'share'},
      {'icon': Icons.favorite, 'label': 'favorite'},
      {'icon': Icons.star, 'label': 'star'},
      {'icon': Icons.notifications, 'label': 'notifications'},
      {'icon': Icons.message, 'label': 'message'},
      {'icon': Icons.email, 'label': 'email'},
      {'icon': Icons.phone, 'label': 'phone'},
      {'icon': Icons.camera_alt, 'label': 'camera'},
      {'icon': Icons.image, 'label': 'image'},
      {'icon': Icons.location_on, 'label': 'location'},
      {'icon': Icons.calendar_today, 'label': 'calendar'},
      {'icon': Icons.check_circle, 'label': 'check'},
      {'icon': Icons.warning, 'label': 'warning'},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: icons.map((item) {
        return Container(
          width: 64,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: VelocityColors.gray200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              VelocityIcon(item['icon'] as IconData),
              const SizedBox(height: 4),
              Text(
                item['label'] as String,
                style: const TextStyle(fontSize: 10, color: VelocityColors.gray600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
