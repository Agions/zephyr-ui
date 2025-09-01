import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// Color Picker Component
/// 
/// A comprehensive color picker component with multiple color selection modes,
/// preset colors, and custom color selection for enterprise applications.
class ZephyrColorPicker extends StatefulWidget {
  final Color? initialColor;
  final void Function(Color)? onColorChanged;
  final List<Color> presetColors;
  final bool enableAlpha;
  final bool showPreview;
  final bool enableCustomInput;
  final ZephyrColorPickerTheme theme;
  final bool enabled;
  final String? label;
  final String? hintText;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final bool showEyeDropper;
  final bool showHistory;
  final List<Color> historyColors;
  final int maxHistoryColors;
  final bool enableKeyboardShortcuts;
  final String? semanticLabel;
  final String? semanticHint;

  const ZephyrColorPicker({
    Key? key,
    this.initialColor,
    this.onColorChanged,
    this.presetColors = const [
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
    ],
    this.enableAlpha = true,
    this.showPreview = true,
    this.enableCustomInput = true,
    required this.theme,
    this.enabled = true,
    this.label,
    this.hintText,
    this.width,
    this.height,
    this.margin,
    this.showEyeDropper = false,
    this.showHistory = true,
    this.historyColors = const [],
    this.maxHistoryColors = 10,
    this.enableKeyboardShortcuts = true,
    this.semanticLabel,
    this.semanticHint,
  }) : super(key: key);

  @override
  State<ZephyrColorPicker> createState() => _ZephyrColorPickerState();
}

