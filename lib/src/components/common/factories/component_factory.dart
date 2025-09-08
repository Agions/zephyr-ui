import 'package:flutter/material.dart';
import '../interfaces/component_interfaces.dart';
import '../base/chroma_base_component.dart';

/// Component factory for creating chromaUI components
class chromaComponentFactory implements chromaComponentFactoryInterface {
  static final chromaComponentFactory _instance = chromaComponentFactory._internal();

  /// Singleton instance
  static chromaComponentFactory get instance => _instance;

  final Map<String, Widget Function(Map<String, dynamic>)> _componentBuilders = {};
  final Map<String, Map<String, dynamic>> _componentMetadata = {};

  chromaComponentFactory._internal();

  @override
  Widget createComponent(String componentType, Map<String, dynamic> config) {
    final builder = _componentBuilders[componentType];
    if (builder == null) {
      throw ArgumentError('Component type "$componentType" is not registered');
    }

    return builder(config);
  }

  @override
  void registerComponentType(String componentType, Widget Function(Map<String, dynamic>) builder) {
    _componentBuilders[componentType] = builder;
    _componentMetadata[componentType] = {
      'type': componentType,
      'registeredAt': DateTime.now().toIso8601String(),
    };
  }

  @override
  List<String> getRegisteredComponentTypes() {
    return _componentBuilders.keys.toList();
  }

  @override
  bool isComponentTypeRegistered(String componentType) {
    return _componentBuilders.containsKey(componentType);
  }

  @override
  Widget createComponentWithConfig(String componentType, chromaComponentConfig config) {
    return createComponent(componentType, {
      'config': config.toJson(),
    });
  }

  @override
  Map<String, dynamic>? getComponentMetadata(String componentType) {
    return _componentMetadata[componentType];
  }

  /// Register built-in components
  void registerBuiltInComponents() {
    // Register basic components
    _registerBasicComponents();
    // Register form components
    _registerFormComponents();
    // Register navigation components
    _registerNavigationComponents();
    // Register display components
    _registerDisplayComponents();
    // Register feedback components
    _registerFeedbackComponents();
    // Register layout components
    _registerLayoutComponents();
    // Register advanced components
    _registerAdvancedComponents();
  }

  void _registerBasicComponents() {
    // Register basic button component
    registerComponentType('button', (config) {
      return chromaButton(
        text: config['text'] ?? 'Button',
        onPressed: config['onPressed'],
        variant: config['variant'] ?? 'primary',
        size: config['size'] ?? 'medium',
        disabled: config['disabled'] ?? false,
        loading: config['loading'] ?? false,
        icon: config['icon'],
      );
    });

    // Register basic text component
    registerComponentType('text', (config) {
      return chromaText(
        text: config['text'] ?? '',
        style: config['style'],
        variant: config['variant'] ?? 'body',
        color: config['color'],
        textAlign: config['textAlign'],
        maxLines: config['maxLines'],
        overflow: config['overflow'],
      );
    });

    // Register basic card component
    registerComponentType('card', (config) {
      return chromaCard(
        title: config['title'],
        subtitle: config['subtitle'],
        content: config['content'],
        actions: config['actions'],
        elevation: config['elevation'] ?? 2,
        variant: config['variant'] ?? 'elevated',
        padding: config['padding'],
      );
    });
  }

  void _registerFormComponents() {
    // Register form input component
    registerComponentType('input', (config) {
      return chromaInput(
        label: config['label'],
        placeholder: config['placeholder'],
        value: config['value'],
        onChanged: config['onChanged'],
        validator: config['validator'],
        type: config['type'] ?? 'text',
        required: config['required'] ?? false,
        disabled: config['disabled'] ?? false,
        error: config['error'],
      );
    });

    // Register form select component
    registerComponentType('select', (config) {
      return chromaSelect(
        label: config['label'],
        value: config['value'],
        options: config['options'] ?? [],
        onChanged: config['onChanged'],
        placeholder: config['placeholder'],
        required: config['required'] ?? false,
        disabled: config['disabled'] ?? false,
        multiple: config['multiple'] ?? false,
      );
    });
  }

