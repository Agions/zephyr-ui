import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 宽高比
class AspectRatioExample extends StatelessWidget {
  const AspectRatioExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AspectRatio 宽高比'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem('16:9 Video', const VelocityAspectRatio.video(
              child: Placeholder(color: Colors.blue),
            )),
            _buildItem('4:3 Photo', const VelocityAspectRatio.photo(
              child: Placeholder(color: Colors.green),
            )),
            _buildItem('1:1 Square', const VelocityAspectRatio.square(
              child: Placeholder(color: Colors.purple),
            )),
            _buildItem('3:4 Portrait', const VelocityAspectRatio.portrait(
              child: Placeholder(color: Colors.orange),
            )),
            _buildItem('Custom 2.0 (2:1)', const VelocityAspectRatio(
              aspectRatio: 2.0,
              child: Placeholder(color: Colors.red),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(width: 200, child: content),
        ],
      ),
    );
  }
}
