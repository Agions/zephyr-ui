---
title: 展示组件
description: ZephyrUI 展示组件，包括列表、表格、日历等数据展示相关组件
---

# 展示组件

展示组件用于数据展示和布局，提供了丰富的数据可视化和布局选项。

## 📦 组件列表

| 组件 | 描述 | 链接 |
|------|------|------|
| [列表](./list) | 支持多种样式的列表组件 | [查看文档](./list) |
| [表格](./table) | 支持排序和筛选的表格组件 | [查看文档](./table) |
| [日历](./calendar) | 支持事件管理的日历组件 | [查看文档](./calendar) |
| [时间线](./timeline) | 用于展示事件序列的时间线组件 | [查看文档](./timeline) |
| [统计卡片](./statistic) | 用于数据统计的统计卡片组件 | [查看文档](./statistic) |
| [头像组](./avatar_group) | 用于展示多个头像的头像组组件 | [查看文档](./avatar_group) |
| [轮播图](./carousel) | 支持自动播放的轮播图组件 | [查看文档](./carousel) |
| [图表](./charts) | 用于数据可视化的图表组件 | [查看文档](./charts) |

## 🎯 使用示例

### 基本数据展示
```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class DisplayDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('展示组件示例'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 统计卡片
            Text('统计数据', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              children: [
                ZephyrStatistic(
                  title: '总用户数',
                  value: '1,234',
                  prefix: Icon(Icons.people),
                  color: Colors.blue,
                ),
                ZephyrStatistic(
                  title: '活跃用户',
                  value: '856',
                  prefix: Icon(Icons.trending_up),
                  color: Colors.green,
                ),
                ZephyrStatistic(
                  title: '新用户',
                  value: '123',
                  prefix: Icon(Icons.person_add),
                  color: Colors.orange,
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // 列表展示
            Text('用户列表', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            ZephyrList(
              items: [
                ZephyrListItem(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://example.com/avatar1.jpg'),
                  ),
                  title: '张三',
                  subtitle: 'zhangsan@example.com',
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    print('点击了张三');
                  },
                ),
                ZephyrListItem(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://example.com/avatar2.jpg'),
                  ),
                  title: '李四',
                  subtitle: 'lisi@example.com',
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    print('点击了李四');
                  },
                ),
                ZephyrListItem(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://example.com/avatar3.jpg'),
                  ),
                  title: '王五',
                  subtitle: 'wangwu@example.com',
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    print('点击了王五');
                  },
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // 时间线
            Text('活动时间线', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            ZephyrTimeline(
              items: [
                ZephyrTimelineItem(
                  title: '项目启动',
                  subtitle: '项目正式启动',
                  time: '2024-01-01',
                  icon: Icon(Icons.flag),
                  color: Colors.blue,
                ),
                ZephyrTimelineItem(
                  title: '需求分析',
                  subtitle: '完成需求分析和设计',
                  time: '2024-01-15',
                  icon: Icon(Icons.description),
                  color: Colors.green,
                ),
                ZephyrTimelineItem(
                  title: '开发阶段',
                  subtitle: '进入开发阶段',
                  time: '2024-02-01',
                  icon: Icon(Icons.code),
                  color: Colors.orange,
                ),
                ZephyrTimelineItem(
                  title: '测试阶段',
                  subtitle: '进入测试阶段',
                  time: '2024-02-15',
                  icon: Icon(Icons.bug_report),
                  color: Colors.red,
                ),
              ],
            ),
            
            SizedBox(height: 32),
            
            // 头像组
            Text('团队成员', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            ZephyrAvatarGroup(
              avatars: [
                ZephyrAvatar(
                  imageUrl: 'https://example.com/avatar1.jpg',
                  size: 40,
                ),
                ZephyrAvatar(
                  initials: 'JD',
                  size: 40,
                  backgroundColor: Colors.blue,
                ),
                ZephyrAvatar(
                  imageUrl: 'https://example.com/avatar2.jpg',
                  size: 40,
                ),
                ZephyrAvatar(
                  initials: 'MJ',
                  size: 40,
                  backgroundColor: Colors.green,
                ),
              ],
              maxCount: 3,
              moreText: '+${10 - 3}',
            ),
          ],
        ),
      ),
    );
  }
}
```

