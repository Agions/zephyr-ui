# 反馈组件

ZephyrUI 反馈组件提供了一套完整的用户反馈解决方案，用于向用户提供状态信息和交互反馈。

## 组件列表

- [ZephyrAlert](alert.md) - 警告对话框
- [ZephyrToast](toast.md) - 消息提示
- [ZephyrProgress](progress.md) - 进度指示器
- [ZephyrSkeleton](skeleton.md) - 骨架屏加载
- [ZephyrModal](modal.md) - 模态对话框

## 使用示例

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class FeedbackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrButton.primary(
          text: '显示提示',
          onPressed: () {
            ZephyrToast.show(
              context,
              message: '操作成功！',
              type: ZephyrToastType.success,
            );
          },
        ),
        ZephyrAlert(
          title: '警告',
          content: '这是一个重要的警告信息',
          type: ZephyrAlertType.warning,
        ),
      ],
    );
  }
}
```