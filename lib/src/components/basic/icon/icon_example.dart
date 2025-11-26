import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrIcon 组件示例
///
/// 展示了 ZephyrIcon 组件的各种尺寸、状态和样式
class ZephyrIconExample extends StatelessWidget {
  /// 创建一个新的 ZephyrIconExample 实例
  const ZephyrIconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrIcon 示例'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题和描述
            const Text(
              '图标组件示例',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '展示 ZephyrIcon 组件的各种尺寸、状态和样式',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // 图标尺寸示例
            const Text(
              '图标尺寸',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildIconSizes(),
            const SizedBox(height: 32),

            // 图标状态示例
            const Text(
              '图标状态',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildIconStatuses(),
            const SizedBox(height: 32),

            // 图标工厂构造函数示例
            const Text(
              '图标工厂构造函数',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildIconFactories(),
            const SizedBox(height: 32),

            // 自定义图标示例
            const Text(
              '自定义图标',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCustomIcons(),
            const SizedBox(height: 32),

            // 图标在实际布局中的应用示例
            const Text(
              '图标在布局中的应用',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildLayoutExample(),
          ],
        ),
      ),
    );
  }

  /// 构建图标尺寸示例
  Widget _buildIconSizes() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildIconItem(
          title: '小尺寸图标',
          icon: const ZephyrIcon(
            Icons.home,
            size: ZephyrIconSize.small,
          ),
        ),
        _buildIconItem(
          title: '中尺寸图标',
          icon: const ZephyrIcon(
            Icons.home,
            size: ZephyrIconSize.medium,
          ),
        ),
        _buildIconItem(
          title: '大尺寸图标',
          icon: const ZephyrIcon(
            Icons.home,
            size: ZephyrIconSize.large,
          ),
        ),
        _buildIconItem(
          title: '自定义尺寸图标',
          icon: const ZephyrIcon(
            Icons.home,
            customSize: 48,
          ),
        ),
      ],
    );
  }

  /// 构建图标状态示例
  Widget _buildIconStatuses() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildIconItem(
          title: '正常状态',
          icon: const ZephyrIcon(
            Icons.info,
            status: ZephyrIconStatus.normal,
          ),
        ),
        _buildIconItem(
          title: '主色状态',
          icon: const ZephyrIcon(
            Icons.info,
            status: ZephyrIconStatus.primary,
          ),
        ),
        _buildIconItem(
          title: '次要色状态',
          icon: const ZephyrIcon(
            Icons.info,
            status: ZephyrIconStatus.secondary,
          ),
        ),
        _buildIconItem(
          title: '错误状态',
          icon: const ZephyrIcon(
            Icons.error,
            status: ZephyrIconStatus.error,
          ),
        ),
        _buildIconItem(
          title: '警告状态',
          icon: const ZephyrIcon(
            Icons.warning,
            status: ZephyrIconStatus.warning,
          ),
        ),
        _buildIconItem(
          title: '成功状态',
          icon: const ZephyrIcon(
            Icons.check_circle,
            status: ZephyrIconStatus.success,
          ),
        ),
        _buildIconItem(
          title: '信息状态',
          icon: const ZephyrIcon(
            Icons.info,
            status: ZephyrIconStatus.info,
          ),
        ),
        _buildIconItem(
          title: '禁用状态',
          icon: const ZephyrIcon(
            Icons.home,
            status: ZephyrIconStatus.disabled,
          ),
        ),
      ],
    );
  }

  /// 构建图标工厂构造函数示例
  Widget _buildIconFactories() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildIconItem(
          title: '小号图标',
          icon: ZephyrIcon.small(Icons.home),
        ),
        _buildIconItem(
          title: '中号图标',
          icon: ZephyrIcon.medium(Icons.home),
        ),
        _buildIconItem(
          title: '大号图标',
          icon: ZephyrIcon.large(Icons.home),
        ),
        _buildIconItem(
          title: '主色图标',
          icon: ZephyrIcon.primary(Icons.home),
        ),
        _buildIconItem(
          title: '次要色图标',
          icon: ZephyrIcon.secondary(Icons.home),
        ),
        _buildIconItem(
          title: '错误图标',
          icon: ZephyrIcon.error(Icons.error),
        ),
        _buildIconItem(
          title: '警告图标',
          icon: ZephyrIcon.warning(Icons.warning),
        ),
        _buildIconItem(
          title: '成功图标',
          icon: ZephyrIcon.success(Icons.check_circle),
        ),
        _buildIconItem(
          title: '信息图标',
          icon: ZephyrIcon.info(Icons.info),
        ),
        _buildIconItem(
          title: '禁用图标',
          icon: ZephyrIcon.disabled(Icons.home),
        ),
      ],
    );
  }

  /// 构建自定义图标示例
  Widget _buildCustomIcons() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildIconItem(
          title: '自定义颜色图标',
          icon: const ZephyrIcon(
            Icons.home,
            color: Colors.purple,
          ),
        ),
        _buildIconItem(
          title: '自定义尺寸和颜色',
          icon: const ZephyrIcon(
            Icons.home,
            customSize: 40,
            color: Colors.orange,
          ),
        ),
        _buildIconItem(
          title: '自定义状态颜色',
          icon: const ZephyrIcon(
            Icons.error,
            status: ZephyrIconStatus.error,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }

  /// 构建图标在实际布局中的应用示例
  Widget _buildLayoutExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '功能菜单',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildMenuItem(
                  icon: const ZephyrIcon.primary(
                    Icons.home,
                    size: ZephyrIconSize.large,
                  ),
                  title: '首页',
                ),
                _buildMenuItem(
                  icon: const ZephyrIcon.primary(
                    Icons.shopping_cart,
                    size: ZephyrIconSize.large,
                  ),
                  title: '购物车',
                ),
                _buildMenuItem(
                  icon: const ZephyrIcon.primary(
                    Icons.favorite,
                    size: ZephyrIconSize.large,
                  ),
                  title: '收藏',
                ),
                _buildMenuItem(
                  icon: const ZephyrIcon.primary(
                    Icons.person,
                    size: ZephyrIconSize.large,
                  ),
                  title: '我的',
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '状态指示器',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 24,
              runSpacing: 16,
              children: [
                _buildStatusIndicator(
                  icon: const ZephyrIcon.success(
                    Icons.check_circle,
                  ),
                  text: '成功',
                ),
                _buildStatusIndicator(
                  icon: const ZephyrIcon.warning(
                    Icons.warning,
                  ),
                  text: '警告',
                ),
                _buildStatusIndicator(
                  icon: const ZephyrIcon.error(
                    Icons.error,
                  ),
                  text: '错误',
                ),
                _buildStatusIndicator(
                  icon: const ZephyrIcon.info(
                    Icons.info,
                  ),
                  text: '信息',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建图标项
  Widget _buildIconItem({
    required String title,
    required Widget icon,
  }) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  /// 构建菜单项
  Widget _buildMenuItem({
    required Widget icon,
    required String title,
  }) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// 构建状态指示器
  Widget _buildStatusIndicator({
    required Widget icon,
    required String text,
  }) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
