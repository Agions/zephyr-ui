import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

// Basic examples
import 'basic/button_example.dart';
import 'basic/chip_example.dart';
import 'basic/icon_example.dart';
import 'basic/image_example.dart';
import 'basic/link_example.dart';
import 'basic/spinner_example.dart';

// Display examples
import 'display/avatar_example.dart';
import 'display/badge_example.dart';
import 'display/card_example.dart';
import 'display/carousel_example.dart';
import 'display/collapse_example.dart';
import 'display/empty_example.dart';
import 'display/list_example.dart';
import 'display/statistic_example.dart';
import 'display/table_example.dart';
import 'display/tag_example.dart';
import 'display/timeline_example.dart';
import 'display/tooltip_example.dart';

// Form examples
import 'form/counter_example.dart';
import 'form/form_field_example.dart';
import 'form/input_example.dart';
import 'form/checkbox_example.dart';
import 'form/radio_example.dart';
import 'form/rate_example.dart';
import 'form/search_example.dart';
import 'form/switch_example.dart';
import 'form/slider_example.dart';
import 'form/select_example.dart';
import 'form/upload_example.dart';

// Navigation examples
import 'navigation/bottom_sheet_example.dart';
import 'navigation/drawer_example.dart';
import 'navigation/menu_example.dart';
import 'navigation/navbar_example.dart';
import 'navigation/pagination_example.dart';
import 'navigation/segmented_example.dart';
import 'navigation/stepper_example.dart';
import 'navigation/tabs_example.dart';

// Feedback examples
import 'feedback/action_sheet_example.dart';
import 'feedback/dialog_example.dart';
import 'feedback/loading_example.dart';
import 'feedback/notification_example.dart';
import 'feedback/popconfirm_example.dart';
import 'feedback/progress_example.dart';
import 'feedback/result_example.dart';
import 'feedback/skeleton_example.dart';
import 'feedback/toast_example.dart';
// Layout examples
import 'layout/aspect_ratio_example.dart';
import 'layout/container_example.dart';
import 'layout/divider_example.dart';
import 'layout/grid_example.dart';
import 'layout/safe_area_example.dart';
import 'layout/scroll_example.dart';
import 'layout/space_example.dart';
import 'layout/stack_example.dart';

void main() {
  runApp(const VelocityShowcaseApp());
}

class VelocityShowcaseApp extends StatelessWidget {
  const VelocityShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VelocityDynamicTheme(
      lightTheme: VelocityThemeData.light(),
      darkTheme: VelocityThemeData.dark(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'VelocityUI Showcase',
            debugShowCheckedModeBanner: false,
            theme: VelocityTheme.of(context).toThemeData(),
            home: const ShowcaseHomePage(),
          );
        },
      ),
    );
  }
}

