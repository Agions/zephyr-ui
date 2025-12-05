# 更新日志

本文件记录了项目的所有重要变更。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
本项目遵循 [语义化版本](https://semver.org/spec/v2.0.0.html) 规范。

## [0.4.0] - 2025-08-30

### Added

- Complete documentation system with 55+ component documentation
- Bilingual support (Chinese/English) for all documentation
- VitePress-based documentation site with search functionality
- GitHub Pages deployment with automated CI/CD pipeline
- Component category index files and improved navigation
- API reference documentation for all components
- Design system and theme system guides
- Comprehensive developer guides (accessibility, testing, performance)
- Missing files report and documentation completeness analysis

### Changed

- Upgraded documentation infrastructure to VitePress
- Improved documentation structure and organization
- Enhanced component examples and usage patterns
- Standardized documentation format across all components
- Fixed all VitePress build errors and syntax issues
- Optimized documentation for better user experience

### Technical Documentation Features

- **VitePress Site**: Modern static site generation with fast builds
- **Bilingual Support**: Complete Chinese and English documentation
- **Search Functionality**: Full-text search across all documentation
- **Responsive Design**: Mobile-friendly documentation layout
- **API Reference**: Complete component API documentation
- **Theme System**: Comprehensive theme customization guides
- **Developer Guides**: Best practices and implementation guides

### Documentation Components

- **Basic Components**: Button, Avatar, Badge, Card, Chip, Icon, Text, Divider, Progress Indicator, Tag, Tooltip, Backdrop Filter
- **Form Components**: Input, Select, Checkbox, Radio, Switch, Slider, Date Picker, Time Picker, Rating, Text Area, Auto Complete, Color Picker, Signature Pad, File Upload
- **Display Components**: List, Table, Calendar, Carousel, Charts, Timeline, Statistic, Avatar Group
- **Feedback Components**: Alert, Modal, Notification, Progress, Skeleton, Toast, Tour
- **Layout Components**: Container, Grid, Accordion, Expandable Panel
- **Navigation Components**: Tabs, Bottom Navigation Bar, Side Menu, Navigation Rail, Pagination, Stepper, Tree

## [0.3.1] - 2025-08-26

### 修复

* 修复 Chip 组件在处理空值时的问题
* 改进了 Chip 组件的颜色回退逻辑

## [0.3.0] - 2025-08-26

### 重大变更

- 重构依赖结构，移除43个依赖中的冲突包
- 优化包大小，减少70-80%的依赖负担
- 简化核心组件，提供最小化可用版本
- 改善 pub.dev 发布兼容性
- 统一组件命名规范，所有组件使用 `Zephyr` 前缀
- 重构项目结构，移除冗余的 `src` 目录层级
- 重新组织文件夹结构，合并为6个主要分类
- 删除不必要的组件分类（media、utilities、error_handling等）
- 删除breadcrumb组件

### 新增功能

- 添加 ZephyrButton、ZephyrText、ZephyrInput、ZephyrContainer 基础组件
- 完善包元数据和主题分类
- 添加发布者验证准备
- 新增命名规范文档和迁移指南
- 重新组织组件分类结构：
  - basic: 基础组件（button、text、icon、badge等）
  - display: 展示组件（timeline、calendar、table、charts等）
  - form: 表单组件（input、select、checkbox、date_picker等）
  - navigation: 导航组件（tabs、stepper、pagination、tree等）
  - feedback: 反馈组件（alert、toast、modal、progress等）
  - layout: 布局组件（grid、container、accordion等）

### 修复

- 解决依赖冲突问题
- 修复代码分析错误
- 统一项目结构
- 更新所有组件引用和导入路径
- 优化组件组织结构，提高可维护性

## [0.2.2] - 2025-08-22

### 优化

- 修正 README.md logo 链接，pub.dev 显示更美观
- 其他细节优化

## [0.2.1] - 2025-08-22

### 修复

- 修复部分组件的样式兼容性问题
- 优化文档描述和示例代码

### 优化

- 小幅提升性能和稳定性

## [0.2.0] - 2025-08-22

### 新增

- 新增多项 UI 组件功能，提升组件库扩展性
- 增强性能优化，响应速度更快
- 增加部分 API 文档和示例

### 修复

- 修复部分组件在特殊场景下的显示问题
- 解决部分依赖兼容性警告

### 优化

- 优化部分组件的代码结构和可维护性
- 提升整体测试覆盖率
- 更新部分依赖版本

## [0.1.0] - 2025-08-22

### 新增

- VelocityUI 首次发布
- 60+ 个企业级 Flutter UI 组件
- 基于 Material Design 3 的完整主题系统
- 内置断点的响应式设计
- RTL 布局的国际化的支持
- WCAG 2.1 合规的无障碍功能
- 懒加载和内存管理的性能优化
- 包含单元测试、组件测试和集成测试的完整测试覆盖
- 全面的文档和示例

### 功能特性

- **基础组件**: Button, Badge, Icon, Tag, Avatar, Divider, Chip, Skeleton
- **布局组件**: Container, Grid, Stack, Spacer, Accordion
- **表单组件**: Input, Select, Switch, Slider, Checkbox, Radio, DatePicker, Rating, FormBuilder
- **导航组件**: SideMenu, Tabs, Breadcrumb, Pagination, Stepper, Tree
- **反馈组件**: Modal, Toast, Tooltip, Progress, Loading, Alert, Tour
- **展示组件**: Table, List, Timeline, Carousel, Card, Calendar, Statistic
- **高级组件**: AutoComplete, Chart, ColorPicker, RichEditor, Upload, Search

### 技术特性

- **类型安全**: 完整的 TypeScript 风格 API 和类型提示
- **性能优化**: 使用 const 构造函数和 RepaintBoundary 优化渲染
- **无障碍**: WCAG 2.1 合规，支持屏幕阅读器
- **主题系统**: 完整的主题系统，支持深色/浅色模式
- **响应式**: 内置断点系统，支持多设备
- **国际化**: 多语言支持，包含 RTL 布局
- **测试覆盖**: 85%+ 的测试覆盖率和全面的测试套件

### 文档

- 完整的 API 文档
- 用户指南和教程
- 组件示例和使用模式
- 主题自定义指南
- 性能优化指南
- 无障碍指南
- 测试指南

## [0.0.1] - 2024-08-18

### 新增

- 项目初始化
- 基础项目结构
- 核心依赖设置
- 初始文档

---

## 版本说明格式

### 版本号规则

- **主版本号**: 不兼容的 API 变更
- **次版本号**: 向后兼容的功能性新增
- **修订版本号**: 向后兼容的问题修复

### 变更类型

- **新增**: 新功能或特性
- **变更**: 现有功能的变更
- **弃用**: 即将移除的功能
- **移除**: 已移除的功能
- **修复**: 问题修复
- **安全**: 安全相关的变更

### 发布流程

1. 所有变更必须通过 CI/CD 流水线
2. 代码覆盖率必须达到 85% 或更高
3. 所有安全检查必须通过
4. 文档必须更新
5. 变更必须在支持的平台上手动测试
6. 必须遵循语义化版本

### 支持的平台

- **Android**: API 21+ (Android 5.0+)
- **iOS**: 12.0+
- **Web**: 现代浏览器 (Chrome, Safari, Firefox, Edge)
- **桌面**: Windows, macOS, Linux

### 依赖项

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- **Provider**: ^6.0.5
- **Intl**: ^0.19.0
- **Vector Graphics**: ^1.1.7
- **Collection**: ^1.17.1
- **Path**: ^1.9.1
- **Meta**: ^1.9.1

### 开发依赖

- **Flutter Test**: SDK
- **Flutter Lints**: ^2.0.2
- **Build Runner**: ^2.4.6
- **Mockito**: ^5.4.2
- **Golden Toolkit**: ^0.15.0
- **Coverage**: ^1.6.3
- **Benchmark Harness**: ^2.2.2
- **Dartdoc**: ^8.3.2
