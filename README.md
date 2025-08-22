# ZephyrUI

<div align="center">
![ZephyrUI Logo](https://raw.githubusercontent.com/Agions/zephyr-ui/main/assets/images/logo.png)
</div>
<div align="center">
![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**企业级 Flutter UI 组件库**

🚀 **60+ 专业组件** • 🎨 **设计系统** • 📱 **响应式** • ♿ **无障碍** • ⚡ **高性能**

</div>

---

## 📖 目录

- [🚀 快速开始](#-快速开始)
- [📦 安装](#-安装)
- [🎯 核心特性](#-核心特性)
- [🎨 组件概览](#-组件概览)
- [🏗️ 架构设计](#-架构设计)
- [📚 文档](#-文档)
- [🤝 贡献](#-贡献)
- [📞 支持](#-支持)

---

## 🚀 快速开始

在2分钟内快速上手 ZephyrUI：

### 1. 安装依赖

```bash
# 添加到 pubspec.yaml
dependencies:
  zephyr_ui: ^1.0.0

# 安装依赖
flutter pub get
```

### 2. 基础配置

```dart
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZephyrApp(
      title: '我的应用',
      theme: ZephyrTheme.light(),
      darkTheme: ZephyrTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
```

### 3. 使用组件

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 演示'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            const Text(
              '欢迎使用 ZephyrUI！',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '企业级 Flutter 组件，触手可及。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // 按钮组
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ZephyrButton.primary(
                  text: '开始使用',
                  onPressed: () => print('主要操作'),
                ),
                ZephyrButton.secondary(
                  text: '了解更多',
                  onPressed: () => print('次要操作'),
                ),
                ZephyrButton.outlined(
                  text: '查看演示',
                  onPressed: () => print('边框操作'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 表单组件
            ZephyrInputField(
              label: '邮箱地址',
              placeholder: '请输入邮箱',
              prefixIcon: const Icon(Icons.email_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入邮箱地址';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return '请输入有效的邮箱地址';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // 卡片组件
            ZephyrCard(
              title: '专业 UI 组件',
              subtitle: '为企业应用而构建',
              content: const Text(
                'ZephyrUI 提供了一套全面的高质量、'
                '无障碍且可定制的 Flutter 组件。',
              ),
              actions: [
                ZephyrButton.text(
                  text: '文档',
                  onPressed: () => print('导航到文档'),
                ),
                ZephyrButton.primary(
                  text: '开始使用',
                  onPressed: () => print('开始使用'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📦 安装

### 系统要求

- **Flutter**: ^3.0.0
- **Dart**: ^3.0.0
- **iOS**: 12.0+
- **Android**: API 21+

### 添加依赖

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  zephyr_ui: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  zephyr_ui_dev_tools: ^1.0.0  # 开发工具
```

### 安装和运行

```bash
# 安装依赖
flutter pub get

# 运行示例应用
flutter run -t lib/main.dart

# 运行测试
flutter test
```

---

## 🎯 核心特性

### 🎨 **设计系统**
- **一致的主题**: 所有组件统一的设计语言
- **可定制**: 广泛的主题定制能力
- **暗色模式**: 内置暗色主题支持
- **Material Design 3**: 最新的 Material Design 指南

### 📱 **响应式设计**
- **断点系统**: 移动端、平板和桌面布局
- **自适应组件**: 根据屏幕大小自适应的组件
- **灵活网格**: 强大的网格系统用于复杂布局

### ♿ **无障碍**
- **屏幕阅读器支持**: 完整的语义标记
- **键盘导航**: 完整的键盘无障碍
- **高对比度**: 符合 WCAG AA 标准的颜色对比度
- **焦点管理**: 适当的焦点处理

### ⚡ **性能**
- **优化渲染**: 高效的组件构建
- **懒加载**: 按需组件加载
- **内存管理**: 适当的资源清理
- **树摇**: 死代码消除

### 🔧 **开发者体验**
- **类型安全**: 完整的类型安全
- **热重载**: 即时开发反馈
- **开发工具**: 全面的开发工具
- **测试**: 内置测试工具

---

## 🎨 组件概览

### 📋 **表单组件** (13个)
| 组件 | 描述 | 状态 |
|------|------|------|
| [ZephyrInput](doc/components/form/input.md) | 文本输入框，支持验证 | ✅ |
| [ZephyrSelect](doc/components/form/select.md) | 下拉选择器 | ✅ |
| [ZephyrDatePicker](doc/components/form/date_picker.md) | 日期选择器 | ✅ |
| [ZephyrCheckbox](doc/components/form/checkbox.md) | 复选框 | ✅ |
| [ZephyrRadio](doc/components/form/radio.md) | 单选按钮 | ✅ |
| [ZephyrSwitch](doc/components/form/switch.md) | 开关切换 | ✅ |
| [ZephyrSlider](doc/components/form/slider.md) | 滑块组件 | ✅ |
| [ZephyrRating](doc/components/form/rating.md) | 评分组件 | ✅ |
| [ZephyrTimePicker](doc/components/form/time_picker.md) | 时间选择器 | ✅ |
| [ZephyrTextArea](doc/components/form/text_area.md) | 多行文本输入 | ✅ |
| [ZephyrFormBuilder](doc/components/form/form_builder.md) | 表单构建器 | ✅ |

### 🎯 **基础组件** (8个)
| 组件 | 描述 | 状态 |
|------|------|------|
| [ZephyrButton](doc/components/basic/button.md) | 多种样式按钮 | ✅ |
| [ZephyrAvatar](doc/components/basic/avatar.md) | 头像组件 | ✅ |
| [ZephyrBadge](doc/components/basic/badge.md) | 徽章和状态指示器 | ✅ |
| [ZephyrCard](doc/components/basic/card.md) | 卡片组件 | ✅ |
| [ZephyrChip](doc/components/basic/chip.md) | 标签选择器 | ✅ |
| [ZephyrIcon](doc/components/basic/icon.md) | 图标组件 | ✅ |
| [ZephyrText](doc/components/basic/text.md) | 文本组件 | ✅ |
| [ZephyrDivider](doc/components/basic/divider.md) | 分割线组件 | ✅ |

### 🧭 **导航组件** (8个)
| 组件 | 描述 | 状态 |
|------|------|------|
| [ZephyrTabs](doc/components/navigation/tabs.md) | 选项卡导航 | ✅ |
| [ZephyrStepper](doc/components/navigation/stepper.md) | 步骤器 | ✅ |
| [ZephyrBreadcrumb](doc/components/navigation/breadcrumb.md) | 面包屑导航 | ✅ |
| [ZephyrPagination](doc/components/navigation/pagination.md) | 分页组件 | ✅ |
| [ZephyrBottomNavigationBar](doc/components/navigation/bottom_navigation_bar.md) | 底部导航栏 | ✅ |
| [ZephyrSideMenu](doc/components/navigation/side_menu.md) | 侧边菜单 | ✅ |
| [ZephyrNavigationRail](doc/components/navigation/navigation_rail.md) | 导航栏 | ✅ |
| [ZephyrTour](doc/components/navigation/tour.md) | 引导游览 | ✅ |

### 📊 **数据展示组件** (13个)
| 组件 | 描述 | 状态 |
|------|------|------|
| [ZephyrTable](doc/components/display/table.md) | 数据表格 | ✅ |
| [ZephyrList](doc/components/display/list.md) | 列表组件 | ✅ |
| [ZephyrCalendar](doc/components/display/calendar.md) | 日历组件 | ✅ |
| [ZephyrStatistic](doc/components/display/statistic.md) | 统计数据展示 | ✅ |
| [ZephyrTimeline](doc/components/display/timeline.md) | 时间线 | ✅ |
| [ZephyrCardGrid](doc/components/display/card_grid.md) | 卡片网格 | ✅ |
| [ZephyrDataGrid](doc/components/display/data_grid.md) | 数据网格 | ✅ |
| [ZephyrProgressIndicators](doc/components/display/progress_indicators.md) | 进度指示器 | ✅ |
| [ZephyrStatusIndicators](doc/components/display/status_indicators.md) | 状态指示器 | ✅ |
| [ZephyrAvatarGroups](doc/components/display/avatar_groups.md) | 头像组 | ✅ |
| [ZephyrBadgeDisplays](doc/components/display/badge_displays.md) | 徽章展示 | ✅ |
| [ZephyrTagClouds](doc/components/display/tag_clouds.md) | 标签云 | ✅ |

### 💬 **反馈组件** (6个)
| 组件 | 描述 | 状态 |
|------|------|------|
| [ZephyrAlert](doc/components/feedback/alert.md) | 警告对话框 | ✅ |
| [ZephyrToast](doc/components/feedback/toast.md) | 消息提示 | ✅ |
| [ZephyrProgress](doc/components/feedback/progress.md) | 进度指示器 | ✅ |
| [ZephyrSkeleton](doc/components/feedback/skeleton.md) | 骨架屏加载 | ✅ |
| [ZephyrModal](doc/components/feedback/modal.md) | 模态对话框 | ✅ |

### 🏗️ **布局组件** (4个)
| 组件 | 描述 | 状态 |
|------|------|------|
| [ZephyrGrid](doc/components/layout/grid.md) | 网格布局 | ✅ |
| [ZephyrContainer](doc/components/layout/container.md) | 容器组件 | ✅ |
| [ZephyrAccordion](doc/components/layout/accordion.md) | 手风琴折叠面板 | ✅ |

### 🚀 **高级组件** (16个)
| 组件 | 描述 | 状态 |
|------|------|------|
| [ZephyrChart](doc/components/advanced/chart.md) | 图表组件 | ✅ |
| [ZephyrUpload](doc/components/advanced/upload.md) | 文件上传 | ✅ |
| [ZephyrColorPicker](doc/components/advanced/color_picker.md) | 颜色选择器 | ✅ |
| [ZephyrCarousel](doc/components/advanced/carousel.md) | 轮播图 | ✅ |
| [ZephyrRichEditor](doc/components/advanced/rich_editor.md) | 富文本编辑器 | ✅ |
| [ZephyrAutocomplete](doc/components/advanced/autocomplete.md) | 自动完成 | ✅ |
| [ZephyrImageCropper](doc/components/advanced/image_cropper.md) | 图片裁剪 | ✅ |
| [ZephyrMediaPlayer](doc/components/advanced/media_player.md) | 媒体播放器 | ✅ |
| [ZephyrPDFViewer](doc/components/advanced/pdf_viewer.md) | PDF查看器 | ✅ |
| [ZephyrQRCode](doc/components/advanced/qr_code.md) | 二维码生成 | ✅ |
| [ZephyrSignature](doc/components/advanced/signature.md) | 签名板 | ✅ |
| [ZephyrDragDrop](doc/components/advanced/drag_drop.md) | 拖拽功能 | ✅ |
| [ZephyrDataVisualization](doc/components/advanced/data_visualization.md) | 数据可视化 | ✅ |

---

## 🏗️ 架构设计

### 核心架构

```
┌─────────────────────────────────────────────────────────────┐
│                    ZephyrUI 架构                            │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │   主题层       │  │   组件层        │  │  工具层     │  │
│  │                 │  │                 │  │             │  │
│  │ • 亮色主题     │  │ • 基础组件     │  │ • 助手函数  │  │
│  │ • 暗色主题     │  │ • 表单组件     │  │ • 工具类    │  │
│  │ • 自定义主题   │  │ • 布局组件     │  │ • 常量      │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │   服务层       │  │   数据层        │  │  平台层     │  │
│  │                 │  │                 │  │             │  │
│  │ • 主题服务     │  │ • 模型         │  │ • iOS       │  │
│  │ • API 服务     │  │ • 仓储         │  │ • Android   │  │
│  │ • 认证服务     │  │ • 提供者       │  │ • Web        │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### 设计原则

1. **一致性**: 统一的设计语言和交互模式
2. **可访问性**: 遵循 WCAG 2.1 标准，支持屏幕阅读器
3. **性能**: 优化的渲染和内存使用
4. **可定制**: 强大的主题系统和组件配置
5. **易用性**: 简洁直观的 API 设计

---

## 📚 文档

### 入门指南
- [安装指南](doc/getting-started.md)
- [快速开始教程](doc/examples/quick-start.md)
- [项目结构](doc/guides/project-structure.md)

### 组件文档
- [基础组件](doc/components/basic/README.md)
- [表单组件](doc/components/form/README.md)
- [导航组件](doc/components/navigation/README.md)
- [数据展示组件](doc/components/display/README.md)
- [反馈组件](doc/components/feedback/README.md)
- [布局组件](doc/components/layout/README.md)
- [高级组件](doc/components/advanced/README.md)

### 设计指南
- [设计系统](doc/guides/design-guidelines.md)
- [主题定制](doc/guides/theming.md)
- [响应式设计](doc/guides/responsive-design.md)
- [无障碍指南](doc/guides/accessibility.md)

### 性能优化
- [性能优化指南](doc/guides/performance-optimization.md)
- [内存管理](doc/guides/memory-management.md)
- [渲染优化](doc/guides/rendering-optimization.md)

### API 参考
- [组件 API](doc/api/components.md)
- [主题 API](doc/api/themes.md)
- [工具函数](doc/api/utils.md)
- [类型定义](doc/api/types.md)

### 示例应用
- [完整示例](example/)
- [组件演示](example/lib/components/)
- [主题演示](example/lib/themes/)

---

## 🎨 主题定制

### 基础主题配置

```dart
MaterialApp(
  theme: ZephyrTheme.light(),
  darkTheme: ZephyrTheme.dark(),
  themeMode: ThemeMode.system,
  home: const MyApp(),
);
```

### 自定义主题

```dart
final customTheme = ZephyrThemeData(
  primaryColor: Colors.blue,
  secondaryColor: Colors.green,
  // ... 其他自定义配置
);

MaterialApp(
  theme: customTheme.toThemeData(),
  home: const MyApp(),
);
```

### 主题切换

```dart
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
```

---

## 📱 响应式设计

### 断点系统

```dart
class ZephyrBreakpoints {
  static const double mobile = 600.0;
  static const double tablet = 900.0;
  static const double desktop = 1200.0;

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobile) return DeviceType.mobile;
    if (width < tablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }
}

enum DeviceType { mobile, tablet, desktop }
```

### 响应式组件

```dart
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceType = ZephyrBreakpoints.getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return const MobileLayout();
      case DeviceType.tablet:
        return const TabletLayout();
      case DeviceType.desktop:
        return const DesktopLayout();
    }
  }
}
```

---

## ⚡ 性能优化

### 目标性能指标

```dart
class ZephyrPerformanceTargets {
  static const Duration frameTime = Duration(milliseconds: 16); // 60 FPS
  static const Duration buildTime = Duration(milliseconds: 2);
  static const Duration layoutTime = Duration(milliseconds: 4);
  static const Duration paintTime = Duration(milliseconds: 8);
  static const int maxMemoryUsage = 100; // MB
  static const double jankThreshold = 0.1; // 10% 卡顿帧
}
```

### 优化策略

1. **组件优化**: 使用 const 构造函数，避免不必要的重建
2. **内存管理**: 正确释放资源，使用图片缓存
3. **渲染优化**: 使用 RepaintBoundary，减少重绘区域
4. **列表优化**: 使用 ListView.builder，设置 itemExtent
5. **网络优化**: 使用缓存，批量请求

---

## 🤝 贡献

我们欢迎社区的贡献！详情请查看[贡献指南](CONTRIBUTING.md)。

### 开发设置

```bash
# 克隆仓库
git clone https://github.com/zephyrui/zephyr_ui.git
cd zephyr_ui

# 安装依赖
flutter pub get

# 运行开发服务器
flutter run -t lib/development/main.dart

# 运行测试
flutter test

# 运行静态分析
flutter analyze
```

### 贡献指南

- 📝 **代码风格**: 遵循 Dart 官方代码风格指南
- 🧪 **测试**: 保持 90%+ 的测试覆盖率
- 📚 **文档**: 为所有公共 API 编写文档
- 🎨 **设计**: 遵循 Material Design 3 指南
- ♿ **无障碍**: 确保 WCAG AA 合规

### 贡献类型

- 🐛 **Bug 修复**: 修复现有问题
- ✨ **新组件**: 开发新的组件
- 📚 **文档**: 改进文档和示例
- 🎨 **UI/UX**: 改进用户界面和体验
- ⚡ **性能**: 性能优化和改进
- 🧪 **测试**: 增加测试覆盖率
- 🔧 **构建**: 改进构建和 CI/CD 流程

---

## 📞 支持

### 获取帮助

1. **文档**: 从[完整文档](doc/README.md)开始
2. **示例**: 查看[示例应用](example/)
3. **问题报告**: [GitHub Issues](https://github.com/agions/zephyr_ui/issues)
4. **讨论**: [GitHub Discussions](https://github.com/agions/zephyr_ui/discussions)

### 专业支持

为企业客户提供：

- 🎯 **优先支持**: 24/7 邮件和聊天支持
- 🚀 **定制开发**: 功能开发和定制
- 📚 **培训**: 现场和远程培训课程
- 🔧 **咨询**: 架构和性能咨询


---

## 📄 许可证

ZephyrUI 采用 MIT 许可证。详情请查看[LICENSE](LICENSE)文件。

### 许可证摘要

✅ **允许**:
- 商业使用
- 修改
- 分发
- 私人使用

❌ **禁止**:
- 声明责任
- 诉诸法律

📋 **要求**:
- 包含许可证和版权声明
- 声明重大更改

---

## 🙏 致谢

- **Flutter 团队**: 感谢出色的 Flutter 框架
- **Material Design**: 感谢设计系统的灵感
- **社区**: 感谢所有反馈和贡献
- **贡献者**: 感谢所有让 ZephyrUI 变得更好的人们

---

<div align="center">

**由 Agions 用 ❤️ 制作**

[![GitHub](https://img.shields.io/github/stars/agions/zephyr_ui?style=social)]

</div>
