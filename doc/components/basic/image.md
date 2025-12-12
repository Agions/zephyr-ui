---
title: Image 图片
description: VelocityUI Image 组件，增强版图片展示，支持圆角、占位图和错误状态
---

# Image 图片

## 简介

Image 是一个增强版图片展示组件，支持圆角、占位图、错误状态和各种图片填充方式，提供了更丰富的图片展示功能和更好的用户体验。

### 核心特性

- 支持网络图片和本地图片
- 提供多种图片填充方式
- 支持圆角和边框样式
- 支持加载占位图
- 支持错误状态处理
- 支持自定义样式
- 支持主题定制
- 支持无障碍访问

### 使用场景

- 商品展示和图片画廊
- 用户头像和个人资料图片
- 新闻和文章配图
- 卡片和列表项图片
- 轮播图和广告图片
- 数据可视化图表图片

## 基本用法

```dart
VelocityImage(
  src: 'https://picsum.photos/300/200',
  width: 300,
  height: 200,
)
```

## 属性配置

### 图片地址

```dart
// 网络图片
VelocityImage(src: 'https://picsum.photos/300/200')

// 本地图片
VelocityImage(src: 'assets/images/logo.png')
```

### 图片尺寸

```dart
// 固定尺寸
VelocityImage(
  src: '...',
  width: 300,
  height: 200,
)

// 自适应宽度
VelocityImage(
  src: '...',
  width: double.infinity,
  height: 200,
)

// 正方形图片
VelocityImage(
  src: '...',
  width: 200,
  height: 200,
)
```

### 图片填充方式

```dart
// 覆盖填充 (默认)
VelocityImage(
  src: '...',
  fit: BoxFit.cover,
)

// 包含填充
VelocityImage(
  src: '...',
  fit: BoxFit.contain,
)

// 拉伸填充
VelocityImage(
  src: '...',
  fit: BoxFit.fill,
)

// 居中填充
VelocityImage(
  src: '...',
  fit: BoxFit.center,
)
```

### 圆角图片

```dart
// 圆角图片
VelocityImage(
  src: '...',
  style: VelocityImageStyle(
    borderRadius: BorderRadius.circular(8),
  ),
)

// 圆形图片
VelocityImage(
  src: '...',
  style: VelocityImageStyle(
    borderRadius: BorderRadius.circular(100),
  ),
  width: 200,
  height: 200,
)

// 椭圆图片
VelocityImage(
  src: '...',
  style: VelocityImageStyle(
    borderRadius: BorderRadius.circular(50),
  ),
  width: 200,
  height: 100,
)
```

### 占位与错误状态

```dart
VelocityImage(
  src: 'https://example.com/invalid-image.jpg',
  // 加载中占位图
  placeholder: CircularProgressIndicator(),
  // 加载失败错误图
  errorWidget: VelocityIcon(Icons.error),
)

// 自定义占位和错误组件
VelocityImage(
  src: '...',
  placeholder: Container(
    color: Colors.grey.shade200,
    child: VelocityIcon(Icons.image, size: VelocityIconSize.lg, color: Colors.grey),
    alignment: Alignment.center,
  ),
  errorWidget: Container(
    color: Colors.red.shade50,
    child: VelocityIcon(Icons.error, size: VelocityIconSize.lg, color: VelocityColors.error),
    alignment: Alignment.center,
  ),
)
```

## 高级用法

### 边框图片

```dart
VelocityImage(
  src: '...',
  style: VelocityImageStyle(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: VelocityColors.primary, width: 2),
  ),
)
```

### 阴影图片

```dart
VelocityImage(
  src: '...',
  style: VelocityImageStyle(
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
)
```

### 图片加载状态管理

```dart
// 结合 StatefulWidget 管理加载状态
class MyImageWidget extends StatefulWidget {
  const MyImageWidget({Key? key}) : super(key: key);

  @override
  State<MyImageWidget> createState() => _MyImageWidgetState();
}

class _MyImageWidgetState extends State<MyImageWidget> {
  bool _isLoading = true;
  String _imageUrl = 'https://picsum.photos/300/200';

  @override
  void initState() {
    super.initState();
    // 模拟图片加载完成
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return VelocityImage(
      src: _imageUrl,
      width: 300,
      height: 200,
      placeholder: _isLoading ? CircularProgressIndicator() : null,
      errorWidget: VelocityIcon(Icons.error),
    );
  }
}
```

### 与其他组件结合使用

#### 图片卡片

```dart
VelocityCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      VelocityImage(
        src: 'https://picsum.photos/400/200',
        width: double.infinity,
        height: 200,
        style: VelocityImageStyle(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VelocityText('图片标题', variant: VelocityTextVariant.titleMedium),
            SizedBox(height: 8),
            VelocityText('这是图片的描述文字', variant: VelocityTextVariant.bodyMedium),
          ],
        ),
      ),
    ],
  ),
)
```

#### 图片网格

```dart
GridView.count(
  crossAxisCount: 2,
  padding: EdgeInsets.all(8),
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  children: List.generate(6, (index) {
    return VelocityImage(
      src: 'https://picsum.photos/200/200?random=$index',
      width: 200,
      height: 200,
      style: VelocityImageStyle(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }),
)
```

## 样式定制

### 主题支持

