import 'package:flutter/material.dart';
import 'badge.dart';

/// ZephyrBadge组件的使用示例
class BadgeExample extends StatefulWidget {
  /// 创建示例实例
  const BadgeExample({Key? key}) : super(key: key);

  @override
  State<BadgeExample> createState() => _BadgeExampleState();
}

class _BadgeExampleState extends State<BadgeExample> {
  int _count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('徽章组件示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('独立徽章', _buildStandaloneBadges()),
            const SizedBox(height: 32),
            _buildSection('数字徽章', _buildCountBadges()),
            const SizedBox(height: 32),
            _buildSection('文本徽章', _buildTextBadges()),
            const SizedBox(height: 32),
            _buildSection('点状徽章', _buildDotBadges()),
            const SizedBox(height: 32),
            _buildSection('徽章位置', _buildPositionBadges()),
            const SizedBox(height: 32),
            _buildSection('自定义样式', _buildCustomBadges()),
            const SizedBox(height: 32),
            _buildSection('交互示例', _buildInteractiveBadge()),
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

  Widget _buildStandaloneBadges() {
    return const Wrap(
      spacing: 24,
      children: [
        ZephyrBadge.count(
          count: 5,
        ),
        ZephyrBadge(
          content: 'NEW',
        ),
        ZephyrBadge.dot(),
      ],
    );
  }

  Widget _buildCountBadges() {
    return Wrap(
      spacing: 24,
      children: [
        _badgeWithChild(
          const ZephyrBadge.count(
            count: 5,
          ),
          const Icon(Icons.notifications, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge.count(
            count: 99,
          ),
          const Icon(Icons.mail, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge.count(
            count: 100,
          ),
          const Icon(Icons.shopping_cart, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge.count(
            count: 0,
          ),
          const Icon(Icons.message, size: 30),
        ),
      ],
    );
  }

  Widget _buildTextBadges() {
    return Wrap(
      spacing: 24,
      children: [
        _badgeWithChild(
          const ZephyrBadge(
            content: 'NEW',
          ),
          const Icon(Icons.notifications, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge(
            content: 'HOT',
          ),
          const Icon(Icons.local_fire_department, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge(
            content: 'VIP',
          ),
          const Icon(Icons.person, size: 30),
        ),
      ],
    );
  }

  Widget _buildDotBadges() {
    return Wrap(
      spacing: 24,
      children: [
        _badgeWithChild(
          const ZephyrBadge.dot(),
          const Icon(Icons.notifications, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge.dot(),
          const Icon(Icons.mail, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge.dot(),
          const Icon(Icons.message, size: 30),
        ),
      ],
    );
  }

  Widget _buildPositionBadges() {
    return Wrap(
      spacing: 24,
      children: [
        _badgeWithChild(
          const ZephyrBadge.dot(),
          const Icon(Icons.notifications, size: 30),
          position: ZephyrBadgePosition.topRight,
        ),
        _badgeWithChild(
          const ZephyrBadge.dot(),
          const Icon(Icons.notifications, size: 30),
          position: ZephyrBadgePosition.topLeft,
        ),
        _badgeWithChild(
          const ZephyrBadge.dot(),
          const Icon(Icons.notifications, size: 30),
          position: ZephyrBadgePosition.bottomRight,
        ),
        _badgeWithChild(
          const ZephyrBadge.dot(),
          const Icon(Icons.notifications, size: 30),
          position: ZephyrBadgePosition.bottomLeft,
        ),
      ],
    );
  }

  Widget _buildCustomBadges() {
    return Wrap(
      spacing: 24,
      children: [
        _badgeWithChild(
          const ZephyrBadge.count(
            count: 5,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
          ),
          const Icon(Icons.notifications, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge(
            content: 'NEW',
            backgroundColor: Colors.green,
            textColor: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          const Icon(Icons.mail, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge.dot(
            backgroundColor: Colors.orange,
            borderWidth: 2,
            borderColor: Colors.white,
          ),
          const Icon(Icons.message, size: 30),
        ),
        _badgeWithChild(
          const ZephyrBadge.count(
            count: 99,
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          const Icon(Icons.shopping_cart, size: 30),
        ),
      ],
    );
  }

  Widget _buildInteractiveBadge() {
    return Column(
      children: [
        _badgeWithChild(
          ZephyrBadge.count(
            count: _count,
          ),
          const Icon(Icons.notifications, size: 30),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _count = _count > 0 ? _count - 1 : 0;
                });
              },
              child: const Text('-'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              child: const Text('+'),
            ),
          ],
        ),
      ],
    );
  }

  /// 辅助方法：将徽章与图标组合显示
  Widget _badgeWithChild(ZephyrBadge badge, Widget child,
      {ZephyrBadgePosition position = ZephyrBadgePosition.topRight}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: position == ZephyrBadgePosition.topLeft ||
                  position == ZephyrBadgePosition.topRight
              ? -5
              : null,
          bottom: position == ZephyrBadgePosition.bottomLeft ||
                  position == ZephyrBadgePosition.bottomRight
              ? -5
              : null,
          left: position == ZephyrBadgePosition.topLeft ||
                  position == ZephyrBadgePosition.bottomLeft
              ? -5
              : null,
          right: position == ZephyrBadgePosition.topRight ||
                  position == ZephyrBadgePosition.bottomRight
              ? -5
              : null,
          child: badge,
        ),
      ],
    );
  }
}
