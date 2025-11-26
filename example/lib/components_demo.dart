/// ZephyrUI 专业组件示例
///
/// 展示新增的专业UI组件的使用方法和效果

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const ZephyrUIComponentsDemo());
}

class ZephyrUIComponentsDemo extends StatelessWidget {
  const ZephyrUIComponentsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZephyrUI 专业组件示例',
      theme: ZephyrThemeConfig.lightTheme,
      darkTheme: ZephyrThemeConfig.darkTheme,
      themeMode: ThemeMode.system,
      home: const ComponentsDemoHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ComponentsDemoHome extends StatefulWidget {
  const ComponentsDemoHome({Key? key}) : super(key: key);

  @override
  State<ComponentsDemoHome> createState() => _ComponentsDemoHomeState();
}

class _ComponentsDemoHomeState extends State<ComponentsDemoHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TimelineDemo(),
    const RatingDemo(),
    const StepperDemo(),
    const CarouselDemo(),
  ];

  final List<String> _titles = [
    '时间线组件',
    '评分组件',
    '步骤指示器',
    '轮播图组件',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 专业组件示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: '时间线',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '评分',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stairs),
            label: '步骤',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.carousel_horizontal),
            label: '轮播',
          ),
        ],
      ),
    );
  }
}

/// 时间线组件示例
class TimelineDemo extends StatelessWidget {
  const TimelineDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('时间线组件示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrText.heading(
              text: '时间线组件',
              color: Colors.blue.shade800,
            ),
            const SizedBox(height: 8),
            ZephyrText.body(
              text: '专业的时间线展示组件，支持多种样式和交互',
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 24),

