import 'package:flutter/material.dart';
import 'slider.dart';
import 'slider_theme.dart';

/// 滑块组件的使用示例
class ZephyrSliderExample extends StatefulWidget {
  /// 创建示例
  const ZephyrSliderExample({Key? key}) : super(key: key);

  @override
  State<ZephyrSliderExample> createState() => _ZephyrSliderExampleState();
}

class _ZephyrSliderExampleState extends State<ZephyrSliderExample> {
  double _standardValue = 0.3;
  double _discreteValue = 50;
  double _indicatorValue = 75;
  double _customValue = 0.7;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '滑块组件示例',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // 标准滑块
          const Text('标准滑块'),
          const SizedBox(height: 8),
          ZephyrSlider(
            value: _standardValue,
            onChanged: (value) {
              setState(() {
                _standardValue = value;
              });
            },
          ),
          Text('当前值: ${(_standardValue * 100).toStringAsFixed(0)}%'),
          const SizedBox(height: 24),

          // 离散值滑块
          const Text('离散值滑块'),
          const SizedBox(height: 8),
          ZephyrSlider(
            value: _discreteValue,
            min: 0,
            max: 100,
            type: ZephyrSliderType.discrete,
            divisions: 10,
            onChanged: (value) {
              setState(() {
                _discreteValue = value;
              });
            },
          ),
          Text('当前值: ${_discreteValue.toStringAsFixed(0)}'),
          const SizedBox(height: 24),

          // 带指示器的滑块
          const Text('带指示器的滑块'),
          const SizedBox(height: 8),
          ZephyrSlider(
            value: _indicatorValue,
            min: 0,
            max: 100,
            type: ZephyrSliderType.indicator,
            divisions: 20,
            label: '${_indicatorValue.toStringAsFixed(0)}%',
            onChanged: (value) {
              setState(() {
                _indicatorValue = value;
              });
            },
          ),
          Text('当前值: ${_indicatorValue.toStringAsFixed(0)}'),
          const SizedBox(height: 24),

          // 禁用的滑块
          const Text('禁用的滑块'),
          const SizedBox(height: 8),
          const ZephyrSlider(
            value: 0.5,
            disabled: true,
          ),
          const SizedBox(height: 24),

          // 自定义主题的滑块
          const Text('自定义主题的滑块'),
          const SizedBox(height: 8),
          ZephyrSlider(
            value: _customValue,
            type: ZephyrSliderType.indicator,
            divisions: 10,
            label: '${(_customValue * 100).toStringAsFixed(0)}%',
            theme: ZephyrSliderTheme(
              activeTrackColor: Colors.purple,
              inactiveTrackColor: Colors.purple.withValues(alpha: 0.2),
              hoverActiveTrackColor: Colors.purpleAccent,
              hoverInactiveTrackColor: Colors.purple.withValues(alpha: 0.4),
              disabledActiveTrackColor: Colors.grey,
              disabledInactiveTrackColor: Colors.grey.withValues(alpha: 0.2),
              thumbColor: Colors.purple,
              hoverThumbColor: Colors.purpleAccent,
              disabledThumbColor: Colors.grey,
              thumbShadowColor: Colors.black26,
              valueIndicatorColor: Colors.purple,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
              thumbBorderColor: Colors.white,
              hoverThumbBorderColor: Colors.purple,
              disabledThumbBorderColor: Colors.grey,
              trackHeight: 6.0,
              thumbSize: 24.0,
            ),
            onChanged: (value) {
              setState(() {
                _customValue = value;
              });
            },
          ),
          Text('当前值: ${(_customValue * 100).toStringAsFixed(0)}%'),
        ],
      ),
    );
  }
}
