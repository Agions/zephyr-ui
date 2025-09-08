import 'package:flutter/material.dart';
import 'package:flutter_ui/src/components/basic/button/button.dart';
import 'package:flutter_ui/src/core/constants/enums.dart';
import 'package:flutter_ui/src/storybook/core/chroma_storybook.dart';

// A stateful widget to manage the state of the interactive controls
class _ButtonStory extends StatefulWidget {
  const _ButtonStory();

  @override
  _ButtonStoryState createState() => _ButtonStoryState();
}

class _ButtonStoryState extends State<_ButtonStory> {
  String _text = 'Button';
  bool _isDisabled = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // This widget will be rebuilt when controls change state,
    // but the controls themselves are not part of this story's definition.
    // For a more advanced storybook, you'd pass the state down from the controls.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Primary (Solid)'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            chromaButton.primary(
              text: _text,
              size: chromaSize.sm,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
            chromaButton.primary(
              text: _text,
              size: chromaSize.md,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
            chromaButton.primary(
              text: _text,
              size: chromaSize.lg,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Outline'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            chromaButton.outline(
              text: _text,
              size: chromaSize.sm,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
            chromaButton.outline(
              text: _text,
              size: chromaSize.md,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
            chromaButton.outline(
              text: _text,
              size: chromaSize.lg,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Text'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            chromaButton.text(
              text: _text,
              size: chromaSize.sm,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
            chromaButton.text(
              text: _text,
              size: chromaSize.md,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
            chromaButton.text(
              text: _text,
              size: chromaSize.lg,
              isDisabled: _isDisabled,
              isLoading: _isLoading,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}


final StorybookCategory basicComponentsCategory = StorybookCategory(
  name: 'Basic Components',
  stories: [
    StorybookStory(
      title: 'Button',
      description: 'A versatile button component with multiple styles and states.',
      builder: (context) => const _ButtonStory(),
      code: """
// Primary Button
chromaButton.primary(
  text: 'Submit',
  onPressed: () {},
  size: chromaSize.md,
  isLoading: false,
  isDisabled: false,
);

// Outline Button
chromaButton.outline(
  text: 'Cancel',
  onPressed: () {},
);

// Text Button
chromaButton.text(
  text: 'Learn More',
  onPressed: () {},
);
""",
      parameters: [
        const StorybookParameter(name: 'text', type: 'String', required: true, description: 'The text displayed on the button.'),
        const StorybookParameter(name: 'onPressed', type: 'VoidCallback?', description: 'Callback when the button is tapped.'),
        const StorybookParameter(name: 'size', type: 'chromaSize', defaultValue: 'chromaSize.md', description: 'The size of the button.'),
        const StorybookParameter(name: 'icon', type: 'IconData?', description: 'An optional icon to display before the text.'),
        const StorybookParameter(name: 'isFullWidth', type: 'bool', defaultValue: 'false', description: 'Whether the button should occupy the full width of its parent.'),
        const StorybookParameter(name: 'isLoading', type: 'bool', defaultValue: 'false', description: 'Shows a loading indicator if true.'),
        const StorybookParameter(name: 'isDisabled', type: 'bool', defaultValue: 'false', description: 'Disables the button if true.'),
      ],
      controls: [
        // In this custom storybook, controls are not directly linked to the builder's state.
        // A more advanced implementation would use a state management solution to link them.
      ],
    ),
  ],
);