### 表格展示
```dart
class TableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表格示例'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ZephyrTable(
          columns: [
            ZephyrTableColumn(
              title: '姓名',
              field: 'name',
              width: 120,
            ),
            ZephyrTableColumn(
              title: '年龄',
              field: 'age',
              width: 80,
              align: TextAlign.center,
            ),
            ZephyrTableColumn(
              title: '邮箱',
              field: 'email',
              flex: 1,
            ),
            ZephyrTableColumn(
              title: '状态',
              field: 'status',
              width: 100,
              align: TextAlign.center,
            ),
          ],
          data: [
            {
              'name': '张三',
              'age': 25,
              'email': 'zhangsan@example.com',
              'status': 'active',
            },
            {
              'name': '李四',
              'age': 30,
              'email': 'lisi@example.com',
              'status': 'inactive',
            },
            {
              'name': '王五',
              'age': 28,
              'email': 'wangwu@example.com',
              'status': 'active',
            },
          ],
          rowBuilder: (context, rowData, index) {
            return ZephyrTableRow(
              cells: [
                ZephyrTableCell(
                  child: Text(rowData['name']),
                ),
                ZephyrTableCell(
                  child: Text('${rowData['age']}'),
                  align: TextAlign.center,
                ),
                ZephyrTableCell(
                  child: Text(rowData['email']),
                ),
                ZephyrTableCell(
                  child: ZephyrBadge(
                    text: rowData['status'] == 'active' ? '活跃' : '非活跃',
                    color: rowData['status'] == 'active' ? Colors.green : Colors.grey,
                  ),
                  align: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
```

