---
title: VelocitySpinner 加载动画
description: VelocityUI Spinner 组件，提供多种样式的加载动画，用于表示加载状态
---

# VelocitySpinner 加载动画

## 简介

VelocitySpinner 是一个用于表示加载状态的动画组件，支持多种动画效果和样式，提供了灵活的加载状态展示功能。

### 核心特性

- 支持 5 种动画类型：圆形、点状、波浪、脉冲、环形
- 支持自定义尺寸和颜色
- 支持自定义样式
- 支持主题定制
- 支持无障碍访问
- 轻量级，性能优化

### 使用场景

- 网络请求加载状态
- 页面初始化加载
- 数据处理和计算过程
- 表单提交状态
- 图片加载状态
- 模态框加载状态
- 列表滚动加载更多

## 基本用法

```dart
VelocitySpinner()
```

## 属性配置

### 动画类型

VelocityUI 提供了五种动画类型，适应不同的设计需求：

```dart
// 圆形旋转 (默认) - 适合大多数场景
VelocitySpinner(type: VelocitySpinnerType.circular)

// 三点跳动 - 适合轻量级加载状态
VelocitySpinner(type: VelocitySpinnerType.dots)

// 波浪效果 - 适合现代风格设计
VelocitySpinner(type: VelocitySpinnerType.wave)

// 脉冲效果 - 适合简洁设计
VelocitySpinner(type: VelocitySpinnerType.pulse)

// 环形旋转 - 适合强调加载状态
VelocitySpinner(type: VelocitySpinnerType.ring)
```

### 自定义尺寸和颜色

```dart
// 自定义尺寸 (48px)
VelocitySpinner(size: 48)

// 自定义颜色
VelocitySpinner(color: VelocityColors.primary)

// 同时自定义尺寸和颜色
VelocitySpinner(
  size: 64,
  color: VelocityColors.success,
)
```

### 自定义样式

```dart
VelocitySpinner(
  type: VelocitySpinnerType.circular,
  size: 40,
  style: VelocitySpinnerStyle(
    strokeWidth: 4,
    color: Colors.purple,
    animationDuration: Duration(milliseconds: 1000),
  ),
)
```

## 高级用法

### 加载状态指示器

```dart
// 结合 FutureBuilder 使用
FutureBuilder<String>(
  future: _fetchData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: VelocitySpinner(size: 50, color: VelocityColors.primary),
      );
    } else if (snapshot.hasError) {
      return Center(child: Text('加载失败: ${snapshot.error}'));
    } else {
      return Center(child: Text('数据: ${snapshot.data}'));
    }
  },
)
```

### 加载覆盖层

```dart
// 加载覆盖层组件
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VelocitySpinner(size: 60, color: Colors.white),
                  SizedBox(height: 16),
                  VelocityText('加载中...', color: Colors.white),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// 使用加载覆盖层
LoadingOverlay(
  isLoading: _isLoading,
  child: MyHomePage(),
)
```

### 多种动画类型展示

```dart
// 展示所有动画类型
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VelocitySpinner(type: VelocitySpinnerType.circular),
        SizedBox(width: 20),
        VelocitySpinner(type: VelocitySpinnerType.dots),
        SizedBox(width: 20),
        VelocitySpinner(type: VelocitySpinnerType.wave),
      ],
    ),
    SizedBox(height: 20),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VelocitySpinner(type: VelocitySpinnerType.pulse),
        SizedBox(width: 20),
        VelocitySpinner(type: VelocitySpinnerType.ring),
      ],
    ),
  ],
)
```

### 结合按钮使用

```dart
// 按钮加载状态
class ButtonWithLoading extends StatefulWidget {
  const ButtonWithLoading({Key? key}) : super(key: key);

  @override
  State<ButtonWithLoading> createState() => _ButtonWithLoadingState();
}

class _ButtonWithLoadingState extends State<ButtonWithLoading> {
  bool _isLoading = false;

  void _handleClick() async {
    setState(() {
      _isLoading = true;
    });
    // 模拟异步操作
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VelocityButton.text(
      text: _isLoading ? '' : '提交',
      onPressed: _isLoading ? null : _handleClick,
      loading: _isLoading,
      loadingWidget: VelocitySpinner(size: 20, color: Colors.white),
    );
  }
}
```

## 样式定制

### 主题支持

