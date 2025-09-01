# ZephyrTimeline 时间线组件

时间线组件是ZephyrUI展示系统中的重要组件，提供了清晰的时间序列展示功能。支持多种时间线模式、自定义样式和交互方式，是构建历史记录、项目进度、活动日志等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种时间线模式**: 支持垂直、水平、交替等多种模式
- **灵活布局**: 支持自定义节点样式、连接线样式等
- **丰富交互**: 支持点击、悬停、展开等交互
- **自定义样式**: 支持自定义节点、连接线、标签等样式
- **响应式设计**: 根据屏幕尺寸自动调整布局
- **主题适配**: 完整的主题系统支持

### 适用场景
- 项目进度展示
- 历史记录查看
- 活动日志展示
- 产品发布记录
- 个人经历展示
- 公司发展历程

## 🚀 基础用法

### 基本时间线

```dart
class BasicTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          items: [
            ZephyrTimelineItem(
              title: '项目启动',
              subtitle: '2024年1月',
              description: '项目正式启动，团队组建完成',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '需求分析',
              subtitle: '2024年2月',
              description: '完成用户需求调研和分析',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.assignment, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '设计阶段',
              subtitle: '2024年3月',
              description: 'UI/UX设计和架构设计',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.design_services, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '开发阶段',
              subtitle: '2024年4月-6月',
              description: '前端和后端开发',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.code, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '测试上线',
              subtitle: '2024年7月',
              description: '系统测试和正式上线',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.launch, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 水平时间线

```dart
class HorizontalTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('水平时间线'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.horizontal,
          items: [
            ZephyrTimelineItem(
              title: '2020',
              subtitle: '成立',
              description: '公司成立',
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('20', style: TextStyle(color: Colors.white)),
              ),
            ),
            ZephyrTimelineItem(
              title: '2021',
              subtitle: '发展',
              description: '快速发展期',
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text('21', style: TextStyle(color: Colors.white)),
              ),
            ),
            ZephyrTimelineItem(
              title: '2022',
              subtitle: '扩张',
              description: '业务扩张',
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text('22', style: TextStyle(color: Colors.white)),
              ),
            ),
            ZephyrTimelineItem(
              title: '2023',
              subtitle: '成熟',
              description: '业务成熟期',
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text('23', style: TextStyle(color: Colors.white)),
              ),
            ),
            ZephyrTimelineItem(
              title: '2024',
              subtitle: '创新',
              description: '技术创新期',
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text('24', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 交替时间线

```dart
class AlternatingTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交替时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          alignment: TimelineAlignment.alternate,
          items: [
            ZephyrTimelineItem(
              title: '产品构思',
              subtitle: '2024年1月',
              description: '初步的产品构思和市场调研',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.lightbulb, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '团队组建',
              subtitle: '2024年2月',
              description: '招募核心团队成员',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.group, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '原型设计',
              subtitle: '2024年3月',
              description: '产品原型设计和用户测试',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.prototyping, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '开发启动',
              subtitle: '2024年4月',
              description: '正式进入开发阶段',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.start, color: Colors.white),
              ),
            ),
            ZephyrTimelineItem(
              title: '产品发布',
              subtitle: '2024年7月',
              description: '产品正式发布上线',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.celebration, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义节点样式

```dart
class CustomNodeTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义节点样式'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          style: ZephyrTimelineStyle(
            nodeStyle: ZephyrTimelineNodeStyle(
              size: 24,
              shape: BoxShape.circle,
              backgroundColor: Colors.blue,
              borderWidth: 3,
              borderColor: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            lineStyle: ZephyrTimelineLineStyle(
              color: Colors.blue[300]!,
              thickness: 3,
              style: LineStyle.solid,
            ),
            itemStyle: ZephyrTimelineItemStyle(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              spacing: 16,
            ),
          ),
          items: [
            ZephyrTimelineItem(
              title: '里程碑 1',
              subtitle: '已完成',
              description: '第一个重要里程碑已经完成',
              leading: Icon(Icons.check_circle, color: Colors.white),
            ),
            ZephyrTimelineItem(
              title: '里程碑 2',
              subtitle: '进行中',
              description: '第二个里程碑正在进行中',
              leading: Icon(Icons.hourglass_half, color: Colors.white),
            ),
            ZephyrTimelineItem(
              title: '里程碑 3',
              subtitle: '待开始',
              description: '第三个里程碑等待开始',
              leading: Icon(Icons.pending, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 彩色时间线

```dart
class ColorfulTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('彩色时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          items: [
            ZephyrTimelineItem(
              title: '需求分析',
              subtitle: '第1阶段',
              description: '完成用户需求调研和分析工作',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.analytics, color: Colors.white),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '100%',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: 'UI设计',
              subtitle: '第2阶段',
              description: '完成界面设计和交互设计',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.palette, color: Colors.white),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '85%',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: '前端开发',
              subtitle: '第3阶段',
              description: '前端界面开发实现',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.code, color: Colors.white),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '60%',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: '后端开发',
              subtitle: '第4阶段',
              description: '后端API和数据库开发',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.storage, color: Colors.white),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '40%',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: '测试部署',
              subtitle: '第5阶段',
              description: '系统测试和部署上线',
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.upload, color: Colors.white),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '20%',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 卡片式时间线

```dart
class CardTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片式时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          style: ZephyrTimelineStyle(
            itemStyle: ZephyrTimelineItemStyle(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              spacing: 24,
            ),
            lineStyle: ZephyrTimelineLineStyle(
              color: Colors.grey[300]!,
              thickness: 2,
              style: LineStyle.solid,
            ),
          ),
          items: [
            ZephyrTimelineItem(
              title: '项目启动',
              subtitle: '2024年1月15日',
              description: '项目正式启动会议',
              leading: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.flag, color: Colors.white, size: 24),
              ),
              content: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '项目启动会议',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '讨论项目目标和时间安排',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.people, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '参与人员: 8人',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: '需求确认',
              subtitle: '2024年2月20日',
              description: '客户需求确认会议',
              leading: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: Colors.white, size: 24),
              ),
              content: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '需求确认完成',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '所有功能需求已确认',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.description, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '需求文档: v1.0',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
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
}
```

## 🔧 高级用法

### 可交互时间线

```dart
class InteractiveTimelineExample extends StatefulWidget {
  @override
  _InteractiveTimelineExampleState createState() => _InteractiveTimelineExampleState();
}

class _InteractiveTimelineExampleState extends State<InteractiveTimelineExample> {
  int? _expandedIndex;
  List<Map<String, dynamic>> _timelineData = [
    {
      'title': '项目启动',
      'subtitle': '2024年1月',
      'description': '项目正式启动',
      'details': '项目正式启动会议，讨论项目目标和时间安排。参与人员包括项目经理、技术负责人、产品经理等。',
      'icon': Icons.play_arrow,
      'color': Colors.blue,
    },
    {
      'title': '需求分析',
      'subtitle': '2024年2月',
      'description': '完成需求分析',
      'details': '完成用户需求调研和分析，编写需求规格说明书。与客户进行了多次沟通和确认。',
      'icon': Icons.assignment,
      'color': Colors.green,
    },
    {
      'title': '设计阶段',
      'subtitle': '2024年3月',
      'description': 'UI/UX设计',
      'details': '完成产品UI/UX设计，包括界面设计、交互设计、视觉设计等。制作了高保真原型。',
      'icon': Icons.design_services,
      'color': Colors.orange,
    },
  ];

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null;
      } else {
        _expandedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可交互时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          items: _timelineData.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isExpanded = _expandedIndex == index;
            
            return ZephyrTimelineItem(
              title: item['title'],
              subtitle: item['subtitle'],
              description: item['description'],
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item['color'],
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'], color: Colors.white),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['description'],
                    style: TextStyle(fontSize: 14),
                  ),
                  if (isExpanded) ...[
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['details'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              onTap: () => _toggleExpand(index),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
```

### 带图片的时间线

```dart
class ImageTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带图片的时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          items: [
            ZephyrTimelineItem(
              title: '公司成立',
              subtitle: '2020年1月',
              description: '公司正式成立',
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/company_founding.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '公司成立',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '创始团队5人，注册资金100万',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            ZephyrTimelineItem(
              title: '首轮融资',
              subtitle: '2021年6月',
              description: '完成A轮融资',
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/funding.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A轮融资1000万',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '估值达到1亿',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            ZephyrTimelineItem(
              title: '产品发布',
              subtitle: '2022年3月',
              description: '首款产品上线',
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/product_launch.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '产品正式上线',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '首月用户突破10万',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
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
```

### 带进度的时间线

```dart
class ProgressTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带进度的时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          items: [
            ZephyrTimelineItem(
              title: '需求分析',
              subtitle: '100% 完成',
              description: '已完成所有需求分析工作',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white),
              ),
              trailing: Container(
                width: 60,
                child: LinearProgressIndicator(
                  value: 1.0,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: 'UI设计',
              subtitle: '85% 完成',
              description: '大部分UI设计已完成',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.hourglass_half, color: Colors.white),
              ),
              trailing: Container(
                width: 60,
                child: LinearProgressIndicator(
                  value: 0.85,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: '前端开发',
              subtitle: '60% 完成',
              description: '前端开发进行中',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.code, color: Colors.white),
              ),
              trailing: Container(
                width: 60,
                child: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: '后端开发',
              subtitle: '40% 完成',
              description: '后端开发刚开始',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.storage, color: Colors.white),
              ),
              trailing: Container(
                width: 60,
                child: LinearProgressIndicator(
                  value: 0.4,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
              ),
            ),
            ZephyrTimelineItem(
              title: '测试部署',
              subtitle: '0% 完成',
              description: '等待开发完成',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.pending, color: Colors.white),
              ),
              trailing: Container(
                width: 60,
                child: LinearProgressIndicator(
                  value: 0.0,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 带标签的时间线

```dart
class TagTimelineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带标签的时间线'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTimeline(
          direction: Axis.vertical,
          items: [
            ZephyrTimelineItem(
              title: '产品发布',
              subtitle: '2024年1月15日',
              description: '新产品正式发布',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.launch, color: Colors.white),
              ),
              tags: [
                Tag(text: '重要', color: Colors.red),
                Tag(text: '产品', color: Colors.blue),
              ],
            ),
            ZephyrTimelineItem(
              title: '用户反馈',
              subtitle: '2024年1月20日',
              description: '收集用户使用反馈',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.feedback, color: Colors.white),
              ),
              tags: [
                Tag(text: '反馈', color: Colors.green),
                Tag(text: '优化', color: Colors.orange),
              ],
            ),
            ZephyrTimelineItem(
              title: '版本更新',
              subtitle: '2024年2月1日',
              description: '发布v1.1版本',
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.system_update, color: Colors.white),
              ),
              tags: [
                Tag(text: '更新', color: Colors.purple),
                Tag(text: 'v1.1', color: Colors.teal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String text;
  final Color color;
  
  const Tag({
    required this.text,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrTimeline()

```dart
const ZephyrTimeline({
  Key? key,
  required List<ZephyrTimelineItem> items,
  Axis direction = Axis.vertical,
  TimelineAlignment alignment = TimelineAlignment.start,
  ZephyrTimelineStyle? style,
  EdgeInsetsGeometry? padding,
  bool shrinkWrap = false,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `items`: 时间线项目
- `direction`: 时间线方向
- `alignment`: 对齐方式
- `style`: 时间线样式
- `padding`: 内边距
- `shrinkWrap`: 是否收缩包裹
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrTimelineItem()

```dart
const ZephyrTimelineItem({
  Key? key,
  required String title,
  String? subtitle,
  String? description,
  Widget? leading,
  Widget? trailing,
  Widget? content,
  List<Widget>? tags,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  bool enabled = true,
  String? tooltip,
  String? semanticLabel,
})
```

### 枚举类型

#### TimelineAlignment

```dart
enum TimelineAlignment {
  start,      // 开始对齐
  center,     // 居中对齐
  end,        // 结束对齐
  alternate,  // 交替对齐
}
```

### 样式类

#### ZephyrTimelineStyle

```dart
class ZephyrTimelineStyle {
  final ZephyrTimelineNodeStyle? nodeStyle;
  final ZephyrTimelineLineStyle? lineStyle;
  final ZephyrTimelineItemStyle? itemStyle;
  final EdgeInsetsGeometry? padding;
  final double? spacing;
}
```

#### ZephyrTimelineNodeStyle

```dart
class ZephyrTimelineNodeStyle {
  final double? size;
  final BoxShape? shape;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
}
```

#### ZephyrTimelineLineStyle

```dart
class ZephyrTimelineLineStyle {
  final Color? color;
  final double? thickness;
  final LineStyle? style;
  final double? spacing;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrTimelineTheme(
        defaultNodeStyle: ZephyrTimelineNodeStyle(
          size: 16,
          shape: BoxShape.circle,
          backgroundColor: Colors.blue,
          borderColor: Colors.white,
          borderWidth: 2,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        defaultLineStyle: ZephyrTimelineLineStyle(
          color: Colors.grey[300],
          thickness: 2,
          style: LineStyle.solid,
          spacing: 16,
        ),
        defaultItemStyle: ZephyrTimelineItemStyle(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          spacing: 16,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          subtitleStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          descriptionStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
        defaultPadding: EdgeInsets.all(16),
        compactNodeStyle: ZephyrTimelineNodeStyle(
          size: 12,
          shape: BoxShape.circle,
          backgroundColor: Colors.blue,
        ),
        completedNodeStyle: ZephyrTimelineNodeStyle(
          backgroundColor: Colors.green,
        ),
        inProgressNodeStyle: ZephyrTimelineNodeStyle(
          backgroundColor: Colors.orange,
        ),
        pendingNodeStyle: ZephyrTimelineNodeStyle(
          backgroundColor: Colors.grey,
        ),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        hoverColor: Colors.grey.withOpacity(0.1),
        focusColor: Colors.blue.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultNodeStyle`: 默认节点样式
- `defaultLineStyle`: 默认连接线样式
- `defaultItemStyle`: 默认项目样式
- `defaultPadding`: 默认内边距
- `compactNodeStyle`: 紧凑型节点样式
- `completedNodeStyle`: 已完成节点样式
- `inProgressNodeStyle`: 进行中节点样式
- `pendingNodeStyle`: 待处理节点样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `hoverColor`: 悬停颜色
- `focusColor`: 焦点颜色

## 🏆 最佳实践

### 1. 合理的时间线布局

```dart
// ✅ 好的做法：根据内容选择合适的布局
ZephyrTimeline(
  direction: Axis.vertical, // 垂直布局适合详细内容
  alignment: TimelineAlignment.start,
  items: _buildDetailedItems(),
)

// ✅ 好的做法：水平布局适合简洁内容
ZephyrTimeline(
  direction: Axis.horizontal, // 水平布局适合年份展示
  alignment: TimelineAlignment.center,
  items: _buildYearItems(),
)

// ❌ 避免的做法：复杂内容使用水平布局
ZephyrTimeline(
  direction: Axis.horizontal, // 空间不足，内容会被截断
  items: _buildComplexItems(),
)
```

### 2. 清晰的视觉层次

```dart
// ✅ 好的做法：使用颜色和大小区分重要程度
ZephyrTimeline(
  items: [
    ZephyrTimelineItem(
      title: '重要里程碑',
      leading: Container(
        size: 24, // 更大的节点
        color: Colors.red, // 重要颜色
      ),
    ),
    ZephyrTimelineItem(
      title: '普通事件',
      leading: Container(
        size: 16, // 较小的节点
        color: Colors.blue, // 普通颜色
      ),
    ),
  ],
)

// ✅ 好的做法：使用图标增强可识别性
ZephyrTimeline(
  items: [
    ZephyrTimelineItem(
      title: '项目启动',
      leading: Icon(Icons.flag), // 清晰的图标
    ),
    ZephyrTimelineItem(
      title: '项目完成',
      leading: Icon(Icons.check_circle), // 明确的完成图标
    ),
  ],
)

// ❌ 避免的做法：缺乏视觉层次
ZephyrTimeline(
  items: [
    ZephyrTimelineItem(
      title: '事件1',
      leading: Container(color: Colors.grey), // 所有事件看起来一样
    ),
    ZephyrTimelineItem(
      title: '事件2',
      leading: Container(color: Colors.grey),
    ),
  ],
)
```

### 3. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整
class ResponsiveTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return ZephyrTimeline(
      direction: screenWidth < 600 ? Axis.vertical : Axis.horizontal,
      alignment: screenWidth < 600 
          ? TimelineAlignment.start 
          : TimelineAlignment.center,
      items: _buildItems(),
    );
  }
}

// ✅ 好的做法：使用可滚动的容器
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: ZephyrTimeline(
    direction: Axis.horizontal,
    items: _buildManyItems(),
  ),
)

// ❌ 避免的做法：不考虑响应式
ZephyrTimeline(
  direction: Axis.horizontal, // 在小屏幕上可能溢出
  items: _buildManyItems(),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrTimeline(
  semanticLabel: '项目进度时间线',
  items: [
    ZephyrTimelineItem(
      title: '项目启动',
      semanticLabel: '项目启动阶段',
      onTap: () => _showDetails('项目启动'),
    ),
  ],
  enableAccessibilityFeatures: true,
)

// ✅ 好的做法：为交互提供描述
ZephyrTimelineItem(
  title: '可点击项目',
  onTap: () => _showDetails(),
  tooltip: '点击查看详细信息',
)

// ✅ 好的做法：确保足够的点击区域
ZephyrTimeline(
  itemStyle: ZephyrTimelineItemStyle(
    padding: EdgeInsets.all(16), // 足够的点击区域
  ),
)

// ❌ 避免的做法：缺乏语义信息
ZephyrTimeline(
  items: [
    ZephyrTimelineItem(
      title: '事件',
      onTap: () => _handleTap(),
      // 缺乏语义信息
    ),
  ],
)
```

## 🔄 相关组件

- **ZephyrCalendar**: 日历组件
- **ZephyrList**: 列表组件
- **ZephyrStepper**: 步骤条组件
- **ZephyrProgress**: 进度条组件
- **ZephyrCard**: 卡片组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种时间线模式
- ✅ 支持自定义样式
- ✅ 支持交互功能
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/timeline/`
**示例路径**: `example/lib/components/timeline_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日