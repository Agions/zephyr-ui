# 高级组件

ZephyrUI 高级组件提供了一套功能强大的专业组件，用于构建复杂的企业级应用。

## 组件列表

- [ZephyrChart](chart.md) - 图表组件
- [ZephyrUpload](upload.md) - 文件上传
- [ZephyrColorPicker](color_picker.md) - 颜色选择器
- [ZephyrCarousel](carousel.md) - 轮播图
- [ZephyrRichEditor](rich_editor.md) - 富文本编辑器
- [ZephyrAutocomplete](auto_complete.md) - 自动完成
- [ZephyrImageCropper](image_cropper.md) - 图片裁剪
- [ZephyrMediaPlayer](media_player.md) - 媒体播放器
- [ZephyrPDFViewer](pdf_viewer.md) - PDF查看器
- [ZephyrQRCode](qr_code.md) - 二维码生成
- [ZephyrSignature](signature.md) - 签名板
- [ZephyrDragDrop](drag_drop.md) - 拖拽功能
- [ZephyrDataVisualization](data_visualization.md) - 数据可视化

## 使用示例

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class AdvancedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrChart(
          type: ZephyrChartType.line,
          data: [
            ChartData(x: 1, y: 10),
            ChartData(x: 2, y: 20),
            ChartData(x: 3, y: 15),
          ],
        ),
        ZephyrUpload(
          onFileSelected: (file) {
            print('选择的文件: $file');
          },
        ),
      ],
    );
  }
}
```