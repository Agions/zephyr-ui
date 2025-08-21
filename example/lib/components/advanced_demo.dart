import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:zephyr_ui/zephyr_ui.dart';

/// Advanced Components Demo Page
/// 
/// Demonstrates all advanced components in the ZephyrUI library.
class AdvancedComponentsDemo extends StatefulWidget {
  const AdvancedComponentsDemo({super.key});

  @override
  State<AdvancedComponentsDemo> createState() => _AdvancedComponentsDemoState();
}

class _AdvancedComponentsDemoState extends State<AdvancedComponentsDemo> {
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
        title: const Text('高级组件演示'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: () => _showTips(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildAutocompleteDemo(context),
            const SizedBox(height: 32),
            _buildCarouselDemo(context),
            const SizedBox(height: 32),
            _buildChartDemo(context),
            const SizedBox(height: 32),
            _buildColorPickerDemo(context),
            const SizedBox(height: 32),
            _buildRichEditorDemo(context),
            const SizedBox(height: 32),
            _buildUploadDemo(context),
            const SizedBox(height: 32),
            _buildQRCodeDemo(context),
            const SizedBox(height: 32),
            _buildSignaturePadDemo(context),
            const SizedBox(height: 32),
            _buildImageCropperDemo(context),
            const SizedBox(height: 32),
            _buildPDFViewerDemo(context),
            const SizedBox(height: 32),
            _buildMediaPlayerDemo(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '高级组件演示',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '探索 ZephyrUI 提供的强大高级组件',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutocompleteDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '自动完成组件',
      '智能搜索和自动补全功能',
      Icons.search,
      [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ZephyrAutoComplete<String>(
            items: const [
              'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
              'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon'
            ],
            controller: TextEditingController(),
            placeholder: '搜索水果...',
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('选择了: $value')),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '轮播图组件',
      '自动播放的图片轮播展示',
      Icons.slideshow,
      [
        SizedBox(
          height: 200,
          child: ZephyrCarousel(
            items: [
              ZephyrCarouselItem(
                child: Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Slide 1',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
              ZephyrCarouselItem(
                child: Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Slide 2',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
              ZephyrCarouselItem(
                child: Container(
                  color: Colors.orange,
                  child: const Center(
                    child: Text(
                      'Slide 3',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
            config: const ZephyrCarouselConfig(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              showIndicator: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChartDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '图表组件',
      '数据可视化图表展示',
      Icons.bar_chart,
      [
        SizedBox(
          height: 300,
          child: ZephyrChart(
            type: ZephyrChartType.bar,
            series: const [
              ZephyrChartSeries(
                name: '销售额',
                data: const [
                  ZephyrChartDataPoint(label: '一月', value: 1000),
                  ZephyrChartDataPoint(label: '二月', value: 1500),
                  ZephyrChartDataPoint(label: '三月', value: 1200),
                  ZephyrChartDataPoint(label: '四月', value: 1800),
                ],
                color: Colors.blue,
              ),
            ],
            config: const ZephyrChartConfig(
              showLegend: true,
              showGrid: true,
              title: '月度销售统计',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorPickerDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '颜色选择器',
      '直观的颜色选择界面',
      Icons.palette,
      [
        ZephyrColorPicker(
          theme: ZephyrColorPickerTheme.light(),
          onColorChanged: (color) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('选择了颜色: $color')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRichEditorDemo(BuildContext context) {
    final controller = quill.QuillController.basic();
    
    return _buildDemoSection(
      context,
      '富文本编辑器',
      '功能丰富的文本编辑器',
      Icons.edit,
      [
        SizedBox(
          height: 300,
          child: ZephyrRichEditor(
            controller: controller,
            placeholder: '开始输入内容...',
            showToolbar: true,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '文件上传组件',
      '拖拽上传和文件管理',
      Icons.cloud_upload,
      [
        ZephyrUpload(
          onUpload: (files) async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('上传了 ${files.length} 个文件')),
            );
          },
          maxFiles: 5,
          showFileList: true,
        ),
      ],
    );
  }

  Widget _buildQRCodeDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '二维码生成器',
      '快速生成二维码',
      Icons.qr_code,
      [
        Center(
          child: const ZephyrQRCode(
            data: 'https://zephyrui.dev',
            size: 200,
            theme: ZephyrQRCodeTheme.light(),
          ),
        ),
      ],
    );
  }

  Widget _buildSignaturePadDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '签名板',
      '手写签名和绘制',
      Icons.draw,
      [
        ZephyrSignaturePad(
          width: 400,
          height: 200,
          theme: ZephyrSignaturePadTheme.light(),
          onSignatureChanged: (signature) {
            debugPrint('签名已更新');
          },
        ),
      ],
    );
  }

  Widget _buildImageCropperDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '图片裁剪器',
      '精确的图片裁剪工具',
      Icons.crop,
      [
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('图片裁剪演示区域'),
          ),
        ),
      ],
    );
  }

  Widget _buildPDFViewerDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      'PDF 查看器',
      'PDF 文档查看和注释',
      Icons.picture_as_pdf,
      [
        Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('PDF 查看器演示区域'),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaPlayerDemo(BuildContext context) {
    return _buildDemoSection(
      context,
      '媒体播放器',
      '音视频播放控制',
      Icons.play_circle,
      [
        ZephyrMediaPlayer(
          type: ZephyrMediaType.audio,
          url: 'https://example.com/audio.mp3',
          theme: ZephyrMediaPlayerTheme.light(),
          showControls: true,
        ),
      ],
    );
  }

  Widget _buildDemoSection(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 28, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  void _showTips(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('使用提示'),
        content: const Text(
          '• 点击各个组件查看详细演示\n'
          '• 所有组件都支持主题定制\n'
          '• 组件遵循 Flutter 设计规范\n'
          '• 支持响应式布局和无障碍访问',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }
}