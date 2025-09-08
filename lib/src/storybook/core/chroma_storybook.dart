import 'package:flutter/material.dart';
import 'package:chroma_ui/src/core/theme/chroma_theme.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// Storybook main application for interactive component documentation
class chromaStorybook extends StatelessWidget {
  final List<StorybookCategory> categories;
  final ThemeMode themeMode;
  final String title;

  const chromaStorybook({
    required this.categories,
    this.themeMode = ThemeMode.system,
    this.title = 'chromaUI Storybook',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: getchromaThemeData(Brightness.light),
      darkTheme: getchromaThemeData(Brightness.dark),
      themeMode: themeMode,
      home: StorybookHome(
        categories: categories,
        title: title,
      ),
    );
  }
}

/// Storybook home screen
class StorybookHome extends StatefulWidget {
  final List<StorybookCategory> categories;
  final String title;

  const StorybookHome({
    required this.categories,
    required this.title,
    super.key,
  });

  @override
  State<StorybookHome> createState() => _StorybookHomeState();
}

class _StorybookHomeState extends State<StorybookHome> {
  int _selectedCategoryIndex = 0;
  int _selectedStoryIndex = 0;
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = widget.categories[_selectedCategoryIndex];
    final selectedStory = selectedCategory.stories[_selectedStoryIndex];

