import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 滑块
class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _basicValue = 50;
  double _volumeValue = 70;
  double _brightnessValue = 80;
  RangeValues _priceRange = const RangeValues(100, 500);
  RangeValues _ageRange = const RangeValues(18, 35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider 滑块'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicSlider()),
            _buildSection('带步进', _buildSteppedSlider()),
            _buildSection('显示标签', _buildLabeledSlider()),
            _buildSection('范围选择', _buildRangeSlider()),
            _buildSection('使用场景', _buildUseCases()),
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

  Widget _buildBasicSlider() {
    return Column(
      children: [
        VelocitySlider(
          value: _basicValue,
          onChanged: (value) => setState(() => _basicValue = value),
        ),
        Text('当前值: ${_basicValue.toInt()}'),
      ],
    );
  }

  Widget _buildSteppedSlider() {
    return Column(
      children: [
        VelocitySlider(
          value: _volumeValue,
          onChanged: (value) => setState(() => _volumeValue = value),
          min: 0,
          max: 100,
          divisions: 10,
        ),
        Text('音量: ${_volumeValue.toInt()}%'),
      ],
    );
  }

  Widget _buildLabeledSlider() {
    return Column(
      children: [
        VelocitySlider(
          value: _brightnessValue,
          onChanged: (value) => setState(() => _brightnessValue = value),
          showLabel: true,
          label: '${_brightnessValue.toInt()}%',
        ),
        Text('亮度: ${_brightnessValue.toInt()}%'),
      ],
    );
  }

  Widget _buildRangeSlider() {
    return Column(
      children: [
        const Text('价格范围 (¥):'),
        VelocityRangeSlider(
          values: _priceRange,
          onChanged: (values) => setState(() => _priceRange = values),
          min: 0,
          max: 1000,
          divisions: 20,
          showLabels: true,
        ),
        Text('¥${_priceRange.start.toInt()} - ¥${_priceRange.end.toInt()}'),
        const SizedBox(height: 16),
        const Text('年龄范围:'),
        VelocityRangeSlider(
          values: _ageRange,
          onChanged: (values) => setState(() => _ageRange = values),
          min: 0,
          max: 100,
          divisions: 100,
          showLabels: true,
        ),
        Text('${_ageRange.start.toInt()} - ${_ageRange.end.toInt()} 岁'),
      ],
    );
  }

  Widget _buildUseCases() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 音量控制
            Row(
              children: [
                const Icon(Icons.volume_down, color: VelocityColors.gray600),
                Expanded(
                  child: VelocitySlider(
                    value: _volumeValue,
                    onChanged: (value) => setState(() => _volumeValue = value),
                  ),
                ),
                const Icon(Icons.volume_up, color: VelocityColors.gray600),
              ],
            ),
            const SizedBox(height: 16),
            // 亮度控制
            Row(
              children: [
                const Icon(Icons.brightness_low, color: VelocityColors.gray600),
                Expanded(
                  child: VelocitySlider(
                    value: _brightnessValue,
                    onChanged: (value) => setState(() => _brightnessValue = value),
                  ),
                ),
                const Icon(Icons.brightness_high, color: VelocityColors.gray600),
              ],
            ),
            const SizedBox(height: 16),
            // 禁用状态
            const Row(
              children: [
                Text('禁用状态: '),
                Expanded(
                  child: VelocitySlider(
                    value: 50,
                    onChanged: null,
                    disabled: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