            // 基础时间线
            ZephyrText.subtitle(
              text: '基础时间线',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrTimeline(
              items: [
                ZephyrTimelineItem(
                  id: '1',
                  title: '项目启动',
                  subtitle: '项目正式启动',
                  time: DateTime.now().subtract(const Duration(days: 30)),
                  isCompleted: true,
                  icon: const Icon(Icons.flag, color: Colors.white),
                ),
                ZephyrTimelineItem(
                  id: '2',
                  title: '需求分析',
                  subtitle: '完成需求分析和规划',
                  time: DateTime.now().subtract(const Duration(days: 20)),
                  isCompleted: true,
                  icon: const Icon(Icons.analytics, color: Colors.white),
                ),
                ZephyrTimelineItem(
                  id: '3',
                  title: '设计阶段',
                  subtitle: 'UI/UX 设计进行中',
                  time: DateTime.now().subtract(const Duration(days: 10)),
                  isActive: true,
                  icon: const Icon(Icons.design_services, color: Colors.white),
                ),
                ZephyrTimelineItem(
                  id: '4',
                  title: '开发阶段',
                  subtitle: '开始开发工作',
                  time: DateTime.now().add(const Duration(days: 5)),
                  icon: const Icon(Icons.code, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 详细时间线
            ZephyrText.subtitle(
              text: '详细时间线',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrTimeline(
              style: ZephyrTimelineStyle.detailed,
              items: [
                ZephyrTimelineItem(
                  id: '1',
                  title: '项目启动会议',
                  subtitle: '团队组建和项目规划',
                  description: '确定了项目目标、时间线和资源分配',
                  time: DateTime.now().subtract(const Duration(days: 30)),
                  isCompleted: true,
                  icon: const Icon(Icons.flag, color: Colors.white),
                ),
                ZephyrTimelineItem(
                  id: '2',
                  title: '需求调研',
                  subtitle: '用户需求收集和分析',
                  description: '收集了50+用户反馈，确定了核心功能',
                  time: DateTime.now().subtract(const Duration(days: 25)),
                  isCompleted: true,
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
                ZephyrTimelineItem(
                  id: '3',
                  title: '原型设计',
                  subtitle: '交互原型和视觉设计',
                  description: '完成了高保真原型和设计规范',
                  time: DateTime.now().subtract(const Duration(days: 15)),
                  isCompleted: true,
                  icon: const Icon(Icons.brush, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 卡片时间线
            ZephyrText.subtitle(
              text: '卡片时间线',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrTimeline(
              style: ZephyrTimelineStyle.card,
              items: [
                ZephyrTimelineItem(
                  id: '1',
                  title: '第一阶段完成',
                  subtitle: '基础功能开发完成',
                  description: '用户注册、登录、个人资料等基础功能已开发完成',
                  time: DateTime.now().subtract(const Duration(days: 5)),
                  isCompleted: true,
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                ),
                ZephyrTimelineItem(
                  id: '2',
                  title: '第二阶段进行中',
                  subtitle: '高级功能开发',
                  description: '正在开发推荐算法、社交功能等高级特性',
                  time: DateTime.now(),
                  isActive: true,
                  icon: const Icon(Icons.settings, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 评分组件示例
class RatingDemo extends StatelessWidget {
  const RatingDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('评分组件示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrText.heading(
              text: '评分组件',
              color: Colors.blue.shade800,
            ),
            const SizedBox(height: 8),
            ZephyrText.body(
              text: '专业的评分展示和交互组件，支持多种样式',
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 24),

            // 基础评分
            ZephyrText.subtitle(
              text: '基础评分',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const ZephyrText.body(text: '当前评分: '),
                const ZephyrRating(
                  value: 4.5,
                  max: 5,
                  showValue: true,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 只读评分
            ZephyrText.subtitle(
              text: '只读评分',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Column(
                  children: [
                    ZephyrRatingDisplay(
                      value: 5.0,
                      iconType: ZephyrRatingIconType.star,
                      size: ZephyrRatingSize.small,
                    ),
                    const SizedBox(height: 4),
                    const ZephyrText.caption(text: '5星 - 小尺寸'),
                  ],
                ),
                Column(
                  children: [
                    ZephyrRatingDisplay(
                      value: 4.0,
                      iconType: ZephyrRatingIconType.star,
                      size: ZephyrRatingSize.medium,
                    ),
                    const SizedBox(height: 4),
                    const ZephyrText.caption(text: '4星 - 中尺寸'),
                  ],
                ),
                Column(
                  children: [
                    ZephyrRatingDisplay(
                      value: 3.5,
                      iconType: ZephyrRatingIconType.star,
                      size: ZephyrRatingSize.large,
                    ),
                    const SizedBox(height: 4),
                    const ZephyrText.caption(text: '3.5星 - 大尺寸'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 不同图标类型
            ZephyrText.subtitle(
              text: '不同图标类型',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Column(
                  children: [
                    ZephyrRatingDisplay(
                      value: 4.0,
                      iconType: ZephyrRatingIconType.star,
                      size: ZephyrRatingSize.medium,
                    ),
                    const SizedBox(height: 4),
                    const ZephyrText.caption(text: '星星'),
                  ],
                ),
                Column(
                  children: [
                    ZephyrRatingDisplay(
                      value: 4.0,
                      iconType: ZephyrRatingIconType.heart,
                      size: ZephyrRatingSize.medium,
                      activeColor: Colors.red,
                    ),
                    const SizedBox(height: 4),
                    const ZephyrText.caption(text: '爱心'),
                  ],
                ),
                Column(
                  children: [
                    ZephyrRatingDisplay(
                      value: 4.0,
                      iconType: ZephyrRatingIconType.thumb,
                      size: ZephyrRatingSize.medium,
                      activeColor: Colors.green,
                    ),
                    const SizedBox(height: 4),
                    const ZephyrText.caption(text: '点赞'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 交互式评分
            ZephyrText.subtitle(
              text: '交互式评分',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setState) {
                double rating = 3.0;
                return Column(
                  children: [
                    ZephyrRating(
                      value: rating,
                      allowHalfRating: true,
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    ZephyrText.body(text: '当前评分: ${rating.toStringAsFixed(1)}'),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // 半星评分
            ZephyrText.subtitle(
              text: '半星评分',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ZephyrRatingDisplay(
                  value: 3.5,
                  allowHalfRating: true,
                  size: ZephyrRatingSize.medium,
                ),
                ZephyrRatingDisplay(
                  value: 4.5,
                  allowHalfRating: true,
                  size: ZephyrRatingSize.medium,
                ),
                ZephyrRatingDisplay(
                  value: 2.5,
                  allowHalfRating: true,
                  size: ZephyrRatingSize.medium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 步骤指示器示例
class StepperDemo extends StatelessWidget {
  const StepperDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('步骤指示器示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrText.heading(
              text: '步骤指示器',
              color: Colors.blue.shade800,
            ),
            const SizedBox(height: 8),
            ZephyrText.body(
              text: '专业的步骤流程展示组件，支持多种布局方式',
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 24),

            // 水平步骤指示器
            ZephyrText.subtitle(
              text: '水平步骤指示器',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            const ZephyrStepper(
              type: ZephyrStepperType.horizontal,
              currentStep: 1,
              steps: [
                ZephyrStep(
                  id: '1',
                  title: '第一步',
                  subtitle: '基础信息',
                  isCompleted: true,
                ),
                ZephyrStep(
                  id: '2',
                  title: '第二步',
                  subtitle: '详细信息',
                  isActive: true,
                ),
                ZephyrStep(
                  id: '3',
                  title: '第三步',
                  subtitle: '确认信息',
                ),
                ZephyrStep(
                  id: '4',
                  title: '第四步',
                  subtitle: '完成',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 垂直步骤指示器
            ZephyrText.subtitle(
              text: '垂直步骤指示器',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            const ZephyrStepper(
              type: ZephyrStepperType.vertical,
              currentStep: 2,
              steps: [
                ZephyrStep(
                  id: '1',
                  title: '用户注册',
                  subtitle: '填写基本信息',
                  isCompleted: true,
                  icon: Icon(Icons.person, color: Colors.white),
                ),
                ZephyrStep(
                  id: '2',
                  title: '邮箱验证',
                  subtitle: '验证邮箱地址',
                  isCompleted: true,
                  icon: Icon(Icons.email, color: Colors.white),
                ),
                ZephyrStep(
                  id: '3',
                  title: '设置密码',
                  subtitle: '设置登录密码',
                  isActive: true,
                  icon: Icon(Icons.lock, color: Colors.white),
                ),
                ZephyrStep(
                  id: '4',
                  title: '完成注册',
                  subtitle: '注册成功',
                  icon: Icon(Icons.check, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 向导式步骤指示器
            ZephyrText.subtitle(
              text: '向导式步骤指示器',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            const ZephyrStepper(
              type: ZephyrStepperType.wizard,
              currentStep: 1,
              steps: [
                ZephyrStep(
                  id: '1',
                  title: '个人信息',
                  subtitle: 'Personal Info',
                  isCompleted: true,
                ),
                ZephyrStep(
                  id: '2',
                  title: '联系方式',
                  subtitle: 'Contact',
                  isActive: true,
                ),
                ZephyrStep(
                  id: '3',
                  title: '偏好设置',
                  subtitle: 'Preferences',
                ),
                ZephyrStep(
                  id: '4',
                  title: '完成',
                  subtitle: 'Complete',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 带内容的步骤指示器
            ZephyrText.subtitle(
              text: '带内容的步骤指示器',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setState) {
                int currentStep = 1;
                return Column(
                  children: [
                    ZephyrStepper(
                      type: ZephyrStepperType.vertical,
                      currentStep: currentStep,
                      onStepTapped: (index) {
                        setState(() {
                          currentStep = index;
                        });
                      },
                      steps: [
                        ZephyrStep(
                          id: '1',
                          title: '基本信息',
                          subtitle: '填写个人基本信息',
                          content: const Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.blue.shade50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ZephyrText.body(text: '姓名: 张三'),
                                ZephyrText.body(text: '年龄: 25'),
                                ZephyrText.body(text: '性别: 男'),
                              ],
                            ),
                          ),
                          isCompleted: true,
                        ),
                        ZephyrStep(
                          id: '2',
                          title: '联系方式',
                          subtitle: '填写联系方式',
                          content: const Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.green.shade50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ZephyrText.body(
                                    text: '邮箱: zhangsan@example.com'),
                                ZephyrText.body(text: '电话: 138****5678'),
                              ],
                            ),
                          ),
                          isActive: true,
                        ),
                        ZephyrStep(
                          id: '3',
                          title: '完成注册',
                          subtitle: '注册成功',
                          content: const Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.orange.shade50,
                            child: ZephyrText.body(
                              text: '恭喜您，注册成功！',
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 轮播图组件示例
class CarouselDemo extends StatelessWidget {
  const CarouselDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('轮播图组件示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZephyrText.heading(
              text: '轮播图组件',
              color: Colors.blue.shade800,
            ),
            const SizedBox(height: 8),
            ZephyrText.body(
              text: '专业的轮播图展示组件，支持多种动画效果',
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 24),

            // 基础轮播图
            ZephyrText.subtitle(
              text: '基础轮播图',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrCarousel(
              height: 200,
              items: [
                ZephyrCarouselItem(
                  id: '1',
                  child: const Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://picsum.photos/400/200?random=1'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: '美丽的风景',
                  subtitle: '大自然的美丽景色',
                ),
                ZephyrCarouselItem(
                  id: '2',
                  child: const Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://picsum.photos/400/200?random=2'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: '城市夜景',
                  subtitle: '繁华的都市夜晚',
                ),
                ZephyrCarouselItem(
                  id: '3',
                  child: const Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://picsum.photos/400/200?random=3'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: '海洋世界',
                  subtitle: '神秘的海洋生物',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 带动画效果的轮播图
            ZephyrText.subtitle(
              text: '淡入淡出效果',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrCarousel(
              height: 200,
              animationType: ZephyrCarouselAnimationType.fade,
              items: [
                ZephyrCarouselItem(
                  id: '1',
                  child: const Container(
                    color: Colors.blue,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '第一页',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '2',
                  child: const Container(
                    color: Colors.green,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '第二页',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '3',
                  child: const Container(
                    color: Colors.orange,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '第三页',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 缩放效果轮播图
            ZephyrText.subtitle(
              text: '缩放效果',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrCarousel(
              height: 200,
              animationType: ZephyrCarouselAnimationType.scale,
              items: [
                ZephyrCarouselItem(
                  id: '1',
                  child: const Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink],
                      ),
                    ),
                    child: Center(
                      child: ZephyrText.heading(
                        text: '渐变背景',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '2',
                  child: const Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.cyan],
                      ),
                    ),
                    child: Center(
                      child: ZephyrText.heading(
                        text: '科技感',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 深度效果轮播图
            ZephyrText.subtitle(
              text: '深度效果',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrCarousel(
              height: 200,
              animationType: ZephyrCarouselAnimationType.depth,
              items: [
                ZephyrCarouselItem(
                  id: '1',
                  child: const Container(
                    color: Colors.red.shade400,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '红色主题',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '2',
                  child: const Container(
                    color: Colors.yellow.shade400,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '黄色主题',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '3',
                  child: const Container(
                    color: Colors.green.shade400,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '绿色主题',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 不同指示器类型
            ZephyrText.subtitle(
              text: '数字指示器',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrCarousel(
              height: 200,
              indicatorType: ZephyrCarouselIndicatorType.numbers,
              items: [
                ZephyrCarouselItem(
                  id: '1',
                  child: const Container(
                    color: Colors.indigo,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '第一页',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '2',
                  child: const Container(
                    color: Colors.teal,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '第二页',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 分数指示器
            ZephyrText.subtitle(
              text: '分数指示器',
              color: Colors.grey.shade800,
            ),
            const SizedBox(height: 16),
            ZephyrCarousel(
              height: 200,
              indicatorType: ZephyrCarouselIndicatorType.fraction,
              items: [
                ZephyrCarouselItem(
                  id: '1',
                  child: const Container(
                    color: Colors.brown,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '图片 1',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '2',
                  child: const Container(
                    color: Colors.pink,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '图片 2',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ZephyrCarouselItem(
                  id: '3',
                  child: const Container(
                    color: Colors.purple,
                    child: Center(
                      child: ZephyrText.heading(
                        text: '图片 3',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