  void _registerNavigationComponents() {
    // Register navigation item component
    registerComponentType('nav_item', (config) {
      return chromaNavItem(
        title: config['title'] ?? '',
        icon: config['icon'],
        onTap: config['onTap'],
        selected: config['selected'] ?? false,
        disabled: config['disabled'] ?? false,
        badge: config['badge'],
      );
    });

    // Register breadcrumb component
    registerComponentType('breadcrumb', (config) {
      return chromaBreadcrumb(
        items: config['items'] ?? [],
        separator: config['separator'],
        onItemTap: config['onItemTap'],
      );
    });
  }

  void _registerDisplayComponents() {
    // Register table component
    registerComponentType('table', (config) {
      return chromaTable(
        columns: config['columns'] ?? [],
        data: config['data'] ?? [],
        onRowTap: config['onRowTap'],
        sortColumn: config['sortColumn'],
        sortDirection: config['sortDirection'],
        loading: config['loading'] ?? false,
        emptyState: config['emptyState'],
      );
    });

    // Register chart component
    registerComponentType('chart', (config) {
      return chromaChart(
        type: config['type'] ?? 'line',
        data: config['data'] ?? [],
        options: config['options'] ?? {},
        onChartTap: config['onChartTap'],
      );
    });
  }

  void _registerFeedbackComponents() {
    // Register alert component
    registerComponentType('alert', (config) {
      return chromaAlert(
        title: config['title'],
        message: config['message'],
        type: config['type'] ?? 'info',
        actions: config['actions'],
        dismissible: config['dismissible'] ?? true,
        onDismiss: config['onDismiss'],
      );
    });

    // Register toast component
    registerComponentType('toast', (config) {
      return chromaToast(
        message: config['message'] ?? '',
        type: config['type'] ?? 'info',
        duration: config['duration'] ?? const Duration(seconds: 3),
        action: config['action'],
        onAction: config['onAction'],
      );
    });
  }

  void _registerLayoutComponents() {
    // Register container component
    registerComponentType('container', (config) {
      return chromaContainer(
        child: config['child'],
        padding: config['padding'],
        margin: config['margin'],
        width: config['width'],
        height: config['height'],
        decoration: config['decoration'],
        constraints: config['constraints'],
      );
    });

    // Register grid component
    registerComponentType('grid', (config) {
      return chromaGrid(
        children: config['children'] ?? [],
        columns: config['columns'] ?? 2,
        spacing: config['spacing'] ?? 16,
        runSpacing: config['runSpacing'] ?? 16,
        responsive: config['responsive'] ?? true,
      );
    });
  }

  void _registerAdvancedComponents() {
    // Register modal component
    registerComponentType('modal', (config) {
      return chromaModal(
        title: config['title'],
        content: config['content'],
        actions: config['actions'],
        show: config['show'] ?? true,
        onClose: config['onClose'],
        size: config['size'] ?? 'medium',
        dismissible: config['dismissible'] ?? true,
      );
    });

    // Register stepper component
    registerComponentType('stepper', (config) {
      return chromaStepper(
        steps: config['steps'] ?? [],
        currentStep: config['currentStep'] ?? 0,
        onStepChanged: config['onStepChanged'],
        orientation: config['orientation'] ?? 'vertical',
      );
    });
  }
}

