# ZephyrSignature

签名板组件，支持手写签名和保存。

## 基本用法

```dart
ZephyrSignature(
  onSigned: (signature) {
    print('签名数据: $signature');
  },
  penColor: Colors.black,
  penWidth: 3.0,
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| onSigned | Function(Uint8List) | required | 签名完成回调 |
| penColor | Color | Colors.black | 画笔颜色 |
| penWidth | double | 3.0 | 画笔宽度 |
| backgroundColor | Color | Colors.white | 背景颜色 |
| width | double | 300 | 画板宽度 |
| height | double | 200 | 画板高度 |
| clearButton | bool | true | 是否显示清除按钮 |
| clearButtonText | String | '清除' | 清除按钮文本 |