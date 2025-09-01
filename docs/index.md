---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "ZephyrUI"
  text: "企业级 Flutter UI 组件库"
  tagline: "为 Flutter 开发者提供的企业级组件库，支持响应式设计、国际化、无障碍访问等特性"
  image:
    src: /logo.png
    alt: ZephyrUI Logo
  actions:
    - theme: brand
      text: 快速开始
      link: /zh-CN/guide/getting-started
    - theme: alt
      text: 组件
      link: /zh-CN/components/introduction
    - theme: alt
      text: GitHub
      link: https://github.com/Agions/zephyr-ui

features:
  - icon: ⚡
    title: 高性能
    details: 基于 Flutter 3.0+ 构建，使用 const 构造函数和 RepaintBoundary 优化渲染性能
  - icon: 🎨
    title: 主题系统
    details: 完整的主题系统，支持深色/浅色模式，Material Design 3 规范
  - icon: 📱
    title: 响应式设计
    details: 内置断点系统，支持移动端、平板、桌面多设备适配
  - icon: 🌐
    title: 国际化
    details: 多语言支持，包含 RTL 布局，满足全球化需求
  - icon: ♿
    title: 无障碍
    details: WCAG 2.1 合规，支持屏幕阅读器，提升用户体验
  - icon: 🧪
    title: 测试覆盖
    details: 85%+ 的测试覆盖率和全面的测试套件，确保稳定性
---

<style>
:root {
  --vp-home-hero-name-color: #2196F3;
  --vp-home-hero-name-background: transparent;
  --vp-home-hero-image-background-image: linear-gradient(135deg, #2196F3 0%, #03DAC6 100%);
  --vp-home-hero-image-filter: none;
}

.VPHome {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
}

.VPNavBar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.VPDoc .content {
  max-width: 1200px;
}
</style>

## 为什么选择 ZephyrUI？

ZephyrUI 是一个为 Flutter 开发者精心设计的企业级 UI 组件库，旨在帮助开发者快速构建高质量、可维护的移动应用。

### 🎯 设计理念

- **一致性**: 遵循 Material Design 3 设计规范，确保视觉和交互的一致性
- **可扩展**: 灵活的组件架构，支持自定义主题和样式
- **易用性**: 直观的 API 设计，丰富的文档和示例
- **性能**: 优化的渲染性能，流畅的用户体验

### 📦 开箱即用

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

// 使用 ZephyrUI 组件
ZephyrButton(
  onPressed: () {
    // 处理按钮点击
  },
  child: Text('点击我'),
)
```

### 🛠️ 核心特性

| 特性 | 描述 |
|------|------|
| **60+ 组件** | 覆盖基础、表单、导航、反馈等场景 |
| **主题系统** | 支持深色/浅色模式，自定义主题 |
| **响应式** | 内置断点系统，多设备适配 |
| **国际化** | 多语言支持，RTL 布局 |
| **无障碍** | WCAG 2.1 合规，屏幕阅读器支持 |
| **类型安全** | 完整的类型提示和错误检查 |

### 🚀 快速体验

<iframe src="https://zephyr-ui-demo.pages.dev/" width="100%" height="600px" style="border: 1px solid #e0e0e0; border-radius: 8px;"></iframe>

### 📊 社区支持

- [GitHub Issues](https://github.com/Agions/zephyr-ui/issues) - 报告问题和功能请求
- [Discussions](https://github.com/Agions/zephyr-ui/discussions) - 技术讨论和经验分享
- [更新日志](./changelog) - 版本更新和功能变更
- [贡献指南](./zh-CN/guide/contributing) - 参与项目开发

---

<div class="v-p-doc">

## 最新动态

### 🎉 v0.4.0 发布 - 2025-08-30

- ✨ **完整文档系统**: 55+ 组件的中英文文档
- 🌐 **VitePress 站点**: 现代化文档网站，支持搜索功能
- 📱 **响应式文档**: 移动端友好的文档布局
- 🔧 **API 参考**: 完整的组件 API 文档
- 📚 **开发者指南**: 最佳实践和实现指南

[查看更新日志 →](./changelog)

</div>

---

<div class="v-p-doc">

## 快速链接

<div class="grid-container">

<div class="grid-item">
### 🚀 快速开始
- [安装指南](./zh-CN/guide/installation)
- [快速上手](./zh-CN/guide/quick-start)
- [项目结构](./zh-CN/guide/getting-started)
</div>

<div class="grid-item">
### 📚 组件文档
- [基础组件](./zh-CN/components/basic)
- [表单组件](./zh-CN/components/form)
- [导航组件](./zh-CN/components/navigation)
- [展示组件](./zh-CN/components/display)
</div>

<div class="grid-item">
### 🎨 设计系统
- [设计原则](./zh-CN/guide/design-system)
- [主题定制](./zh-CN/guide/theme-system)
- [颜色系统](./zh-CN/design-system/color)
- [图标系统](./zh-CN/design-system/icons)
</div>

<div class="grid-item">
### 🔧 开发指南
- [开发环境](./zh-CN/guide/development-setup)
- [测试指南](./zh-CN/guide/testing)
- [性能优化](./zh-CN/guide/performance)
- [无障碍设计](./zh-CN/guide/accessibility)
</div>

</div>

<style>
.grid-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 24px;
  margin-top: 32px;
}

.grid-item {
  padding: 24px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.grid-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
}

.grid-item h3 {
  margin: 0 0 16px 0;
  color: #2196F3;
  font-size: 18px;
  font-weight: 600;
}

.grid-item ul {
  margin: 0;
  padding-left: 20px;
}

.grid-item li {
  margin: 8px 0;
  color: #666;
}

.grid-item a {
  color: #2196F3;
  text-decoration: none;
  transition: color 0.2s ease;
}

.grid-item a:hover {
  color: #1976D2;
  text-decoration: underline;
}
</style>

</div>

---

## 谁在使用 ZephyrUI？

ZephyrUI 被广泛应用于各种企业级应用中，包括：

- **企业管理系统**: 内部管理平台、CRM、ERP 系统
- **电商应用**: 购物应用、支付系统、订单管理
- **社交应用**: 即时通讯、社区平台、内容分享
- **教育应用**: 在线教育、学习平台、考试系统
- **金融应用**: 银行应用、投资平台、支付系统

## 开始使用

准备好开始使用 ZephyrUI 了吗？

<div class="cta-container">
  <a href="./zh-CN/guide/getting-started" class="cta-button primary">
    🚀 快速开始
  </a>
  <a href="./zh-CN/components/introduction" class="cta-button secondary">
    📚 浏览组件
  </a>
  <a href="https://github.com/Agions/zephyr-ui" class="cta-button secondary">
    💻 查看源码
  </a>
</div>

<style>
.cta-container {
  display: flex;
  gap: 16px;
  justify-content: center;
  margin-top: 48px;
  flex-wrap: wrap;
}

.cta-button {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 24px;
  border-radius: 8px;
  text-decoration: none;
  font-weight: 500;
  transition: all 0.2s ease;
  border: none;
  cursor: pointer;
}

.cta-button.primary {
  background: #2196F3;
  color: white;
}

.cta-button.primary:hover {
  background: #1976D2;
  transform: translateY(-1px);
}

.cta-button.secondary {
  background: white;
  color: #2196F3;
  border: 2px solid #2196F3;
}

.cta-button.secondary:hover {
  background: #f5f5f5;
  transform: translateY(-1px);
}
</style>