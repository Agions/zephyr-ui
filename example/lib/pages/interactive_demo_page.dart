import 'package:flutter/material.dart';
import '../widgets/interactive_demo.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class InteractiveDemoPage extends StatelessWidget {
  const InteractiveDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('交互式演示'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '交互式组件演示',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '在这里您可以实时调整组件参数，查看效果变化。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            
            // 按钮交互式演示
            InteractiveDemoCard(
              title: '按钮组件',
              description: '可以调整按钮的各种参数',
              code: '''
ZButton(
  text: "点击我",
  type: ZButtonType.primary,
  size: ZButtonSize.medium,
  disabled: false,
  loading: false,
  onPressed: () {
    print("按钮被点击");
  },
)''',
              options: [
                const DemoOption(
                  key: 'text',
                  label: '按钮文本',
                  type: DemoOptionType.string,
                  defaultValue: '点击我',
                  values: ['确定', '取消', '提交', '重置'],
                ),
                const DemoOption(
                  key: 'disabled',
                  label: '禁用状态',
                  type: DemoOptionType.boolean,
                  defaultValue: false,
                ),
                const DemoOption(
                  key: 'loading',
                  label: '加载状态',
                  type: DemoOptionType.boolean,
                  defaultValue: false,
                ),
              ],
              demo: Builder(
                builder: (context) {
                  final card = context.findAncestorWidgetOfExactType<InteractiveDemoCard>()!;
                  final text = card.getOptionValue<String>('text');
                  final disabled = card.getOptionValue<bool>('disabled');
                  final loading = card.getOptionValue<bool>('loading');
                  
                  return ZButton(
                    text: text,
                    type: ZButtonType.primary,
                    disabled: disabled,
                    loading: loading,
                    onPressed: disabled || loading ? null : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('按钮被点击')),
                      );
                    },
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 输入框交互式演示
            InteractiveDemoCard(
              title: '输入框组件',
              description: '可以调整输入框的各种参数',
              code: '''
ZInputField(
  label: "用户名",
  placeholder: "请输入用户名",
  helperText: "用户名长度为3-20个字符",
  errorText: "用户名不能为空",
)''',
              options: [
                const DemoOption(
                  key: 'label',
                  label: '标签文本',
                  type: DemoOptionType.string,
                  defaultValue: '用户名',
                  values: ['用户名', '邮箱', '密码', '手机号'],
                ),
                const DemoOption(
                  key: 'showError',
                  label: '显示错误',
                  type: DemoOptionType.boolean,
                  defaultValue: false,
                ),
                const DemoOption(
                  key: 'showHelper',
                  label: '显示帮助',
                  type: DemoOptionType.boolean,
                  defaultValue: true,
                ),
              ],
              demo: Builder(
                builder: (context) {
                  final card = context.findAncestorWidgetOfExactType<InteractiveDemoCard>()!;
                  final label = card.getOptionValue<String>('label');
                  final showError = card.getOptionValue<bool>('showError');
                  final showHelper = card.getOptionValue<bool>('showHelper');
                  
                  return ZInputField(
                    label: label,
                    placeholder: '请输入$label',
                    helperText: showHelper ? '$label长度为3-20个字符' : null,
                    errorText: showError ? '$label不能为空' : null,
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 卡片交互式演示
            InteractiveDemoCard(
              title: '卡片组件',
              description: '可以调整卡片的各种参数',
              code: '''
ZCard(
  title: "卡片标题",
  subtitle: "卡片副标题",
  child: Text("这是卡片的内容"),
  elevation: 2,
)''',
              options: [
                const DemoOption(
                  key: 'elevation',
                  label: '阴影深度',
                  type: DemoOptionType.number,
                  defaultValue: 2.0,
                ),
                const DemoOption(
                  key: 'showSubtitle',
                  label: '显示副标题',
                  type: DemoOptionType.boolean,
                  defaultValue: true,
                ),
                const DemoOption(
                  key: 'color',
                  label: '背景颜色',
                  type: DemoOptionType.color,
                  defaultValue: Colors.white,
                ),
              ],
              demo: Builder(
                builder: (context) {
                  final card = context.findAncestorWidgetOfExactType<InteractiveDemoCard>()!;
                  final elevation = card.getOptionValue<double>('elevation');
                  final showSubtitle = card.getOptionValue<bool>('showSubtitle');
                  final color = card.getOptionValue<Color>('color');
                  
                  return ZCard(
                    title: '卡片标题',
                    subtitle: showSubtitle ? '卡片副标题' : null,
                    elevation: elevation.toInt(),
                    color: color,
                    child: const Text('这是卡片的内容'),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 图标交互式演示
            InteractiveDemoCard(
              title: '图标组件',
              description: '可以调整图标的各种参数',
              code: '''
ZIcon(
  Icons.star,
  size: 24,
  color: Colors.amber,
  onPressed: () {
    print("图标被点击");
  },
)''',
              options: [
                const DemoOption(
                  key: 'size',
                  label: '图标大小',
                  type: DemoOptionType.number,
                  defaultValue: 24.0,
                ),
                const DemoOption(
                  key: 'color',
                  label: '图标颜色',
                  type: DemoOptionType.color,
                  defaultValue: Colors.amber,
                ),
                const DemoOption(
                  key: 'clickable',
                  label: '可点击',
                  type: DemoOptionType.boolean,
                  defaultValue: true,
                ),
              ],
              demo: Builder(
                builder: (context) {
                  final card = context.findAncestorWidgetOfExactType<InteractiveDemoCard>()!;
                  final size = card.getOptionValue<double>('size');
                  final color = card.getOptionValue<Color>('color');
                  final clickable = card.getOptionValue<bool>('clickable');
                  
                  return ZIcon(
                    Icons.star,
                    size: size.toInt(),
                    color: color,
                    onPressed: clickable ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('图标被点击')),
                      );
                    } : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}