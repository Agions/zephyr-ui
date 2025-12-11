---
title: Loading 加载
description: VelocityUI Loading 组件，用于展示加载状态
---

# Loading 加载

用于页面或区块的加载状态展示。

## 基本用法

```dart
VelocityLoading()
```

## 加载类型

```dart
// 圆形加载 (默认)
VelocityLoading(type: VelocityLoadingType.circular)

// 线性加载
VelocityLoading(type: VelocityLoadingType.linear)
```

## 带进度值

```dart
// 圆形进度
VelocityLoading(value: 0.5)

// 线性进度
VelocityLoading(type: VelocityLoadingType.linear, value: 0.7)
```

## 加载覆盖层

用于覆盖在内容上的加载状态。

```dart
VelocityLoadingOverlay(
  loading: _isLoading,
  message: '加载中...',
  child: ContentWidget(),
)
```

## API

### VelocityLoading

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| type | VelocityLoadingType | circular | 加载类型 |
| size | double | 24 | 尺寸 (仅圆形) |
| strokeWidth | double | 2 | 线条宽度 (仅圆形) |
| value | double? | - | 进度值 (0.0 - 1.0) |
| style | VelocityLoadingStyle? | - | 自定义样式 |

### VelocityLoadingOverlay

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| child | Widget | - | 子组件 (必填) |
| loading | bool | - | 是否显示加载 (必填) |
| message | String? | - | 加载提示文字 |
| style | VelocityLoadingOverlayStyle? | - | 自定义样式 |

### VelocityLoadingType

| 类型 | 说明 |
|------|------|
| circular | 圆形加载 |
| linear | 线性加载 |
