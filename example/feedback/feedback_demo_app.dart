/// ZephyrUI 反馈组件示例应用
///
/// 展示各种反馈组件的使用方法和效果。
library feedback_demo_app;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const FeedbackDemoApp());
}

class FeedbackDemoApp extends StatelessWidget {
  const FeedbackDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI 反馈组件示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        extensions: [
          ZephyrMessageTheme.light(),
          ZephyrNotificationTheme.light(),
          ZephyrPopconfirmTheme.light(),
          ZephyrSpinTheme.light(),
          ZephyrBackTopTheme.light(),
        ],
      ),
      home: const FeedbackDemoPage(),
    );
  }
}

class FeedbackDemoPage extends StatefulWidget {
  const FeedbackDemoPage({Key? key}) : super(key: key);

  @override
  State<FeedbackDemoPage> createState() => _FeedbackDemoPageState();
}

class _FeedbackDemoPageState extends State<FeedbackDemoPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 反馈组件示例'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Message 全局提示'),
            _buildMessageDemo(),
            const SizedBox(height: 32),
            _buildSectionTitle('Notification 通知提醒'),
            _buildNotificationDemo(),
            const SizedBox(height: 32),
            _buildSectionTitle('Popconfirm 气泡确认框'),
            _buildPopconfirmDemo(),
            const SizedBox(height: 32),
            _buildSectionTitle('Spin 加载中'),
            _buildSpinDemo(),
            const SizedBox(height: 32),
            _buildSectionTitle('BackTop 返回顶部'),
            _buildBackTopDemo(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: ZephyrBackTop(
        scrollController: _scrollController,
        targetHeight: 200,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildMessageDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _showMessage(ZephyrVariant.success),
              child: const Text('成功消息'),
            ),
            ElevatedButton(
              onPressed: () => _showMessage(ZephyrVariant.error),
              child: const Text('错误消息'),
            ),
            ElevatedButton(
              onPressed: () => _showMessage(ZephyrVariant.warning),
              child: const Text('警告消息'),
            ),
            ElevatedButton(
              onPressed: () => _showMessage(ZephyrVariant.info),
              child: const Text('信息消息'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _showNotification(ZephyrVariant.success),
              child: const Text('成功通知'),
            ),
            ElevatedButton(
              onPressed: () => _showNotification(ZephyrVariant.error),
              child: const Text('错误通知'),
            ),
            ElevatedButton(
              onPressed: () => _showNotification(ZephyrVariant.warning),
              child: const Text('警告通知'),
            ),
            ElevatedButton(
              onPressed: () => _showNotification(ZephyrVariant.info),
              child: const Text('信息通知'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPopconfirmDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ZephyrPopconfirm(
              title: '确认删除？',
              message: '此操作不可恢复',
              onConfirm: () => _showMessage(ZephyrVariant.success),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('删除操作'),
              ),
            ),
            ZephyrPopconfirm(
              title: '确认提交？',
              message: '提交后将无法修改',
              onConfirm: () => _showMessage(ZephyrVariant.success),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('提交操作'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpinDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _showSpinDemo(),
              child: const Text('显示加载'),
            ),
            ElevatedButton(
              onPressed: () => _showFullscreenSpin(),
              child: const Text('全屏加载'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('内容区域'),
          ),
        ),
      ],
    );
  }

  Widget _buildBackTopDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '向下滚动页面，返回顶部按钮将会出现在右下角',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        const Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('滚动测试区域'),
          ),
        ),
      ],
    );
  }

  void _showMessage(ZephyrVariant variant) {
    String content;
    switch (variant) {
      case ZephyrVariant.success:
        content = '操作成功完成！';
        break;
      case ZephyrVariant.error:
        content = '操作失败，请重试！';
        break;
      case ZephyrVariant.warning:
        content = '请注意，这是一个警告！';
        break;
      case ZephyrVariant.info:
        content = '这是一条信息提示！';
        break;
      default:
        content = '未知消息类型';
    }

    ZephyrMessage.show(
      context,
      content: content,
      type: variant,
      duration: const Duration(seconds: 3),
    );
  }

  void _showNotification(ZephyrVariant variant) {
    String title;
    String? message;
    switch (variant) {
      case ZephyrVariant.success:
        title = '操作成功';
        message = '您的操作已成功完成';
        break;
      case ZephyrVariant.error:
        title = '操作失败';
        message = '操作过程中发生错误';
        break;
      case ZephyrVariant.warning:
        title = '警告';
        message = '请注意检查您的输入';
        break;
      case ZephyrVariant.info:
        title = '信息';
        message = '这是一条重要信息';
        break;
      default:
        title = '通知';
        message = '未知通知类型';
    }

    ZephyrNotification.show(
      context,
      title: title,
      message: message,
      type: variant,
      duration: const Duration(seconds: 4),
    );
  }

  void _showSpinDemo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('加载示例'),
        content: const SizedBox(
          width: 200,
          height: 100,
          child: ZephyrSpin(
            spinning: true,
            tip: '加载中...',
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text('内容'),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showFullscreenSpin() {
    ZephyrSpin.showFullscreen(
      context,
      tip: '正在加载...',
      size: ZephyrSpinSize.large,
    );

    // 模拟加载过程
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        ZephyrSpin.hideFullscreen(context);
        _showMessage(ZephyrVariant.success);
      }
    });
  }
}
