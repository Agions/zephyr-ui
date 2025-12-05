import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 表单组件示例 - 开关
class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _autoUpdate = true;
  bool _locationService = false;
  bool _dataSync = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch 开关'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('基础用法', _buildBasicSwitch()),
            _buildSection('带标签', _buildLabeledSwitch()),
            _buildSection('禁用状态', _buildDisabledSwitch()),
            _buildSection('设置页面示例', _buildSettingsExample()),
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

  Widget _buildBasicSwitch() {
    return Row(
      children: [
        VelocitySwitch(
          value: _notifications,
          onChanged: (value) => setState(() => _notifications = value),
        ),
        const SizedBox(width: 8),
        Text(_notifications ? '开启' : '关闭'),
      ],
    );
  }

  Widget _buildLabeledSwitch() {
    return Column(
      children: [
        VelocitySwitch(
          value: _darkMode,
          onChanged: (value) => setState(() => _darkMode = value),
          label: '深色模式',
        ),
        const SizedBox(height: 8),
        VelocitySwitch(
          value: _autoUpdate,
          onChanged: (value) => setState(() => _autoUpdate = value),
          label: '自动更新',
        ),
      ],
    );
  }

  Widget _buildDisabledSwitch() {
    return const Column(
      children: [
        Row(
          children: [
            VelocitySwitch(
              value: false,
              onChanged: null,
              disabled: true,
            ),
            SizedBox(width: 8),
            Text('禁用关闭'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            VelocitySwitch(
              value: true,
              onChanged: null,
              disabled: true,
            ),
            SizedBox(width: 8),
            Text('禁用开启'),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsExample() {
    return Card(
      child: Column(
        children: [
          _buildSettingItem(
            icon: Icons.notifications,
            title: '推送通知',
            subtitle: '接收消息推送提醒',
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
          const Divider(height: 1),
          _buildSettingItem(
            icon: Icons.dark_mode,
            title: '深色模式',
            subtitle: '减少屏幕亮度，保护眼睛',
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),
          const Divider(height: 1),
          _buildSettingItem(
            icon: Icons.system_update,
            title: '自动更新',
            subtitle: '在 Wi-Fi 下自动下载更新',
            value: _autoUpdate,
            onChanged: (value) => setState(() => _autoUpdate = value),
          ),
          const Divider(height: 1),
          _buildSettingItem(
            icon: Icons.location_on,
            title: '位置服务',
            subtitle: '允许应用访问您的位置',
            value: _locationService,
            onChanged: (value) => setState(() => _locationService = value),
          ),
          const Divider(height: 1),
          _buildSettingItem(
            icon: Icons.sync,
            title: '数据同步',
            subtitle: '自动同步您的数据',
            value: _dataSync,
            onChanged: (value) => setState(() => _dataSync = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: VelocityColors.gray600),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: VelocityColors.gray500)),
              ],
            ),
          ),
          VelocitySwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
