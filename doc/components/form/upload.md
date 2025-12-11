---
title: VelocityUpload 文件上传
description: VelocityUI 文件上传组件，支持单文件、多文件上传和拖拽上传
---

# VelocityUpload 文件上传

文件上传组件，支持单文件上传、多文件上传和拖拽上传功能。

## 基本用法

```dart
VelocityUpload(
  onUpload: (files) async {
    // 处理文件上传逻辑
    print('上传文件: ${files.length} 个');
    // 返回 Future<void>
  },
)
```

## 单文件上传

```dart
VelocityUpload(
  multiple: false,
  onUpload: (files) async {
    print('上传单个文件: ${files.first.path}');
  },
)
```

## 限制文件数量

```dart
VelocityUpload(
  multiple: true,
  maxFiles: 3,
  onUpload: (files) async {
    print('上传文件: ${files.length} 个');
  },
)
```

## 限制文件类型

```dart
VelocityUpload(
  multiple: true,
  allowedTypes: ['.jpg', '.png', '.gif'],
  onUpload: (files) async {
    print('上传图片文件: ${files.length} 个');
  },
)
```

## 自定义主题

```dart
VelocityUpload(
  onUpload: (files) async {
    print('上传文件: ${files.length} 个');
  },
  theme: VelocityUploadTheme(
    backgroundColor: Colors.blue.shade50,
    borderColor: Colors.blue.shade200,
    textStyle: TextStyle(color: Colors.blue.shade800),
    iconColor: Colors.blue,
  ),
)
```

## API

### VelocityUpload

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| onUpload | Future<void> Function(List<File>) | - | 文件上传回调函数 |
| multiple | bool | true | 是否支持多文件上传 |
| autoUpload | bool | true | 是否自动上传 |
| maxFiles | int? | - | 最大文件数量限制 |
| maxSize | int? | - | 最大文件大小限制（字节） |
| allowedTypes | List<String>? | - | 允许的文件类型列表，如 ['.jpg', '.png'] |
| showFileList | bool | true | 是否显示已选择的文件列表 |
| showProgress | bool | true | 是否显示上传进度 |
| enableDragAndDrop | bool | true | 是否启用拖拽上传功能 |
| theme | VelocityUploadTheme? | - | 自定义主题配置 |

## 注意事项

1. 上传组件目前仅支持文件选择功能，完整的上传逻辑需要在 `onUpload` 回调中实现
2. 拖拽上传功能在不同平台上的支持程度可能有所不同
3. 建议在实际项目中结合后端 API 实现完整的文件上传功能
4. 对于大文件上传，建议添加分块上传和断点续传功能
