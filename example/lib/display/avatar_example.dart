import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 展示组件示例 - 头像
class AvatarExample extends StatelessWidget {
  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar 头像'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicAvatar()),
            _buildSection('头像尺寸', _buildAvatarSizes()),
            _buildSection('头像形状', _buildAvatarShapes()),
            _buildSection('头像组', _buildAvatarGroup()),
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

  Widget _buildBasicAvatar() {
    return const Wrap(
      spacing: 16,
      children: [
        VelocityAvatar(name: 'User'),
        VelocityAvatar(icon: Icons.person),
        VelocityAvatar(
          imageUrl: 'https://avatars.githubusercontent.com/u/1?v=4',
        ),
      ],
    );
  }

  Widget _buildAvatarSizes() {
    return const Wrap(
      spacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        VelocityAvatar(size: VelocityAvatarSize.xs, name: 'XS'),
        VelocityAvatar(size: VelocityAvatarSize.sm, name: 'SM'),
        VelocityAvatar(size: VelocityAvatarSize.md, name: 'MD'),
        VelocityAvatar(size: VelocityAvatarSize.lg, name: 'LG'),
        VelocityAvatar(size: VelocityAvatarSize.xl, name: 'XL'),
      ],
    );
  }

  Widget _buildAvatarShapes() {
    return const Wrap(
      spacing: 16,
      children: [
        VelocityAvatar(shape: VelocityAvatarShape.circle, name: 'C'),
        VelocityAvatar(shape: VelocityAvatarShape.square, name: 'S'),
        VelocityAvatar(shape: VelocityAvatarShape.rounded, name: 'R'),
      ],
    );
  }

  Widget _buildAvatarGroup() {
    return const VelocityAvatarGroup(
      avatars: [
        VelocityAvatar(name: 'A'),
        VelocityAvatar(name: 'B'),
        VelocityAvatar(name: 'C'),
        VelocityAvatar(name: 'D'),
        VelocityAvatar(name: 'E'),
        VelocityAvatar(name: 'F'),
      ],
      max: 4,
    );
  }
}
