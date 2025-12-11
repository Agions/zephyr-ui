/// VelocityUI 空状态组件
library velocity_empty;

import 'package:flutter/material.dart';
import 'empty_style.dart';

export 'empty_style.dart';

/// 空状态类型
enum VelocityEmptyType { noData, noNetwork, noSearch, error, custom }

/// VelocityUI 空状态
class VelocityEmpty extends StatelessWidget {
  const VelocityEmpty({
    super.key,
    this.type = VelocityEmptyType.noData,
    this.icon,
    this.title,
    this.description,
    this.action,
    this.actionText,
    this.onAction,
    this.style,
  });

  final VelocityEmptyType type;
  final IconData? icon;
  final String? title;
  final String? description;
  final Widget? action;
  final String? actionText;
  final VoidCallback? onAction;
  final VelocityEmptyStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityEmptyStyle();
    final config = _getConfig();

    return Center(
      child: Padding(
        padding: effectiveStyle.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? config.icon,
                size: effectiveStyle.iconSize, color: effectiveStyle.iconColor),
            SizedBox(height: effectiveStyle.spacing),
            Text(title ?? config.title,
                style: effectiveStyle.titleStyle, textAlign: TextAlign.center),
            if ((description ?? config.description) != null) ...[
              SizedBox(height: effectiveStyle.spacing / 2),
              Text(description ?? config.description!,
                  style: effectiveStyle.descriptionStyle,
                  textAlign: TextAlign.center),
            ],
            if (action != null || actionText != null) ...[
              SizedBox(height: effectiveStyle.actionSpacing),
              action ??
                  TextButton(
                      onPressed: onAction,
                      child:
                          Text(actionText!, style: effectiveStyle.actionStyle)),
            ],
          ],
        ),
      ),
    );
  }

  _EmptyConfig _getConfig() {
    switch (type) {
      case VelocityEmptyType.noData:
        return const _EmptyConfig(Icons.inbox_outlined, '暂无数据', null);
      case VelocityEmptyType.noNetwork:
        return const _EmptyConfig(
            Icons.wifi_off_outlined, '网络连接失败', '请检查网络设置后重试');
      case VelocityEmptyType.noSearch:
        return const _EmptyConfig(
            Icons.search_off_outlined, '无搜索结果', '换个关键词试试');
      case VelocityEmptyType.error:
        return const _EmptyConfig(Icons.error_outline, '出错了', '请稍后重试');
      case VelocityEmptyType.custom:
        return const _EmptyConfig(Icons.inbox_outlined, '', null);
    }
  }
}

class _EmptyConfig {
  const _EmptyConfig(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String? description;
}
