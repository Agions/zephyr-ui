import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/component_card.dart';
import '../widgets/example_card.dart';
import '../services/theme_service.dart';

class BasicComponentsDemo extends StatelessWidget {
  const BasicComponentsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础组件'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => _showThemeDialog(context),
            tooltip: '主题设置',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: '组件信息',
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          _buildButtonExamples(),
          const SizedBox(height: 32),
          _buildTextExamples(),
          const SizedBox(height: 32),
          _buildIconExamples(),
          const SizedBox(height: 32),
          _buildCardExamples(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildButtonExamples(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTextExamples(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildIconExamples(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildCardExamples(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroduction(),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildButtonExamples(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildTextExamples(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildIconExamples(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCardExamples(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '基础组件',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ZephyrUI 提供了 8 个基础 UI 组件，遵循 Material Design 3 规范',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '8 个组件',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Material Design 3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '这些组件具有一致的设计风格和优秀的用户体验，支持主题定制和无障碍访问。',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildButtonExamples() {
    return ExampleCard(
      title: '按钮组件',
      code: '''ElevatedButton(
  onPressed: () {},
  child: const Text('主要按钮'),
)

OutlinedButton(
  onPressed: () {},
  child: const Text('次要按钮'),
)

TextButton(
  onPressed: () {},
  child: const Text('文本按钮'),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '基础按钮',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Material Design 3 按钮样式',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () => _showButtonAction(context, '主要按钮'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('主要按钮'),
              ),
              OutlinedButton(
                onPressed: () => _showButtonAction(context, '次要按钮'),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('次要按钮'),
              ),
              TextButton(
                onPressed: () => _showButtonAction(context, '文本按钮'),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('文本按钮'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '图标按钮',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () => _showButtonAction(context, '保存'),
                icon: const Icon(Icons.save),
                label: const Text('保存'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showButtonAction(context, '删除'),
                icon: const Icon(Icons.delete),
                label: const Text('删除'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              FilledButton.icon(
                onPressed: () => _showButtonAction(context, '下载'),
                icon: const Icon(Icons.download),
                label: const Text('下载'),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '按钮状态',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _showButtonAction(context, '正常状态'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('正常状态'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('禁用状态'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 8),
                    Text('加载中'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextExamples() {
    return ExampleCard(
      title: '文本组件',
      code: '''Text(
  '标题文本',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)

Text(
  '正文文本',
  style: TextStyle(
    fontSize: 16,
    color: Colors.grey[600],
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '标题文本',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '副标题文本',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '正文文本内容，这是普通的正文文本样式。正文文本通常用于显示详细的信息内容。',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '小字文本',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '文本样式示例',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '主要',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '成功',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '错误',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconExamples() {
    return const ExampleCard(
      title: '图标组件',
      code: '''Icon(
  Icons.home,
  size: 24,
  color: Colors.blue,
)

Icon(
  Icons.favorite,
  size: 32,
  color: Colors.red,
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '基础图标',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Column(
                children: [
                  Icon(Icons.home, size: 32, color: Colors.blue),
                  SizedBox(height: 4),
                  Text('首页'),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.search, size: 32, color: Colors.green),
                  SizedBox(height: 4),
                  Text('搜索'),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.notifications, size: 32, color: Colors.orange),
                  SizedBox(height: 4),
                  Text('通知'),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.settings, size: 32, color: Colors.purple),
                  SizedBox(height: 4),
                  Text('设置'),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            '图标大小',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.star, size: 16, color: Colors.amber),
              Icon(Icons.star, size: 24, color: Colors.amber),
              Icon(Icons.star, size: 32, color: Colors.amber),
              Icon(Icons.star, size: 48, color: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardExamples() {
    return ExampleCard(
      title: '卡片组件',
      code: '''Card(
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('卡片标题'),
        const SizedBox(height: 8),
        Text('卡片内容'),
      ],
    ),
  ),
)''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '基础卡片',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '卡片标题',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '这是卡片的内容描述。卡片可以包含各种类型的内容，如文本、图片、按钮等。',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('取消'),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('确认'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '带图标的卡片',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person, size: 32),
              title: const Text('用户信息'),
              subtitle: const Text('查看和编辑用户资料'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _showButtonAction(BuildContext context, String buttonName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('点击了 $buttonName 按钮'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: '确定',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('主题设置'),
        content: const SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 主题模式
              Column(
                children: [
                  ListTile(
                    title: Text('浅色主题'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.light,
                      groupValue: themeService.themeMode,
                      onChanged: (value) => themeService.setThemeMode(value!),
                    ),
                  ),
                  ListTile(
                    title: Text('深色主题'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.dark,
                      groupValue: themeService.themeMode,
                      onChanged: (value) => themeService.setThemeMode(value!),
                    ),
                  ),
                  ListTile(
                    title: Text('跟随系统'),
                    leading: Radio<ThemeMode>(
                      value: ThemeMode.system,
                      groupValue: themeService.themeMode,
                      onChanged: (value) => themeService.setThemeMode(value!),
                    ),
                  ),
                ],
              ),

              Divider(),

              // 预设主题
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ThemeService.themePresets.length,
                  itemBuilder: (context, index) {
                    final preset = ThemeService.themePresets[index];
                    final isSelected = themeService.themePreset == index;

                    return GestureDetector(
                      onTap: () => themeService.applyThemePreset(index),
                      child: const Container(
                        width: 80,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.withValues(alpha: 0.3),
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: preset['primary'],
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: preset['accent'],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('基础组件信息'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('包含组件：'),
            SizedBox(height: 8),
            Text('• ZephyrButton - 按钮组件'),
            Text('• ZephyrText - 文本组件'),
            Text('• ZephyrIcon - 图标组件'),
            Text('• ZephyrCard - 卡片组件'),
            Text('• ZephyrAvatar - 头像组件'),
            Text('• ZephyrBadge - 徽章组件'),
            Text('• ZephyrChip - 标签组件'),
            Text('• ZephyrDivider - 分割线组件'),
            SizedBox(height: 16),
            Text('特性：'),
            SizedBox(height: 8),
            Text('• Material Design 3 规范'),
            Text('• 支持主题定制'),
            Text('• 无障碍访问'),
            Text('• 响应式设计'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