### 轮播图
```dart
class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('轮播图示例'),
      ),
      body: Column(
        children: [
          // 基本轮播图
          ZephyrCarousel(
            height: 200,
            autoPlay: true,
            items: [
              ZephyrCarouselItem(
                image: NetworkImage('https://example.com/image1.jpg'),
                title: '图片1',
              ),
              ZephyrCarouselItem(
                image: NetworkImage('https://example.com/image2.jpg'),
                title: '图片2',
              ),
              ZephyrCarouselItem(
                image: NetworkImage('https://example.com/image3.jpg'),
                title: '图片3',
              ),
            ],
          ),
          
          SizedBox(height: 32),
          
          // 自定义轮播图
          ZephyrCarousel(
            height: 150,
            autoPlay: true,
            indicatorAlignment: Alignment.bottomRight,
            items: [
              ZephyrCarouselItem(
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      '自定义内容1',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
              ZephyrCarouselItem(
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      '自定义内容2',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
              ZephyrCarouselItem(
                child: Container(
                  color: Colors.orange,
                  child: Center(
                    child: Text(
                      '自定义内容3',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

## 🎨 主题定制

展示组件支持完整的主题定制，可以通过 `ZephyrThemeData` 统一配置：

```dart
final theme = ZephyrThemeData(
  // 列表主题
  listTheme: ZephyrListThemeData(
    backgroundColor: Colors.white,
    dividerColor: Colors.grey[300],
    padding: EdgeInsets.zero,
    itemPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  
  // 表格主题
  tableTheme: ZephyrTableThemeData(
    backgroundColor: Colors.white,
    headerColor: Colors.grey[100],
    borderColor: Colors.grey[300],
    headerTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    rowTextStyle: TextStyle(
      color: Colors.black87,
    ),
  ),
  
  // 统计卡片主题
  statisticTheme: ZephyrStatisticThemeData(
    backgroundColor: Colors.white,
    titleColor: Colors.grey[600],
    valueColor: Colors.black87,
    padding: EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(8),
    elevation: 2,
  ),
  
  // 时间线主题
  timelineTheme: ZephyrTimelineThemeData(
    lineColor: Colors.grey[300],
    dotColor: Colors.blue,
    titleStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    subtitleStyle: TextStyle(
      color: Colors.grey[600],
      fontSize: 14,
    ),
    timeStyle: TextStyle(
      color: Colors.grey[500],
      fontSize: 12,
    ),
  ),
);

// 使用主题
ZephyrApp(
  theme: theme,
  home: DisplayDemo(),
)
```

## 📱 响应式设计

展示组件支持响应式设计，可以根据不同的设备尺寸自动调整样式：

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    final deviceType = sizingInformation.deviceType;
    
    return Column(
      children: [
        // 响应式统计卡片
        Wrap(
          spacing: deviceType == DeviceType.mobile ? 8 : 16,
          runSpacing: 16,
          children: [
            ZephyrStatistic(
              title: '总用户数',
              value: '1,234',
              size: deviceType == DeviceType.mobile ? ZephyrSize.small : ZephyrSize.medium,
            ),
            ZephyrStatistic(
              title: '活跃用户',
              value: '856',
              size: deviceType == DeviceType.mobile ? ZephyrSize.small : ZephyrSize.medium,
            ),
          ],
        ),
        
        SizedBox(height: 24),
        
        // 响应式表格
        ZephyrTable(
          columns: [
            ZephyrTableColumn(
              title: '姓名',
              field: 'name',
              width: deviceType == DeviceType.mobile ? 80 : 120,
            ),
            ZephyrTableColumn(
              title: '邮箱',
              field: 'email',
              flex: 1,
            ),
            if (deviceType != DeviceType.mobile)
              ZephyrTableColumn(
                title: '状态',
                field: 'status',
                width: 100,
              ),
          ],
          data: [
            {
              'name': '张三',
              'email': 'zhangsan@example.com',
              'status': 'active',
            },
            {
              'name': '李四',
              'email': 'lisi@example.com',
              'status': 'inactive',
            },
          ],
          rowBuilder: (context, rowData, index) {
            return ZephyrTableRow(
              cells: [
                ZephyrTableCell(
                  child: Text(rowData['name']),
                ),
                ZephyrTableCell(
                  child: Text(rowData['email']),
                ),
                if (deviceType != DeviceType.mobile)
                  ZephyrTableCell(
                    child: ZephyrBadge(
                      text: rowData['status'] == 'active' ? '活跃' : '非活跃',
                      color: rowData['status'] == 'active' ? Colors.green : Colors.grey,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  },
)
```

## 🌐 国际化

展示组件支持国际化，可以根据不同的语言环境显示不同的文本：

```dart
MaterialApp(
  localizationsDelegates: [
    ZephyrLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
  ],
  locale: Locale('zh', 'CN'),
  home: DisplayDemo(),
)
```

## 🧪 测试

展示组件提供了完整的测试覆盖：

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('展示组件测试', () {
    testWidgets('统计卡片测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrStatistic(
            title: '总用户数',
            value: '1,234',
            prefix: Icon(Icons.people),
            color: Colors.blue,
          ),
        ),
      );
      
      expect(find.byType(ZephyrStatistic), findsOneWidget);
      expect(find.text('总用户数'), findsOneWidget);
      expect(find.text('1,234'), findsOneWidget);
    });

    testWidgets('列表组件测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrList(
            items: [
              ZephyrListItem(
                title: '项目1',
                onTap: () {},
              ),
              ZephyrListItem(
                title: '项目2',
                onTap: () {},
              ),
            ],
          ),
        ),
      );
      
      expect(find.byType(ZephyrList), findsOneWidget);
      expect(find.text('项目1'), findsOneWidget);
      expect(find.text('项目2'), findsOneWidget);
    });

    testWidgets('时间线测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ZephyrTimeline(
            items: [
              ZephyrTimelineItem(
                title: '事件1',
                time: '2024-01-01',
              ),
              ZephyrTimelineItem(
                title: '事件2',
                time: '2024-01-02',
              ),
            ],
          ),
        ),
      );
      
      expect(find.byType(ZephyrTimeline), findsOneWidget);
      expect(find.text('事件1'), findsOneWidget);
      expect(find.text('事件2'), findsOneWidget);
    });
  });
}
```

## 📚 相关资源

- [组件总览](../introduction) - 所有组件的概览
- [基础组件](../basic) - 基础UI组件
- [表单组件](../form) - 表单相关的组件
- [导航组件](../navigation) - 导航相关的组件
- [反馈组件](../feedback) - 用户反馈相关的组件
- [数据可视化](../../guide/data-visualization) - 数据可视化指南
- [主题定制](../../guide/theme-system) - 主题定制指南

## 🤝 贡献

我们欢迎所有形式的贡献！请阅读 [贡献指南](../../guide/contributing) 了解如何参与项目开发。

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](../../../LICENSE) 文件。