class _ZephyrColorPickerState extends State<ZephyrColorPicker> {
  late Color _selectedColor;
  late TextEditingController _hexController;
  late FocusNode _focusNode;
  List<Color> _historyColors = [];

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor ?? Colors.blue;
    _hexController = TextEditingController(text: _colorToHex(_selectedColor));
    _focusNode = FocusNode();
    _historyColors = List<Color>.from(widget.historyColors);
  }

  @override
  void dispose() {
    _hexController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _colorToHex(Color color) {
    if (widget.enableAlpha) {
      return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    } else {
      return '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
    }
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    } else if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    } else {
      return _selectedColor;
    }
  }

  void _onColorChanged(Color color) {
    setState(() {
      _selectedColor = color;
      _hexController.text = _colorToHex(color);
    });

    // Add to history
    if (!_historyColors.contains(color)) {
      setState(() {
        _historyColors.insert(0, color);
        if (_historyColors.length > widget.maxHistoryColors) {
          _historyColors = _historyColors.take(widget.maxHistoryColors).toList();
        }
      });
    }

    widget.onColorChanged?.call(color);
  }

  void _onHexChanged(String value) {
    if (value.isEmpty) return;
    
    try {
      final color = _hexToColor(value);
      _onColorChanged(color);
    } catch (e) {
      // Invalid hex format, ignore
    }
  }

  Widget _buildColorPreview() {
    if (!widget.showPreview) return const SizedBox.shrink();

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: _selectedColor,
        borderRadius: BorderRadius.circular(widget.theme.previewBorderRadius),
        border: Border.all(
          color: widget.theme.previewBorderColor,
          width: widget.theme.previewBorderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.theme.shadowColor,
            blurRadius: widget.theme.shadowBlurRadius,
            offset: widget.theme.shadowOffset,
          ),
        ],
      ),
      child: widget.enableAlpha && _selectedColor.a < 255
          ? CustomPaint(
              painter: AlphaCheckerPainter(),
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.circular(widget.theme.previewBorderRadius),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildPresetColors() {
    return Wrap(
      spacing: widget.theme.presetColorSpacing,
      runSpacing: widget.theme.presetColorSpacing,
      children: widget.presetColors.map((color) {
        final isSelected = color == _selectedColor;
        return GestureDetector(
          onTap: widget.enabled ? () => _onColorChanged(color) : null,
          child: Container(
            width: widget.theme.presetColorSize,
            height: widget.theme.presetColorSize,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(widget.theme.presetColorBorderRadius),
              border: Border.all(
                color: isSelected
                    ? widget.theme.selectedBorderColor
                    : widget.theme.presetColorBorderColor,
                width: isSelected
                    ? widget.theme.selectedBorderWidth
                    : widget.theme.presetColorBorderWidth,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: widget.theme.selectedBorderColor.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHistoryColors() {
    if (!widget.showHistory || _historyColors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Colors',
          style: widget.theme.labelStyle,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: widget.theme.historyColorSpacing,
          runSpacing: widget.theme.historyColorSpacing,
          children: _historyColors.map((color) {
            return GestureDetector(
              onTap: widget.enabled ? () => _onColorChanged(color) : null,
              child: Container(
                width: widget.theme.historyColorSize,
                height: widget.theme.historyColorSize,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(widget.theme.historyColorBorderRadius),
                  border: Border.all(
                    color: widget.theme.historyColorBorderColor,
                    width: widget.theme.historyColorBorderWidth,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorInput() {
    if (!widget.enableCustomInput) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText ?? 'Hex Color',
          style: widget.theme.labelStyle,
        ),
        const SizedBox(height: 8),
        ZephyrInput(
          controller: _hexController,
          onChanged: _onHexChanged,
          enabled: widget.enabled,
          placeholder: '#RRGGBB${widget.enableAlpha ? 'AA' : ''}',
          prefix: const Icon(Icons.tag),
          theme: widget.theme.inputTheme,
        ),
      ],
    );
  }

  Widget _buildColorSliders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RGB Values',
          style: widget.theme.labelStyle,
        ),
        const SizedBox(height: 8),
        _buildSlider('Red', _selectedColor.r.toDouble(), (value) {
          _onColorChanged(Color.from(
            red: value,
            green: _selectedColor.g.toDouble(),
            blue: _selectedColor.b.toDouble(),
            alpha: _selectedColor.a.toDouble(),
          ));
        }, 0, 255, Colors.red),
        const SizedBox(height: 8),
        _buildSlider('Green', _selectedColor.g.toDouble(), (value) {
          _onColorChanged(Color.from(
            red: _selectedColor.r.toDouble(),
            green: value,
            blue: _selectedColor.b.toDouble(),
            alpha: _selectedColor.a.toDouble(),
          ));
        }, 0, 255, Colors.green),
        const SizedBox(height: 8),
        _buildSlider('Blue', _selectedColor.b.toDouble(), (value) {
          _onColorChanged(Color.from(
            red: _selectedColor.r.toDouble(),
            green: _selectedColor.g.toDouble(),
            blue: value,
            alpha: _selectedColor.a.toDouble(),
          ));
        }, 0, 255, Colors.blue),
        if (widget.enableAlpha) ...[
          const SizedBox(height: 8),
          _buildSlider('Alpha', _selectedColor.a.toDouble(), (value) {
            _onColorChanged(Color.from(
              red: _selectedColor.r.toDouble(),
              green: _selectedColor.g.toDouble(),
              blue: _selectedColor.b.toDouble(),
              alpha: value,
            ));
          }, 0, 255, Colors.grey),
        ],
      ],
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged,
      double min, double max, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            label,
            style: widget.theme.sliderLabelStyle,
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            onChanged: widget.enabled ? onChanged : null,
            min: min,
            max: max,
            activeColor: color,
            inactiveColor: color.withValues(alpha: 0.3),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.round().toString(),
            style: widget.theme.sliderValueStyle,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        borderRadius: BorderRadius.circular(widget.theme.borderRadius),
        border: Border.all(
          color: widget.theme.borderColor,
          width: widget.theme.borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.theme.shadowColor,
            blurRadius: widget.theme.shadowBlurRadius,
            offset: widget.theme.shadowOffset,
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: widget.theme.contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: widget.theme.labelStyle,
              ),
              const SizedBox(height: 16),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildColorPreview(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildColorInput(),
                      const SizedBox(height: 16),
                      _buildColorSliders(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPresetColors(),
            const SizedBox(height: 16),
            _buildHistoryColors(),
          ],
        ),
      ),
    );
  }
}

enum ColorMode { rgb, hsv, hsl }

class AlphaCheckerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final squareSize = size.width / 8;

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        paint.color = (i + j) % 2 == 0 ? Colors.grey[300]! : Colors.grey[100]!;
        canvas.drawRect(
          Rect.fromLTWH(i * squareSize, j * squareSize, squareSize, squareSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}