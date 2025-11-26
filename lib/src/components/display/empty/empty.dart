import 'package:flutter/material.dart';
import 'empty_theme.dart';

class ZephyrEmpty extends StatelessWidget {
  const ZephyrEmpty({
    super.key,
    this.image,
    this.title,
    this.description,
    this.action,
    this.theme,
    this.imageSize = 120,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget? image;
  final String? title;
  final String? description;
  final Widget? action;
  final ZephyrEmptyTheme? theme;
  final double imageSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrEmptyTheme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(context, themeData),
          if (title != null) ...[
            const SizedBox(height: 16),
            Text(
              title!,
              style: themeData.titleStyle,
              textAlign: TextAlign.center,
            ),
          ],
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: themeData.descriptionStyle,
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 24),
            action!,
          ],
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, ZephyrEmptyTheme themeData) {
    if (image != null) {
      return SizedBox(
        width: imageSize,
        height: imageSize,
        child: image,
      );
    }

    // 默认空状态图标
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        color: themeData.imageBackgroundColor,
        borderRadius: BorderRadius.circular(imageSize / 2),
      ),
      child: Icon(
        Icons.inbox_outlined,
        size: imageSize * 0.5,
        color: themeData.imageColor,
      ),
    );
  }
}

class ZephyrEmptySimple extends StatelessWidget {
  const ZephyrEmptySimple({
    super.key,
    this.description = '暂无数据',
    this.theme,
    this.padding = const EdgeInsets.all(16),
  });

  final String description;
  final ZephyrEmptyTheme? theme;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrEmptyTheme.of(context);

    return Padding(
      padding: padding,
      child: Center(
        child: Text(
          description,
          style: themeData.descriptionStyle,
        ),
      ),
    );
  }
}

class ZephyrEmptyImage extends StatelessWidget {
  const ZephyrEmptyImage({
    super.key,
    this.image,
    this.title,
    this.description,
    this.actions,
    this.theme,
    this.imageSize = 200,
    this.padding = const EdgeInsets.all(32),
  });

  final Widget? image;
  final String? title;
  final String? description;
  final List<Widget>? actions;
  final ZephyrEmptyTheme? theme;
  final double imageSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final themeData = theme ?? ZephyrEmptyTheme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null)
            SizedBox(
              width: imageSize,
              height: imageSize,
              child: image,
            )
          else
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                color: themeData.imageBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.search_off_outlined,
                size: imageSize * 0.4,
                color: themeData.imageColor,
              ),
            ),
          if (title != null) ...[
            const SizedBox(height: 24),
            Text(
              title!,
              style: themeData.titleStyle?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ) ??
                  Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
              textAlign: TextAlign.center,
            ),
          ],
          if (description != null) ...[
            const SizedBox(height: 12),
            Text(
              description!,
              style: themeData.descriptionStyle,
              textAlign: TextAlign.center,
            ),
          ],
          if (actions != null && actions!.isNotEmpty) ...[
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions!,
            ),
          ],
        ],
      ),
    );
  }
}