VelocitySpinner 支持通过主题进行全局样式定制：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        spinnerTheme: VelocitySpinnerTheme(
          type: VelocitySpinnerType.circular,
          size: 40,
          color: VelocityColors.primary,
          strokeWidth: 3,
          animationDuration: Duration(milliseconds: 1200),
        ),
      ),
    ],
  ),
  home: MyHomePage(),
);
```

### 样式属性

| 属性 | 说明 |
|------|------|
| strokeWidth | 圆形和环形的线条宽度 |
| color | 动画颜色 |
| backgroundColor | 背景颜色（仅部分类型支持） |
| animationDuration | 动画持续时间 |
| dotsCount | 点状动画的点数量 |
| waveCount | 波浪动画的波浪数量 |

## 可访问性

### 无障碍支持

- 支持语义标签
- 支持屏幕阅读器
- 支持高对比度模式
- 支持键盘导航

### 使用建议

- 为加载状态提供文字说明
- 确保加载动画有足够的对比度
- 避免在同一页面显示多个加载动画
- 考虑为长时间加载提供取消选项
- 确保加载动画不会分散用户注意力

```dart
// 带文字说明的加载状态
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    VelocitySpinner(size: 50),
    SizedBox(height: 12),
    VelocityText('正在加载数据...', variant: VelocityTextVariant.bodyMedium),
  ],
)
```

## 最佳实践

1. **选择合适的动画类型**：
   - 常规加载：使用 `circular` 或 `ring` 类型
   - 轻量级加载：使用 `dots` 或 `pulse` 类型
   - 现代设计：使用 `wave` 类型

2. **合适的尺寸**：
   - 页面级加载：40-64px
   - 组件级加载：24-32px
   - 按钮内部：16-20px

3. **颜色选择**：
   - 主色调：使用品牌主色
   - 中性色：使用灰色系
   - 确保与背景对比度足够

4. **加载状态设计**：
   - 提供清晰的视觉反馈
   - 避免过度使用加载动画
   - 考虑添加加载进度提示
   - 为长时间加载提供取消选项

5. **性能考虑**：
   - 避免在频繁更新的组件中使用复杂动画
   - 考虑在低性能设备上降级动画效果
   - 确保动画不会导致页面卡顿

## 常见问题

### 问题：加载动画不显示

**症状**：调用 `VelocitySpinner()` 后，动画不显示

**解决方案**：
- 检查是否在 `build` 方法中正确返回了 `VelocitySpinner`
- 检查是否被其他组件遮挡
- 检查颜色是否与背景色相同
- 尝试调整 `size` 属性，使用较大尺寸

### 问题：加载动画性能差

**症状**：加载动画导致页面卡顿或帧率低

**解决方案**：
- 减少动画复杂度，使用 `pulse` 或 `dots` 类型
- 降低动画尺寸
- 避免在同一页面显示多个加载动画
- 考虑使用静态加载指示器替代动画

### 问题：加载动画样式与设计稿不符

**症状**：加载动画的颜色、大小或线条宽度与设计稿不一致

**解决方案**：
- 使用 `style` 属性自定义样式
- 调整 `color`、`size`、`strokeWidth` 等属性
- 考虑在主题中配置全局加载动画样式

### 问题：加载动画在深色模式下不可见

**症状**：加载动画在深色模式下与背景对比度不够

**解决方案**：
- 使用主题中的颜色，它会根据当前主题自动调整
- 为不同主题（亮色/暗色）提供不同的加载动画颜色
- 确保背景色和前景色的对比度足够

### 问题：加载动画持续时间过长

**症状**：加载动画显示时间过长，影响用户体验

**解决方案**：
- 优化后端接口，减少响应时间
- 实现加载超时机制
- 提供取消加载的选项
- 考虑添加加载进度提示

## API 参考

### VelocitySpinner

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| type | VelocitySpinnerType | circular | 动画类型 |
| size | double | 32 | 动画尺寸 |
| color | Color? | - | 动画颜色 |
| style | VelocitySpinnerStyle? | - | 自定义样式 |
| semanticLabel | String? | - | 语义标签，用于无障碍访问 |
| key | Key? | - | 组件 key |

### VelocitySpinnerType

```dart
enum VelocitySpinnerType {
  circular, // 圆形旋转
  dots, // 三点跳动
  wave, // 波浪效果
  pulse, // 脉冲效果
  ring, // 环形旋转
}
```

### VelocitySpinnerStyle

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| strokeWidth | double | 2.0 | 圆形和环形的线条宽度 |
| color | Color? | - | 动画颜色 |
| backgroundColor | Color? | - | 背景颜色 |
| animationDuration | Duration? | - | 动画持续时间 |
| dotsCount | int | 3 | 点状动画的点数量 |
| waveCount | int | 5 | 波浪动画的波浪数量 |
| strokeCap | StrokeCap | StrokeCap.round | 线条端点样式 |

## 相关组件

- [VelocityButton 按钮](/components/basic/button) - 支持加载状态
- [VelocityLoading 加载](/components/feedback/loading) - 全屏加载组件
- [VelocitySkeleton 骨架屏](/components/feedback/skeleton) - 渐进式加载

## 更新日志

### v1.0.0

- 初始版本发布
- 支持 5 种动画类型
- 支持自定义尺寸和颜色
- 支持基本样式定制

### v1.0.1

- 优化了动画性能
- 增加了对主题定制的支持
- 改进了无障碍访问
- 增加了更多自定义样式属性

### v1.0.2

- 修复了某些动画类型的性能问题
- 增加了 `semanticLabel` 支持
- 优化了动画在不同设备上的表现
- 增加了对 Web 端的支持

---

::: tip 提示

- 选择合适的动画类型，保持与应用设计风格一致
- 为加载状态提供清晰的视觉反馈
- 确保加载动画有足够的对比度
- 避免在同一页面显示多个加载动画
- 考虑为长时间加载提供取消选项

:::

::: warning 警告

- 避免过度使用复杂动画，影响性能
- 不要在频繁更新的组件中使用加载动画
- 确保加载动画不会分散用户注意力
- 考虑在低性能设备上降级动画效果

:::
