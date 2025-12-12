---
title: Carousel 轮播图
description: VelocityUI Carousel 组件，用于轮播展示一组图片或内容
---

# Carousel 轮播图

## 简介

Carousel 轮播图组件用于循环展示一组图片或内容，支持自动播放、手动切换、指示器显示等功能，适用于首页 banner、产品展示、图片画廊等场景。

### 核心特性

- 支持自动播放和手动切换
- 可自定义轮播高度和切换间隔
- 支持指示器显示/隐藏和样式定制
- 提供页面切换回调
- 支持无限循环
- 完善的样式定制能力

### 使用场景

- 首页 banner 轮播
- 产品展示画廊
- 图片相册
- 新闻资讯轮播
- 广告展示
- 活动促销轮播

## 基本用法

```dart
// 最基本的轮播图
VelocityCarousel(
  items: [
    Image.network('https://example.com/image1.jpg', fit: BoxFit.cover),
    Image.network('https://example.com/image2.jpg', fit: BoxFit.cover),
    Image.network('https://example.com/image3.jpg', fit: BoxFit.cover),
  ],
)
```

## 属性配置

### 自定义高度

```dart
// 设置固定高度
VelocityCarousel(
  height: 150,
  items: [/* 轮播项 */],
)

// 设置自适应高度（根据内容自动调整）
VelocityCarousel(
  autoHeight: true,
  items: [/* 轮播项 */],
)
```

### 自动播放配置

```dart
// 开启自动播放
VelocityCarousel(
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 5), // 5秒切换一次
  items: [/* 轮播项 */],
)

// 禁用自动播放
VelocityCarousel(
  autoPlay: false,
  items: [/* 轮播项 */],
)
```

### 指示器配置

```dart
// 隐藏指示器
VelocityCarousel(
  showIndicator: false,
  items: [/* 轮播项 */],
)

// 自定义指示器位置
VelocityCarousel(
  indicatorAlignment: Alignment.bottomRight,
  items: [/* 轮播项 */],
)
```

### 页面切换回调

```dart
VelocityCarousel(
  onPageChanged: (index) {
    print('当前页索引：$index');
    // 可以在这里处理页面切换逻辑
  },
  items: [/* 轮播项 */],
)
```

## 高级用法

### 复杂内容轮播

轮播项可以包含复杂内容，不仅仅是图片。

```dart
VelocityCarousel(
  items: [
    // 轮播项1：带文字的图片
    Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://example.com/image1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: VelocityText(
            '轮播标题1',
            color: Colors.white,
            weight: VelocityFontWeight.bold,
          ),
        ),
      ),
    ),
    // 轮播项2：纯文字内容
    Container(
      height: 200,
      color: Colors.blue,
      child: Center(
        child: VelocityText(
          '纯文字轮播项',
          color: Colors.white,
          size: VelocityTextSize.lg,
        ),
      ),
    ),
    // 轮播项3：带按钮的内容
    Container(
      height: 200,
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VelocityText('带按钮的轮播项'),
            SizedBox(height: 16),
            VelocityButton(
              child: Text('点击查看'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  ],
)
```

### 自定义指示器样式

通过 `style` 属性可以自定义指示器的样式。

```dart
VelocityCarousel(
  items: [/* 轮播项 */],
  style: VelocityCarouselStyle(
    indicatorColor: Colors.grey,
    indicatorActiveColor: Colors.blue,
    indicatorSize: 10,
    indicatorSpacing: 8,
    indicatorShape: BoxShape.rectangle,
    indicatorBorderRadius: BorderRadius.circular(4),
  ),
)
```

### 轮播图控制器

使用控制器可以手动控制轮播图的切换。

```dart
// 创建控制器
final _controller = VelocityCarouselController();

// 使用控制器
VelocityCarousel(
  controller: _controller,
  items: [/* 轮播项 */],
)

// 手动控制切换
_controller.nextPage(); // 下一页
_controller.previousPage(); // 上一页
_controller.animateToPage(2); // 跳转到指定页
```

## 样式定制

### 自定义轮播图样式

```dart
VelocityCarousel(
  items: [/* 轮播项 */],
  style: VelocityCarouselStyle(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
    indicatorColor: Colors.grey,
    indicatorActiveColor: Colors.red,
  ),
)
```

### 自定义指示器样式

```dart
VelocityCarousel(
  items: [/* 轮播项 */],
  style: VelocityCarouselStyle(
    // 指示器样式
    indicatorColor: Colors.white.withOpacity(0.5),
    indicatorActiveColor: Colors.white,
    indicatorSize: 12,
    indicatorSpacing: 10,
    indicatorShape: BoxShape.circle,
    // 指示器容器样式
    indicatorContainerPadding: EdgeInsets.all(16),
    indicatorContainerDecoration: BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
)
```

