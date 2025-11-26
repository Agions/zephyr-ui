import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'form_theme.dart';

/// Zephyr表单容器组件
///
/// 提供完整的表单功能，包括：
/// - 表单验证
/// - 状态管理
/// - 提交处理
/// - 重置功能
/// - 错误处理
///
/// 示例用法:
/// ```dart
/// ZephyrForm(
///   onSubmitted: (values) => debugPrint(values),
///   children: [
///     ZephyrFormItem(
///       label: '用户名',
///       child: ZephyrInput(
///         placeholder: '请输入用户名',
///         name: 'username',
///       ),
///     ),
///   ],
/// )
/// ```
class ZephyrForm extends StatefulWidget {
  /// 创建表单容器
  const ZephyrForm({
    required this.children,
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.initialValues,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.enabled = true,
    this.theme,
    this.labelWidth = 100,
    this.labelAlign = TextAlign.end,
    this.requiredMark = '*',
    this.showRequiredMark = true,
    this.itemSpacing = 16,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.borderRadius = 8,
    this.backgroundColor,
  });

  /// 表单项列表
  final List<Widget> children;

  /// 提交回调
  final Map<String, dynamic> Function(Map<String, dynamic>)? onSubmitted;

  /// 值变化回调
  final void Function(Map<String, dynamic>)? onChanged;

  /// 初始值
  final Map<String, dynamic>? initialValues;

  /// 自动验证模式
  final AutovalidateMode autovalidateMode;

  /// 是否启用
  final bool enabled;

  /// 主题
  final ZephyrFormTheme? theme;

  /// 标签宽度
  final double labelWidth;

  /// 标签对齐方式
  final TextAlign labelAlign;

  /// 必填标记
  final String requiredMark;

  /// 是否显示必填标记
  final bool showRequiredMark;

  /// 表单项间距
  final double itemSpacing;

  /// 内容内边距
  final EdgeInsetsGeometry contentPadding;

  /// 边框圆角
  final double borderRadius;

  /// 背景颜色
  final Color? backgroundColor;

  @override
  State<ZephyrForm> createState() => _ZephyrFormState();
}

class _ZephyrFormState extends State<ZephyrForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _values = {};
  final Map<String, String?> _errors = {};
  final Map<String, bool> _touched = {};
  final Map<String, bool> _required = {};

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  void _initializeValues() {
    if (widget.initialValues != null) {
      _values.addAll(widget.initialValues!);
    }
  }

  /// 更新表单值
  void updateValue(String name, dynamic value) {
    setState(() {
      _values[name] = value;
      _touched[name] = true;

      if (widget.onChanged != null) {
        widget.onChanged!(_values);
      }
    });
  }

  /// 更新错误信息
  void updateError(String name, String? error) {
    setState(() {
      _errors[name] = error;
    });
  }

  /// 设置字段是否必填
  void setRequired(String name, bool required) {
    setState(() {
      _required[name] = required;
    });
  }

  /// 验证表单
  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  /// 提交表单
  void submit() {
    if (validate()) {
      if (widget.onSubmitted != null) {
        widget.onSubmitted!(_values);
      }
    }
  }

  /// 重置表单
  void reset() {
    _formKey.currentState?.reset();
    setState(() {
      _values.clear();
      _errors.clear();
      _touched.clear();
      _required.clear();
      _initializeValues();
    });
  }

  /// 获取表单值
  Map<String, dynamic> get values => Map.unmodifiable(_values);

  /// 获取错误信息
  Map<String, String?> get errors => Map.unmodifiable(_errors);

  /// 检查字段是否被触摸过
  bool isTouched(String name) => _touched[name] ?? false;

  /// 检查字段是否必填
  bool isRequired(String name) => _required[name] ?? false;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrFormTheme.resolve(context, widget.theme);

    return ZephyrFormProvider(
      state: this,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? effectiveTheme.backgroundColor,
          borderRadius: const BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: effectiveTheme.borderColor,
            width: effectiveTheme.borderWidth,
          ),
        ),
        padding: widget.contentPadding,
        child: Form(
          key: _formKey,
          autovalidateMode: widget.autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.children.expand((child) => [
                    child,
                    if (child != widget.children.last)
                      SizedBox(height: widget.itemSpacing),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

/// 表单状态提供者
class ZephyrFormProvider extends InheritedWidget {
  const ZephyrFormProvider({
    required this.state,
    required super.child,
    super.key,
  });

  /// 表单状态
  final _ZephyrFormState state;

  /// 获取表单状态
  static _ZephyrFormState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ZephyrFormProvider>()
        ?.state;
  }

  @override
  bool updateShouldNotify(ZephyrFormProvider oldWidget) {
    return state != oldWidget.state;
  }
}
