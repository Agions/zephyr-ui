import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 反馈组件示例 - 加载
class LoadingExample extends StatefulWidget {
  const LoadingExample({super.key});

  @override
  State<LoadingExample> createState() => _LoadingExampleState();
}

class _LoadingExampleState extends State<LoadingExample> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading 加载'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('加载类型', _buildLoadingTypes()),
            _buildSection('不同尺寸', _buildLoadingSizes()),
            _buildSection('带进度值', _buildLoadingWithValue()),
            _buildSection('加载覆盖层', _buildLoadingOverlay()),
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

  Widget _buildLoadingTypes() {
    return const Row(
      children: [
        Expanded(
          child: Column(
            children: [
              VelocityLoading(type: VelocityLoadingType.circular),
              SizedBox(height: 8),
              Text('Circular', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: 150,
                child: VelocityLoading(type: VelocityLoadingType.linear),
              ),
              SizedBox(height: 8),
              Text('Linear', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSizes() {
    return const Wrap(
      spacing: 32,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          children: [
            VelocityLoading(size: 16),
            SizedBox(height: 8),
            Text('16px', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocityLoading(size: 24),
            SizedBox(height: 8),
            Text('24px', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocityLoading(size: 32),
            SizedBox(height: 8),
            Text('32px', style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            VelocityLoading(size: 48),
            SizedBox(height: 8),
            Text('48px', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingWithValue() {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  VelocityLoading(size: 40, value: 0.3),
                  SizedBox(height: 8),
                  Text('30%', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  VelocityLoading(size: 40, value: 0.6),
                  SizedBox(height: 8),
                  Text('60%', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  VelocityLoading(size: 40, value: 0.9),
                  SizedBox(height: 8),
                  Text('90%', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: VelocityLoading(type: VelocityLoadingType.linear, value: 0.7),
        ),
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Column(
      children: [
        VelocityButton.text(
          text: _isLoading ? '停止加载' : '显示加载覆盖层',
          onPressed: () {
            setState(() {
              _isLoading = !_isLoading;
            });
            if (_isLoading) {
              Future.delayed(const Duration(seconds: 3), () {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              });
            }
          },
        ),
        const SizedBox(height: 16),
        VelocityLoadingOverlay(
          loading: _isLoading,
          message: '加载中，请稍候...',
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: VelocityColors.gray100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('内容区域'),
            ),
          ),
        ),
      ],
    );
  }
}
