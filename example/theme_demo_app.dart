/// ZephyrUI 主题演示应用
/// 
/// 展示主题系统的各种功能和特性
import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ThemeDemoApp());
}

class ThemeDemoApp extends StatelessWidget {
  const ThemeDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeDemoNotifier(),
      child: Consumer<ThemeDemoNotifier>(
        builder: (context, notifier, child) {
          return MaterialApp(
            title: 'ZephyrUI 主题演示',
            theme: notifier.currentTheme.toMaterialTheme(),
            darkTheme: notifier.darkTheme.toMaterialTheme(),
            themeMode: notifier.themeMode,
            home: const ThemeDemoHomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

/// 主题演示通知器
class ThemeDemoNotifier extends ChangeNotifier {
  ZephyrUnifiedThemeData _currentTheme = ZephyrUnifiedThemeData.light();
  ZephyrUnifiedThemeData _darkTheme = ZephyrUnifiedThemeData.dark();
  ThemeMode _themeMode = ThemeMode.system;

  ZephyrUnifiedThemeData get currentTheme => _currentTheme;
  ZephyrUnifiedThemeData get darkTheme => _darkTheme;
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLightTheme(ZephyrUnifiedThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void setDarkTheme(ZephyrUnifiedThemeData theme) {
    _darkTheme = theme;
    notifyListeners();
  }

  void applyPreset(String presetName) {
    final theme = ZephyrThemeConfigurations.createPresetTheme(presetName);
    _currentTheme = theme;
    notifyListeners();
  }

  void applyEnterpriseTheme(String themeName) {
    final theme = ZephyrThemeConfigurations.createEnterpriseTheme(themeName);
    _currentTheme = theme;
    notifyListeners();
  }

  void applySpecialTheme(String themeName) {
    final theme = ZephyrThemeConfigurations.createSpecialTheme(themeName);
    _currentTheme = theme;
    notifyListeners();
  }
}

/// 主题演示主页
class ThemeDemoHomePage extends StatefulWidget {
  const ThemeDemoHomePage({Key? key}) : super(key: key);

  @override
  State<ThemeDemoHomePage> createState() => _ThemeDemoHomePageState();
}

class _ThemeDemoHomePageState extends State<ThemeDemoHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ThemeOverviewPage(),
    const ThemePickerPage(),
    const ThemeCustomizerPage(),
    const ThemeToolsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI 主题系统'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => _showThemeModeDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareTheme(context),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: '概览',
          ),
          NavigationDestination(
            icon: Icon(Icons.palette),
            label: '选择',
          ),
          NavigationDestination(
            icon: Icons.tune),
            label: '定制',
          ),
          NavigationDestination(
            icon: Icon(Icons.build),
            label: '工具',
          ),
        ],
      ),
    );
  }

  void _showThemeModeDialog(BuildContext context) {
    final notifier = Provider.of<ThemeDemoNotifier>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('主题模式'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeModeOption(
              title: '浅色',
              icon: Icons.light_mode,
              selected: notifier.themeMode == ThemeMode.light,
              onTap: () {
                notifier.setThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
            _ThemeModeOption(
              title: '深色',
              icon: Icons.dark_mode,
              selected: notifier.themeMode == ThemeMode.dark,
              onTap: () {
                notifier.setThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            _ThemeModeOption(
              title: '跟随系统',
              icon: Icons.settings_brightness,
              selected: notifier.themeMode == ThemeMode.system,
              onTap: () {
                notifier.setThemeMode(ThemeMode.system);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareTheme(BuildContext context) {
    final notifier = Provider.of<ThemeDemoNotifier>(context, listen: false);
    ZephyrThemeTools.exporter.shareTheme(
      notifier.currentTheme,
      'zephyr_theme.json',
    );
  }
}

/// 主题模式选项
class _ThemeModeOption extends StatelessWidget {
  const _ThemeModeOption({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: selected ? const Icon(Icons.check) : null,
      selected: selected,
      onTap: onTap,
    );
  }
}

/// 主题概览页面
class ThemeOverviewPage extends StatelessWidget {
  const ThemeOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('当前主题信息'),
          _buildThemeInfo(context),
          const SizedBox(height: 24),
          _buildSectionTitle('颜色方案'),
          _buildColorScheme(context),
          const SizedBox(height: 24),
          _buildSectionTitle('文本样式'),
          _buildTextStyles(context),
          const SizedBox(height: 24),
          _buildSectionTitle('组件预览'),
          _buildComponentPreview(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildThemeInfo(BuildContext context) {
    final theme = Theme.of(context);
    final notifier = Provider.of<ThemeDemoNotifier>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('主题模式', notifier.themeMode.name),
            _buildInfoRow('亮度', theme.brightness.name),
            _buildInfoRow('主色', theme.colorScheme.primary.toString()),
            _buildInfoRow('次要色', theme.colorScheme.secondary.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildColorScheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorRow('主色', colorScheme.primary, colorScheme.onPrimary),
            _buildColorRow('次要色', colorScheme.secondary, colorScheme.onSecondary),
            _buildColorRow('第三色', colorScheme.tertiary, colorScheme.onTertiary),
            _buildColorRow('错误色', colorScheme.error, colorScheme.onError),
            _buildColorRow('表面色', colorScheme.surface, colorScheme.onSurface),
            _buildColorRow('表面变体', colorScheme.surfaceVariant, colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _buildColorRow(String label, Color color, Color onColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  color.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextStyles(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('显示大号', style: textTheme.displayLarge),
            Text('显示中号', style: textTheme.displayMedium),
            Text('显示小号', style: textTheme.displaySmall),
            const Divider(),
            Text('标题大号', style: textTheme.headlineLarge),
            Text('标题中号', style: textTheme.headlineMedium),
            Text('标题小号', style: textTheme.headlineSmall),
            const Divider(),
            Text('正文大号', style: textTheme.bodyLarge),
            Text('正文中号', style: textTheme.bodyMedium),
            Text('正文小号', style: textTheme.bodySmall),
            const Divider(),
            Text('标签大号', style: textTheme.labelLarge),
            Text('标签中号', style: textTheme.labelMedium),
            Text('标签小号', style: textTheme.labelSmall),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentPreview(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('按钮组件'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('主要按钮'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text('填充按钮'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('边框按钮'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('文本按钮'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('输入框组件'),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: '用户名',
                hintText: '请输入用户名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: '密码',
                hintText: '请输入密码',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility),
              ),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}

/// 主题选择页面
class ThemePickerPage extends StatelessWidget {
  const ThemePickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('主题选择'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '预设'),
              Tab(text: '企业'),
              Tab(text: '特殊'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPresetThemes(context),
            _buildEnterpriseThemes(context),
            _buildSpecialThemes(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetThemes(BuildContext context) {
    final presetNames = ZephyrThemeConfigurations.getPresetNames();
    final notifier = Provider.of<ThemeDemoNotifier>(context);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: presetNames.length,
      itemBuilder: (context, index) {
        final presetName = presetNames[index];
        final preset = ZephyrThemeConfigurations.presets[presetName]!;
        
        return _ThemeCard(
          title: preset.name,
          description: preset.description,
          colors: [preset.primaryColor, preset.secondaryColor],
          onTap: () {
            notifier.applyPreset(presetName);
          },
        );
      },
    );
  }

  Widget _buildEnterpriseThemes(BuildContext context) {
    final themeNames = ZephyrThemeConfigurations.getEnterpriseThemeNames();
    final notifier = Provider.of<ThemeDemoNotifier>(context);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: themeNames.length,
      itemBuilder: (context, index) {
        final themeName = themeNames[index];
        final theme = ZephyrThemeConfigurations.enterpriseThemes[themeName]!;
        
        return _ThemeCard(
          title: theme.name,
          description: theme.description,
          colors: [theme.primaryColor, theme.secondaryColor, theme.accentColor],
          onTap: () {
            notifier.applyEnterpriseTheme(themeName);
          },
        );
      },
    );
  }

  Widget _buildSpecialThemes(BuildContext context) {
    final themeNames = ZephyrThemeConfigurations.getSpecialThemeNames();
    final notifier = Provider.of<ThemeDemoNotifier>(context);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: themeNames.length,
      itemBuilder: (context, index) {
        final themeName = themeNames[index];
        final theme = ZephyrThemeConfigurations.specialThemes[themeName]!;
        
        return _ThemeCard(
          title: theme.name,
          description: theme.description,
          colors: [Theme.of(context).colorScheme.primary],
          onTap: () {
            notifier.applySpecialTheme(themeName);
          },
        );
      },
    );
  }
}

/// 主题卡片
class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.title,
    required this.description,
    required this.colors,
    required this.onTap,
  });

  final String title;
  final String description;
  final List<Color> colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: colors
                    .map((color) => Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 主题定制页面
class ThemeCustomizerPage extends StatefulWidget {
  const ThemeCustomizerPage({Key? key}) : super(key: key);

  @override
  State<ThemeCustomizerPage> createState() => _ThemeCustomizerPageState();
}

class _ThemeCustomizerPageState extends State<ThemeCustomizerPage> {
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.green;
  String _fontFamily = 'Roboto';
  double _fontSize = 16.0;
  double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主题定制'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTheme,
          ),
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: _previewTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColorSection(),
            const SizedBox(height: 24),
            _buildTypographySection(),
            const SizedBox(height: 24),
            _buildSpacingSection(),
            const SizedBox(height: 24),
            _buildPreviewSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '颜色设置',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildColorPicker('主色', _primaryColor, (color) {
              setState(() {
                _primaryColor = color;
              });
            }),
            const SizedBox(height: 16),
            _buildColorPicker('次要色', _secondaryColor, (color) {
              setState(() {
                _secondaryColor = color;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker(String label, Color color, Function(Color) onColorChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(label),
        ),
        GestureDetector(
          onTap: () async {
            final selectedColor = await showDialog<Color>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('选择$label'),
                content: SizedBox(
                  width: 300,
                  height: 400,
                  child: _ColorPickerGrid(
                    selectedColor: color,
                    onColorSelected: onColorChanged,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('取消'),
                  ),
                ],
              ),
            );
            if (selectedColor != null) {
              onColorChanged(selectedColor);
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypographySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '字体设置',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildFontFamilySelector(),
            const SizedBox(height: 16),
            _buildFontSizeSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildFontFamilySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('字体家族'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            'Roboto',
            'Open Sans',
            'Lato',
            'Montserrat',
            'Poppins',
          ].map((font) {
            return ChoiceChip(
              label: Text(font),
              selected: _fontFamily == font,
              onSelected: (selected) {
                setState(() {
                  _fontFamily = font;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFontSizeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('基础字体大小: ${_fontSize.toStringAsFixed(1)}px'),
        Slider(
          value: _fontSize,
          min: 12.0,
          max: 24.0,
          divisions: 12,
          onChanged: (value) {
            setState(() {
              _fontSize = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSpacingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '间距设置',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('基础间距: ${_spacing.toStringAsFixed(1)}px'),
            Slider(
              value: _spacing,
              min: 8.0,
              max: 32.0,
              divisions: 12,
              onChanged: (value) {
                setState(() {
                  _spacing = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '实时预览',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(_spacing),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).colorScheme.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '示例标题',
                    style: TextStyle(
                      fontSize: _fontSize * 1.5,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: _spacing / 2),
                  Text(
                    '这是一段示例文本，用于预览字体和间距效果。',
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: _spacing),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: ZephyrThemeUtils.getContrastColor(_primaryColor),
                    ),
                    child: const Text('示例按钮'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTheme() {
    final notifier = Provider.of<ThemeDemoNotifier>(context, listen: false);
    final customTheme = ZephyrUnifiedThemeData.light(
      primaryColor: _primaryColor,
      secondaryColor: _secondaryColor,
      fontFamily: _fontFamily,
    );
    
    notifier.setLightTheme(customTheme);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('主题已保存'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _previewTheme() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 400,
          height: 600,
          padding: const EdgeInsets.all(16),
          child: Theme(
            data: ZephyrUnifiedThemeData.light(
              primaryColor: _primaryColor,
              secondaryColor: _secondaryColor,
              fontFamily: _fontFamily,
            ).toMaterialTheme(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '主题预览',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 16),
                const Text('标题示例', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                const Text('正文示例，这是一段示例文本。'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('按钮示例'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 颜色选择器网格
class _ColorPickerGrid extends StatelessWidget {
  const _ColorPickerGrid({
    required this.selectedColor,
    required this.onColorSelected,
  });

  final Color selectedColor;
  final Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        return GestureDetector(
          onTap: () {
            onColorSelected(color);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selectedColor == color ? Colors.black : Colors.transparent,
                width: 3,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 主题工具页面
class ThemeToolsPage extends StatelessWidget {
  const ThemeToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('主题验证'),
          _buildThemeValidator(context),
          const SizedBox(height: 24),
          _buildSectionTitle('主题分析'),
          _buildThemeAnalyzer(context),
          const SizedBox(height: 24),
          _buildSectionTitle('主题生成'),
          _buildThemeGenerator(context),
          const SizedBox(height: 24),
          _buildSectionTitle('导出/导入'),
          _buildThemeExporter(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildThemeValidator(BuildContext context) {
    final notifier = Provider.of<ThemeDemoNotifier>(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('验证当前主题'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final result = ZephyrThemeTools.validator.validate(notifier.currentTheme);
                _showValidationResult(context, result);
              },
              child: const Text('开始验证'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeAnalyzer(BuildContext context) {
    final notifier = Provider.of<ThemeDemoNotifier>(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('分析当前主题'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final result = ZephyrThemeTools.analyzer.analyze(notifier.currentTheme);
                _showAnalysisResult(context, result);
              },
              child: const Text('开始分析'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeGenerator(BuildContext context) {
    final notifier = Provider.of<ThemeDemoNotifier>(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('生成随机主题'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final randomTheme = ZephyrThemeTools.generator.generateRandomTheme();
                      notifier.setLightTheme(randomTheme);
                    },
                    child: const Text('生成随机主题'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final fromColorTheme = ZephyrThemeTools.generator.generateFromColor(Colors.purple);
                      notifier.setLightTheme(fromColorTheme);
                    },
                    child: const Text('从颜色生成'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeExporter(BuildContext context) {
    final notifier = Provider.of<ThemeDemoNotifier>(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('导出/导入主题'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ZephyrThemeTools.exporter.shareTheme(
                      notifier.currentTheme,
                      'zephyr_theme.json',
                    );
                  },
                  child: const Text('分享主题'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showExportDialog(context, notifier.currentTheme);
                  },
                  child: const Text('导出配置'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showImportDialog(context);
                  },
                  child: const Text('导入配置'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showValidationResult(BuildContext context, ZephyrThemeValidationResult result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result.isValid ? '验证通过' : '验证失败'),
        content: SizedBox(
          width: 400,
          height: 300,
          child: result.issues.isEmpty
              ? const Center(child: Text('主题配置正确！'))
              : ListView.builder(
                  itemCount: result.issues.length,
                  itemBuilder: (context, index) {
                    final issue = result.issues[index];
                    return ListTile(
                      leading: Icon(
                        issue.type == ZephyrThemeValidationType.error
                            ? Icons.error
                            : issue.type == ZephyrThemeValidationType.warning
                                ? Icons.warning
                                : Icons.info,
                        color: issue.type == ZephyrThemeValidationType.error
                            ? Colors.red
                            : issue.type == ZephyrThemeValidationType.warning
                                ? Colors.orange
                                : Colors.blue,
                      ),
                      title: Text(issue.message),
                      subtitle: Text(issue.suggestion),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showAnalysisResult(BuildContext context, ZephyrThemeAnalysisResult result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('主题分析结果'),
        content: SizedBox(
          width: 400,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnalysisRow('亮度模式', result.brightness.name),
                _buildAnalysisRow('颜色数量', result.colorCount.toString()),
                _buildAnalysisRow('字体家族', result.fontFamilies.join(', ')),
                _buildAnalysisRow('对比度', result.contrastRatio.toStringAsFixed(2)),
                _buildAnalysisRow('可访问性评分', '${(result.accessibilityScore * 100).toStringAsFixed(1)}%'),
                const SizedBox(height: 16),
                const Text('建议：', style: TextStyle(fontWeight: FontWeight.bold)),
                ...result.recommendations.map((rec) => Text('• $rec')),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context, ZephyrUnifiedThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('导出主题'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('JSON 格式'),
              onTap: () {
                final json = ZephyrThemeTools.exporter.toJson(theme);
                _copyToClipboard(context, json);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dart 代码'),
              onTap: () {
                final dart = ZephyrThemeTools.exporter.toDartCode(theme);
                _copyToClipboard(context, dart);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('CSS 变量'),
              onTap: () {
                final css = ZephyrThemeTools.exporter.toCss(theme);
                _copyToClipboard(context, css);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  void _showImportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('导入主题'),
        content: const Text('导入功能正在开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    // 这里需要实现剪贴板功能
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('已复制到剪贴板'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}