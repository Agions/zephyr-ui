# ZephyrUI 示例应用

这是一个完整的 ZephyrUI 组件库示例应用，展示了所有组件的使用方法和最佳实践。

## 🚀 快速开始

### 运行示例应用

1. **克隆项目**
   ```bash
   git clone https://github.com/agions/zephyr-ui.git
   cd zephyr-ui/example
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **运行应用**
   ```bash
   flutter run
   ```

### 启动选项

项目提供了多个启动入口：

- **完整演示**: `flutter run` (使用 `lib/main.dart`)
- **简化版本**: `flutter run -t lib/main_simple.dart`

## 📱 功能特性

### 🎨 完整的组件演示
- **基础组件**: 按钮、文本、图标、卡片等
- **表单组件**: 输入框、选择器、表单验证等
- **布局组件**: 容器、网格、折叠面板等
- **导航组件**: 标签页、侧边栏、分页等
- **展示组件**: 表格、列表、日历、时间线等
- **反馈组件**: 提示、进度、骨架屏等
- **高级组件**: 图表、轮播、富文本编辑器等

### 🌓 主题系统
- **深色/浅色主题**: 支持系统主题跟随
- **自定义主题**: 完全可定制的颜色和样式
- **实时切换**: 动态主题切换功能

### 📱 响应式设计
- **多设备适配**: 手机、平板、桌面设备
- **自适应布局**: 根据屏幕尺寸自动调整
- **断点系统**: 智能的响应式断点

### 🎯 交互功能
- **代码查看**: 每个组件都有对应的代码示例
- **实时预览**: 参数调整实时生效
- **性能监控**: 性能优化演示和监控

## 📁 项目结构

```
lib/
├── main.dart                    # 主入口文件
├── main_simple.dart            # 简化版本入口
├── pages/                      # 页面组件
│   └── home_page.dart          # 主页面
├── components/                 # 组件演示
│   ├── basic_components_demo.dart
│   ├── form_components_demo.dart
│   ├── layout_components_demo.dart
│   ├── navigation_components_demo.dart
│   ├── display_components_demo.dart
│   ├── feedback_components_demo.dart
│   ├── advanced_components_demo.dart
│   ├── theme_demo.dart
│   ├── responsive_demo.dart
│   └── performance_demo.dart
├── widgets/                    # 通用组件
│   ├── responsive_layout.dart
│   ├── component_card.dart
│   └── example_card.dart
├── services/                   # 服务类
│   └── theme_service.dart
└── routes/                     # 路由配置
    └── app_routes.dart
```

## 🎨 组件分类

### 基础组件 (Basic Components)
- 按钮 (Button)
- 文本 (Text)
- 图标 (Icon)
- 卡片 (Card)
- 徽章 (Badge)
- 分隔线 (Divider)
- 芯片 (Chip)

### 表单组件 (Form Components)
- 输入框 (Input)
- 选择器 (Select)
- 日期选择器 (DatePicker)
- 复选框 (Checkbox)
- 单选框 (Radio)
- 开关 (Switch)
- 滑块 (Slider)
- 表单构建器 (FormBuilder)

### 布局组件 (Layout Components)
- 容器 (Container)
- 网格 (Grid)
- 折叠面板 (Accordion)

### 导航组件 (Navigation Components)
- 标签页 (Tabs)
- 分页 (Pagination)
- 侧边菜单 (SideMenu)
- 步骤器 (Stepper)
- 底部导航栏 (BottomNavigationBar)

### 展示组件 (Display Components)
- 表格 (Table)
- 列表 (List)
- 日历 (Calendar)
- 时间线 (Timeline)
- 统计卡片 (Statistic)
- 数据网格 (DataGrid)

### 反馈组件 (Feedback Components)
- 提示 (Alert)
- 模态框 (Modal)
- 消息提示 (Toast)
- 进度条 (Progress)
- 骨架屏 (Skeleton)

### 高级组件 (Advanced Components)
- 自动完成 (AutoComplete)
- 图表 (Chart)
- 轮播图 (Carousel)
- 颜色选择器 (ColorPicker)
- 面包屑 (Breadcrumb)
- 富文本编辑器 (RichEditor)
- 文件上传 (Upload)

## 🔧 开发指南

### 添加新组件演示

1. **创建演示文件**
   ```dart
   // lib/components/new_component_demo.dart
   class NewComponentDemo extends StatelessWidget {
     const NewComponentDemo({super.key});

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: const Text('新组件演示')),
         body: // 组件演示内容
       );
     }
   }
   ```

2. **添加路由配置**
   ```dart
   // lib/routes/app_routes.dart
   static const String newComponent = '/new-component';

   static Map<String, WidgetBuilder> getRoutes() {
     return {
       // ... 其他路由
       newComponent: (context) => const NewComponentDemo(),
     };
   }
   ```

3. **在主页添加入口**
   ```dart
   // lib/pages/home_page.dart
   ComponentCard(
     title: '新组件',
     description: '组件描述',
     icon: Icons.new_icon,
     color: Colors.blue,
     route: AppRoutes.newComponent,
   )
   ```

### 主题定制

```dart
// 自定义主题
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    // 更多主题配置...
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  ),
  themeMode: ThemeMode.system,
)
```

### 响应式布局

```dart
// 使用响应式布局
ResponsiveLayout(
  mobile: _buildMobileLayout(),
  tablet: _buildTabletLayout(),
  desktop: _buildDesktopLayout(),
)

// 响应式网格
ResponsiveGrid(
  mobileColumns: 1,
  tabletColumns: 2,
  desktopColumns: 3,
  children: [
    // 网格项目
  ],
)
```

## 📚 文档

完整的组件文档请查看 [docs](../docs) 目录：

- [快速开始指南](../docs/getting-started.md)
- [组件 API 文档](../docs/api/components.md)
- [最佳实践](../docs/guides/best-practices.md)
- [主题系统](../docs/guides/theming.md)

## 🤝 贡献

欢迎贡献代码！请查看 [CONTRIBUTING.md](../CONTRIBUTING.md) 了解贡献指南。

## 📄 许可证

本项目采用 MIT 许可证。详情请查看 [LICENSE](../LICENSE) 文件。

## 🔗 相关链接

- [GitHub 仓库](https://github.com/your-repo/zephyr-ui)
- [在线文档](https://zephyr-ui.dev)
- [Flutter 官方文档](https://flutter.dev)
- [Material Design 3](https://m3.material.io)

---

**版本**: 1.0.0
**最后更新**: 2024年8月20日
