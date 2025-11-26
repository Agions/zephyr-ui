import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const TestFeedbackApp());
}

class TestFeedbackApp extends StatelessWidget {
  const TestFeedbackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI Feedback 组件测试',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TestHomePage(),
    );
  }
}

class TestHomePage extends StatelessWidget {
  const TestHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Feedback 组件测试'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Feedback 组件测试',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('所有 feedback 组件已成功创建并导出！'),
              SizedBox(height: 20),
              FeedbackTestButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackTestButtons extends StatelessWidget {
  const FeedbackTestButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ZephyrMessage.show(
              context,
              content: '测试消息组件',
              type: ZephyrVariant.success,
            );
          },
          child: const Text('测试 Message'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            ZephyrNotification.show(
              context,
              title: '测试通知',
              message: '这是一个通知测试',
              type: ZephyrVariant.info,
            );
          },
          child: const Text('测试 Notification'),
        ),
        const SizedBox(height: 10),
        ZephyrPopconfirm(
          title: '确认测试？',
          message: '这是一个气泡确认框测试',
          onConfirm: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('确认框测试成功')),
            );
          },
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('测试 Popconfirm'),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ZephyrSpin(
                spinning: true,
                tip: '测试加载中...',
                fullscreen: true,
              ),
            );
          },
          child: const Text('测试 Spin'),
        ),
      ],
    );
  }
}
