import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

// Basic examples
import 'basic/button_example.dart';
import 'basic/chip_example.dart';
import 'basic/icon_example.dart';
import 'basic/spinner_example.dart';

// Feedback examples
import 'feedback/notification_example.dart';
import 'feedback/popconfirm_example.dart';
import 'feedback/dialog_example.dart';
import 'feedback/toast_example.dart';
import 'feedback/loading_example.dart';
import 'feedback/progress_example.dart';

// Form examples
import 'form/input_example.dart';
import 'form/checkbox_example.dart';
import 'form/radio_example.dart';
import 'form/switch_example.dart';
import 'form/slider_example.dart';

// Navigation examples
import 'navigation/tabs_example.dart';

void main() {
  runApp(const VelocityShowcaseApp());
}

class VelocityShowcaseApp extends StatelessWidget {
  const VelocityShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VelocityDynamicTheme(
      lightTheme: VelocityThemeData.light(),
      darkTheme: VelocityThemeData.dark(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'VelocityUI Showcase',
            debugShowCheckedModeBanner: false,
            theme: VelocityTheme.of(context).toThemeData(),
            home: const ShowcaseHomePage(),
          );
        },
      ),
    );
  }
}

class ShowcaseHomePage extends StatelessWidget {
  const ShowcaseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VelocityUI 组件库'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => VelocityDynamicTheme.of(context).toggleTheme(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildComponentCategory(
            context,
            '基础组件',
            Icons.widgets,
            VelocityColors.primary,
            [
              _ComponentItem('Button 按钮', const ButtonExample()),
              _ComponentItem('Chip 芯片', const ChipExample()),
              _ComponentItem('Icon 图标', const IconExample()),
              _ComponentItem('Spinner 加载动画', const SpinnerExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '反馈组件',
            Icons.feedback,
            VelocityColors.secondary,
            [
              _ComponentItem('Notification 通知', const NotificationExample()),
              _ComponentItem('Popconfirm 确认气泡', const PopconfirmExample()),
              _ComponentItem('Dialog 对话框', const DialogExample()),
              _ComponentItem('Toast 轻提示', const ToastExample()),
              _ComponentItem('Loading 加载', const LoadingExample()),
              _ComponentItem('Progress 进度条', const ProgressExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '表单组件',
            Icons.edit_note,
            VelocityColors.success,
            [
              _ComponentItem('Input 输入框', const InputExample()),
              _ComponentItem('Checkbox 复选框', const CheckboxExample()),
              _ComponentItem('Radio 单选框', const RadioExample()),
              _ComponentItem('Switch 开关', const SwitchExample()),
              _ComponentItem('Slider 滑块', const SliderExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '导航组件',
            Icons.navigation,
            VelocityColors.warning,
            [
              _ComponentItem('Tabs 标签页', const TabsExample()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [VelocityColors.primary, VelocityColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: VelocityColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.rocket_launch, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VelocityUI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '高性能 Flutter UI 组件库',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('55+ 组件'),
              _buildTag('主题系统'),
              _buildTag('响应式设计'),
              _buildTag('无障碍'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _buildComponentCategory(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    List<_ComponentItem> items,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${items.length} 个',
                    style: TextStyle(color: color, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          ...items.map((item) => _buildComponentTile(context, item)),
        ],
      ),
    );
  }

  Widget _buildComponentTile(BuildContext context, _ComponentItem item) {
    return ListTile(
      title: Text(item.name),
      trailing: const Icon(Icons.chevron_right, color: VelocityColors.gray400),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item.page),
        );
      },
    );
  }
}

class _ComponentItem {
  final String name;
  final Widget page;

  _ComponentItem(this.name, this.page);
}