## 可访问性

- 为轮播图添加 `semanticLabel` 属性，提高屏幕阅读器的可访问性
- 为每个轮播项添加适当的无障碍标签
- 确保轮播图可以通过键盘导航
- 对于自动播放的轮播图，考虑提供暂停/播放控制

## 最佳实践

- **图片优化**：使用适当尺寸和格式的图片，确保加载速度
- **内容简洁**：轮播内容应简洁明了，避免过于复杂
- **自动播放设置**：合理设置自动播放间隔，建议3-5秒
- **指示器设计**：确保指示器清晰可见，与背景有足够对比度
- **响应式设计**：在不同屏幕尺寸下调整轮播高度
- **性能考虑**：对于大量轮播项，考虑使用懒加载
- **用户控制**：为自动播放的轮播图提供手动控制选项

## 常见问题

### 问题：轮播图不显示？

**症状**：轮播图区域空白，没有显示任何内容

**原因**：可能存在以下问题

**解决方案**：
1. 确保 `items` 列表不为空且包含有效内容
2. 检查图片URL是否正确且可访问
3. 确保轮播图有足够的高度
4. 检查是否有其他组件遮挡了轮播图

### 问题：自动播放不生效？

**症状**：轮播图没有自动切换

**原因**：
1. `autoPlay` 属性设置为 `false`
2. 轮播项数量不足2个

**解决方案**：
1. 确保 `autoPlay` 属性设置为 `true`
2. 确保轮播项数量至少为2个
3. 检查 `autoPlayInterval` 设置是否合理

### 问题：指示器样式不符合预期？

**症状**：指示器颜色、大小或位置不符合预期

**原因**：样式配置不当

**解决方案**：
1. 通过 `style` 属性自定义指示器样式
2. 调整 `indicatorAlignment` 属性设置指示器位置
3. 检查 `indicatorContainerPadding` 和 `indicatorContainerDecoration` 属性

## API 参考

### VelocityCarousel

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| key | Key? | - | 组件的唯一标识符 |
| items | ZephyrList<Widget> | - | 轮播项列表 (必填) |
| height | double | 200 | 高度 |
| autoHeight | bool | false | 是否自适应高度 |
| autoPlay | bool | true | 是否自动播放 |
| autoPlayInterval | Duration | Duration(seconds: 3) | 自动播放间隔 |
| showIndicator | bool | true | 是否显示指示器 |
| indicatorAlignment | Alignment | Alignment.bottomCenter | 指示器位置 |
| onPageChanged | ValueChanged<int>? | - | 页面切换回调 |
| controller | VelocityCarouselController? | - | 轮播图控制器 |
| semanticLabel | String? | - | 无障碍标签 |
| style | VelocityCarouselStyle? | - | 自定义样式 |

### VelocityCarouselStyle

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| borderRadius | BorderRadius | BorderRadius.zero | 边框圆角 |
| boxShadow | List<BoxShadow>? | - | 阴影效果 |
| indicatorColor | Color? | Colors.grey | 指示器颜色 |
| indicatorActiveColor | Color? | Colors.blue | 激活状态指示器颜色 |
| indicatorSize | double | 8 | 指示器大小 |
| indicatorSpacing | double | 6 | 指示器间距 |
| indicatorShape | BoxShape | BoxShape.circle | 指示器形状 |
| indicatorBorderRadius | BorderRadius? | - | 指示器圆角 |
| indicatorContainerPadding | EdgeInsets | EdgeInsets.all(8) | 指示器容器内边距 |
| indicatorContainerDecoration | Decoration? | - | 指示器容器装饰 |

### VelocityCarouselController

| 方法 | 说明 |
|------|------|
| nextPage() | 切换到下一页 |
| previousPage() | 切换到上一页 |
| animateToPage(int page) | 跳转到指定页 |
| stopAutoPlay() | 停止自动播放 |
| startAutoPlay() | 开始自动播放 |

## 相关组件

- [Image 图片](/components/basic/image)
- [Text 文本](/components/basic/text)
- [Container 容器](/components/layout/container)

## 更新日志

### v1.0.0

- 初始版本发布
- 支持自动播放和手动切换
- 提供指示器显示/隐藏功能
- 支持高度自定义
- 提供页面切换回调

---

::: tip 提示

为了获得最佳性能，建议轮播图的高度不要设置得过高，图片大小也要进行适当优化。

:::
