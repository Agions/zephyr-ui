# ZephyrDragDrop

拖拽功能组件，支持拖拽排序和文件拖拽。

## 基本用法

```dart
ZephyrDragDrop(
  items: [
    DragDropItem(
      id: '1',
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blue,
        child: Text('项目 1'),
      ),
    ),
    DragDropItem(
      id: '2',
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.green,
        child: Text('项目 2'),
      ),
    ),
  ],
  onReorder: (oldIndex, newIndex) {
    print('从 $oldIndex 移动到 $newIndex');
  },
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| items | List<DragDropItem> | required | 可拖拽项目列表 |
| onReorder | Function(int, int) | required | 重新排序回调 |
| direction | Axis | vertical | 拖拽方向 |
| spacing | double | 8.0 | 项目间距 |
| physics | ScrollPhysics? | null | 滚动物理 |
| shrinkWrap | bool | false | 是否收缩包装 |