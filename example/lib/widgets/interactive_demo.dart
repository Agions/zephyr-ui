import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeViewerDialog extends StatelessWidget {
  final String title;
  final String code;
  final String? language;

  const CodeViewerDialog({
    super.key,
    required this.title,
    required this.code,
    this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: code));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('代码已复制到剪贴板'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      tooltip: '复制代码',
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: '关闭',
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: SelectableText(
                    code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InteractiveDemoCard extends StatefulWidget {
  final String title;
  final String description;
  final Widget demo;
  final String code;
  final List<Widget> controls;
  final List<DemoOption> options;

  const InteractiveDemoCard({
    super.key,
    required this.title,
    required this.description,
    required this.demo,
    required this.code,
    this.controls = const [],
    this.options = const [],
  });

  @override
  State<InteractiveDemoCard> createState() => _InteractiveDemoCardState();
}

class _InteractiveDemoCardState extends State<InteractiveDemoCard> {
  Map<String, dynamic> _optionValues = {};

  @override
  void initState() {
    super.initState();
    for (final option in widget.options) {
      _optionValues[option.key] = option.defaultValue;
    }
  }

  void _updateOption(String key, dynamic value) {
    setState(() {
      _optionValues[key] = value;
    });
  }

  void _showCodeViewer() {
    showDialog(
      context: context,
      builder: (context) => CodeViewerDialog(
        title: widget.title,
        code: widget.code,
        language: 'dart',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.code),
                  onPressed: _showCodeViewer,
                  tooltip: '查看代码',
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.options.isNotEmpty) ...[
              const Text(
                '参数调整',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: widget.options.map((option) {
                  return _buildOptionControl(option);
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            const Text(
              '演示效果',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: widget.demo,
            ),
            if (widget.controls.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.controls,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOptionControl(DemoOption option) {
    switch (option.type) {
      case DemoOptionType.boolean:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(option.label),
            const SizedBox(width: 8),
            Switch(
              value: _optionValues[option.key] as bool,
              onChanged: (value) => _updateOption(option.key, value),
            ),
          ],
        );
      case DemoOptionType.string:
        return DropdownButton<String>(
          value: _optionValues[option.key] as String,
          items: (option.values as List<String>).map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              _updateOption(option.key, value);
            }
          },
        );
      case DemoOptionType.number:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(option.label),
            const SizedBox(width: 8),
            SizedBox(
              width: 80,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final number = double.tryParse(value);
                  if (number != null) {
                    _updateOption(option.key, number);
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ),
          ],
        );
      case DemoOptionType.color:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(option.label),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                final color = await showDialog<Color>(
                  context: context,
                  builder: (context) => const ColorPickerDialog(),
                );
                if (color != null) {
                  _updateOption(option.key, color);
                }
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _optionValues[option.key] as Color,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        );
    }
  }

  T getOptionValue<T>(String key) {
    return _optionValues[key] as T;
  }
}

class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red, Colors.blue, Colors.green, Colors.yellow,
      Colors.purple, Colors.orange, Colors.pink, Colors.teal,
    ];

    return Dialog(
      title: const Text('选择颜色'),
      child: SizedBox(
        width: 200,
        height: 200,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(colors[index]),
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

enum DemoOptionType {
  boolean,
  string,
  number,
  color,
}

class DemoOption {
  final String key;
  final String label;
  final DemoOptionType type;
  final dynamic defaultValue;
  final List<dynamic> values;

  const DemoOption({
    required this.key,
    required this.label,
    required this.type,
    required this.defaultValue,
    this.values = const [],
  });
}