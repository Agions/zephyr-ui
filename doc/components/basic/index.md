# 基础组件

基础组件是 VelocityUI 组件库的核心构建块，提供了构建用户界面的基本元素。

## 组件列表

| 组件 | 描述 |
|------|------|
| [Button 按钮](button) | 用于触发操作或事件的按钮组件 |
| [Text 文本](text) | 用于显示文本内容的组件 |
| [Icon 图标](icon) | 用于显示图标的组件 |
| [Image 图片](image) | 用于显示图片的组件 |
| [Link 链接](link) | 用于创建可点击链接的组件 |
| [Chip 芯片](chip) | 用于显示标签或简短信息的组件 |
| [Spinner 加载动画](spinner) | 用于显示加载状态的动画组件 |

## 设计原则

基础组件遵循以下设计原则：

- **简洁性**：组件设计简洁明了，专注于核心功能
- **一致性**：组件之间保持一致的设计语言和交互方式
- **可扩展性**：组件支持通过样式定制和属性配置进行扩展
- **可访问性**：组件支持无障碍访问，确保所有用户都能使用

## 使用指南

### 安装

```bash
flutter pub add velocity_ui
```

### 导入

```dart
import 'package:velocity_ui/velocity_ui.dart';
```

### 基本使用

```dart
// 使用 Button 组件
VelocityButton.text(
  text: '点击我',
  onPressed: () {
    // 处理点击事件
  },
);

// 使用 Text 组件
VelocityText('Hello, VelocityUI!');

// 使用 Icon 组件
VelocityIcon(Icons.home);
```

## 主题定制

基础组件支持通过主题进行全局样式定制：

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      VelocityThemeData(
        buttonTheme: VelocityButtonTheme(
          primaryColor: Colors.purple,
          secondaryColor: Colors.blue,
        ),
        textTheme: VelocityTextTheme(
          bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    ],
  ),
  home: MyHomePage(),
);
```

## 最佳实践

1. **组件复用**：尽量复用基础组件，避免重复造轮子
2. **样式一致性**：在整个应用中保持基础组件样式的一致性
3. **适当使用主题**：对于应用中频繁使用的组件样式，建议通过主题进行全局配置
4. **考虑可访问性**：确保基础组件的使用符合无障碍设计原则
5. **性能优化**：对于大量使用的基础组件，注意性能优化，避免不必要的重绘

## 相关资源

- [Flutter 官方文档](https://flutter.dev/docs)
- [Material Design 设计规范](https://material.io/design)
- [VelocityUI GitHub 仓库](https://github.com/agions/velocity_ui)

---

接下来，您可以：

- 查看 [Button 按钮](button) 组件的详细文档
- 查看 [Text 文本](text) 组件的详细文档
- 查看 [Icon 图标](icon) 组件的详细文档