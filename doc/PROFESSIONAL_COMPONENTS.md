# ZephyrUI 专业组件文档

## 📋 概述

ZephyrUI 提供了一系列专业的UI组件，这些组件经过精心设计，具备企业级应用所需的各种功能特性。

## 🎯 新增组件

### 1. 时间线组件 (ZephyrTimeline)

#### 功能特性
- **多种样式**: 支持基础、详细、紧凑、卡片四种样式
- **双向布局**: 支持垂直和水平两种布局方式
- **交互支持**: 支持点击事件和自定义操作
- **时间显示**: 智能时间格式化显示
- **主题定制**: 完整的主题系统支持

#### 使用示例

```dart
// 基础时间线
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
      isActive: true,
      icon: const Icon(Icons.analytics, color: Colors.white),
    ),
  ],
)

// 详细时间线
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
    ),
  ],
)
```

#### 属性说明

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | List<ZephyrTimelineItem> | required | 时间线项目列表 |
| direction | ZephyrTimelineDirection | vertical | 时间线方向 |
| style | ZephyrTimelineStyle | basic | 时间线样式 |
| spacing | double | 16.0 | 项目间距 |
| showTime | bool | true | 是否显示时间 |
| theme | ZephyrTimelineTheme? | null | 自定义主题 |

#### 适用场景
- 项目进度展示
- 历史记录展示
- 个人成长轨迹
- 事件时间轴
- 新闻时间线

### 2. 评分组件 (ZephyrRating)

#### 功能特性
- **多种图标**: 支持星星、爱心、点赞、圆形等图标
- **尺寸选择**: 四种预设尺寸（小、中、大、超大）
- **半星支持**: 支持半星评分
- **交互式**: 支持用户交互评分
- **只读模式**: 纯展示模式
- **主题定制**: 完整的颜色和样式定制

#### 使用示例

```dart
// 基础评分
ZephyrRating(
  value: 4.5,
  max: 5,
  showValue: true,
)

// 只读评分
ZephyrRatingDisplay(
  value: 4.0,
  iconType: ZephyrRatingIconType.star,
  size: ZephyrRatingSize.medium,
)

// 交互式评分
StatefulBuilder(
  builder: (context, setState) {
    double rating = 3.0;
    return ZephyrRating(
      value: rating,
      allowHalfRating: true,
      onChanged: (value) {
        setState(() {
          rating = value;
        });
      },
    );
  },
)
```

#### 属性说明

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| value | double | required | 当前评分值 |
| max | int | 5 | 最大评分值 |
| iconType | ZephyrRatingIconType | star | 图标类型 |
| size | ZephyrRatingSize | medium | 尺寸大小 |
| allowHalfRating | bool | false | 是否支持半星 |
| readonly | bool | false | 是否只读 |
| showValue | bool | false | 是否显示数值 |
| onChanged | ValueChanged<double>? | null | 评分变化回调 |

#### 适用场景
- 商品评分
- 内容评价
- 用户反馈
- 质量评估
- 满意度调查

### 3. 步骤指示器 (ZephyrStepper)

#### 功能特性
- **多种布局**: 水平、垂直、向导式三种布局
- **状态管理**: 完整的步骤状态管理
- **交互支持**: 支持步骤跳转和导航
- **内容展示**: 支持每个步骤的内容展示
- **控制按钮**: 内置导航按钮
- **主题定制**: 完整的主题系统

#### 使用示例

```dart
// 水平步骤指示器
ZephyrStepper(
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
  ],
)

// 垂直步骤指示器
ZephyrStepper(
  type: ZephyrStepperType.vertical,
  currentStep: 2,
  steps: [
    ZephyrStep(
      id: '1',
      title: '用户注册',
      subtitle: '填写基本信息',
      isCompleted: true,
      icon: const Icon(Icons.person, color: Colors.white),
    ),
    ZephyrStep(
      id: '2',
      title: '邮箱验证',
      subtitle: '验证邮箱地址',
      isCompleted: true,
      icon: const Icon(Icons.email, color: Colors.white),
    ),
  ],
)
```

#### 属性说明

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| steps | List<ZephyrStep> | required | 步骤列表 |
| type | ZephyrStepperType | horizontal | 步骤指示器类型 |
| currentStep | int | 0 | 当前步骤索引 |
| onStepTapped | ValueChanged<int>? | null | 步骤点击回调 |
| onStepContinue | VoidCallback? | null | 继续按钮回调 |
| onStepCancel | VoidCallback? | null | 取消按钮回调 |
| showControls | bool | true | 是否显示控制按钮 |

