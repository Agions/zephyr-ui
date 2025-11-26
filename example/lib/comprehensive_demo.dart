import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 综合演示页面
///
/// 展示所有54+组件的完整功能，体现企业级组件库的强大能力。
class ComprehensiveDemo extends StatefulWidget {
  const ComprehensiveDemo({Key? key}) : super(key: key);

  @override
  State<ComprehensiveDemo> createState() => _ComprehensiveDemoState();
}

class _ComprehensiveDemoState extends State<ComprehensiveDemo> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BasicComponentsDemo(),
    const FormComponentsDemo(),
    const NavigationComponentsDemo(),
    const FeedbackComponentsDemo(),
    const DisplayComponentsDemo(),
    const LayoutComponentsDemo(),
    const AdvancedComponentsDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 侧边导航
          const Container(
            width: 280,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ZephyrText.headlineLarge('ZephyrUI'),
                      SizedBox(height: 8),
                      ZephyrText.bodyMedium('54+ 企业级组件'),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildNavItem(
                        icon: Icons.widgets,
                        title: '基础组件',
                        subtitle: '8个组件',
                        index: 0,
                      ),
                      _buildNavItem(
                        icon: Icons.edit_note,
                        title: '表单组件',
                        subtitle: '13个组件',
                        index: 1,
                      ),
                      _buildNavItem(
                        icon: Icons.navigation,
                        title: '导航组件',
                        subtitle: '8个组件',
                        index: 2,
                      ),
                      _buildNavItem(
                        icon: Icons.notifications,
                        title: '反馈组件',
                        subtitle: '6个组件',
                        index: 3,
                      ),
                      _buildNavItem(
                        icon: IconData(0xf1e8,
                            fontFamily: 'MaterialIcons'), // chart
                        title: '数据展示',
                        subtitle: '13个组件',
                        index: 4,
                      ),
                      _buildNavItem(
                        icon: Icons.dashboard,
                        title: '布局组件',
                        subtitle: '4个组件',
                        index: 5,
                      ),
                      _buildNavItem(
                        icon: Icons.auto_awesome,
                        title: '高级组件',
                        subtitle: '16个组件',
                        index: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 主内容区域
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required int index,
  }) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: const Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZephyrText.labelLarge(
                    title,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  ZephyrText.bodySmall(
                    subtitle,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 基础组件演示
class BasicComponentsDemo extends StatelessWidget {
  const BasicComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrText.headlineLarge('基础组件'),
          ZephyrText.bodyMedium('8个精心设计的基础UI组件'),
          const SizedBox(height: 32),

          // 头像组件
          _buildSection('头像组件', [
            Row(
              children: [
                ZephyrAvatar.text(text: 'ZU', size: ZephyrAvatarSize.small),
                const SizedBox(width: 16),
                ZephyrAvatar.text(text: 'ZU', size: ZephyrAvatarSize.medium),
                const SizedBox(width: 16),
                ZephyrAvatar.text(text: 'ZU', size: ZephyrAvatarSize.large),
                const SizedBox(width: 16),
                ZephyrAvatar.image(
                  imagePath: 'https://via.placeholder.com/150',
                  size: ZephyrAvatarSize.medium,
                ),
              ],
            ),
          ]),

          // 徽章组件
          _buildSection('徽章组件', [
            const Wrap(
              spacing: 16,
              children: [
                ZephyrBadge(content: '新'),
                ZephyrBadge(content: '12', backgroundColor: Colors.red),
                ZephyrBadge.dot(),
                ZephyrBadge(content: 'Hot', backgroundColor: Colors.orange),
              ],
            ),
          ]),

          // 按钮组件
          _buildSection('按钮组件', [
            Wrap(
              spacing: 16,
              children: [
                ZephyrButton.primary(text: '主要按钮', onPressed: () {}),
                ZephyrButton.secondary(text: '次要按钮', onPressed: () {}),
                ZephyrButton.outline(text: '轮廓按钮', onPressed: () {}),
                ZephyrButton.text(text: '文本按钮', onPressed: () {}),
              ],
            ),
          ]),

          // 卡片组件
          _buildSection('卡片组件', [
            ZephyrCard(
              title: '卡片标题',
              subtitle: '卡片副标题',
              content: const Text('这是卡片的内容区域，可以放置任何组件。'),
              actions: [
                ZephyrButton.text(text: '操作', onPressed: () {}),
              ],
            ),
          ]),

          // 标签组件
          _buildSection('标签组件', [
            Wrap(
              spacing: 8,
              children: [
                ZephyrChip(label: '标签1', onSelected: (selected) {}),
                ZephyrChip(label: '标签2', onSelected: (selected) {}),
                ZephyrChip(label: '标签3', onSelected: (selected) {}),
              ],
            ),
          ]),

          // 分割线组件
          _buildSection('分割线组件', [
            Column(
              children: [
                const Text('上半部分'),
                const ZephyrDivider(),
                const Text('下半部分'),
                const SizedBox(height: 16),
                const Text('带文本的分割线'),
                const ZephyrDivider(text: '或者'),
              ],
            ),
          ]),

          // 图标组件
          _buildSection('图标组件', [
            const Wrap(
              spacing: 16,
              children: [
                ZephyrIcon(Icons.home, size: 24),
                ZephyrIcon(Icons.search, size: 24),
                ZephyrIcon(Icons.notifications, size: 24),
                ZephyrIcon(Icons.settings, size: 24),
              ],
            ),
          ]),

          // 文本组件
          _buildSection('文本组件', [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZephyrText.headlineLarge('大标题'),
                ZephyrText.headlineMedium('中标题'),
                ZephyrText.headlineSmall('小标题'),
                ZephyrText.titleLarge('大正文'),
                ZephyrText.titleMedium('中正文'),
                ZephyrText.titleSmall('小正文'),
                ZephyrText.bodyLarge('大段落'),
                ZephyrText.bodyMedium('中段落'),
                ZephyrText.bodySmall('小段落'),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZephyrText.headlineMedium(title),
        const SizedBox(height: 16),
        ...children,
        const SizedBox(height: 32),
      ],
    );
  }
}

/// 表单组件演示
class FormComponentsDemo extends StatelessWidget {
  const FormComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrText.headlineLarge('表单组件'),
          ZephyrText.bodyMedium('13个完整的表单组件'),
          const SizedBox(height: 32),
          ZephyrCard(
            title: '完整表单示例',
            content: Column(
              children: [
                ZephyrInput(
                  placeholder: '请输入用户名',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '用户名不能为空';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const ZephyrInput(
                  placeholder: '请输入密码',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                ),
                const SizedBox(height: 16),
                ZephyrSelect(
                  placeholder: '请选择职业',
                  items: const ['开发者', '设计师', '产品经理', '其他'],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ZephyrCheckbox(value: false, onChanged: (value) {}),
                    const SizedBox(width: 8),
                    const Text('我同意用户协议'),
                  ],
                ),
                const SizedBox(height: 16),
                ZephyrRating(
                  value: 4,
                  allowHalfRating: true,
                  onValueChanged: (value) {},
                ),
                const SizedBox(height: 16),
                ZephyrSlider(
                  value: 0.5,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 24),
                ZephyrButton.primary(
                  text: '提交表单',
                  onPressed: () {},
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 导航组件演示
class NavigationComponentsDemo extends StatelessWidget {
  const NavigationComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrText.headlineLarge('导航组件'),
          ZephyrText.bodyMedium('8个导航组件'),
          const SizedBox(height: 32),
          ZephyrCard(
            title: '导航示例',
            content: Column(
              children: [
                // 面包屑
                const ZephyrBreadcrumb(
                  items: ['首页', '产品', '详情'],
                ),
                const SizedBox(height: 24),

                // 选项卡
                ZephyrTabs(
                  tabs: const ['概览', '详情', '设置'],
                  onTabChanged: (index) {},
                ),
                const SizedBox(height: 24),

                // 步骤器
                const ZephyrStepper(
                  steps: ['第一步', '第二步', '第三步'],
                  currentStep: 1,
                ),
                const SizedBox(height: 24),

                // 分页
                ZephyrPagination(
                  currentPage: 1,
                  totalPages: 10,
                  onPageChanged: (page) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 反馈组件演示
class FeedbackComponentsDemo extends StatelessWidget {
  const FeedbackComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrText.headlineLarge('反馈组件'),
          ZephyrText.bodyMedium('6个反馈组件'),
          const SizedBox(height: 32),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ZephyrButton.primary(
                text: '显示提示',
                onPressed: () {
                  // 显示 Toast
                },
              ),
              ZephyrButton.secondary(
                text: '显示对话框',
                onPressed: () {
                  // 显示 Alert
                },
              ),
              ZephyrButton.outline(
                text: '显示加载',
                onPressed: () {
                  // 显示 Progress
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 进度指示器
          ZephyrProgress(
            value: 0.7,
            type: ZephyrProgressType.linear,
          ),
          const SizedBox(height: 16),

          // 骨架屏
          ZephyrSkeleton(
            type: ZephyrSkeletonType.list,
          ),
        ],
      ),
    );
  }
}

/// 数据展示组件演示
class DisplayComponentsDemo extends StatelessWidget {
  const DisplayComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrText.headlineLarge('数据展示组件'),
          ZephyrText.bodyMedium('13个数据展示组件'),
          const SizedBox(height: 32),

          // 统计数据
          Row(
            children: [
              Expanded(
                child: ZephyrStatistic(
                  title: '总用户数',
                  value: '1,234',
                  suffix: '人',
                  trend: ZephyrStatisticTrend.up,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ZephyrStatistic(
                  title: '转化率',
                  value: '68.5',
                  suffix: '%',
                  trend: ZephyrStatisticTrend.down,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 表格
          const ZephyrCard(
            title: '数据表格',
            content: SizedBox(
              height: 300,
              child: ZephyrTable(
                columns: ['姓名', '年龄', '职业'],
                rows: [
                  ['张三', '28', '开发者'],
                  ['李四', '32', '设计师'],
                  ['王五', '26', '产品经理'],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 时间线
          ZephyrCard(
            title: '时间线',
            content: ZephyrTimeline(
              events: [
                ZephyrTimelineEvent(
                  title: '项目启动',
                  subtitle: '2024-01-01',
                  content: '项目正式启动',
                ),
                ZephyrTimelineEvent(
                  title: '第一阶段完成',
                  subtitle: '2024-03-01',
                  content: '完成核心功能开发',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 布局组件演示
class LayoutComponentsDemo extends StatelessWidget {
  const LayoutComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrText.headlineLarge('布局组件'),
          ZephyrText.bodyMedium('4个布局组件'),
          const SizedBox(height: 32),

          // 网格布局
          const ZephyrGrid(
            crossAxisCount: 3,
            children: [
              ZephyrCard(title: '卡片1', content: Text('内容1')),
              ZephyrCard(title: '卡片2', content: Text('内容2')),
              ZephyrCard(title: '卡片3', content: Text('内容3')),
              ZephyrCard(title: '卡片4', content: Text('内容4')),
              ZephyrCard(title: '卡片5', content: Text('内容5')),
              ZephyrCard(title: '卡片6', content: Text('内容6')),
            ],
          ),
          const SizedBox(height: 24),

          // 手风琴
          const ZephyrAccordion(
            items: [
              ZephyrAccordionItem(
                title: '什么是ZephyrUI？',
                content: Text('ZephyrUI是一个企业级的Flutter组件库，提供54+个高质量组件。'),
              ),
              ZephyrAccordionItem(
                title: '如何使用？',
                content: Text('只需要导入包并按照文档使用即可。'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 高级组件演示
class AdvancedComponentsDemo extends StatelessWidget {
  const AdvancedComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrText.headlineLarge('高级组件'),
          ZephyrText.bodyMedium('16个高级功能组件'),
          const SizedBox(height: 32),

          Wrap(
            spacing: 16,
            children: [
              ZephyrButton.primary(
                text: '文件上传',
                onPressed: () {
                  // 显示文件上传
                },
              ),
              ZephyrButton.secondary(
                text: '颜色选择',
                onPressed: () {
                  // 显示颜色选择器
                },
              ),
              ZephyrButton.outline(
                text: '二维码生成',
                onPressed: () {
                  // 显示二维码
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 轮播图
          ZephyrCard(
            title: '轮播图',
            content: const SizedBox(
              height: 200,
              child: ZephyrCarousel(
                items: [
                  Container(
                    color: Colors.blue,
                    child: Center(child: Text('幻灯片1')),
                  ),
                  Container(
                    color: Colors.green,
                    child: Center(child: Text('幻灯片2')),
                  ),
                  Container(
                    color: Colors.orange,
                    child: Center(child: Text('幻灯片3')),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 图表
          ZephyrCard(
            title: '图表组件',
            content: const SizedBox(
              height: 300,
              child: ZephyrChart(
                type: ZephyrChartType.line,
                data: [
                  ZephyrChartData(x: '1月', y: 100),
                  ZephyrChartData(x: '2月', y: 150),
                  ZephyrChartData(x: '3月', y: 120),
                  ZephyrChartData(x: '4月', y: 180),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
