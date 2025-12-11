import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 滚动视图
class ScrollExample extends StatefulWidget {
  const ScrollExample({super.key});

  @override
  State<ScrollExample> createState() => _ScrollExampleState();
}

class _ScrollExampleState extends State<ScrollExample> {
  final ScrollController _controller = ScrollController();
  final List<String> _list = List.generate(20, (i) => 'Item $i');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _list.insert(0, 'New Item ${DateTime.now().second}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll 滚动'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: VelocityScrollToTop(
        controller: _controller,
        child: VelocityRefresh(
          onRefresh: _onRefresh,
          child: VelocityScrollView(
            controller: _controller,
            padding: const EdgeInsets.all(16),
            children: [
              const Text('下拉刷新试试 ↓', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              ..._list.map((item) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.list),
                  title: Text(item),
                ),
              )),
              const SizedBox(height: 50),
              const Text('滚动到底部会出现回到顶部按钮', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 500), // Force scroll
              const Text('到底了', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
