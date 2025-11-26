import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class DisplayDemo extends StatefulWidget {
  const DisplayDemo({super.key});

  @override
  State<DisplayDemo> createState() => _DisplayDemoState();
}

class _DisplayDemoState extends State<DisplayDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Components Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Empty Components', [
            _buildEmptyDemo(),
          ]),
          const SizedBox(height: 24),
          _buildSection('Result Components', [
            _buildResultDemo(),
          ]),
          const SizedBox(height: 24),
          _buildSection('Skeleton Components', [
            _buildSkeletonDemo(),
          ]),
          const SizedBox(height: 24),
          _buildSection('Description Components', [
            _buildDescriptionDemo(),
          ]),
          const SizedBox(height: 24),
          _buildSection('Tooltip Components', [
            _buildTooltipDemo(),
          ]),
          const SizedBox(height: 24),
          _buildSection('Popover Components', [
            _buildPopoverDemo(),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildEmptyDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrEmpty(
              title: '暂无数据',
              description: '当前没有可显示的数据，请稍后再试',
            ),
            SizedBox(height: 16),
            ZephyrEmptySimple(
              description: '暂无搜索结果',
            ),
            SizedBox(height: 16),
            ZephyrEmptyImage(
              title: '搜索无结果',
              description: '没有找到匹配的内容，请尝试其他关键词',
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text('清除搜索'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('重新搜索'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrResult(
              status: ZephyrResultStatus.success,
              title: '提交成功',
              description: '您的信息已成功提交',
            ),
            SizedBox(height: 16),
            ZephyrResult(
              status: ZephyrResultStatus.error,
              title: '提交失败',
              description: '网络连接异常，请检查网络设置',
            ),
            SizedBox(height: 16),
            ZephyrResult(
              status: ZephyrResultStatus.warning,
              title: '注意',
              description: '此操作将永久删除数据，请谨慎操作',
            ),
            SizedBox(height: 16),
            ZephyrResultCard(
              status: ZephyrResultStatus.info,
              title: '操作提示',
              description: '请确保所有必填字段都已填写完整',
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text('取消'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('确定'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonDemo() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrSkeleton(
              width: double.infinity,
              height: 20,
            ),
            SizedBox(height: 16),
            ZephyrSkeletonText(
              lines: 3,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ZephyrSkeletonAvatar(
                  size: 40,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ZephyrSkeletonText(
                    lines: 2,
                    lineHeight: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ZephyrSkeletonCard(
              child: ZephyrSkeletonText(
                lines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionDemo() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrDescriptionList(
              items: [
                ZephyrDescriptionItem(
                  label: '用户名',
                  children: [
                    Text('zhangsan'),
                  ],
                ),
                ZephyrDescriptionItem(
                  label: '邮箱',
                  children: [
                    Text('zhangsan@example.com'),
                  ],
                ),
                ZephyrDescriptionItem(
                  label: '状态',
                  children: [
                    Text('活跃'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            ZephyrDescription(
              items: [
                ZephyrDescriptionItem(
                  label: '产品信息',
                  children: [
                    Text('iPhone 15 Pro'),
                    Text('¥8,999'),
                  ],
                ),
              ],
              column: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTooltipDemo() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrTooltip(
              message: '这是一个提示信息',
              child: ElevatedButton(
                onPressed: null,
                child: Text('悬停查看提示'),
              ),
            ),
            SizedBox(height: 16),
            ZephyrTooltip(
              message: '点击了解更多详情',
              placement: ZephyrTooltipPlacement.right,
              child: Icon(Icons.info_outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopoverDemo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ZephyrPopoverCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('用户信息', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('姓名: 张三'),
                  Text('邮箱: zhangsan@example.com'),
                  Text('部门: 技术部'),
                ],
              ),
            ),
            SizedBox(height: 16),
            ZephyrPopoverList(
              items: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('编辑'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('删除'),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
