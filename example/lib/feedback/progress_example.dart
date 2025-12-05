import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 进度条
class ProgressExample extends StatefulWidget {
  const ProgressExample({super.key});

  @override
  State<ProgressExample> createState() => _ProgressExampleState();
}

class _ProgressExampleState extends State<ProgressExample> {
  double _progress = 0.5;
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress 进度条'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('线性进度条', _buildLinearProgress()),
            _buildSection('圆形进度条', _buildCircularProgress()),
            _buildSection('带标签进度条', _buildProgressWithLabel()),
            _buildSection('交互式进度', _buildInteractiveProgress()),
            _buildSection('步骤进度', _buildStepProgress()),
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

  Widget _buildLinearProgress() {
    return const Column(
      children: [
        VelocityProgress(value: 0.3),
        SizedBox(height: 16),
        VelocityProgress(value: 0.6),
        SizedBox(height: 16),
        VelocityProgress(value: 0.9),
      ],
    );
  }

  Widget _buildCircularProgress() {
    return const Wrap(
      spacing: 32,
      runSpacing: 16,
      children: [
        VelocityProgress(type: VelocityProgressType.circular, value: 0.25),
        VelocityProgress(type: VelocityProgressType.circular, value: 0.5),
        VelocityProgress(type: VelocityProgressType.circular, value: 0.75),
        VelocityProgress(type: VelocityProgressType.circular, value: 1.0),
      ],
    );
  }

  Widget _buildProgressWithLabel() {
    return const Column(
      children: [
        VelocityProgress(value: 0.3, showLabel: true, label: '下载中'),
        SizedBox(height: 16),
        VelocityProgress(value: 0.7, showLabel: true, label: '上传进度'),
        SizedBox(height: 24),
        Wrap(
          spacing: 32,
          runSpacing: 16,
          children: [
            VelocityProgress(
              type: VelocityProgressType.circular,
              value: 0.25,
              showLabel: true,
            ),
            VelocityProgress(
              type: VelocityProgressType.circular,
              value: 0.75,
              showLabel: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractiveProgress() {
    return Column(
      children: [
        VelocityProgress(value: _progress, showLabel: true, label: '当前进度'),
        const SizedBox(height: 16),
        Slider(
          value: _progress,
          onChanged: (value) {
            setState(() {
              _progress = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            VelocityButton.text(
              text: '0%',
              type: VelocityButtonType.outline,
              size: VelocityButtonSize.small,
              onPressed: () => setState(() => _progress = 0),
            ),
            VelocityButton.text(
              text: '25%',
              type: VelocityButtonType.outline,
              size: VelocityButtonSize.small,
              onPressed: () => setState(() => _progress = 0.25),
            ),
            VelocityButton.text(
              text: '50%',
              type: VelocityButtonType.outline,
              size: VelocityButtonSize.small,
              onPressed: () => setState(() => _progress = 0.5),
            ),
            VelocityButton.text(
              text: '75%',
              type: VelocityButtonType.outline,
              size: VelocityButtonSize.small,
              onPressed: () => setState(() => _progress = 0.75),
            ),
            VelocityButton.text(
              text: '100%',
              type: VelocityButtonType.outline,
              size: VelocityButtonSize.small,
              onPressed: () => setState(() => _progress = 1.0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepProgress() {
    return Column(
      children: [
        VelocityStepProgress(
          currentStep: _currentStep,
          totalSteps: 4,
          labels: const ['信息填写', '实名认证', '协议签署', '开户完成'],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          children: [
            VelocityButton.text(
              text: '上一步',
              type: VelocityButtonType.outline,
              disabled: _currentStep <= 0,
              onPressed: () {
                setState(() {
                  if (_currentStep > 0) _currentStep--;
                });
              },
            ),
            VelocityButton.text(
              text: '下一步',
              disabled: _currentStep >= 3,
              onPressed: () {
                setState(() {
                  if (_currentStep < 3) _currentStep++;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
