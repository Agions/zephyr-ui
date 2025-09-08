import 'package:flutter/material.dart';
import 'package:flutter_ui/src/storybook/core/chroma_storybook.dart';
import 'package:flutter_ui/src/storybook/stories/basic_components_storybook.dart';
// Import other story files as needed

void main() {
  runApp(const chromaStorybookApp());
}

class chromaStorybookApp extends StatelessWidget {
  const chromaStorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return chromaStorybook(
      title: 'chroma UI Storybook',
      categories: [
        basicComponentsCategory,
        // Add other categories here
      ],
    );
  }
}
