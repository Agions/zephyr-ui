---
title: Collapse 折叠面板
description: VelocityUI Collapse 组件，用于折叠/展开内容
---

# Collapse 折叠面板

可以折叠/展开的内容区域。

## 基本用法

```dart
VelocityCollapse(
  title: ZephyrText('标题'),
  child: ZephyrText('内容...'),
)
```

## 初始展开

```dart
VelocityCollapse(
  title: ZephyrText('标题'),
  initiallyExpanded: true,
  child: ZephyrText('内容...'),
)
```

## 手风琴模式 (Accordion)

手风琴模式下，通常一次只展开一个面板（也可以通过 `allowMultiple: true` 允许展开多个）。

```dart
VelocityAccordion(
  items: [
    VelocityAccordionItem(
      title: ZephyrText('面板 1'),
      child: ZephyrText('内容 1'),
    ),
    VelocityAccordionItem(
      title: ZephyrText('面板 2'),
      child: ZephyrText('内容 2'),
    ),
  ],
)
```

## API

### VelocityCollapse

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| title | Widget | - | 标题组件 (必填) |
| child | Widget | - | 内容组件 (必填) |
| leading | Widget? | - | 左侧组件 |
| initiallyExpanded | bool | false | 初始是否展开 |
| onChanged | ValueChanged<bool>? | - | 状态改变回调 |
| style | VelocityCollapseStyle? | - | 自定义样式 |

### VelocityAccordion

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | List<VelocityAccordionItem> | - | 面板项列表 (必填) |
| allowMultiple | bool | false | 是否允许同时展开多个 |
| style | VelocityCollapseStyle? | - | 自定义样式 |
