# ZephyrUI 反馈组件

反馈组件用于向用户提供操作结果的视觉反馈，包括成功、错误、警告和信息等状态。

## 组件列表

### 1. Message 全局提示组件

用于显示全局的消息提示，通常出现在页面顶部或底部。

#### 基本用法

```dart
ZephyrMessage.show(
  context,
  content: '操作成功',
  type: ZephyrVariant.success,
  duration: Duration(seconds: 3),
);
```

#### 支持的变体

- `ZephyrVariant.success` - 成功提示
- `ZephyrVariant.error` - 错误提示
- `ZephyrVariant.warning` - 警告提示
- `ZephyrVariant.info` - 信息提示

### 2. Notification 通知提醒组件

用于显示通知提醒，通常出现在页面右上角。

#### 基本用法

```dart
ZephyrNotification.show(
  context,
  title: '操作成功',
  message: '您的操作已成功完成',
  type: ZephyrVariant.success,
  duration: Duration(seconds: 4),
);
```

#### 支持的变体

- `ZephyrVariant.success` - 成功通知
- `ZephyrVariant.error` - 错误通知
- `ZephyrVariant.warning` - 警告通知
- `ZephyrVariant.info` - 信息通知

#### 支持的位置

- `ZephyrNotificationPosition.topRight` - 右上角（默认）
- `ZephyrNotificationPosition.topLeft` - 左上角
- `ZephyrNotificationPosition.bottomRight` - 右下角
- `ZephyrNotificationPosition.bottomLeft` - 左下角

### 3. Popconfirm 气泡确认框组件

用于在点击元素时显示一个确认气泡，通常用于需要用户确认的操作。

#### 基本用法

```dart
ZephyrPopconfirm(
  title: '确认删除？',
  message: '此操作不可恢复',
  onConfirm: () {
    // 确认操作
  },
  child: ZephyrButton(
    text: '删除',
    variant: ZephyrVariant.error,
  ),
)
```

#### 支持的触发模式

- `ZephyrPopconfirmTriggerMode.click` - 点击触发（默认）
- `ZephyrPopconfirmTriggerMode.longPress` - 长按触发

#### 支持的位置

- `ZephyrPopconfirmPlacement.top` - 上方
- `ZephyrPopconfirmPlacement.bottom` - 下方
- `ZephyrPopconfirmPlacement.left` - 左侧
- `ZephyrPopconfirmPlacement.right` - 右侧
- `ZephyrPopconfirmPlacement.topLeft` - 左上角
- `ZephyrPopconfirmPlacement.topRight` - 右上角
- `ZephyrPopconfirmPlacement.bottomLeft` - 左下角
- `ZephyrPopconfirmPlacement.bottomRight` - 右下角

### 4. Spin 加载中组件

用于显示加载中状态，可以是全屏遮罩或局部加载指示器。

#### 基本用法

```dart
ZephyrSpin(
  spinning: true,
  size: ZephyrSpinSize.medium,
  tip: '加载中...',
  child: Container(
    width: 200,
    height: 200,
    child: Text('内容'),
  ),
)
```

#### 支持的尺寸

- `ZephyrSpinSize.small` - 小尺寸
- `ZephyrSpinSize.medium` - 中等尺寸（默认）
- `ZephyrSpinSize.large` - 大尺寸

#### 全屏加载

```dart
// 显示全屏加载
ZephyrSpin.showFullscreen(
  context,
  tip: '正在加载...',
  size: ZephyrSpinSize.large,
);

// 隐藏全屏加载
ZephyrSpin.hideFullscreen(context);
```

### 5. BackTop 返回顶部组件

用于在页面滚动到一定位置时显示返回顶部按钮。

#### 基本用法

```dart
ZephyrBackTop(
  targetHeight: 400,
  duration: Duration(milliseconds: 500),
  scrollController: _scrollController,
)
```

#### 包装器用法

```dart
ZephyrBackTopWrapper(
  targetHeight: 400,
  child: ListView(
    children: [
      // 长列表内容
    ],
  ),
)
```

## 主题支持

所有反馈组件都支持主题自定义，可以通过 `ThemeExtension` 进行配置：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrMessageTheme.light(),
      ZephyrNotificationTheme.light(),
      ZephyrPopconfirmTheme.light(),
      ZephyrSpinTheme.light(),
      ZephyrBackTopTheme.light(),
    ],
  ),
)
```

## 示例应用

运行示例应用查看所有组件的效果：

```bash
flutter run example/feedback/feedback_demo_app.dart
```

## 设计规范

所有反馈组件都遵循 Ant Design 设计规范：

- **颜色系统**：使用统一的颜色方案
- **动画效果**：平滑的过渡动画
- **响应式设计**：适配不同屏幕尺寸
- **可访问性**：支持键盘导航和屏幕阅读器
- **主题系统**：支持亮色和暗色主题

## 最佳实践

1. **合理使用反馈**：避免过多的反馈干扰用户
2. **及时消失**：设置合理的自动消失时间
3. **清晰的信息**：使用简洁明了的文字描述
4. **一致的样式**：保持组件样式的一致性
5. **适当的位置**：根据使用场景选择合适的位置