/// Enhanced button component using the new architecture
class chromaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final String variant;
  final String size;
  final bool disabled;
  final bool loading;
  final IconData? icon;

  const chromaButton({
    required this.text,
    this.onPressed,
    this.variant = 'primary',
    this.size = 'medium',
    this.disabled = false,
    this.loading = false,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled || loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        foregroundColor: _getForegroundColor(),
        padding: _getPadding(),
        minimumSize: _getMinimumSize(),
      ),
      child: _buildChild(),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case 'primary':
        return Colors.blue;
      case 'secondary':
        return Colors.grey;
      case 'success':
        return Colors.green;
      case 'danger':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  Color _getForegroundColor() {
    return Colors.white;
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case 'small':
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case 'large':
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }

  Size _getMinimumSize() {
    switch (size) {
      case 'small':
        return const Size(60, 32);
      case 'large':
        return const Size(100, 48);
      default:
        return const Size(80, 40);
    }
  }

  Widget _buildChild() {
    if (loading) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}

/// Enhanced text component
class chromaText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final String variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const chromaText({
    required this.text,
    this.style,
    this.variant = 'body',
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(context),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle baseStyle;

    switch (variant) {
      case 'h1':
        baseStyle = theme.textTheme.headlineMedium!;
        break;
      case 'h2':
        baseStyle = theme.textTheme.headlineSmall!;
        break;
      case 'h3':
        baseStyle = theme.textTheme.titleLarge!;
        break;
      case 'h4':
        baseStyle = theme.textTheme.titleMedium!;
        break;
      case 'body':
        baseStyle = theme.textTheme.bodyMedium!;
        break;
      case 'caption':
        baseStyle = theme.textTheme.bodySmall!;
        break;
      default:
        baseStyle = theme.textTheme.bodyMedium!;
    }

    return baseStyle.copyWith(
      color: color ?? baseStyle.color,
    ).merge(style);
  }
}

/// Enhanced card component
class chromaCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? content;
  final List<Widget>? actions;
  final double elevation;
  final String variant;
  final EdgeInsetsGeometry? padding;

  const chromaCard({
    this.title,
    this.subtitle,
    this.content,
    this.actions,
    this.elevation = 2,
    this.variant = 'elevated',
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: 16),
            ],
            if (content != null) content!,
            if (actions != null && actions!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Placeholder components for other types
class chromaInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final String? value;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String type;
  final bool required;
  final bool disabled;
  final String? error;

  const chromaInput({
    this.label,
    this.placeholder,
    this.value,
    this.onChanged,
    this.validator,
    this.type = 'text',
    this.required = false,
    this.disabled = false,
    this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        errorText: error,
        border: const OutlineInputBorder(),
      ),
      enabled: !disabled,
      obscureText: type == 'password',
    );
  }
}

class chromaSelect extends StatelessWidget {
  final String? label;
  final String? value;
  final List<Map<String, dynamic>> options;
  final Function(String?)? onChanged;
  final String? placeholder;
  final bool required;
  final bool disabled;
  final bool multiple;

  const chromaSelect({
    this.label,
    this.value,
    this.options = const [],
    this.onChanged,
    this.placeholder,
    this.required = false,
    this.disabled = false,
    this.multiple = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        border: const OutlineInputBorder(),
      ),
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option['value'],
          child: Text(option['label']),
        );
      }).toList(),
    );
  }
}

// Additional placeholder components...
class chromaNavItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool selected;
  final bool disabled;
  final String? badge;

  const chromaNavItem({
    required this.title,
    this.icon,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.badge,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title),
      selected: selected,
      onTap: disabled ? null : onTap,
    );
  }
}

class chromaBreadcrumb extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String? separator;
  final Function(int)? onItemTap;

  const chromaBreadcrumb({
    this.items = const [],
    this.separator,
    this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        final index = items.indexOf(item);
        return Row(
          children: [
            if (index > 0) ...[
              Text(separator ?? ' > '),
              const SizedBox(width: 8),
            ],
            GestureDetector(
              onTap: () => onItemTap?.call(index),
              child: Text(
                item['title'],
                style: TextStyle(
                  color: index == items.length - 1
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class chromaTable extends StatelessWidget {
  final List<Map<String, dynamic>> columns;
  final List<Map<String, dynamic>> data;
  final Function(Map<String, dynamic>)? onRowTap;
  final String? sortColumn;
  final String? sortDirection;
  final bool loading;
  final Widget? emptyState;

  const chromaTable({
    this.columns = const [],
    this.data = const [],
    this.onRowTap,
    this.sortColumn,
    this.sortDirection,
    this.loading = false,
    this.emptyState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data.isEmpty) {
      return emptyState ?? const Center(child: Text('No data available'));
    }

    return DataTable(
      columns: columns.map((column) {
        return DataColumn(
          label: Text(column['title']),
        );
      }).toList(),
      rows: data.map((row) {
        return DataRow(
          cells: columns.map((column) {
            return DataCell(
              Text(row[column['field']]?.toString() ?? ''),
            );
          }).toList(),
          onSelectChanged: onRowTap != null ? (selected) {
            if (selected == true) {
              onRowTap!(row);
            }
          } : null,
        );
      }).toList(),
    );
  }
}

class chromaChart extends StatelessWidget {
  final String type;
  final List<Map<String, dynamic>> data;
  final Map<String, dynamic> options;
  final Function(Map<String, dynamic>)? onChartTap;

  const chromaChart({
    this.type = 'line',
    this.data = const [],
    this.options = const {},
    this.onChartTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: Text('Chart: $type (${data.length} data points)'),
      ),
    );
  }
}

class chromaAlert extends StatelessWidget {
  final String? title;
  final String message;
  final String type;
  final List<Widget>? actions;
  final bool dismissible;
  final VoidCallback? onDismiss;

  const chromaAlert({
    this.title,
    required this.message,
    this.type = 'info',
    this.actions,
    this.dismissible = true,
    this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getIcon(), color: _getIconColor()),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      Text(message),
                    ],
                  ),
                ),
                if (dismissible)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onDismiss,
                  ),
              ],
            ),
            if (actions != null && actions!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case 'success':
        return Colors.green.shade50;
      case 'warning':
        return Colors.orange.shade50;
      case 'error':
        return Colors.red.shade50;
      case 'info':
      default:
        return Colors.blue.shade50;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case 'success':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      case 'info':
      default:
        return Icons.info;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      case 'info':
      default:
        return Colors.blue;
    }
  }
}

