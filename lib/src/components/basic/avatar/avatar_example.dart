import 'package:flutter/material.dart';
import 'avatar.dart';

/// ZephyrAvatar组件的使用示例
class AvatarExample extends StatelessWidget {
  /// 创建一个示例实例
  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('头像组件示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('图片头像', _buildImageAvatars()),
            const SizedBox(height: 32),
            _buildSection('文字头像', _buildTextAvatars()),
            const SizedBox(height: 32),
            _buildSection('图标头像', _buildIconAvatars()),
            const SizedBox(height: 32),
            _buildSection('方形头像', _buildSquareAvatars()),
            const SizedBox(height: 32),
            _buildSection('带边框头像', _buildBorderedAvatars()),
            const SizedBox(height: 32),
            _buildSection('带阴影头像', _buildElevatedAvatars()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildImageAvatars() {
    // 模拟网络图片
    const imageUrl = 'https://via.placeholder.com/150';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZephyrAvatar.image(
          image: const NetworkImage(imageUrl),
          size: ZephyrAvatarSize.extraSmall,
        ),
        ZephyrAvatar.image(
          image: const NetworkImage(imageUrl),
          size: ZephyrAvatarSize.small,
        ),
        ZephyrAvatar.image(
          image: const NetworkImage(imageUrl),
          size: ZephyrAvatarSize.medium,
        ),
        ZephyrAvatar.image(
          image: const NetworkImage(imageUrl),
          size: ZephyrAvatarSize.large,
        ),
        ZephyrAvatar.image(
          image: const NetworkImage(imageUrl),
          size: ZephyrAvatarSize.extraLarge,
        ),
      ],
    );
  }

  Widget _buildTextAvatars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZephyrAvatar.text(
          text: '张三',
          size: ZephyrAvatarSize.extraSmall,
        ),
        ZephyrAvatar.text(
          text: '李四',
          size: ZephyrAvatarSize.small,
        ),
        ZephyrAvatar.text(
          text: '王五',
          size: ZephyrAvatarSize.medium,
        ),
        ZephyrAvatar.text(
          text: '赵六',
          size: ZephyrAvatarSize.large,
          backgroundColor: Colors.teal,
        ),
        ZephyrAvatar.text(
          text: '钱七',
          size: ZephyrAvatarSize.extraLarge,
          backgroundColor: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildIconAvatars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZephyrAvatar.icon(
          icon: Icons.person,
          size: ZephyrAvatarSize.extraSmall,
        ),
        ZephyrAvatar.icon(
          icon: Icons.person,
          size: ZephyrAvatarSize.small,
          backgroundColor: Colors.blue,
        ),
        ZephyrAvatar.icon(
          icon: Icons.star,
          size: ZephyrAvatarSize.medium,
          backgroundColor: Colors.amber,
        ),
        ZephyrAvatar.icon(
          icon: Icons.favorite,
          size: ZephyrAvatarSize.large,
          backgroundColor: Colors.red,
        ),
        ZephyrAvatar.icon(
          icon: Icons.home,
          size: ZephyrAvatarSize.extraLarge,
          backgroundColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildSquareAvatars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZephyrAvatar.text(
          text: 'A',
          shape: ZephyrAvatarShape.square,
          size: ZephyrAvatarSize.small,
          backgroundColor: Colors.blue,
        ),
        ZephyrAvatar.text(
          text: 'B',
          shape: ZephyrAvatarShape.square,
          size: ZephyrAvatarSize.medium,
          backgroundColor: Colors.orange,
        ),
        ZephyrAvatar.text(
          text: 'C',
          shape: ZephyrAvatarShape.square,
          size: ZephyrAvatarSize.large,
          backgroundColor: Colors.green,
        ),
        ZephyrAvatar.icon(
          icon: Icons.favorite,
          shape: ZephyrAvatarShape.square,
          size: ZephyrAvatarSize.large,
          backgroundColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildBorderedAvatars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZephyrAvatar.text(
          text: 'A',
          size: ZephyrAvatarSize.medium,
          borderWidth: 2,
          borderColor: Colors.blue,
        ),
        ZephyrAvatar.text(
          text: 'B',
          size: ZephyrAvatarSize.medium,
          shape: ZephyrAvatarShape.square,
          borderWidth: 2,
          borderColor: Colors.orange,
        ),
        ZephyrAvatar.icon(
          icon: Icons.person,
          size: ZephyrAvatarSize.medium,
          borderWidth: 2,
          borderColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildElevatedAvatars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ZephyrAvatar.text(
          text: 'A',
          size: ZephyrAvatarSize.medium,
          elevation: 4,
        ),
        ZephyrAvatar.text(
          text: 'B',
          size: ZephyrAvatarSize.medium,
          shape: ZephyrAvatarShape.square,
          elevation: 4,
        ),
        ZephyrAvatar.icon(
          icon: Icons.person,
          size: ZephyrAvatarSize.medium,
          elevation: 4,
          shadowColor: Colors.purple,
        ),
      ],
    );
  }
}
