import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 容器
class ContainerExample extends StatelessWidget {
  const ContainerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container 容器'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicContainer()),
            _buildSection('自定义样式', _buildStyledContainer()),
            _buildSection('嵌套容器', _buildNestedContainer()),
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

  Widget _buildBasicContainer() {
    return const VelocityContainer(
      height: 100,
      style: VelocityContainerStyle(
        backgroundColor: VelocityColors.gray100,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        padding: EdgeInsets.all(16),
      ),
      child: Center(child: Text('基础容器')),
    );
  }

  Widget _buildStyledContainer() {
    return const VelocityContainer(
      height: 120,
      width: double.infinity,
      style: VelocityContainerStyle(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        padding: EdgeInsets.all(24),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.fromBorderSide(BorderSide(color: VelocityColors.primary, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('带阴影和边框', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('这是一个自定义样式的容器组件，支持圆角、边框、阴影等常用样式配置。'),
        ],
      ),
    );
  }

  Widget _buildNestedContainer() {
    return const VelocityContainer(
      constraints: BoxConstraints(minHeight: 150),
      style: VelocityContainerStyle(
        backgroundColor: VelocityColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        padding: EdgeInsets.all(20),
      ),
      child: Column(
        children: [
          Text('父容器', style: TextStyle(color: Colors.white)),
          SizedBox(height: 16),
          VelocityContainer(
            height: 60,
            width: double.infinity,
            style: VelocityContainerStyle(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(child: Text('子容器')),
          ),
        ],
      ),
    );
  }
}
