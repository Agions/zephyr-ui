import 'package:flutter/material.dart';
import 'package:velocity_ui/velocity_ui.dart';

/// 布局组件示例 - 层叠布局
class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack 层叠布局'),
        backgroundColor: VelocityColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基本层叠', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              width: 300,
              height: 300,
              color: Colors.grey[200],
              child: VelocityStack(
                alignment: Alignment.center,
                children: [
                  Container(width: 200, height: 200, color: Colors.blue),
                  Container(width: 150, height: 150, color: Colors.green),
                  Container(width: 100, height: 100, color: Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('定位组件 (VelocityPositioned)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              width: 300,
              height: 200,
              color: Colors.grey[300],
              child: const VelocityStack(
                children: [
                  VelocityPositioned(
                    left: 20,
                    top: 20,
                    child: Icon(Icons.star, color: Colors.amber),
                  ),
                  VelocityPositioned(
                    right: 20,
                    bottom: 20,
                    child: Text('Right Bottom'),
                  ),
                  VelocityPositioned.center(
                    child: VelocityTag(text: 'Center', type: VelocityTagType.primary),
                  ),
                  VelocityPositioned.fill(
                    child: Center(
                      child: Opacity(
                        opacity: 0.2,
                        child: Text(
                          'FILL',
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
