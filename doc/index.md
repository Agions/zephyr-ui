---
layout: home

hero:
  name: VelocityUI
  text: 高性能 Flutter UI 组件库
  tagline: 优雅、易用、高效的移动端组件解决方案，为您的 Flutter 应用提供强大的 UI 支持
  image:
    src: /images/logo_docs.png
    alt: VelocityUI Logo
  actions:
    - theme: brand
      text: 快速开始
      link: /quick-start
      icon: rocket
    - theme: alt
      text: 查看组件
      link: /components/basic/button
      icon: components
    - theme: alt
      text: GitHub
      link: https://github.com/agions/velocity_ui
      icon: github

features:
  - icon: ✨
    title: 丰富组件库
    details: 提供 50+ 个高质量 Flutter 组件，覆盖基础、展示、布局、导航、表单、反馈等多个类别
    link: /components/basic/button
    linkText: 查看所有组件
  - icon: 🎨
    title: 强大主题系统
    details: 支持全局主题配置和组件级样式覆盖，轻松实现品牌定制和深色模式
    link: /theme-customization
    linkText: 了解主题定制
  - icon: ⚡
    title: 高性能
    details: 优化的组件实现，确保流畅的用户体验，即使在复杂布局下也能保持高性能
    link: /components/basic/button
    linkText: 体验高性能组件
  - icon: ♿
    title: 无障碍支持
    details: 全面的无障碍设计，确保所有用户都能使用，符合 WCAG 标准
    link: /quick-start
    linkText: 了解无障碍支持
  - icon: 🔒
    title: 类型安全
    details: 完整的类型定义，提供良好的开发体验，减少运行时错误
    link: /api-reference
    linkText: 查看 API 文档
  - icon: 📈
    title: 活跃维护
    details: 持续更新和改进，响应用户反馈，不断完善组件库
    link: https://github.com/agions/velocity_ui
    linkText: 参与贡献
---

## 🚀 快速开始

### 1. 安装

在您的 Flutter 项目中添加 VelocityUI 依赖：

```bash
flutter pub add velocity_ui
```

### 2. 导入

在需要使用 VelocityUI 组件的文件中导入：

```dart
import 'package:velocity_ui/velocity_ui.dart';
```

### 3. 使用组件

```dart
// 创建一个简单的按钮
VelocityButton.primary(
  text: '点击我',
  onPressed: () {
    // 处理点击事件
  },
)

// 创建一段文本
VelocityText(
  'Hello VelocityUI!',
  size: VelocityTextSize.lg,
  weight: VelocityFontWeight.bold,
)
```

### 4. 运行应用

```bash
flutter run
```

> 💡 **提示**：查看 [快速开始](/quick-start) 页面获取更详细的教程

## 🎯 核心优势

### 设计美观

- 遵循现代设计原则
- 统一的设计语言
- 支持自定义主题

### 易用性

- 简洁的 API 设计
- 详细的文档和示例
- 丰富的组件属性

### 高性能

- 优化的渲染性能
- 减少不必要的重建
- 支持懒加载

### 可扩展性

- 支持自定义组件
- 灵活的样式系统
- 主题继承机制

## 🌟 热门组件

<FeatureGrid>
  <FeatureCard title="Button 按钮" description="支持多种类型和样式的按钮组件" link="/components/basic/button" />
  <FeatureCard title="Card 卡片" description="通用卡片容器，用于承载内容" link="/components/display/card" />
  <FeatureCard title="Input 输入框" description="功能丰富的输入框组件" link="/components/form/input" />
  <FeatureCard title="Dialog 对话框" description="灵活的对话框组件" link="/components/feedback/dialog" />
  <FeatureCard title="Tabs 标签页" description="用于页面切换的标签页组件" link="/components/navigation/tabs" />
  <FeatureCard title="Grid 网格" description="响应式网格布局组件" link="/components/layout/grid" />
</FeatureGrid>

## 📚 学习资源

- [快速开始](/quick-start) - 入门教程
- [组件文档](/components/basic/button) - 所有组件的详细文档
- [主题定制](/theme-customization) - 自定义主题样式
- [API 参考](/api-reference) - 完整的 API 文档
- [示例项目](https://github.com/agions/velocity_ui/tree/main/example) - 实际应用示例

## 👥 社区支持

- [GitHub](https://github.com/agions/velocity_ui) - 源码和问题反馈
- [Discussions](https://github.com/agions/velocity_ui/discussions) - 讨论和交流
- [Issues](https://github.com/agions/velocity_ui/issues) - 报告问题

## 📄 许可证

VelocityUI 采用 [MIT 许可证](https://github.com/agions/velocity_ui/blob/main/LICENSE)，可自由使用和修改。

---

<div style="text-align: center; margin-top: 4rem; color: #666;">
  <p>Made with ❤️ by the VelocityUI Team</p>
  <p>Version 1.0.0</p>
</div>
