# ZephyrCarousel 轮播组件

轮播组件是ZephyrUI高级组件中的重要组件，提供了强大的内容轮播展示功能。支持多种轮播模式、自定义样式和交互方式，是构建图片轮播、产品展示、广告横幅等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种轮播模式**: 支持自动轮播、手动切换、指示器等多种模式
- **灵活布局**: 支持水平、垂直、卡片等多种布局方式
- **丰富交互**: 支持滑动、点击、键盘导航等交互操作
- **自定义样式**: 支持自定义指示器、导航按钮、动画效果等
- **响应式设计**: 根据容器尺寸自动调整轮播项大小
- **主题适配**: 完整的主题系统支持

### 适用场景
- 图片轮播展示
- 产品特色介绍
- 广告横幅
- 用户评价展示
- 新闻资讯轮播
- 功能特性展示

## 🚀 基础用法

### 基本轮播组件

```dart
class BasicCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本轮播组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrCarousel(
          items: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blue,
              child: Center(
                child: Text(
                  '轮播项 1',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.green,
              child: Center(
                child: Text(
                  '轮播项 2',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.orange,
              child: Center(
                child: Text(
                  '轮播项 3',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ],
          autoPlay: true,
          interval: Duration(seconds: 3),
        ),
      ),
    );
  }
}
```

### 图片轮播

```dart
class ImageCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片轮播'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrCarousel(
          items: [
            Image.network(
              'https://example.com/image1.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Image.network(
              'https://example.com/image2.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Image.network(
              'https://example.com/image3.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
          ],
          autoPlay: true,
          interval: Duration(seconds: 4),
          showIndicators: true,
          indicatorAlignment: ZephyrCarouselIndicatorAlignment.bottom,
        ),
      ),
    );
  }
}
```

### 卡片式轮播

