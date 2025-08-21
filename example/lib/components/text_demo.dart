import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class TextDemo extends StatelessWidget {
  const TextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文本组件演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '标题样式',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 标题样式展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZephyrText('主标题 H1', style: ZephyrTextStyle.headline1),
                    const SizedBox(height: 8),
                    ZephyrText('副标题 H2', style: ZephyrTextStyle.headline2),
                    const SizedBox(height: 8),
                    ZephyrText('标题 H3', style: ZephyrTextStyle.headline3),
                    const SizedBox(height: 8),
                    ZephyrText('标题 H4', style: ZephyrTextStyle.headline4),
                    const SizedBox(height: 8),
                    ZephyrText('标题 H5', style: ZephyrTextStyle.headline5),
                    const SizedBox(height: 8),
                    ZephyrText('标题 H6', style: ZephyrTextStyle.headline6),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '正文样式',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 正文样式展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZephyrText(
                      '这是主要正文样式，用于段落内容的显示。它具有合适的字体大小和行高，确保良好的阅读体验。',
                      style: ZephyrTextStyle.body1,
                    ),
                    const SizedBox(height: 12),
                    ZephyrText(
                      '这是次要正文样式，通常用于辅助信息的显示，字体相对较小。',
                      style: ZephyrTextStyle.body2,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '特殊样式',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 特殊样式展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZephyrText('按钮文本', style: ZephyrTextStyle.button),
                    const SizedBox(height: 8),
                    ZephyrText(
                      '链接文本',
                      style: ZephyrTextStyle.link,
                      onPressed: () => _showMessage(context, '链接被点击'),
                    ),
                    const SizedBox(height: 8),
                    ZephyrText('小字说明文本', style: ZephyrTextStyle.caption),
                    const SizedBox(height: 8),
                    ZephyrText('上划线文本', style: ZephyrTextStyle.overline),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '文本颜色',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 颜色展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZephyrText('主要文本', color: ZephyrColors.primary),
                    const SizedBox(height: 8),
                    ZephyrText('次要文本', color: ZephyrColors.secondary),
                    const SizedBox(height: 8),
                    ZephyrText('成功文本', color: ZephyrColors.success),
                    const SizedBox(height: 8),
                    ZephyrText('警告文本', color: ZephyrColors.warning),
                    const SizedBox(height: 8),
                    ZephyrText('错误文本', color: ZephyrColors.error),
                    const SizedBox(height: 8),
                    ZephyrText('禁用文本', color: ZephyrColors.disabled),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '文本对齐',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 对齐展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ZephyrText(
                      '左对齐文本 Left aligned text',
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 8),
                    ZephyrText(
                      '居中对齐文本 Center aligned text',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ZephyrText(
                      '右对齐文本 Right aligned text',
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '文本截断',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 截断展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZephyrText(
                      '这是一段很长的文本，当设置最大行数为1行时，超出部分会被截断并显示省略号。',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    ZephyrText(
                      '这是一段很长的文本，当设置最大行数为2行时，超出部分会被截断并显示省略号。这样可以保持布局的整洁性，同时提供良好的用户体验。',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '文本装饰',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 装饰展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZephyrText(
                      '下划线文本',
                      decoration: TextDecoration.underline,
                    ),
                    const SizedBox(height: 8),
                    ZephyrText(
                      '删除线文本',
                      decoration: TextDecoration.lineThrough,
                    ),
                    const SizedBox(height: 8),
                    ZephyrText(
                      '上划线文本',
                      decoration: TextDecoration.overline,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '富文本示例',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 富文本展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '欢迎使用 ',
                        style: ZephyrTextStyle.body1,
                      ),
                      TextSpan(
                        text: 'ZephyrUI',
                        style: ZephyrTextStyle.body1.copyWith(
                          color: ZephyrColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' - 这是一个强大的 ',
                        style: ZephyrTextStyle.body1,
                      ),
                      TextSpan(
                        text: 'Flutter UI 组件库',
                        style: ZephyrTextStyle.body1.copyWith(
                          color: ZephyrColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '实际应用示例',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 实际应用示例
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 文章标题
                    ZephyrText(
                      'Flutter 开发最佳实践',
                      style: ZephyrTextStyle.headline5,
                    ),
                    const SizedBox(height: 8),
                    
                    // 文章元信息
                    Row(
                      children: [
                        ZephyrText(
                          '作者：张三',
                          style: ZephyrTextStyle.caption,
                        ),
                        const SizedBox(width: 16),
                        ZephyrText(
                          '2024年8月18日',
                          style: ZephyrTextStyle.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // 文章摘要
                    ZephyrText(
                      '本文介绍了Flutter开发中的最佳实践，包括代码结构、性能优化、状态管理等方面的建议。通过遵循这些实践，您可以构建出高质量的Flutter应用程序。',
                      style: ZephyrTextStyle.body2,
                      color: ZephyrColors.secondary,
                    ),
                    const SizedBox(height: 16),
                    
                    // 阅读更多链接
                    ZephyrText(
                      '阅读全文 →',
                      style: ZephyrTextStyle.link,
                      onPressed: () => _showMessage(context, '阅读全文'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '状态文本示例',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 状态文本展示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ZephyrIcon(Icons.check_circle, size: 20, color: Colors.green),
                        const SizedBox(width: 8),
                        ZephyrText(
                          '操作成功完成',
                          style: ZephyrTextStyle.body1.copyWith(
                            color: ZephyrColors.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ZephyrIcon(Icons.error, size: 20, color: Colors.red),
                        const SizedBox(width: 8),
                        ZephyrText(
                          '操作失败，请重试',
                          style: ZephyrTextStyle.body1.copyWith(
                            color: ZephyrColors.error,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ZephyrIcon(Icons.warning, size: 20, color: Colors.orange),
                        const SizedBox(width: 8),
                        ZephyrText(
                          '请注意检查输入信息',
                          style: ZephyrTextStyle.body1.copyWith(
                            color: ZephyrColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}