import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/theme_service.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化主题服务
  final themeService = ThemeService();
  await themeService._loadThemePreferences();

  runApp(
    ChangeNotifierProvider.value(
      value: themeService,
      child: const ZephyrUIDemoApp(),
    ),
  );
}

class ZephyrUIDemoApp extends StatelessWidget {
  const ZephyrUIDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return MaterialApp(
      title: 'ZephyrUI 组件库演示',
      debugShowCheckedModeBanner: false,
      theme: themeService.getTheme(context),
      darkTheme: themeService.getTheme(context),
      themeMode: themeService.themeMode,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.getRoutes(),
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('页面不存在'),
            ),
            body: const Center(
              child: Text('您访问的页面不存在'),
            ),
          ),
        );
      },
    );
  }
}