class chromaToast extends StatelessWidget {
  final String message;
  final String type;
  final Duration duration;
  final String? action;
  final VoidCallback? onAction;

  const chromaToast({
    required this.message,
    this.type = 'info',
    this.duration = const Duration(seconds: 3),
    this.action,
    this.onAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(_getIcon(), color: _getIconColor()),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
            if (action != null) ...[
              TextButton(
                onPressed: onAction,
                child: Text(action!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case 'success':
        return Colors.green.shade50;
      case 'warning':
        return Colors.orange.shade50;
      case 'error':
        return Colors.red.shade50;
      case 'info':
      default:
        return Colors.blue.shade50;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case 'success':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      case 'info':
      default:
        return Icons.info;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      case 'info':
      default:
        return Colors.blue;
    }
  }
}

class chromaContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;

  const chromaContainer({
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.decoration,
    this.constraints,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      constraints: constraints,
      child: child,
    );
  }
}

class chromaGrid extends StatelessWidget {
  final List<Widget> children;
  final int columns;
  final double spacing;
  final double runSpacing;
  final bool responsive;

  const chromaGrid({
    this.children = const [],
    this.columns = 2,
    this.spacing = 16,
    this.runSpacing = 16,
    this.responsive = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive
            ? (MediaQuery.of(context).size.width > 600 ? columns : 1)
            : columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}

class chromaModal extends StatelessWidget {
  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool show;
  final VoidCallback? onClose;
  final String size;
  final bool dismissible;

  const chromaModal({
    this.title,
    this.content,
    this.actions,
    this.show = true,
    this.onClose,
    this.size = 'medium',
    this.dismissible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: _getMaxWidth(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (dismissible)
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onClose,
                      ),
                  ],
                ),
              ),
              const Divider(),
            ],
            if (content != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: content!,
                ),
              ),
            if (actions != null && actions!.isNotEmpty) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _getMaxWidth() {
    switch (size) {
      case 'small':
        return 400;
      case 'large':
        return 800;
      case 'medium':
      default:
        return 600;
    }
  }
}

class chromaStepper extends StatelessWidget {
  final List<Map<String, dynamic>> steps;
  final int currentStep;
  final Function(int)? onStepChanged;
  final String orientation;

  const chromaStepper({
    this.steps = const [],
    this.currentStep = 0,
    this.onStepChanged,
    this.orientation = 'vertical',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: currentStep,
      onStepTapped: onStepChanged,
      steps: steps.map((step) {
        return Step(
          title: Text(step['title']),
          content: step['content'] ?? const SizedBox.shrink(),
          isActive: currentStep >= steps.indexOf(step),
          state: currentStep > steps.indexOf(step)
              ? StepState.complete
              : currentStep == steps.indexOf(step)
                  ? StepState.editing
                  : StepState.indexed,
        );
      }).toList(),
    );
  }
}
