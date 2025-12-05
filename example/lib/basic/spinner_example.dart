import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 基础组件示例 - 加载动画
class SpinnerExample extends StatelessWidget {
  const SpinnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spinner 加载动画'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('加载动画类型', _buildSpinnerTypes()),
            _buildSection('不同尺寸', _buildSpinnerSizes()),
            _buildSection('自定义颜色', _buildSpinnerColors()),
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

  Widget _buildSpinnerTypes() {
    return const Wrap(
      spacing: 32,
      runSpacing: 24,
      children: [
        _SpinnerCard(type: VelocitySpinnerType.circular, label: 'Circular'),
        _SpinnerCard(type: VelocitySpinnerType.dots, label: 'Dots'),
        _SpinnerCard(type: VelocitySpinnerType.wave, label: 'Wave'),
        _SpinnerCard(type: VelocitySpinnerType.pulse, label: 'Pulse'),
        _SpinnerCard(type: VelocitySpinnerType.ring, label: 'Ring'),
      ],
    );
  }

  Widget _buildSpinnerSizes() {
    return const Wrap(
      spacing: 32,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          children: [
            VelocitySpinner(size: 20),
            SizedBox(height: 8),
            Text('20px', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocitySpinner(size: 32),
            SizedBox(height: 8),
            Text('32px', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocitySpinner(size: 48),
            SizedBox(height: 8),
            Text('48px', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocitySpinner(size: 64),
            SizedBox(height: 8),
            Text('64px', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildSpinnerColors() {
    return const Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        VelocitySpinner(color: VelocityColors.primary),
        VelocitySpinner(color: VelocityColors.secondary),
        VelocitySpinner(color: VelocityColors.success),
        VelocitySpinner(color: VelocityColors.warning),
        VelocitySpinner(color: VelocityColors.error),
      ],
    );
  }
}

class _SpinnerCard extends StatelessWidget {
  const _SpinnerCard({
    required this.type,
    required this.label,
  });

  final VelocitySpinnerType type;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: VelocityColors.gray50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VelocityColors.gray200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VelocitySpinner(type: type, size: 40),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: VelocityColors.gray600,
            ),
          ),
        ],
      ),
    );
  }
}
