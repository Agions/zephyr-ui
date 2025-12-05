/// VelocityUI 分页组件
library velocity_pagination;

import 'package:flutter/material.dart';
import 'pagination_style.dart';

export 'pagination_style.dart';

/// VelocityUI 分页
class VelocityPagination extends StatelessWidget {
  const VelocityPagination({
    super.key,
    required this.current,
    required this.total,
    required this.onPageChanged,
    this.pageSize = 10,
    this.simple = false,
    this.style,
  });

  final int current;
  final int total;
  final ValueChanged<int> onPageChanged;
  final int pageSize;
  final bool simple;
  final VelocityPaginationStyle? style;

  int get _totalPages => (total / pageSize).ceil();

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityPaginationStyle();

    if (simple) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildArrowButton(Icons.chevron_left, current > 1, () => onPageChanged(current - 1), effectiveStyle),
          Padding(
            padding: effectiveStyle.simplePadding,
            child: Text('$current / $_totalPages', style: effectiveStyle.simpleTextStyle),
          ),
          _buildArrowButton(Icons.chevron_right, current < _totalPages, () => onPageChanged(current + 1), effectiveStyle),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildArrowButton(Icons.chevron_left, current > 1, () => onPageChanged(current - 1), effectiveStyle),
        ..._buildPageButtons(effectiveStyle),
        _buildArrowButton(Icons.chevron_right, current < _totalPages, () => onPageChanged(current + 1), effectiveStyle),
      ],
    );
  }

  List<Widget> _buildPageButtons(VelocityPaginationStyle style) {
    final pages = <Widget>[];
    for (int i = 1; i <= _totalPages; i++) {
      if (i == 1 || i == _totalPages || (i >= current - 1 && i <= current + 1)) {
        pages.add(_buildPageButton(i, style));
      } else if (i == current - 2 || i == current + 2) {
        pages.add(Padding(
          padding: style.buttonSpacing,
          child: Text('...', style: style.ellipsisStyle),
        ));
      }
    }
    return pages;
  }

  Widget _buildPageButton(int page, VelocityPaginationStyle style) {
    final isActive = page == current;
    return Padding(
      padding: style.buttonSpacing,
      child: GestureDetector(
        onTap: isActive ? null : () => onPageChanged(page),
        child: Container(
          width: style.buttonSize,
          height: style.buttonSize,
          decoration: BoxDecoration(
            color: isActive ? style.activeBackgroundColor : style.buttonBackgroundColor,
            borderRadius: style.buttonBorderRadius,
            border: Border.all(color: isActive ? style.activeBackgroundColor : style.borderColor),
          ),
          child: Center(child: Text('$page', style: isActive ? style.activeTextStyle : style.textStyle)),
        ),
      ),
    );
  }

  Widget _buildArrowButton(IconData icon, bool enabled, VoidCallback onTap, VelocityPaginationStyle style) {
    return Padding(
      padding: style.buttonSpacing,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: style.buttonSize,
          height: style.buttonSize,
          decoration: BoxDecoration(
            color: style.buttonBackgroundColor,
            borderRadius: style.buttonBorderRadius,
            border: Border.all(color: style.borderColor),
          ),
          child: Icon(icon, size: style.arrowSize, color: enabled ? style.arrowColor : style.disabledArrowColor),
        ),
      ),
    );
  }
}
