import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 时间线
class TimelineExample extends StatelessWidget {
  const TimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline 时间线'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicTimeline()),
            _buildSection('自定义颜色', _buildColorTimeline()),
            _buildSection('自定义图标', _buildIconTimeline()),
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

  Widget _buildBasicTimeline() {
    return const VelocityTimeline(
      items: [
        VelocityTimelineItem(
          label: '2023-10-01',
          content: Text('创建项目'),
        ),
        VelocityTimelineItem(
          label: '2023-10-05',
          content: Text('完成需求分析'),
        ),
        VelocityTimelineItem(
          label: '2023-10-10',
          content: Text('开始开发'),
        ),
      ],
    );
  }

  Widget _buildColorTimeline() {
    return const VelocityTimeline(
      items: [
        VelocityTimelineItem(
          label: '已完成',
          color: Colors.green,
          content: Text('系统设计完成'),
        ),
        VelocityTimelineItem(
          label: '进行中',
          color: Colors.blue,
          content: Text('核心功能开发'),
        ),
        VelocityTimelineItem(
          label: '待开始',
          color: Colors.grey,
          content: Text('测试验收'),
          hollow: true,
        ),
      ],
    );
  }

  Widget _buildIconTimeline() {
    return const VelocityTimeline(
      items: [
        VelocityTimelineItem(
          icon: Icons.check,
          color: Colors.green,
          content: Text('提交成功'),
          time: '2023-10-20 10:00:00',
        ),
        VelocityTimelineItem(
          icon: Icons.sync,
          color: Colors.blue,
          content: Text('正在审核'),
          time: '2023-10-20 10:05:00',
        ),
        VelocityTimelineItem(
          icon: Icons.close,
          color: Colors.red,
          content: Text('审核失败'),
          time: '2023-10-20 11:00:00',
        ),
      ],
    );
  }
}
