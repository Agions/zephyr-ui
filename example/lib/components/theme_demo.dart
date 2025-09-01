import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ThemeDemo extends StatefulWidget {
  const ThemeDemo({Key? key}) : super(key: key);

  @override
  _ThemeDemoState createState() => _ThemeDemoState();
}

class _ThemeDemoState extends State<ThemeDemo> {
  bool _isDarkMode = false;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _borderRadius = 8.0;
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主题定制演示'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '主题配置',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 主题切换
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
                        const SizedBox(width: 8),
                        const Text(
                          '主题模式',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Switch(
                          value: _isDarkMode,
                          onChanged: (value) => setState(() => _isDarkMode = value),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isDarkMode ? '深色主题' : '浅色主题',
                      style: TextStyle(
                        color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '颜色配置',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 主要颜色选择
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '主要颜色',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      children: [
                        _buildColorOption(Colors.blue, '蓝色'),
                        _buildColorOption(Colors.green, '绿色'),
                        _buildColorOption(Colors.purple, '紫色'),
                        _buildColorOption(Colors.orange, '橙色'),
                        _buildColorOption(Colors.red, '红色'),
                        _buildColorOption(Colors.teal, '青色'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 次要颜色选择
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '次要颜色',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      children: [
                        _buildSecondaryColorOption(Colors.grey, '灰色'),
                        _buildSecondaryColorOption(Colors.blueGrey, '蓝灰'),
                        _buildSecondaryColorOption(Colors.brown, '棕色'),
                        _buildSecondaryColorOption(Colors.indigo, '靛蓝'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '形状配置',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 圆角配置
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          '圆角大小',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text('${_borderRadius.round()}px'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _borderRadius,
                      min: 0,
                      max: 24,
                      divisions: 24,
                      onChanged: (value) => setState(() => _borderRadius = value),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBorderRadiusPreview(0),
                        _buildBorderRadiusPreview(8),
                        _buildBorderRadiusPreview(16),
                        _buildBorderRadiusPreview(24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 字体大小配置
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          '字体大小',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text('${_fontSize.round()}px'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _fontSize,
                      min: 12,
                      max: 24,
                      divisions: 12,
                      onChanged: (value) => setState(() => _fontSize = value),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '这是示例文本，展示字体大小效果',
                      style: TextStyle(fontSize: _fontSize),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              '预览效果',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 预览区域
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '主题预览',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // 按钮预览
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ZephyrButton(
                          text: '主要按钮',
                          backgroundColor: _primaryColor,
                          textColor: Colors.white,
                          borderRadius: _borderRadius,
                          onPressed: () {},
                        ),
                        ZephyrButton.outlined(
                          text: '次要按钮',
                          borderColor: _secondaryColor,
                          textColor: _secondaryColor,
                          borderRadius: _borderRadius,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 卡片预览
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isDarkMode ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(_borderRadius),
                        border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '卡片标题',
                            style: TextStyle(
                              fontSize: _fontSize + 2,
                              fontWeight: FontWeight.bold,
                              color: _isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '这是卡片内容，展示主题定制的效果。您可以看到颜色、圆角、字体大小等样式都根据您的设置进行了调整。',
                            style: TextStyle(
                              fontSize: _fontSize,
                              color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 图标预览
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ZephyrIcon(Icons.home, size: 24, color: _primaryColor),
                        ZephyrIcon(Icons.search, size: 24, color: _secondaryColor),
                        ZephyrIcon(Icons.favorite, size: 24, color: Colors.red),
                        ZephyrIcon(Icons.settings, size: 24, color: _primaryColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // 重置和应用按钮
            Row(
              children: [
                Expanded(
                  child: ZephyrButton.outlined(
                    text: '重置为默认',
                    onPressed: _resetToDefault,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ZephyrButton(
                    text: '应用主题',
                    onPressed: _applyTheme,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color, String label) {
    final isSelected = _primaryColor == color;
    
    return InkWell(
      onTap: () => setState(() => _primaryColor = color),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? color : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryColorOption(Color color, String label) {
    final isSelected = _secondaryColor == color;
    
    return InkWell(
      onTap: () => setState(() => _secondaryColor = color),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? color : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderRadiusPreview(double radius) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _primaryColor,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${radius.round()}px',
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  void _resetToDefault() {
    setState(() {
      _isDarkMode = false;
      _primaryColor = Colors.blue;
      _secondaryColor = Colors.grey;
      _borderRadius = 8.0;
      _fontSize = 16.0;
    });
  }

  void _applyTheme() {
    // 这里可以应用主题设置到整个应用
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('主题已应用'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}