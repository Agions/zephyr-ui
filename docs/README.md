# ZephyrUI

<div align="center">

![ZephyrUI Logo](https://img.shields.io/badge/ZephyrUI-Flutter%20UI%20Library-blue?style=for-the-badge&logo=flutter&logoColor=white)
![Version](https://img.shields.io/badge/version-0.4.0-green?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-purple?style=for-the-badge)
![Platform](https://img.shields.io/badge/platform-Flutter%20%7C%20Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-orange?style=for-the-badge)

**企业级 Flutter UI 组件库**

[快速开始](./zh-CN/guide/getting-started) • [组件文档](./zh-CN/components/introduction) • [API 参考](./zh-CN/api/introduction) • [示例](https://zephyr-ui-demo.pages.dev/)

</div>

---

## 🌟 特性

### 🎨 设计系统
- ✨ **Material Design 3**: 遵循最新的 Material Design 规范
- 🎯 **一致性**: 统一的设计语言和交互模式
- 🎨 **主题系统**: 支持深色/浅色模式，自定义主题
- 📐 **响应式**: 内置断点系统，多设备适配

### ⚡ 性能优化
- 🚀 **高性能**: 基于 Flutter 3.0+ 构建，优化的渲染性能
- 💾 **内存管理**: 智能的内存管理和垃圾回收
- 🔄 **懒加载**: 组件懒加载，减少初始包大小
- 📊 **性能监控**: 内置性能监控和调试工具

### 🌐 国际化
- 🗣️ **多语言**: 支持中文、英文等多种语言
- 🔄 **RTL**: 支持从右到左的布局
- 🌍 **本地化**: 日期、时间、货币等本地化支持
- 📱 **适配**: 不同地区的文化适配

### ♿ 无障碍
- 🎧 **屏幕阅读器**: 支持 VoiceOver 和 TalkBack
- ⌨️ **键盘导航**: 完整的键盘操作支持
- 🎨 **高对比度**: 支持高对比度模式
- 📏 **可访问性**: 符合 WCAG 2.1 标准

### 🧪 测试覆盖
- 📝 **单元测试**: 85%+ 的代码覆盖率
- 🎯 **组件测试**: 完整的组件功能测试
- 🔍 **集成测试**: 端到端的集成测试
- 📊 **性能测试**: 性能基准测试

## 📦 快速开始

### 安装

```bash
# 添加到 pubspec.yaml
dependencies:
  zephyr_ui: ^0.4.0
```

```bash
# 安装依赖
flutter pub get
```

### 基本使用

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  runApp(ZephyrApp(
    theme: ZephyrThemeData.light(),
    darkTheme: ZephyrThemeData.dark(),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZephyrUI 示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZephyrButton(
              onPressed: () {
                // 处理按钮点击
              },
              child: Text('主要按钮'),
              variant: ZephyrVariant.primary,
            ),
            SizedBox(height: 16),
            ZephyrInput(
              placeholder: '请输入内容',
              onChanged: (value) {
                print('输入内容: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎯 组件概览

### 基础组件
- **ZephyrButton** - 按钮组件，支持多种样式和状态
- **ZephyrText** - 文本组件，支持多种字体样式
- **ZephyrIcon** - 图标组件，支持多种图标库
- **ZephyrAvatar** - 头像组件，支持图片和文字头像
- **ZephyrBadge** - 徽章组件，支持多种样式
- **ZephyrCard** - 卡片组件，支持阴影和圆角

### 表单组件
- **ZephyrInput** - 输入框组件，支持多种输入类型
- **ZephyrSelect** - 选择器组件，支持下拉和搜索
- **ZephyrCheckbox** - 复选框组件，支持多种状态
- **ZephyrRadio** - 单选框组件，支持分组选择
- **ZephyrSwitch** - 开关组件，支持滑动切换
- **ZephyrSlider** - 滑块组件，支持数值选择

### 导航组件
- **ZephyrTabs** - 标签页组件，支持滑动切换
- **ZephyrBottomNavigationBar** - 底部导航栏组件
- **ZephyrSideMenu** - 侧边菜单组件，支持多级菜单
- **ZephyrStepper** - 步骤器组件，支持线性流程
- **ZephyrPagination** - 分页器组件，支持大数据量

### 反馈组件
- **ZephyrAlert** - 警告框组件，支持多种类型
- **ZephyrModal** - 模态框组件，支持自定义内容
- **ZephyrToast** - 提示框组件，支持多种位置
- **ZephyrProgress** - 进度条组件，支持多种样式
- **ZephyrSkeleton** - 骨架屏组件，支持加载状态

## 🎨 主题定制

### 自定义主题

```dart
final customTheme = ZephyrThemeData(
  primaryColor: Color(0xFF6366F1),
  secondaryColor: Color(0xFF8B5CF6),
  backgroundColor: Color(0xFFF9FAFB),
  surfaceColor: Color(0xFFFFFFFF),
  errorColor: Color(0xFFEF4444),
  
  // 文字主题
  textTheme: ZephyrTextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
  ),
  
  // 组件主题
  buttonTheme: ZephyrButtonThemeData(
    borderRadius: BorderRadius.circular(8),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
);

// 使用自定义主题
ZephyrApp(
  theme: customTheme,
  home: MyApp(),
)
```

### 深色模式

```dart
ZephyrApp(
  theme: ZephyrThemeData.light(),
  darkTheme: ZephyrThemeData.dark(),
  themeMode: ZephyrThemeMode.system, // 跟随系统
  home: MyApp(),
)
```

## 📱 响应式设计

### 断点系统

```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    if (sizingInformation.deviceType == DeviceType.mobile) {
      return _buildMobileLayout();
    } else if (sizingInformation.deviceType == DeviceType.tablet) {
      return _buildTabletLayout();
    } else {
      return _buildDesktopLayout();
    }
  },
)
```

### 响应式网格

```dart
ResponsiveGrid(
  columns: ResponsiveGridValue(
    xs: 1,  // 手机端: 1列
    sm: 2,  // 小平板: 2列
    md: 3,  // 平板: 3列
    lg: 4,  // 桌面: 4列
    xl: 6,  // 大桌面: 6列
  ),
  spacing: 16,
  children: [
    _buildGridItem(1),
    _buildGridItem(2),
    _buildGridItem(3),
    _buildGridItem(4),
  ],
)
```

## 🌐 国际化

### 多语言支持

```dart
MaterialApp(
  localizationsDelegates: [
    ZephyrLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
  ],
  locale: Locale('zh', 'CN'),
)
```

### RTL 支持

```dart
MaterialApp(
  locale: Locale('ar', 'SA'), // 阿拉伯语
  textDirection: TextDirection.rtl,
  home: MyApp(),
)
```

## 🧪 测试

### 单元测试

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  testWidgets('ZephyrButton 点击测试', (WidgetTester tester) async {
    bool clicked = false;
    
    await tester.pumpWidget(
      MaterialApp(
        home: ZephyrButton(
          onPressed: () {
            clicked = true;
          },
          child: Text('测试按钮'),
        ),
      ),
    );
    
    await tester.tap(find.byType(ZephyrButton));
    await tester.pump();
    
    expect(clicked, true);
  });
}
```

### 组件测试

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

void main() {
  group('ZephyrInput 组件测试', () {
    testWidgets('输入框输入测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ZephyrInput(
              placeholder: '请输入内容',
            ),
          ),
        ),
      );
      
      await tester.enterText(find.byType(ZephyrInput), 'Hello World');
      await tester.pump();
      
      expect(find.text('Hello World'), findsOneWidget);
    });
  });
}
```

## 📊 性能优化

### 使用 const 构造函数

```dart
// 好的做法
const ZephyrButton(
  onPressed: null,
  child: Text('按钮'),
)

// 不好的做法
ZephyrButton(
  onPressed: null,
  child: Text('按钮'),
)
```

### 使用 RepaintBoundary

```dart
RepaintBoundary(
  child: ZephyrCard(
    child: _buildComplexContent(),
  ),
)
```

### 懒加载

```dart
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return LazyLoadingWidget(
      child: ZephyrListItem(
        title: '项目 $index',
      ),
    );
  },
)
```

## 🤝 贡献

我们欢迎所有形式的贡献！请阅读 [贡献指南](./zh-CN/guide/contributing) 了解如何参与项目开发。

### 开发环境设置

```bash
# 克隆项目
git clone https://github.com/Agions/zephyr-ui.git
cd zephyr-ui

# 安装依赖
flutter pub get

# 运行测试
flutter test

# 启动示例应用
cd example
flutter run
```

## 📄 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](../LICENSE) 文件。

## 📞 联系我们

- **GitHub Issues**: [报告问题](https://github.com/Agions/zephyr-ui/issues)
- **Discussions**: [技术讨论](https://github.com/Agions/zephyr-ui/discussions)
- **Email**: [contact@agions.com](mailto:contact@agions.com)

## 🙏 致谢

感谢以下开源项目和贡献者：

- [Flutter](https://flutter.dev/) - Google 的 UI 工具包
- [Material Design](https://material.io/) - Google 的设计系统
- [VitePress](https://vitepress.dev/) - 现代化文档网站生成器

---

<div align="center">

**Made with ❤️ by Agions**

[![GitHub](https://img.shields.io/github/followers/Agions?style=social)](https://github.com/Agions)
[![Twitter](https://img.shields.io/twitter/follow/Agions?style=social)](https://twitter.com/Agions)

</div>