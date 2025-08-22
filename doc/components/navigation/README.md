# 导航组件

ZephyrUI 导航组件提供了一套完整的导航解决方案，帮助用户在应用中轻松导航。

## 组件列表

- [ZephyrTabs](tabs.md) - 选项卡导航
- [ZephyrStepper](stepper.md) - 步骤器
- [ZephyrBreadcrumb](breadcrumb.md) - 面包屑导航
- [ZephyrPagination](pagination.md) - 分页组件
- [ZephyrBottomNavigationBar](bottom_navigation_bar.md) - 底部导航栏
- [ZephyrSideMenu](side_menu.md) - 侧边菜单
- [ZephyrNavigationRail](navigation_rail.md) - 导航栏
- [ZephyrTour](tour.md) - 引导游览

## 使用示例

```dart
import 'package:zephyr_ui/zephyr_ui.dart';

class NavigationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZephyrTabs(
      tabs: [
        ZephyrTab(
          title: '首页',
          icon: Icons.home,
          content: const HomeContent(),
        ),
        ZephyrTab(
          title: '设置',
          icon: Icons.settings,
          content: const SettingsContent(),
        ),
      ],
    );
  }
}
```