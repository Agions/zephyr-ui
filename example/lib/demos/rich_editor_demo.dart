import 'package:flutter/material.dart';

/// Rich Editor Demo Page
///
/// Demonstrates the capabilities of the ZephyrRichEditor component
class RichEditorDemo extends StatefulWidget {
  const RichEditorDemo({Key? key}) : super(key: key);

  @override
  State<RichEditorDemo> createState() => _RichEditorDemoState();
}

class _RichEditorDemoState extends State<RichEditorDemo> {
  // Note: This would require flutter_quill package to work
  // For now, this is a placeholder implementation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rich Editor Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit,
                size: 80,
                color: Colors.blue,
              ),
              SizedBox(height: 24),
              Text(
                'Rich Editor Component',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'The ZephyrRichEditor component provides a comprehensive rich text editing experience with:\n\n'
                '• Complete formatting toolbar (bold, italic, underline, etc.)\n'
                '• Header and text sizing options\n'
                '• Color and background customization\n'
                '• Lists and alignment controls\n'
                '• Link, image, and video embedding\n'
                '• Code blocks and quotes\n'
                '• Undo/redo functionality\n'
                '• HTML import/export\n'
                '• Character and word count\n'
                '• Customizable themes\n'
                '• Responsive design\n'
                '• Accessibility support\n\n'
                'To use this component, add the flutter_quill package to your dependencies.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Components'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
