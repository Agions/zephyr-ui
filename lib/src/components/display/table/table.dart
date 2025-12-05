/// VelocityUI 表格组件
library velocity_table;

import 'package:flutter/material.dart';
import 'table_style.dart';

export 'table_style.dart';

/// VelocityUI 表格
class VelocityTable extends StatelessWidget {
  const VelocityTable({
    super.key,
    required this.columns,
    required this.rows,
    this.showHeader = true,
    this.striped = false,
    this.bordered = false,
    this.style,
  });

  final List<VelocityTableColumn> columns;
  final List<VelocityTableRow> rows;
  final bool showHeader;
  final bool striped;
  final bool bordered;
  final VelocityTableStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityTableStyle();

    return Container(
      decoration: BoxDecoration(
        border: bordered ? Border.all(color: effectiveStyle.borderColor) : null,
        borderRadius: effectiveStyle.borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          if (showHeader) _buildHeader(effectiveStyle),
          ...List.generate(rows.length, (i) => _buildRow(rows[i], i, effectiveStyle)),
        ],
      ),
    );
  }

  Widget _buildHeader(VelocityTableStyle style) {
    return Container(
      color: style.headerBackgroundColor,
      padding: style.cellPadding,
      child: Row(
        children: columns.map((col) => Expanded(
          flex: col.flex,
          child: Text(col.title, style: style.headerTextStyle, textAlign: col.align),
        )).toList(),
      ),
    );
  }

  Widget _buildRow(VelocityTableRow row, int index, VelocityTableStyle style) {
    return Container(
      color: striped && index.isOdd ? style.stripedColor : style.rowBackgroundColor,
      padding: style.cellPadding,
      decoration: bordered ? BoxDecoration(border: Border(top: BorderSide(color: style.borderColor))) : null,
      child: Row(
        children: [
          for (int i = 0; i < columns.length; i++)
            Expanded(
              flex: columns[i].flex,
              child: row.cells.length > i
                  ? (row.cells[i] is Widget ? row.cells[i] as Widget : Text('${row.cells[i]}', style: style.cellTextStyle, textAlign: columns[i].align))
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}

class VelocityTableColumn {
  const VelocityTableColumn({required this.title, this.flex = 1, this.align = TextAlign.left});
  final String title;
  final int flex;
  final TextAlign align;
}

class VelocityTableRow {
  const VelocityTableRow({required this.cells, this.onTap});
  final List<dynamic> cells;
  final VoidCallback? onTap;
}