class ShowcaseHomePage extends StatelessWidget {
  const ShowcaseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VelocityUI 组件库'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => VelocityDynamicTheme.of(context).toggleTheme(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildComponentCategory(
            context,
            '基础组件',
            Icons.widgets,
            VelocityColors.primary,
            [
              _ComponentItem('Button 按钮', const ButtonExample()),
              _ComponentItem('Chip 芯片', const ChipExample()),
              _ComponentItem('Icon 图标', const IconExample()),
              _ComponentItem('Image 图片', const ImageExample()),
              _ComponentItem('Link 链接', const LinkExample()),
              _ComponentItem('Spinner 加载动画', const SpinnerExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '展示组件',
            Icons.image,
            VelocityColors.warning,
            [
              _ComponentItem('Avatar 头像', const AvatarExample()),
              _ComponentItem('Badge 徽章', const BadgeExample()),
              _ComponentItem('Card 卡片', const CardExample()),
              _ComponentItem('Carousel 轮播图', const CarouselExample()),
              _ComponentItem('Collapse 折叠面板', const CollapseExample()),
              _ComponentItem('List 列表', const ListExample()),
              _ComponentItem('Tag 标签', const TagExample()),
              _ComponentItem('Timeline 时间线', const TimelineExample()),
              _ComponentItem('Statistic 统计数值', const StatisticExample()),
              _ComponentItem('Table 表格', const TableExample()),
              _ComponentItem('Tooltip 文字提示', const TooltipExample()),
              _ComponentItem('Empty 空状态', const EmptyExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '布局组件',
            Icons.view_quilt,
            VelocityColors.secondary,
            [
              _ComponentItem('Container 容器', const ContainerExample()),
              _ComponentItem('Grid 网格', const GridExample()),
              _ComponentItem('Divider 分隔线', const DividerExample()),
              _ComponentItem('Stack 层叠', const StackExample()),
              _ComponentItem('Scroll 滚动', const ScrollExample()),
              _ComponentItem('Space 间距', const SpaceExample()),
              _ComponentItem('SafeArea 安全区域', const SafeAreaExample()),
              _ComponentItem('AspectRatio 宽高比', const AspectRatioExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '导航组件',
            Icons.navigation,
            VelocityColors.warning,
            [
              _ComponentItem('Navbar 导航栏', const NavbarExample()),
              _ComponentItem('Tabs 标签页', const TabsExample()),
              _ComponentItem('Drawer 抽屉', const DrawerExample()),
              _ComponentItem('Stepper 步骤条', const StepperExample()),
              _ComponentItem('BottomSheet 底部面板', const BottomSheetExample()),
              _ComponentItem('Menu 菜单', const MenuExample()),
              _ComponentItem('Pagination 分页', const PaginationExample()),
              _ComponentItem('Segmented 分段器', const SegmentedExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '表单组件',
            Icons.edit_note,
            VelocityColors.success,
            [
              _ComponentItem('Input 输入框', const InputExample()),
              _ComponentItem('Search 搜索框', const SearchExample()),
              _ComponentItem('Counter 计数器', const CounterExample()),
              _ComponentItem('Select 选择器', const SelectExample()),
              _ComponentItem('Checkbox 复选框', const CheckboxExample()),
              _ComponentItem('Radio 单选框', const RadioExample()),
              _ComponentItem('Switch 开关', const SwitchExample()),
              _ComponentItem('Slider 滑块', const SliderExample()),
              _ComponentItem('Rate 评分', const RateExample()),
              _ComponentItem('FormField 表单字段', const FormFieldExample()),
              _ComponentItem('Upload 上传', const UploadExample()),
            ],
          ),
          const SizedBox(height: 16),
          _buildComponentCategory(
            context,
            '反馈组件',
            Icons.feedback,
            VelocityColors.secondary,
            [
              _ComponentItem('Notification 通知', const NotificationExample()),
              _ComponentItem('Popconfirm 确认气泡', const PopconfirmExample()),
              _ComponentItem('Dialog 对话框', const DialogExample()),
              _ComponentItem('ActionSheet 动作面板', const ActionSheetExample()),
              _ComponentItem('Toast 轻提示', const ToastExample()),
              _ComponentItem('Loading 加载', const LoadingExample()),
              _ComponentItem('Progress 进度条', const ProgressExample()),
              _ComponentItem('Result 结果页', const ResultExample()),
              _ComponentItem('Skeleton 骨架屏', const SkeletonExample()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [VelocityColors.primary, VelocityColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: VelocityColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.rocket_launch, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VelocityUI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '高性能 Flutter UI 组件库',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('55+ 组件'),
              _buildTag('主题系统'),
              _buildTag('响应式设计'),
              _buildTag('无障碍'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _buildComponentCategory(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    List<_ComponentItem> items,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${items.length} 个',
                    style: TextStyle(color: color, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          ...items.map((item) => _buildComponentTile(context, item)),
        ],
      ),
    );
  }

  Widget _buildComponentTile(BuildContext context, _ComponentItem item) {
    return ListTile(
      title: Text(item.name),
      trailing: const Icon(Icons.chevron_right, color: VelocityColors.gray400),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item.page),
        );
      },
    );
  }
}

class _ComponentItem {
  final String name;
  final Widget page;

  _ComponentItem(this.name, this.page);
}
