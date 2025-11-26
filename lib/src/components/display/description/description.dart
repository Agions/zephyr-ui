import 'package:flutter/material.dart';
import 'description_theme.dart';

class ZephyrDescriptionItem {
  const ZephyrDescriptionItem({
    required this.label,
    required this.children,
    this.span = 1,
  });

  final String label;
  final List<Widget> children;
  final int span;
}

class ZephyrDescription extends StatelessWidget {
  const ZephyrDescription({
    required this.items,
    super.key,
    this.theme,
    this.column = 3,
    this.border = true,
    this.size = ZephyrDescriptionSize.defaultSize,
    this.layout = ZephyrDescriptionLayout.horizontal,
    this.labelStyle,
    this.contentStyle,
    this.padding = const EdgeInsets.all(16),
  });

  final List<ZephyrDescriptionItem> items;
  final ZephyrDescriptionTheme? theme;
  final int column;
  final bool border;
  final ZephyrDescriptionSize size;
  final ZephyrDescriptionLayout layout;
  final TextStyle? labelStyle;
  final TextStyle? contentStyle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrDescriptionTheme.of(context);

    return Container(
      padding: padding,
      decoration: border
          ? BoxDecoration(
              border: Border.all(
                color: themeData.borderColor!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(themeData.borderRadius!),
            )
          : null,
      child: layout == ZephyrDescriptionLayout.horizontal
          ? _buildHorizontalLayout(context, themeData)
          : _buildVerticalLayout(context, themeData),
    );
  }

  Widget _buildHorizontalLayout(
      BuildContext context, ZephyrDescriptionTheme themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context, themeData),
        const SizedBox(height: 16),
        _buildHorizontalContent(context, themeData),
      ],
    );
  }

  Widget _buildVerticalLayout(
      BuildContext context, ZephyrDescriptionTheme themeData) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0)
              Divider(
                height: 1,
                color: themeData.borderColor!,
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: _getVerticalPadding(size),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      item.label,
                      style: labelStyle ?? themeData.getLabelStyle(size),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: item.children,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildHeader(BuildContext context, ZephyrDescriptionTheme themeData) {
    return Row(
      children: List.generate(column, (index) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: _getVerticalPadding(size),
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: themeData.headerBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: themeData.borderColor!,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '标题 ${index + 1}',
              style: labelStyle ?? themeData.getLabelStyle(size),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHorizontalContent(
      BuildContext context, ZephyrDescriptionTheme themeData) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return Column(
          children: [
            if (index > 0)
              Divider(
                height: 1,
                color: themeData.borderColor!,
              ),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: _getVerticalPadding(size),
                      horizontal: 16,
                    ),
                    child: Text(
                      item.label,
                      style: labelStyle ?? themeData.getLabelStyle(size),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: List.generate(column, (colIndex) {
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: _getVerticalPadding(size),
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            border: colIndex < column - 1
                                ? Border(
                                    right: BorderSide(
                                      color: themeData.borderColor!,
                                      width: 1,
                                    ),
                                  )
                                : null,
                          ),
                          child: colIndex < item.children.length
                              ? DefaultTextStyle(
                                  style: contentStyle ??
                                      themeData.getContentStyle(size),
                                  child: item.children[colIndex],
                                )
                              : const SizedBox(),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }

  double _getVerticalPadding(ZephyrDescriptionSize size) {
    switch (size) {
      case ZephyrDescriptionSize.small:
        return 8;
      case ZephyrDescriptionSize.defaultSize:
        return 12;
      case ZephyrDescriptionSize.large:
        return 16;
    }
  }
}

class ZephyrDescriptionList extends StatelessWidget {
  const ZephyrDescriptionList({
    required this.items,
    super.key,
    this.theme,
    this.size = ZephyrDescriptionSize.defaultSize,
    this.labelWidth = 120,
    this.spacing = 16,
    this.labelStyle,
    this.contentStyle,
  });

  final List<ZephyrDescriptionItem> items;
  final ZephyrDescriptionTheme? theme;
  final ZephyrDescriptionSize size;
  final double labelWidth;
  final double spacing;
  final TextStyle? labelStyle;
  final TextStyle? contentStyle;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrDescriptionTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: items.last == item ? 0 : spacing,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: labelWidth,
                child: Text(
                  item.label,
                  style: labelStyle ?? themeData.getLabelStyle(size),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DefaultTextStyle(
                  style: contentStyle ?? themeData.getContentStyle(size),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.children,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
