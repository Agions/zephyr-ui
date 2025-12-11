import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 导航组件示例 - 步骤条
class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _currentStep = 1;

  final List<VelocityStep> _steps = const [
    VelocityStep(title: '步骤一', subtitle: '基本信息'),
    VelocityStep(title: '步骤二', subtitle: '详细信息'),
    VelocityStep(title: '步骤三', subtitle: '确认提交'),
    VelocityStep(title: '步骤四', subtitle: '完成'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper 步骤条'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('水平步骤条', _buildHorizontalStepper()),
            _buildSection('垂直步骤条', _buildVerticalStepper()),
            _buildSection('控制按钮', _buildControls()),
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

  Widget _buildHorizontalStepper() {
    return VelocityStepper(
      steps: _steps,
      currentStep: _currentStep,
      direction: VelocityStepperDirection.horizontal,
      onStepTap: (index) => setState(() => _currentStep = index),
    );
  }

  Widget _buildVerticalStepper() {
    return VelocityStepper(
      steps: [
        VelocityStep(
          title: '下单',
          subtitle: '2023-10-01 12:00',
          content: const Text('您的订单已提交，等待商家确认。'),
          status: _currentStep > 0 ? VelocityStepStatus.finish : (_currentStep == 0 ? VelocityStepStatus.process : VelocityStepStatus.wait),
        ),
        VelocityStep(
          title: '出库',
          subtitle: '2023-10-01 14:00',
          content: const Text('您的订单已出库，正在发往分拣中心。'),
          status: _currentStep > 1 ? VelocityStepStatus.finish : (_currentStep == 1 ? VelocityStepStatus.process : VelocityStepStatus.wait),
        ),
        VelocityStep(
          title: '运输',
          subtitle: '预计 3 天送达',
          content: const Text('您的订单正在运输中。'),
          status: _currentStep > 2 ? VelocityStepStatus.finish : (_currentStep == 2 ? VelocityStepStatus.process : VelocityStepStatus.wait),
        ),
        VelocityStep(
          title: '签收',
          content: const Text('您的订单已签收。'),
          status: _currentStep > 3 ? VelocityStepStatus.finish : (_currentStep == 3 ? VelocityStepStatus.process : VelocityStepStatus.wait),
        ),
      ],
      currentStep: _currentStep,
      direction: VelocityStepperDirection.vertical,
      onStepTap: (index) => setState(() => _currentStep = index),
    );
  }

  Widget _buildControls() {
    return Wrap(
      spacing: 16,
      children: [
        VelocityButton.text(
          text: '上一步',
          type: VelocityButtonType.outline,
          disabled: _currentStep <= 0,
          onPressed: () => setState(() => _currentStep--),
        ),
        VelocityButton.text(
          text: '下一步',
          disabled: _currentStep >= 3,
          onPressed: () => setState(() => _currentStep++),
        ),
        VelocityButton.text(
          text: '重置',
          type: VelocityButtonType.text,
          onPressed: () => setState(() => _currentStep = 0),
        ),
      ],
    );
  }
}
