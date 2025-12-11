import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 骨架屏
class SkeletonExample extends StatefulWidget {
  const SkeletonExample({super.key});

  @override
  State<SkeletonExample> createState() => _SkeletonExampleState();
}

class _SkeletonExampleState extends State<SkeletonExample> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeleton 骨架屏'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSwitch(),
            const Divider(),
            _buildSection('基础用法', _buildBasicSkeleton()),
            _buildSection('列表骨架', _buildListSkeleton()),
            _buildSection('卡片骨架', _buildCardSkeleton()),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return Row(
      children: [
        const Text('Loading 状态: '),
        VelocitySwitch(
          value: _loading,
          onChanged: (v) => setState(() => _loading = v),
        ),
      ],
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

  Widget _buildBasicSkeleton() {
    return VelocitySkeletonContainer(
      loading: _loading,
      skeleton: const Row(
        children: [
          VelocitySkeleton(width: 80, height: 80, circle: true),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VelocitySkeleton(width: 120, height: 20),
              SizedBox(height: 8),
              VelocitySkeleton(width: 80, height: 16),
            ],
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.person, size: 80, color: Colors.blue),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Velocity User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Flutter Developer', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListSkeleton() {
    if (_loading) {
      return const VelocityListSkeleton(itemCount: 3);
    }
    return Column(
      children: List.generate(3, (index) => ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text('User $index'),
        subtitle: Text('Description for user $index'),
      )),
    );
  }

  Widget _buildCardSkeleton() {
    if (_loading) {
      return const VelocityCardSkeleton();
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 180, color: Colors.blue[100], child: const Center(child: Icon(Icons.image, size: 64, color: Colors.white))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Card Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('This is a description for the card.', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