```dart
class CardCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡片式轮播'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrCarousel(
          items: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.star, size: 48, color: Colors.amber),
                    SizedBox(height: 16),
                    Text(
                      '产品特性 1',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('这是一个重要的产品特性描述'),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.bolt, size: 48, color: Colors.yellow),
                    SizedBox(height: 16),
                    Text(
                      '产品特性 2',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('这是另一个重要的产品特性描述'),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.shield, size: 48, color: Colors.green),
                    SizedBox(height: 16),
                    Text(
                      '产品特性 3',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('这是第三个重要的产品特性描述'),
                  ],
                ),
              ),
            ),
          ],
          autoPlay: true,
          interval: Duration(seconds: 5),
          showNavigation: true,
          navigationAlignment: ZephyrCarouselNavigationAlignment.sides,
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义指示器

```dart
class CustomIndicatorCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrCarousel(
          items: [
            Container(
              color: Colors.blue,
              height: 200,
              child: Center(
                child: Text('轮播项 1', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              color: Colors.green,
              height: 200,
              child: Center(
                child: Text('轮播项 2', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              color: Colors.orange,
              height: 200,
              child: Center(
                child: Text('轮播项 3', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
          autoPlay: true,
          interval: Duration(seconds: 3),
          showIndicators: true,
          indicatorBuilder: (index, count, isActive) {
            return Container(
              width: isActive ? 24 : 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

### 自定义导航按钮

```dart
class CustomNavigationCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义导航按钮'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrCarousel(
          items: [
            Container(
              color: Colors.purple,
              height: 200,
              child: Center(
                child: Text('轮播项 1', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              color: Colors.teal,
              height: 200,
              child: Center(
                child: Text('轮播项 2', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              color: Colors.indigo,
              height: 200,
              child: Center(
                child: Text('轮播项 3', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
          autoPlay: true,
          interval: Duration(seconds: 4),
          showNavigation: true,
          navigationBuilder: (canGoPrevious, canGoNext, onPrevious, onNext) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: canGoPrevious ? onPrevious : null,
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: canGoNext ? onNext : null,
                  color: Colors.white,
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

### 3D卡片轮播

```dart
class Card3DCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D卡片轮播'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrCarousel(
          items: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 300,
              child: Center(
                child: Text(
                  '3D卡片 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.teal],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 300,
              child: Center(
                child: Text(
                  '3D卡片 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange, Colors.red],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 300,
              child: Center(
                child: Text(
                  '3D卡片 3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          autoPlay: true,
          interval: Duration(seconds: 5),
          showIndicators: true,
          showNavigation: true,
          itemExtent: 300,
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 产品展示轮播

```dart
class ProductCarouselExample extends StatefulWidget {
  @override
  _ProductCarouselExampleState createState() => _ProductCarouselExampleState();
}

class _ProductCarouselExampleState extends State<ProductCarouselExample> {
  int _currentIndex = 0;
  final List<Product> _products = [
    Product(
      id: '1',
      name: '智能手机',
      price: 2999,
      image: 'https://example.com/phone.jpg',
      description: '最新款智能手机，配备强大的处理器和出色的摄像头',
    ),
    Product(
      id: '2',
      name: '平板电脑',
      price: 3999,
      image: 'https://example.com/tablet.jpg',
      description: '轻薄便携的平板电脑，适合办公和娱乐',
    ),
    Product(
      id: '3',
      name: '智能手表',
      price: 1299,
      image: 'https://example.com/watch.jpg',
      description: '功能丰富的智能手表，健康监测专家',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('产品展示轮播'),
      ),
      body: Column(
        children: [
          // 轮播区域
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ZephyrCarousel(
                items: _products.map((product) {
                  return Container(
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
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '¥${product.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                product.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                autoPlay: true,
                interval: Duration(seconds: 6),
                showIndicators: true,
                showNavigation: true,
              ),
            ),
          ),
          // 产品详情
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '当前产品: ${_products[_currentIndex].name}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '¥${_products[_currentIndex].price}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('已添加到购物车'),
                          ),
                        );
                      },
                      child: Text('加入购物车'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final int price;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });
}
```

### 用户评价轮播

```dart
class TestimonialCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Testimonial> testimonials = [
      Testimonial(
        name: '张三',
        role: '产品经理',
        company: '科技公司',
        content: '这个产品真的很棒，大大提升了我们的工作效率。界面简洁易用，功能强大。',
        avatar: 'https://example.com/avatar1.jpg',
        rating: 5,
      ),
      Testimonial(
        name: '李四',
        role: '设计师',
        company: '设计工作室',
        content: '作为设计师，我对产品的视觉效果要求很高。这个产品完全超出了我的期望。',
        avatar: 'https://example.com/avatar2.jpg',
        rating: 4,
      ),
      Testimonial(
        name: '王五',
        role: '开发者',
        company: '软件公司',
        content: 'API设计得很合理，集成起来非常方便。文档也很详细，推荐使用。',
        avatar: 'https://example.com/avatar3.jpg',
        rating: 5,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('用户评价轮播'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ZephyrCarousel(
          items: testimonials.map((testimonial) {
            return Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 评分
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < testimonial.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                    SizedBox(height: 16),
                    // 评价内容
                    Text(
                      testimonial.content,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 16),
                    // 用户信息
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(testimonial.avatar),
                          radius: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                testimonial.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${testimonial.role} · ${testimonial.company}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          autoPlay: true,
          interval: Duration(seconds: 8),
          showIndicators: true,
          showNavigation: true,
          indicatorAlignment: ZephyrCarouselIndicatorAlignment.bottom,
        ),
      ),
    );
  }
}

class Testimonial {
  final String name;
  final String role;
  final String company;
  final String content;
  final String avatar;
  final int rating;

  Testimonial({
    required this.name,
    required this.role,
    required this.company,
    required this.content,
    required this.avatar,
    required this.rating,
  });
}
```

### 垂直轮播

```dart
class VerticalCarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('垂直轮播'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          height: 400,
          child: ZephyrCarousel(
            items: [
              Container(
                height: 120,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '垂直轮播项 1',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Container(
                height: 120,
                color: Colors.green,
                child: Center(
                  child: Text(
                    '垂直轮播项 2',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Container(
                height: 120,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    '垂直轮播项 3',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Container(
                height: 120,
                color: Colors.purple,
                child: Center(
                  child: Text(
                    '垂直轮播项 4',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
            scrollDirection: Axis.vertical,
            autoPlay: true,
            interval: Duration(seconds: 3),
            showIndicators: true,
            indicatorAlignment: ZephyrCarouselIndicatorAlignment.right,
          ),
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrCarousel()

```dart
const ZephyrCarousel({
  Key? key,
  required List<Widget> items,
  bool autoPlay = false,
  Duration interval = const Duration(seconds: 3),
  bool showIndicators = true,
  bool showNavigation = false,
  ZephyrCarouselIndicatorAlignment indicatorAlignment = ZephyrCarouselIndicatorAlignment.bottom,
  ZephyrCarouselNavigationAlignment navigationAlignment = ZephyrCarouselNavigationAlignment.sides,
  Widget Function(int index, int count, bool isActive)? indicatorBuilder,
  Widget Function(bool canGoPrevious, bool canGoNext, VoidCallback onPrevious, VoidCallback onNext)? navigationBuilder,
  void Function(int index)? onPageChanged,
  double? itemExtent,
  double? viewportFraction,
  Axis scrollDirection = Axis.horizontal,
  bool enableInfiniteScroll = true,
  Duration animationDuration = const Duration(milliseconds: 300),
  Curve animationCurve = Curves.easeInOut,
  EdgeInsetsGeometry? padding,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `items`: 轮播项列表
- `autoPlay`: 是否自动播放
- `interval`: 自动播放间隔
- `showIndicators`: 是否显示指示器
- `showNavigation`: 是否显示导航按钮
- `indicatorAlignment`: 指示器对齐方式
- `navigationAlignment`: 导航按钮对齐方式
- `indicatorBuilder`: 自定义指示器构建器
- `navigationBuilder`: 自定义导航按钮构建器
- `onPageChanged`: 页面变化回调
- `itemExtent`: 轮播项固定大小
- `viewportFraction`: 视口比例
- `scrollDirection`: 滚动方向
- `enableInfiniteScroll`: 是否启用无限滚动
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `padding`: 内边距
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrCarouselIndicatorAlignment

```dart
enum ZephyrCarouselIndicatorAlignment {
  top,     // 顶部
  bottom,  // 底部
  left,    // 左侧
  right,   // 右侧
}
```

#### ZephyrCarouselNavigationAlignment

```dart
enum ZephyrCarouselNavigationAlignment {
  sides,   // 两侧
  bottom,  // 底部
  top,     // 顶部
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrCarouselTheme(
        defaultInterval: Duration(seconds: 3),
        defaultAnimationDuration: Duration(milliseconds: 300),
        defaultAnimationCurve: Curves.easeInOut,
        indicatorColor: Colors.blue,
        indicatorActiveColor: Colors.blue[700],
        indicatorInactiveColor: Colors.grey[300],
        navigationColor: Colors.white,
        navigationBackgroundColor: Colors.black54,
        navigationSize: 24,
        indicatorSize: 8,
        indicatorSpacing: 4,
        padding: EdgeInsets.all(16),
        enableInfiniteScroll: true,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultInterval`: 默认自动播放间隔
- `defaultAnimationDuration`: 默认动画持续时间
- `defaultAnimationCurve`: 默认动画曲线
- `indicatorColor`: 指示器颜色
- `indicatorActiveColor`: 活跃指示器颜色
- `indicatorInactiveColor`: 非活跃指示器颜色
- `navigationColor`: 导航按钮颜色
- `navigationBackgroundColor`: 导航按钮背景颜色
- `navigationSize`: 导航按钮大小
- `indicatorSize`: 指示器大小
- `indicatorSpacing`: 指示器间距
- `padding`: 内边距
- `enableInfiniteScroll`: 是否启用无限滚动

## 🏆 最佳实践

### 1. 合理的轮播间隔

```dart
// ✅ 好的做法：根据内容类型设置合适的间隔
ZephyrCarousel(
  autoPlay: true,
  interval: Duration(seconds: 5), // 图片内容需要更长时间查看
  items: _imageItems,
)

ZephyrCarousel(
  autoPlay: true,
  interval: Duration(seconds: 3), // 文字内容可以较快切换
  items: _textItems,
)

// ❌ 避免的做法：间隔时间不合适
ZephyrCarousel(
  autoPlay: true,
  interval: Duration(seconds: 1), // 切换太快，用户来不及阅读
  items: _textItems,
)
```

### 2. 适当的轮播项数量

```dart
// ✅ 好的做法：控制轮播项数量
ZephyrCarousel(
  items: _items.take(5), // 限制轮播项数量
  autoPlay: true,
)

// ✅ 好的做法：提供导航功能
ZephyrCarousel(
  items: _manyItems,
  showNavigation: true,
  showIndicators: true,
)

// ❌ 避免的做法：轮播项过多
ZephyrCarousel(
  items: _tooManyItems, // 用户难以找到特定内容
  autoPlay: true,
)
```

### 3. 良好的用户体验

```dart
// ✅ 好的做法：提供暂停功能
class PausableCarousel extends StatefulWidget {
  @override
  _PausableCarouselState createState() => _PausableCarouselState();
}

class _PausableCarouselState extends State<PausableCarousel> {
  bool _isPlaying = true;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZephyrCarousel(
          autoPlay: _isPlaying,
          items: _items,
        ),
        IconButton(
          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            setState(() => _isPlaying = !_isPlaying);
          },
        ),
      ],
    );
  }
}

// ✅ 好的做法：提供进度指示
ZephyrCarousel(
  autoPlay: true,
  interval: Duration(seconds: 5),
  showIndicators: true,
  onPageChanged: (index) {
    print('当前页面: $index');
  },
)

// ❌ 避免的做法：缺乏用户控制
ZephyrCarousel(
  autoPlay: true,
  items: _items,
  // 用户无法暂停或导航
)
```

### 4. 性能优化

```dart
// ✅ 好的做法：使用缓存图片
ZephyrCarousel(
  items: _imageUrls.map((url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }).toList(),
)

// ✅ 好的做法：懒加载内容
class LazyCarousel extends StatefulWidget {
  @override
  _LazyCarouselState createState() => _LazyCarouselState();
}

class _LazyCarouselState extends State<LazyCarousel> {
  final List<bool> _loadedItems = [];
  
  @override
  void initState() {
    super.initState();
    _loadedItems = List.filled(_items.length, false);
  }
  
  Widget _buildItem(int index) {
    if (!_loadedItems[index]) {
      return Container(
        color: Colors.grey[200],
        child: Center(child: CircularProgressIndicator()),
      );
    }
    
    return _items[index];
  }
}

// ❌ 避免的做法：一次性加载大量内容
ZephyrCarousel(
  items: _heavyWidgets, // 影响性能
  autoPlay: true,
)
```

### 5. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrCarousel(
  semanticLabel: '产品图片轮播',
  enableAccessibilityFeatures: true,
  items: _items,
)

// ✅ 好的做法：为每个轮播项提供描述
ZephyrCarousel(
  items: _items.map((item) {
    return Semantics(
      label: item.description,
      child: item.widget,
    );
  }).toList(),
)

// ✅ 好的做法：支持键盘导航
Focus(
  child: ZephyrCarousel(
    items: _items,
    enableAccessibilityFeatures: true,
  ),
)

// ❌ 避免的做法：缺乏无障碍支持
ZephyrCarousel(
  items: _items,
  // 缺乏语义信息和键盘支持
)
```

## 🔄 相关组件

- **ZephyrCard**: 卡片组件
- **ZephyrImage**: 图片组件
- **ZephyrList**: 列表组件
- **ZephyrProgress**: 进度组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基本轮播功能
- ✅ 支持自定义指示器和导航
- ✅ 支持多种布局方式
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/advanced/carousel/`
**示例路径**: `example/lib/components/carousel_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日