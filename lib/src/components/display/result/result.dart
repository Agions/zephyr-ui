import 'package:flutter/material.dart';
import 'result_theme.dart';
import 'result_types.dart';

class ZephyrResult extends StatelessWidget {
  const ZephyrResult({
    super.key,
    this.status = ZephyrResultStatus.info,
    this.title,
    this.description,
    this.icon,
    this.actions,
    this.theme,
    this.size = 48,
    this.padding = const EdgeInsets.all(24),
  });

  final ZephyrResultStatus status;
  final String? title;
  final String? description;
  final Widget? icon;
  final List<Widget>? actions;
  final ZephyrResultTheme? theme;
  final double size;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrResultTheme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIcon(context, themeData),
          if (title != null) ...[
            const SizedBox(height: 16),
            Text(
              title!,
              style: themeData.getTitleStyle(status),
              textAlign: TextAlign.center,
            ),
          ],
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: themeData.getDescriptionStyle(status),
              textAlign: TextAlign.center,
            ),
          ],
          if (actions != null && actions!.isNotEmpty) ...[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, ZephyrResultTheme themeData) {
    if (icon != null) {
      return SizedBox(
        width: size,
        height: size,
        child: icon,
      );
    }

    final IconData iconData;
    final Color color;

    switch (status) {
      case ZephyrResultStatus.success:
        iconData = Icons.check_circle_outline;
        color = themeData.successColor ?? Colors.green;
        break;
      case ZephyrResultStatus.error:
        iconData = Icons.error_outline;
        color = themeData.errorColor ?? Colors.red;
        break;
      case ZephyrResultStatus.warning:
        iconData = Icons.warning_amber_outlined;
        color = themeData.warningColor ?? Colors.orange;
        break;
      case ZephyrResultStatus.info:
        iconData = Icons.info_outline;
        color = themeData.infoColor ?? Colors.blue;
        break;
      case ZephyrResultStatus.loading:
        iconData = Icons.hourglass_empty;
        color = themeData.infoColor ?? Colors.blue;
        break;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Icon(
        iconData,
        size: size * 0.5,
        color: color,
      ),
    );
  }
}

class ZephyrResultCard extends StatelessWidget {
  const ZephyrResultCard({
    super.key,
    this.status = ZephyrResultStatus.info,
    this.title,
    this.description,
    this.icon,
    this.actions,
    this.theme,
    this.elevation,
    this.margin = const EdgeInsets.all(16),
  });

  final ZephyrResultStatus status;
  final String? title;
  final String? description;
  final Widget? icon;
  final List<Widget>? actions;
  final ZephyrResultTheme? theme;
  final double? elevation;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: margin,
      child: ZephyrResult(
        status: status,
        title: title,
        description: description,
        icon: icon,
        actions: actions,
        theme: theme,
        padding: const EdgeInsets.all(24),
      ),
    );
  }
}

class ZephyrResultPage extends StatelessWidget {
  const ZephyrResultPage({
    super.key,
    this.status = ZephyrResultStatus.info,
    this.title,
    this.subtitle,
    this.description,
    this.icon,
    this.primaryAction,
    this.secondaryAction,
    this.theme,
  });

  final ZephyrResultStatus status;
  final String? title;
  final String? subtitle;
  final String? description;
  final Widget? icon;
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final ZephyrResultTheme? theme;

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[];

    if (secondaryAction != null) {
      actions.add(secondaryAction!);
    }
    if (primaryAction != null) {
      if (actions.isNotEmpty) {
        actions.add(const SizedBox(width: 16));
      }
      actions.add(primaryAction!);
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ZephyrResult(
            status: status,
            title: title ?? subtitle,
            description: description,
            icon: icon,
            actions: actions.isNotEmpty ? actions : null,
            theme: theme,
            size: 72,
          ),
        ),
      ),
    );
  }
}
