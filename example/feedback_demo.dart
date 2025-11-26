/// ZephyrUI Feedback 组件演示
///
/// 展示各种反馈组件的使用方法
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class FeedbackDemo extends StatefulWidget {
  const FeedbackDemo({Key? key}) : super(key: key);

  @override
  State<FeedbackDemo> createState() => _FeedbackDemoState();
}

class _FeedbackDemoState extends State<FeedbackDemo> {
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
        title: const Text('Feedback 组件演示'),
      ),
      body: ZephyrBackTopWrapper(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Message 组件'),
              const SizedBox(height: 16),
              _buildMessageDemo(),

              const SizedBox(height: 32),
              _buildSection('Notification 组件'),
              const SizedBox(height: 16),
              _buildNotificationDemo(),

              const SizedBox(height: 32),
              _buildSection('Popconfirm 组件'),
              const SizedBox(height: 16),
              _buildPopconfirmDemo(),

              const SizedBox(height: 32),
              _buildSection('Spin 组件'),
              const SizedBox(height: 16),
              _buildSpinDemo(),

              const SizedBox(height: 32),
              _buildSection('BackTop 组件'),
              const SizedBox(height: 16),
              _buildBackTopDemo(),

              // 添加更多内容以测试滚动
              ...List.generate(
                  20,
                  (index) => const Container(
                        height: 100,
                        margin: EdgeInsets.only(bottom: 16),
                        color: Colors.grey[200],
                        child: Center(child: Text('测试内容 $index')),
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildMessageDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrMessage.show(
                  context,
                  content: '这是一条成功消息',
                  type: ZephyrVariant.success,
                );
              },
              child: const Text('成功消息'),
            ),
            ElevatedButton(
              onPressed: () {
                ZephyrMessage.show(
                  context,
                  content: '这是一条错误消息',
                  type: ZephyrVariant.error,
                );
              },
              child: const Text('错误消息'),
            ),
            ElevatedButton(
              onPressed: () {
                ZephyrMessage.show(
                  context,
                  content: '这是一条警告消息',
                  type: ZephyrVariant.warning,
                );
              },
              child: const Text('警告消息'),
            ),
            ElevatedButton(
              onPressed: () {
                ZephyrMessage.show(
                  context,
                  content: '这是一条信息消息',
                  type: ZephyrVariant.info,
                );
              },
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
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrNotification.show(
                  context,
                  title: '成功',
                  message: '操作已成功完成',
                  type: ZephyrVariant.success,
                );
              },
              child: const Text('成功通知'),
            ),
            ElevatedButton(
              onPressed: () {
                ZephyrNotification.show(
                  context,
                  title: '错误',
                  message: '操作失败，请重试',
                  type: ZephyrVariant.error,
                );
              },
              child: const Text('错误通知'),
            ),
            ElevatedButton(
              onPressed: () {
                ZephyrNotification.show(
                  context,
                  title: '警告',
                  message: '请注意检查您的输入',
                  type: ZephyrVariant.warning,
                );
              },
              child: const Text('警告通知'),
            ),
            ElevatedButton(
              onPressed: () {
                ZephyrNotification.show(
                  context,
                  title: '信息',
                  message: '这是一条信息通知',
                  type: ZephyrVariant.info,
                );
              },
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
        ZephyrPopconfirm(
          title: '确认删除？',
          message: '此操作不可恢复',
          onConfirm: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('删除操作已确认')),
            );
          },
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('删除项目'),
          ),
        ),
        const SizedBox(height: 16),
        ZephyrPopconfirm(
          title: '确认提交？',
          message: '提交后将无法修改',
          confirmText: '提交',
          cancelText: '取消',
          confirmVariant: ZephyrVariant.primary,
          onConfirm: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('提交操作已确认')),
            );
          },
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('提交表单'),
          ),
        ),
      ],
    );
  }

  Widget _buildSpinDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          children: [
            ElevatedButton(
              onPressed: () {
                ZephyrSpin.showFullscreen(
                  context,
                  tip: '正在加载...',
                );
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) {
                    ZephyrSpin.hideFullscreen(context);
                  }
                });
              },
              child: const Text('显示全屏加载'),
            ),
            const Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ZephyrSpin(
                spinning: true,
                tip: '加载中...',
                child: Center(child: Text('内容区域')),
              ),
            ),
            const ZephyrSpin.small(
              spinning: true,
              tip: '小尺寸',
            ),
            const ZephyrSpin.large(
              spinning: true,
              tip: '大尺寸',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBackTopDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '向下滚动页面以查看返回顶部按钮',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        const Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('返回顶部按钮会出现在右下角'),
          ),
        ),
      ],
    );
  }
}
