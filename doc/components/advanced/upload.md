# ZephyrUpload

文件上传组件，支持拖拽上传和多文件选择。

## 基本用法

```dart
ZephyrUpload(
  onFileSelected: (files) {
    print('选择的文件: $files');
  },
  allowedTypes: ['image/jpeg', 'image/png'],
  maxSize: 10 * 1024 * 1024, // 10MB
  multiple: true,
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| onFileSelected | Function(List<File>) | required | 文件选择回调 |
| allowedTypes | List<String> | [] | 允许的文件类型 |
| maxSize | int | 10 * 1024 * 1024 | 最大文件大小 |
| multiple | bool | false | 是否支持多文件 |
| dragEnabled | bool | true | 是否支持拖拽 |
| placeholder | Widget? | null | 占位符组件 |
| disabled | bool | false | 是否禁用 |