VelocityImage 支持通过主题进行全局样式定制：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        imageTheme: VelocityImageTheme(
          borderRadius: BorderRadius.circular(4),
          fit: BoxFit.cover,
        ),
      ),
    ],
  ),
  home: MyHomePage(),
);
```

### 自定义样式

通过 `style` 属性可以完全自定义图片的样式：

```dart
VelocityImage(
  src: '...',
  style: VelocityImageStyle(
    backgroundColor: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.blue, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  ),
)
```

## 可访问性

### 无障碍支持

- 支持语义标签
- 支持高对比度模式
- 支持屏幕阅读器

### 使用建议

- 为图片添加 `semanticLabel`，提高屏幕阅读器的可访问性
- 确保图片与周围文本有足够的对比度
- 为重要图片提供替代文本描述
- 考虑为不同能力的用户提供不同版本的图片

```dart
VelocityImage(
  src: 'https://example.com/product.jpg',
  semanticLabel: '产品图片：红色运动鞋',
  // 为屏幕阅读器提供更详细的描述
  ariaLabel: '这是一张红色运动鞋的图片，鞋面为皮革材质，鞋底为橡胶材质，适合跑步和日常穿着。',
)
```

## 最佳实践

1. **图片尺寸优化**：

   - 为不同设备提供不同分辨率的图片
   - 使用合适的图片格式 (WebP, AVIF 等)
   - 压缩图片大小，减少加载时间
   - 考虑使用渐进式加载

2. **响应式设计**：

   - 根据屏幕尺寸调整图片大小
   - 使用 `double.infinity` 实现宽度自适应
   - 考虑使用 `AspectRatio` 保持图片比例

3. **加载性能**：

   - 使用适当的占位图，提高用户体验
   - 实现错误处理，避免空白或崩溃
   - 考虑使用图片缓存
   - 懒加载长列表中的图片

4. **视觉设计**：

   - 保持图片风格的一致性
   - 使用适当的圆角和边框
   - 考虑图片周围的留白
   - 确保图片与文本的对比度足够

5. **安全考虑**：
   - 验证图片来源
   - 考虑使用 HTTPS 图片
   - 避免加载过大的图片
   - 实现图片加载超时处理

## 常见问题

### 问题：图片加载慢

**症状**：图片需要很长时间才能显示

**解决方案**：

- 优化图片大小和格式
- 使用 CDN 加速
- 实现图片缓存
- 使用渐进式加载
- 添加加载占位图

### 问题：图片显示变形

**症状**：图片被拉伸或压缩，失去原有比例

**解决方案**：

- 使用合适的 `fit` 属性 (contain, cover 等)
- 保持图片的原始比例
- 使用 `AspectRatio` 组件
- 确保 width 和 height 的比例与图片原始比例一致

### 问题：图片加载失败

**症状**：显示错误图标或空白

**解决方案**：

- 检查图片 URL 是否正确
- 确保网络连接正常
- 实现错误处理和重试机制
- 使用可靠的图片来源

### 问题：图片模糊

**症状**：图片显示模糊，不够清晰

**解决方案**：

- 使用高分辨率图片
- 避免过度缩放图片
- 确保图片尺寸与显示尺寸匹配
- 使用合适的图片格式

### 问题：图片在深色模式下显示异常

**症状**：图片在深色模式下对比度不够或显示不正常

**解决方案**：

- 为深色模式提供专门的图片
- 调整图片样式以适应深色背景
- 考虑使用 `ColorFilter` 调整图片颜色

## API 参考

### VelocityImage

| 属性          | 类型                | 默认值 | 说明                              |
| ------------- | ------------------- | ------ | --------------------------------- |
| src           | String?             | -      | 图片地址 (支持网络和本地)         |
| width         | double?             | -      | 图片宽度                          |
| height        | double?             | -      | 图片高度                          |
| fit           | BoxFit              | cover  | 图片填充方式                      |
| placeholder   | Widget?             | -      | 加载占位组件                      |
| errorWidget   | Widget?             | -      | 错误占位组件                      |
| semanticLabel | String?             | -      | 语义标签，用于无障碍访问          |
| ariaLabel     | String?             | -      | ARIA 标签，提供更详细的无障碍描述 |
| style         | VelocityImageStyle? | -      | 自定义样式                        |
| key           | Key?                | -      | 组件 key                          |

### VelocityImageStyle

| 属性            | 类型             | 默认值 | 说明     |
| --------------- | ---------------- | ------ | -------- |
| backgroundColor | Color?           | -      | 背景颜色 |
| borderRadius    | BorderRadius?    | -      | 圆角半径 |
| border          | Border?          | -      | 边框样式 |
| boxShadow       | List<BoxShadow>? | -      | 阴影效果 |
| padding         | EdgeInsets?      | -      | 内边距   |
| margin          | EdgeInsets?      | -      | 外边距   |
| colorFilter     | ColorFilter?     | -      | 颜色滤镜 |

## 相关组件

- [VelocityAvatar 头像](/components/display/avatar) - 基于 VelocityImage 构建的头像组件
- [VelocityCard 卡片](/components/display/card) - 常用于展示图片和内容
- [VelocityCarousel 轮播图](/components/display/carousel) - 用于展示多张图片
- [AspectRatio 宽高比](/components/layout/aspect_ratio) - 用于保持图片比例

## 更新日志

### v1.0.0

- 初始版本发布
- 支持网络和本地图片
- 支持圆角和边框
- 支持占位图和错误状态

### v1.0.1

- 优化了图片加载性能
- 增加了对语义标签的支持
- 改进了错误处理
- 支持主题定制

### v1.0.2

- 增加了 ARIA 标签支持
- 优化了占位图和错误图的显示逻辑
- 修复了某些情况下的内存泄漏问题

---

::: tip 提示

- 优先使用 WebP 或 AVIF 等现代图片格式，它们具有更好的压缩比
- 为不同设备尺寸提供不同分辨率的图片
- 考虑使用图片懒加载，提高长列表的性能
- 为所有重要图片添加语义标签，提高可访问性

:::

::: warning 警告

- 避免加载过大的图片，这会影响应用性能
- 不要依赖客户端进行图片裁剪和缩放，尽量在服务端处理
- 注意图片的版权问题
- 考虑在弱网络环境下的体验

:::
