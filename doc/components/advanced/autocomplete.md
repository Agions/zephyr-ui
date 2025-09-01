# ZephyrAutocomplete

自动完成组件，支持搜索建议和智能匹配。

## 基本用法

```dart
ZephyrAutocomplete(
  suggestions: ['苹果', '香蕉', '橙子', '葡萄'],
  onSelected: (value) {
    print('选择: $value');
  },
  placeholder: '请输入水果名称',
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| suggestions | List<String> | required | 建议列表 |
| onSelected | Function(String) | required | 选择回调 |
| placeholder | String? | null | 占位符文本 |
| minChars | int | 1 | 最小字符数 |
| maxSuggestions | int | 5 | 最大建议数 |
| caseSensitive | bool | false | 是否区分大小写 |
| debounce | Duration | Duration(milliseconds: 300) | 防抖时长 |
| decoration | InputDecoration? | null | 输入框装饰 |
| suggestionBuilder | Widget Function(String)? | null | 自定义建议构建器 |