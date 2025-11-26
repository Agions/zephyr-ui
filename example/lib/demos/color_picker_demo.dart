import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// Color Picker Demo Page
///
/// Demonstrates the usage of the ZephyrColorPicker component
class ColorPickerDemo extends StatefulWidget {
  const ColorPickerDemo({Key? key}) : super(key: key);

  @override
  State<ColorPickerDemo> createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  Color _selectedColor = Colors.blue;
  List<Color> _historyColors = [];
  final List<Color> _customPresetColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.amber,
    Colors.indigo,
    Colors.teal,
    Colors.lime,
    Colors.brown,
    Colors.grey,
    Colors.black,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDemoSection(
              'Basic Color Picker',
              ZephyrColorPicker(
                initialColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                theme: ZephyrColorPickerTheme.light(),
                label: 'Select Color',
                hintText: 'Choose a color',
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Color Picker with Custom Presets',
              ZephyrColorPicker(
                initialColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                presetColors: _customPresetColors,
                theme: ZephyrColorPickerTheme.light(),
                label: 'Custom Presets',
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Color Picker with History',
              ZephyrColorPicker(
                initialColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                    if (!_historyColors.contains(color)) {
                      _historyColors.insert(0, color);
                      if (_historyColors.length > 10) {
                        _historyColors = _historyColors.take(10).toList();
                      }
                    }
                  });
                },
                historyColors: _historyColors,
                theme: ZephyrColorPickerTheme.light(),
                label: 'Color with History',
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Color Picker without Alpha',
              ZephyrColorPicker(
                initialColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                enableAlpha: false,
                theme: ZephyrColorPickerTheme.light(),
                label: 'No Alpha Channel',
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Color Picker without Custom Input',
              ZephyrColorPicker(
                initialColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                enableCustomInput: false,
                theme: ZephyrColorPickerTheme.light(),
                label: 'No Custom Input',
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Color Picker without Preview',
              ZephyrColorPicker(
                initialColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                showPreview: false,
                theme: ZephyrColorPickerTheme.light(),
                label: 'No Preview',
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Dark Theme Color Picker',
              const Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                child: ZephyrColorPicker(
                  initialColor: _selectedColor,
                  onColorChanged: (color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  theme: ZephyrColorPickerTheme.dark(),
                  label: 'Dark Theme',
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildDemoSection(
              'Disabled Color Picker',
              ZephyrColorPicker(
                initialColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                enabled: false,
                theme: ZephyrColorPickerTheme.light(),
                label: 'Disabled State',
              ),
            ),
            const SizedBox(height: 32),
            _buildColorInfo(),
            const SizedBox(height: 32),
            _buildColorUtilities(),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildColorInfo() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Color Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _selectedColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'HEX: ${ZephyrColorPickerUtils.toHex(_selectedColor)}'),
                      Text(
                          'RGB: ${_selectedColor.r}, ${_selectedColor.g}, ${_selectedColor.b}'),
                      Text('Alpha: ${_selectedColor.a}'),
                      Text(
                          'Name: ${ZephyrColorPickerUtils.getColorName(_selectedColor)}'),
                      Text(
                          'Temperature: ${ZephyrColorPickerUtils.getColorTemperature(_selectedColor)}'),
                      Text(
                          'Brightness: ${ZephyrColorPickerUtils.getBrightness(_selectedColor).toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorUtilities() {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color Utilities',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            _buildColorPalette(),
            SizedBox(height: 16),
            _buildColorHarmonies(),
            SizedBox(height: 16),
            _buildColorManipulation(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPalette() {
    final palette = ZephyrColorPickerUtils.generatePalette(_selectedColor, 8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color Palette'),
        const SizedBox(height: 8),
        Row(
          children: palette.map((color) {
            return Expanded(
              child: const Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorHarmonies() {
    final complementary =
        ZephyrColorPickerUtils.getComplementaryColors(_selectedColor);
    final triadic = ZephyrColorPickerUtils.getTriadicColors(_selectedColor);
    final analogous = ZephyrColorPickerUtils.getAnalogousColors(_selectedColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color Harmonies'),
        const SizedBox(height: 8),
        _buildColorRow('Complementary', complementary),
        const SizedBox(height: 8),
        _buildColorRow('Triadic', triadic),
        const SizedBox(height: 8),
        _buildColorRow('Analogous', analogous),
      ],
    );
  }

  Widget _buildColorRow(String label, List<Color> colors) {
    return Row(
      children: [
        const SizedBox(
          width: 100,
          child: Text(label),
        ),
        Expanded(
          child: Row(
            children: colors.map((color) {
              return Expanded(
                child: const Container(
                  height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildColorManipulation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color Manipulation'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor =
                      ZephyrColorPickerUtils.lighten(_selectedColor, 0.1);
                });
              },
              child: const Text('Lighten'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor =
                      ZephyrColorPickerUtils.darken(_selectedColor, 0.1);
                });
              },
              child: const Text('Darken'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor =
                      ZephyrColorPickerUtils.saturate(_selectedColor, 0.1);
                });
              },
              child: const Text('Saturate'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor =
                      ZephyrColorPickerUtils.desaturate(_selectedColor, 0.1);
                });
              },
              child: const Text('Desaturate'),
            ),
          ],
        ),
      ],
    );
  }
}