    return Scaffold(
      appBar: AppBar(
        title: chromaText(widget.title, variant: 'h4'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              setState(() {
                _showCode = !_showCode;
              });
            },
            tooltip: 'Toggle Code View',
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Toggle theme mode would be handled by parent
            },
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.categories.length,
                    itemBuilder: (context, categoryIndex) {
                      final category = widget.categories[categoryIndex];
                      final isSelected = categoryIndex == _selectedCategoryIndex;

                      return ExpansionTile(
                        title: chromaText(
                          category.name,
                          variant: 'h6',
                          color: isSelected ? Theme.of(context).colorScheme.primary : null,
                        ),
                        initiallyExpanded: isSelected,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: category.stories.length,
                            itemBuilder: (context, storyIndex) {
                              final story = category.stories[storyIndex];
                              final isStorySelected = isSelected && storyIndex == _selectedStoryIndex;

                              return ListTile(
                                title: chromaText(
                                  story.title,
                                  variant: 'body',
                                  color: isStorySelected ? Theme.of(context).colorScheme.primary : null,
                                ),
                                selected: isStorySelected,
                                onTap: () {
                                  setState(() {
                                    _selectedCategoryIndex = categoryIndex;
                                    _selectedStoryIndex = storyIndex;
                                    _showCode = false;
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Main content area
          Expanded(
            child: Column(
              children: [
                // Story header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      chromaText(
                        selectedStory.title,
                        variant: 'h3',
                      ),
                      if (selectedStory.description != null) ...[
                        const SizedBox(height: 8),
                        chromaText(
                          selectedStory.description!,
                          variant: 'body',
                        ),
                      ],
                    ],
                  ),
                ),

                // Story content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Component preview
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: selectedStory.builder(context),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Controls
                        if (selectedStory.controls.isNotEmpty) ...[
                          chromaText('Controls', variant: 'h5'),
                          const SizedBox(height: 16),
                          _buildControls(selectedStory.controls),
                          const SizedBox(height: 32),
                        ],

                        // Code view
                        if (_showCode) ...[
                          chromaText('Code', variant: 'h5'),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: chromaText(
                              selectedStory.code ?? '// Code example not available',
                              variant: 'caption',
                            ),
                          ),
                        ],

                        // Props
                        if (selectedStory.parameters.isNotEmpty) ...[
                          const SizedBox(height: 32),
                          chromaText('Parameters', variant: 'h5'),
                          const SizedBox(height: 16),
                          _buildParametersTable(selectedStory.parameters),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(List<StorybookControl> controls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: controls.map((control) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildControl(control),
        );
      }).toList(),
    );
  }

  Widget _buildControl(StorybookControl control) {
    switch (control.type) {
      case StorybookControlType.boolean:
        final boolControl = control as StorybookBooleanControl;
        return Row(
          children: [
            Checkbox(
              value: boolControl.value,
              onChanged: (value) {
                boolControl.value = value ?? false;
                if (control.onChanged != null) {
                  control.onChanged!(value ?? false);
                }
              },
            ),
            const SizedBox(width: 8),
            chromaText(control.label),
          ],
        );

      case StorybookControlType.string:
        final stringControl = control as StorybookStringControl;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chromaText(control.label, variant: 'body'),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: control.placeholder,
              ),
              controller: TextEditingController(text: stringControl.value),
              onChanged: (value) {
                stringControl.value = value;
                if (control.onChanged != null) {
                  control.onChanged!(value);
                }
              },
            ),
          ],
        );

      case StorybookControlType.number:
        final numberControl = control as StorybookNumberControl;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chromaText(control.label, variant: 'body'),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: control.placeholder,
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: numberControl.value.toString()),
              onChanged: (value) {
                final parsedValue = double.tryParse(value);
                if (parsedValue != null) {
                  numberControl.value = parsedValue;
                  if (control.onChanged != null) {
                    control.onChanged!(parsedValue);
                  }
                }
              },
            ),
          ],
        );

      case StorybookControlType.select:
        final selectControl = control as StorybookSelectControl;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chromaText(control.label, variant: 'body'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: selectControl.value,
              items: selectControl.options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  selectControl.value = value;
                  if (control.onChanged != null) {
                    control.onChanged!(value);
                  }
                }
              },
            ),
          ],
        );

      case StorybookControlType.color:
        final colorControl = control as StorybookColorControl;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chromaText(control.label, variant: 'body'),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorControl.value,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Hex color',
                    ),
                    controller: TextEditingController(text: colorControl.value.toString()),
                    onChanged: (value) {
                      final parsedColor = _parseColor(value);
                      if (parsedColor != null) {
                        colorControl.value = parsedColor;
                        if (control.onChanged != null) {
                          control.onChanged!(parsedColor);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }

  Widget _buildParametersTable(List<StorybookParameter> parameters) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: chromaText('Name', variant: 'h6'),
                ),
                Expanded(
                  flex: 1,
                  child: chromaText('Type', variant: 'h6'),
                ),
                Expanded(
                  flex: 1,
                  child: chromaText('Default', variant: 'h6'),
                ),
                Expanded(
                  flex: 3,
                  child: chromaText('Description', variant: 'h6'),
                ),
              ],
            ),
          ),

          // Parameters
          ...parameters.map((parameter) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: chromaText(
                      parameter.name,
                      variant: 'body',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: chromaText(
                      parameter.type,
                      variant: 'body',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: chromaText(
                      parameter.defaultValue ?? '-',
                      variant: 'body',
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: chromaText(
                      parameter.description ?? '',
                      variant: 'body',
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Color? _parseColor(String colorString) {
    try {
      if (colorString.startsWith('#')) {
        return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

/// Storybook category
class StorybookCategory {
  final String name;
  final String? description;
  final List<StorybookStory> stories;

  const StorybookCategory({
    required this.name,
    this.description,
    required this.stories,
  });
}

/// Storybook story
class StorybookStory {
  final String title;
  final String? description;
  final Widget Function(BuildContext context) builder;
  final String? code;
  final List<StorybookControl> controls;
  final List<StorybookParameter> parameters;

  const StorybookStory({
    required this.title,
    this.description,
    required this.builder,
    this.code,
    this.controls = const [],
    this.parameters = const [],
  });
}

/// Storybook control
abstract class StorybookControl {
  final String label;
  final String? description;
  final StorybookControlType type;
  final Function(dynamic)? onChanged;

  StorybookControl({
    required this.label,
    this.description,
    required this.type,
    this.onChanged,
  });
}

/// Boolean control
class StorybookBooleanControl extends StorybookControl {
  bool value;

  StorybookBooleanControl({
    required String label,
    bool value = false,
    String? description,
    Function(bool)? onChanged,
  }) : super(
          label: label,
          description: description,
          type: StorybookControlType.boolean,
          onChanged: onChanged,
        ) {
    this.value = value;
  }
}

/// String control
class StorybookStringControl extends StorybookControl {
  String value;
  final String? placeholder;

  StorybookStringControl({
    required String label,
    String value = '',
    this.placeholder,
    String? description,
    Function(String)? onChanged,
  }) : super(
          label: label,
          description: description,
          type: StorybookControlType.string,
          onChanged: onChanged,
        ) {
    this.value = value;
  }
}

/// Number control
class StorybookNumberControl extends StorybookControl {
  double value;
  final String? placeholder;

  StorybookNumberControl({
    required String label,
    double value = 0,
    this.placeholder,
    String? description,
    Function(double)? onChanged,
  }) : super(
          label: label,
          description: description,
          type: StorybookControlType.number,
          onChanged: onChanged,
        ) {
    this.value = value;
  }
}

/// Select control
class StorybookSelectControl extends StorybookControl {
  String value;
  final List<String> options;

  StorybookSelectControl({
    required String label,
    required this.options,
    String? description,
    Function(String)? onChanged,
  }) : super(
          label: label,
          description: description,
          type: StorybookControlType.select,
          onChanged: onChanged,
        ) {
    value = options.first;
  }
}

/// Color control
class StorybookColorControl extends StorybookControl {
  Color value;

  StorybookColorControl({
    required String label,
    Color value = Colors.blue,
    String? description,
    Function(Color)? onChanged,
  }) : super(
          label: label,
          description: description,
          type: StorybookControlType.color,
          onChanged: onChanged,
        ) {
    this.value = value;
  }
}

/// Storybook control types
enum StorybookControlType {
  boolean,
  string,
  number,
  select,
  color,
}

/// Storybook parameter
class StorybookParameter {
  final String name;
  final String type;
  final String? defaultValue;
  final String? description;
  final bool required;

  const StorybookParameter({
    required this.name,
    required this.type,
    this.defaultValue,
    this.description,
    this.required = false,
  });
}
