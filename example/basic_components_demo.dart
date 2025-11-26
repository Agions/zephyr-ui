/// ZephyrUI 基础组件示例
///
/// 展示新创建的基础组件的使用方法

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class BasicComponentsDemo extends StatelessWidget {
  const BasicComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 基础组件示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image 组件示例
            _buildImageSection(),
            const SizedBox(height: 32),

            // Dropdown 组件示例
            _buildDropdownSection(),
            const SizedBox(height: 32),

            // Tag 组件示例
            _buildTagSection(),
            const SizedBox(height: 32),

            // Typography 组件示例
            _buildTypographySection(),
            const SizedBox(height: 32),

            // Space 组件示例
            _buildSpaceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrTitle(text: 'Image 图片组件'),
        SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // 网络图片
            Column(
              children: [
                ZephyrNetworkImage(
                  url: 'https://via.placeholder.com/150',
                  width: 100,
                  height: 100,
                  shape: ZephyrImageShape.rounded,
                  borderRadius: 8,
                ),
                SizedBox(height: 8),
                Text('网络图片'),
              ],
            ),

            // 圆形图片
            Column(
              children: [
                ZephyrAssetImage(
                  path: 'assets/avatar.png',
                  width: 80,
                  height: 80,
                  shape: ZephyrImageShape.circle,
                ),
                SizedBox(height: 8),
                Text('圆形图片'),
              ],
            ),

            // 头像图片
            Column(
              children: [
                ZephyrAvatarImage(
                  name: '张三',
                  size: 60,
                ),
                SizedBox(height: 8),
                Text('头像图片'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownSection() {
    final items = [
      const ZephyrDropdownItem(
        value: 'apple',
        label: '苹果',
        subtitle: '新鲜水果',
      ),
      const ZephyrDropdownItem(
        value: 'banana',
        label: '香蕉',
        subtitle: '热带水果',
      ),
      const ZephyrDropdownItem(
        value: 'orange',
        label: '橙子',
        subtitle: '柑橘类水果',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ZephyrTitle(text: 'Dropdown 下拉菜单组件'),
        const SizedBox(height: 16),

        // 单选下拉菜单
        ZephyrDropdown<String>(
          items: items,
          value: 'apple',
          hintText: '请选择水果',
          labelText: '水果选择',
          onChanged: (value) {
            debugPrint('选择了: $value');
          },
          style: ZephyrDropdownStyle.outlined,
          showClearButton: true,
        ),

        const SizedBox(height: 16),

        // 多选下拉菜单
        ZephyrMultiSelectDropdown<String>(
          items: items,
          values: const ['apple', 'banana'],
          hintText: '请选择水果',
          labelText: '多选水果',
          onChanged: (values) {
            debugPrint('选择了: $values');
          },
          showSearch: true,
          showSelectAll: true,
        ),
      ],
    );
  }

  Widget _buildTagSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ZephyrTitle(text: 'Tag 标签组件'),
        const SizedBox(height: 16),

        ZephyrSpace(
          direction: Axis.horizontal,
          children: const [
            ZephyrTag(
              text: '默认',
              style: ZephyrTagStyle.defaultStyle,
            ),
            ZephyrTag(
              text: '成功',
              style: ZephyrTagStyle.success,
            ),
            ZephyrTag(
              text: '警告',
              style: ZephyrTagStyle.warning,
            ),
            ZephyrTag(
              text: '错误',
              style: ZephyrTagStyle.error,
            ),
            ZephyrTag(
              text: '信息',
              style: ZephyrTagStyle.info,
            ),
          ],
        ),

        const SizedBox(height: 16),

        // 可关闭标签
        ZephyrSpace(
          direction: Axis.horizontal,
          children: [
            ZephyrCloseableTag(
              text: '可关闭标签',
              onClose: () {
                debugPrint('标签已关闭');
              },
            ),
            const ZephyrTag(
              text: '带图标',
              icon: Icons.star,
            ),
          ],
        ),

        const SizedBox(height: 16),

        // 标签组
        ZephyrTagGroup(
          tags: const ['标签1', '标签2', '标签3', '标签4'],
          style: ZephyrTagStyle.success,
          onTagTap: (tag) {
            debugPrint('点击了: $tag');
          },
        ),
      ],
    );
  }

  Widget _buildTypographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ZephyrTitle(text: 'Typography 排版组件'),
        const SizedBox(height: 16),
        const ZephyrTypography(
          text: '主标题 H1',
          type: ZephyrTextType.h1,
          weight: ZephyrTextWeight.bold,
        ),
        const ZephyrTypography(
          text: '副标题 H2',
          type: ZephyrTextType.h2,
          weight: ZephyrTextWeight.bold,
        ),
        const ZephyrTypography(
          text: '三级标题 H3',
          type: ZephyrTextType.h3,
          weight: ZephyrTextWeight.bold,
        ),
        const SizedBox(height: 16),
        const ZephyrParagraph(
          text:
              '这是一段正文内容，用于展示段落文本的样式效果。Typography 组件提供了标准化的文本排版样式，包括不同级别的标题、正文、说明文字等。',
        ),
        const SizedBox(height: 16),
        const ZephyrCaption(
          text: '这是一段说明文字，通常用于显示次要信息或提示内容。',
        ),
        const SizedBox(height: 16),
        ZephyrLink(
          text: '这是一个链接',
          onTap: () {
            debugPrint('点击了链接');
          },
        ),
      ],
    );
  }

  Widget _buildSpaceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ZephyrTitle(text: 'Space 间距组件'),
        const SizedBox(height: 16),

        // 水平间距
        const ZephyrTypography(
          text: '水平间距：',
          type: ZephyrTextType.h4,
        ),

        const ZephyrSpace(
          direction: Axis.horizontal,
          children: [
            const Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              child: Center(
                child: Text('1', style: TextStyle(color: Colors.white)),
              ),
            ),
            const Container(
              width: 50,
              height: 50,
              color: Colors.green,
              child: Center(
                child: Text('2', style: TextStyle(color: Colors.white)),
              ),
            ),
            const Container(
              width: 50,
              height: 50,
              color: Colors.red,
              child: Center(
                child: Text('3', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 垂直间距
        const ZephyrTypography(
          text: '垂直间距：',
          type: ZephyrTextType.h4,
        ),

        const ZephyrSpace(
          direction: Axis.vertical,
          children: [
            const Container(
              width: double.infinity,
              height: 50,
              color: Colors.purple,
              child: Center(
                child: Text('容器 1', style: TextStyle(color: Colors.white)),
              ),
            ),
            const Container(
              width: double.infinity,
              height: 50,
              color: Colors.orange,
              child: Center(
                child: Text('容器 2', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 分隔线
        const ZephyrTypography(
          text: '分隔线：',
          type: ZephyrTextType.h4,
        ),

        const ZephyrSpaceDivider(
          text: '分隔线文本',
        ),

        const ZephyrSpaceDivider(
          direction: Axis.vertical,
          size: ZephyrSpaceSize.large,
        ),
      ],
    );
  }
}
