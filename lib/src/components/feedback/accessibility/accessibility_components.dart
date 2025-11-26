import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 可访问性配置类
class ZephyrAccessibilityConfig {
  final Set<ZephyrAccessibilityFeature> enabledFeatures;
  final double textScaleFactor;
  final double minTouchTargetSize;
  final Color focusColor;
  final double focusBorderWidth;
  final bool highContrast;
  final bool reduceMotion;

  const ZephyrAccessibilityConfig({
    this.enabledFeatures = const {},
    this.textScaleFactor = 1.0,
    this.minTouchTargetSize = 44.0,
    this.focusColor = Colors.blue,
    this.focusBorderWidth = 2.0,
    this.highContrast = false,
    this.reduceMotion = false,
  });

  ZephyrAccessibilityConfig copyWith({
    Set<ZephyrAccessibilityFeature>? enabledFeatures,
    double? textScaleFactor,
    double? minTouchTargetSize,
    Color? focusColor,
    double? focusBorderWidth,
    bool? highContrast,
    bool? reduceMotion,
  }) {
    return ZephyrAccessibilityConfig(
      enabledFeatures: enabledFeatures ?? this.enabledFeatures,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      minTouchTargetSize: minTouchTargetSize ?? this.minTouchTargetSize,
      focusColor: focusColor ?? this.focusColor,
      focusBorderWidth: focusBorderWidth ?? this.focusBorderWidth,
      highContrast: highContrast ?? this.highContrast,
      reduceMotion: reduceMotion ?? this.reduceMotion,
    );
  }
}

/// 可访问性输入框
class ZephyrAccessibleInput extends StatefulWidget {
  const ZephyrAccessibleInput({
    super.key,
    this.labelText,
    this.placeholder,
    this.required = false,
    this.controller,
    this.keyboardType,
    this.accessibilityConfig,
    this.validator,
    this.focusNode,
    this.onSubmitted,
  });

  final String? labelText;
  final String? placeholder;
  final bool required;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ZephyrAccessibleInputConfig? accessibilityConfig;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;

  @override
  State<ZephyrAccessibleInput> createState() => _ZephyrAccessibleInputState();
}

class _ZephyrAccessibleInputState extends State<ZephyrAccessibleInput> {
  late TextEditingController _controller;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    widget.focusNode?.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = widget.focusNode?.hasFocus ?? false;
    });
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.labelText ?? widget.placeholder ?? '',
      hint: widget.placeholder,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Text(
              widget.labelText!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          TextFormField(
            controller: _controller,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _hasFocus ? Theme.of(context).colorScheme.primary : Colors.grey,
                  width: _hasFocus ? 2.0 : 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 可访问性输入框配置
class ZephyrAccessibleInputConfig {
  final String? semanticLabel;
  final String? semanticHint;
  final bool enableLiveValidation;
  final bool showCharacterCount;

  const ZephyrAccessibleInputConfig({
    this.semanticLabel,
    this.semanticHint,
    this.enableLiveValidation = false,
    this.showCharacterCount = false,
  });
}

/// 可访问性密码输入框
class ZephyrAccessiblePasswordInput extends StatefulWidget {
  final String? labelText;
  final String? placeholder;
  final bool required;
  final TextEditingController? controller;
  final bool showPasswordStrength;
  final String? Function(String?)? validator;

  const ZephyrAccessiblePasswordInput({
    super.key,
    this.labelText,
    this.placeholder,
    this.required = false,
    this.controller,
    this.showPasswordStrength = false,
    this.validator,
  });

  @override
  State<ZephyrAccessiblePasswordInput> createState() => _ZephyrAccessiblePasswordInputState();
}

class _ZephyrAccessiblePasswordInputState extends State<ZephyrAccessiblePasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.labelText ?? widget.placeholder ?? '密码输入框',
      hint: widget.placeholder,
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Text(
              widget.labelText!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              suffixIcon: IconButton(
                icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                tooltip: _obscureText ? '显示密码' : '隐藏密码',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 可访问性按钮
class ZephyrAccessibleButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final String? hint;
  final ZephyrButtonType type;

  const ZephyrAccessibleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.semanticLabel,
    this.hint,
    this.type = ZephyrButtonType.filled,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      hint: hint,
      button: true,
      enabled: onPressed != null,
      child: () {
        switch (type) {
          case ZephyrButtonType.filled:
            return ElevatedButton(
              onPressed: onPressed,
              child: _buildButtonContent(),
            );
          case ZephyrButtonType.text:
            return TextButton(
              onPressed: onPressed,
              child: _buildButtonContent(),
            );
          case ZephyrButtonType.outlined:
            return OutlinedButton(
              onPressed: onPressed,
              child: _buildButtonContent(),
            );
          case ZephyrButtonType.icon:
            return IconButton(
              onPressed: onPressed,
              icon: _buildButtonContent(),
            );
          case ZephyrButtonType.fab:
            return FloatingActionButton(
              onPressed: onPressed,
              child: _buildButtonContent(),
            );
        }
      }(),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );
  }
}


/// 可访问性复选框
class ZephyrAccessibleCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const ZephyrAccessibleCheckbox({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      checked: value,
      enabled: onChanged != null,
      child: CheckboxListTile(
        title: Text(label),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

/// 可访问性开关
class ZephyrAccessibleSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const ZephyrAccessibleSwitch({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      checked: value,
      enabled: onChanged != null,
      child: SwitchListTile(
        title: Text(label),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

/// 可访问性图片
class ZephyrAccessibleImage extends StatelessWidget {
  final Widget child;
  final String description;

  const ZephyrAccessibleImage({
    super.key,
    required this.child,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: description,
      image: true,
      child: ExcludeSemantics(
        child: child,
      ),
    );
  }
}

/// 可访问性包装器
class ZephyrAccessibilityWrapper extends StatelessWidget {
  final Widget child;
  final ZephyrAccessibilityWrapperConfig config;
  final bool isInteractive;

  const ZephyrAccessibilityWrapper({
    super.key,
    required this.child,
    required this.config,
    this.isInteractive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: config.semanticData?.label,
      hint: config.semanticData?.hint,
      button: isInteractive,
      link: isInteractive,
      enabled: isInteractive,
      child: child,
    );
  }
}

/// 可访问性包装器配置
class ZephyrAccessibilityWrapperConfig {
  final ZephyrSemanticData? semanticData;

  const ZephyrAccessibilityWrapperConfig({
    this.semanticData,
  });
}

/// 语义化数据
class ZephyrSemanticData {
  final String label;
  final String? hint;

  const ZephyrSemanticData({
    required this.label,
    this.hint,
  });
}