#### 适用场景
- 表单分步填写
- 引导流程
- 订单流程
- 用户注册流程
- 安装向导
- 配置向导

### 4. 轮播图组件 (ZephyrCarousel)

#### 功能特性
- **多种动画**: 滑动、淡入淡出、缩放、深度四种动画效果
- **自动播放**: 支持自动播放和暂停
- **无限滚动**: 支持无限循环滚动
- **控制按钮**: 内置前后导航按钮
- **指示器**: 多种指示器样式（点、数字、分数）
- **交互支持**: 鼠标悬停暂停、点击跳转

#### 使用示例

```dart
// 基础轮播图
ZephyrCarousel(
  height: 200,
  items: [
    ZephyrCarouselItem(
      id: '1',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/400/200?random=1'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: '美丽的风景',
      subtitle: '大自然的美丽景色',
    ),
    ZephyrCarouselItem(
      id: '2',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/400/200?random=2'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: '城市夜景',
      subtitle: '繁华的都市夜晚',
    ),
  ],
)

// 淡入淡出效果
ZephyrCarousel(
  height: 200,
  animationType: ZephyrCarouselAnimationType.fade,
  items: [
    ZephyrCarouselItem(
      id: '1',
      child: Container(
        color: Colors.blue,
        child: const Center(
          child: ZephyrText.heading(
            text: '第一页',
            color: Colors.white,
          ),
        ),
      ),
    ),
  ],
)
```

#### 属性说明

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | List<ZephyrCarouselItem> | required | 轮播图项目列表 |
| height | double | 200.0 | 轮播图高度 |
| autoPlay | bool | true | 是否自动播放 |
| autoPlayInterval | Duration | 3秒 | 自动播放间隔 |
| animationType | ZephyrCarouselAnimationType | slide | 动画类型 |
| indicatorType | ZephyrCarouselIndicatorType | dots | 指示器类型 |
| showControls | bool | true | 是否显示控制按钮 |
| viewportFraction | double | 1.0 | 视口比例 |

#### 适用场景
- 产品展示
- 广告轮播
- 图片画廊
- 特色内容展示
- 引导页面
- 新闻头条

## 🎨 主题定制

所有新增组件都支持完整的主题定制，可以通过 `ThemeExtension` 进行样式自定义：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTimelineTheme(
        lineColor: Colors.blue,
        completedColor: Colors.green,
        activeColor: Colors.orange,
        // ... 其他主题属性
      ),
      ZephyrRatingTheme(
        activeColor: Colors.amber,
        inactiveColor: Colors.grey,
        // ... 其他主题属性
      ),
      ZephyrStepperTheme(
        activeColor: Colors.blue,
        completedColor: Colors.green,
        // ... 其他主题属性
      ),
      ZephyrCarouselTheme(
        activeIndicatorColor: Colors.blue,
        inactiveIndicatorColor: Colors.grey,
        // ... 其他主题属性
      ),
    ],
  ),
)
```

## 🔧 最佳实践

### 性能优化
1. **使用 const 构造函数**: 对于静态内容使用 const 构造函数
2. **避免过度重建**: 合理使用 StatefulWidget 和 StatelessWidget
3. **图片优化**: 使用适当的图片格式和尺寸
4. **内存管理**: 及时清理不需要的资源

### 无障碍支持
1. **语义化标签**: 为所有交互元素添加语义化标签
2. **键盘导航**: 确保所有功能都可以通过键盘操作
3. **屏幕阅读器**: 提供完整的屏幕阅读器支持
4. **颜色对比**: 确保文本和背景有足够的对比度

### 国际化支持
1. **文本本地化**: 所有显示文本都支持本地化
2. **布局适配**: 支持 RTL (从右到左) 布局
3. **日期格式**: 根据地区设置显示日期格式
4. **数字格式**: 根据地区设置显示数字格式

## 📚 相关资源

- [示例代码](../example/lib/components_demo.dart)
- [主题系统](../lib/src/core/theme/)
- [性能优化](../lib/src/core/performance/)
- [测试用例](../test/components/)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这些组件。

## 📄 许可证

MIT License