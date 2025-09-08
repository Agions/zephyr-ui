import 'package:flutter/material.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// 高级组件 Storybook 故事
class AdvancedComponentsStorybook {
  /// 获取所有高级组件的故事
  static List<StorybookStory> getStories() {
    return [
      _fileUploadStory(),
      _imageCropperStory(),
      _richTextEditorStory(),
      _colorPickerStory(),
      _calendarStory(),
      _kanbanBoardStory(),
      _mindMapStory(),
      _workflowDesignerStory(),
      _dashboardStory(),
      _dataVisualizationStory(),
    ];
  }

  /// 文件上传组件故事
  static StorybookStory _fileUploadStory() {
    return StorybookStory(
      name: 'chromaEnhancedFileUpload',
      category: '高级组件',
      description: '增强型文件上传组件，支持拖拽、分块上传和进度显示',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础文件上传', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaEnhancedFileUpload(
            maxFiles: 5,
            maxFileSize: 10 * 1024 * 1024, // 10MB
            allowedFileTypes: ['.jpg', '.png', '.pdf', '.doc', '.docx'],
            enableDragAndDrop: true,
            onFilesSelected: (files) {
              print('选择的文件: $files');
            },
            onUploadProgress: (progress) {
              print('上传进度: $progress%');
            },
            onUploadComplete: (files) {
              print('上传完成: $files');
            },
            onUploadError: (error) {
              print('上传错误: $error');
            },
          ),
          const SizedBox(height: 24),
          const Text('图片预览上传', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaEnhancedFileUpload(
            maxFiles: 3,
            maxFileSize: 5 * 1024 * 1024, // 5MB
            allowedFileTypes: ['.jpg', '.png', '.gif'],
            enableDragAndDrop: true,
            showPreview: true,
            enableImageCompression: true,
            onFilesSelected: (files) {
              print('选择的图片: $files');
            },
          ),
          const SizedBox(height: 24),
          const Text('多文件上传', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaEnhancedFileUpload(
            maxFiles: 10,
            maxFileSize: 50 * 1024 * 1024, // 50MB
            enableDragAndDrop: true,
            enableChunkedUpload: true,
            chunkSize: 5 * 1024 * 1024, // 5MB
            enableRetry: true,
            maxRetries: 3,
            onFilesSelected: (files) {
              print('选择的文件: $files');
            },
          ),
        ],
      ),
      controls: [
        StorybookNumberControl(
          label: '最大文件数',
          defaultValue: 5,
          description: '允许上传的最大文件数',
        ),
        StorybookNumberControl(
          label: '最大文件大小 (MB)',
          defaultValue: 10,
          description: '单个文件的最大大小（MB）',
        ),
        StorybookBooleanControl(
          label: '启用拖拽',
          defaultValue: true,
          description: '是否启用拖拽上传',
        ),
        StorybookBooleanControl(
          label: '显示预览',
          defaultValue: false,
          description: '是否显示文件预览',
        ),
        StorybookBooleanControl(
          label: '分块上传',
          defaultValue: false,
          description: '是否启用分块上传',
        ),
      ],
      codeExample: '''
// 基础文件上传
chromaEnhancedFileUpload(
  maxFiles: 5,
  maxFileSize: 10 * 1024 * 1024, // 10MB
  allowedFileTypes: ['.jpg', '.png', '.pdf', '.doc', '.docx'],
  enableDragAndDrop: true,
  onFilesSelected: (files) {
    print('选择的文件: $files');
  },
  onUploadProgress: (progress) {
    print('上传进度: $progress%');
  },
  onUploadComplete: (files) {
    print('上传完成: $files');
  },
  onUploadError: (error) {
    print('上传错误: $error');
  },
)

// 图片预览上传
chromaEnhancedFileUpload(
  maxFiles: 3,
  maxFileSize: 5 * 1024 * 1024, // 5MB
  allowedFileTypes: ['.jpg', '.png', '.gif'],
  enableDragAndDrop: true,
  showPreview: true,
  enableImageCompression: true,
  onFilesSelected: (files) {
    print('选择的图片: $files');
  },
)

// 多文件上传
chromaEnhancedFileUpload(
  maxFiles: 10,
  maxFileSize: 50 * 1024 * 1024, // 50MB
  enableDragAndDrop: true,
  enableChunkedUpload: true,
  chunkSize: 5 * 1024 * 1024, // 5MB
  enableRetry: true,
  maxRetries: 3,
  onFilesSelected: (files) {
    print('选择的文件: $files');
  },
)
''',
    );
  }

  /// 图片裁剪组件故事
  static StorybookStory _imageCropperStory() {
    return StorybookStory(
      name: 'chromaImageCropper',
      category: '高级组件',
      description: '图片裁剪组件，支持多种裁剪模式和预设',
      component: (context, controls) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('基础图片裁剪', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('点击选择图片进行裁剪'),
                      SizedBox(height: 16),
                      chromaButton(
                        text: '选择图片',
                        onPressed: () {
                          // 模拟选择图片
                          setState(() {
                            // 这里应该显示图片裁剪界面
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('预设裁剪比例', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  chromaButton(
                    text: '1:1',
                    variant: 'secondary',
                    onPressed: () {
                      print('设置裁剪比例为 1:1');
                    },
                  ),
                  chromaButton(
                    text: '4:3',
                    variant: 'secondary',
                    onPressed: () {
                      print('设置裁剪比例为 4:3');
                    },
                  ),
                  chromaButton(
                    text: '16:9',
                    variant: 'secondary',
                    onPressed: () {
                      print('设置裁剪比例为 16:9');
                    },
                  ),
                  chromaButton(
                    text: '自由',
                    variant: 'primary',
                    onPressed: () {
                      print('自由裁剪');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('裁剪选项', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              chromaCard(
                content: Column(
                  children: [
                    chromaCheckbox(
                      label: '保持宽高比',
                      value: true,
                      onChanged: (value) {
                        print('保持宽高比: $value');
                      },
                    ),
                    const SizedBox(height: 8),
                    chromaCheckbox(
                      label: '显示网格',
                      value: true,
                      onChanged: (value) {
                        print('显示网格: $value');
                      },
                    ),
                    const SizedBox(height: 8),
                    chromaCheckbox(
                      label: '启用旋转',
                      value: false,
                      onChanged: (value) {
                        print('启用旋转: $value');
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      controls: [
        StorybookSelectControl(
          label: '裁剪模式',
          defaultValue: 'free',
          options: ['free', 'square', 'rectangle', 'circle'],
          description: '裁剪模式',
        ),
        StorybookBooleanControl(
          label: '保持宽高比',
          defaultValue: true,
          description: '是否保持宽高比',
        ),
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格',
        ),
        StorybookBooleanControl(
          label: '启用旋转',
          defaultValue: false,
          description: '是否启用旋转功能',
        ),
        StorybookBooleanControl(
          label: '启用缩放',
          defaultValue: true,
          description: '是否启用缩放功能',
        ),
      ],
      codeExample: '''
// 基础图片裁剪
chromaImageCropper(
  image: File('path/to/image.jpg'),
  cropMode: CropMode.free,
  onCropped: (croppedImage) {
    print('裁剪后的图片: $croppedImage');
  },
)

// 预设比例裁剪
chromaImageCropper(
  image: File('path/to/image.jpg'),
  cropMode: CropMode.ratio,
  aspectRatio: 16/9,
  onCropped: (croppedImage) {
    print('裁剪后的图片: $croppedImage');
  },
)

// 圆形裁剪
chromaImageCropper(
  image: File('path/to/image.jpg'),
  cropMode: CropMode.circle,
  onCropped: (croppedImage) {
    print('裁剪后的图片: $croppedImage');
  },
)

// 带网格的裁剪
chromaImageCropper(
  image: File('path/to/image.jpg'),
  cropMode: CropMode.free,
  showGrid: true,
  enableRotation: true,
  enableZoom: true,
  onCropped: (croppedImage) {
    print('裁剪后的图片: $croppedImage');
  },
)
''',
    );
  }

  /// 富文本编辑器组件故事
  static StorybookStory _richTextEditorStory() {
    return StorybookStory(
      name: 'chromaRichTextEditor',
      category: '高级组件',
      description: '富文本编辑器组件，支持多种格式和工具栏',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础富文本编辑器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                // 工具栏
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      chromaButton(
                        text: 'B',
                        variant: 'secondary',
                        size: 'small',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 4),
                      chromaButton(
                        text: 'I',
                        variant: 'secondary',
                        size: 'small',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 4),
                      chromaButton(
                        text: 'U',
                        variant: 'secondary',
                        size: 'small',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      const VerticalDivider(),
                      const SizedBox(width: 8),
                      chromaButton(
                        icon: Icons.format_align_left,
                        variant: 'secondary',
                        size: 'small',
                        onPressed: () {},
                      ),
                      chromaButton(
                        icon: Icons.format_align_center,
                        variant: 'secondary',
                        size: 'small',
                        onPressed: () {},
                      ),
                      chromaButton(
                        icon: Icons.format_align_right,
                        variant: 'secondary',
                        size: 'small',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // 编辑区域
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '开始输入内容...',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('完整工具栏编辑器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                // 完整工具栏
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildToolbarButton('B', 'bold'),
                        _buildToolbarButton('I', 'italic'),
                        _buildToolbarButton('U', 'underline'),
                        const SizedBox(width: 8),
                        const VerticalDivider(),
                        const SizedBox(width: 8),
                        _buildToolbarIcon(Icons.format_list_bulleted, 'bullet_list'),
                        _buildToolbarIcon(Icons.format_list_numbered, 'numbered_list'),
                        const SizedBox(width: 8),
                        const VerticalDivider(),
                        const SizedBox(width: 8),
                        _buildToolbarIcon(Icons.link, 'link'),
                        _buildToolbarIcon(Icons.image, 'image'),
                        _buildToolbarIcon(Icons.table_chart, 'table'),
                        const SizedBox(width: 8),
                        const VerticalDivider(),
                        const SizedBox(width: 8),
                        _buildToolbarIcon(Icons.undo, 'undo'),
                        _buildToolbarIcon(Icons.redo, 'redo'),
                      ],
                    ),
                  ),
                ),
                // 编辑区域
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '支持完整格式化的富文本编辑器...',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '显示工具栏',
          defaultValue: true,
          description: '是否显示工具栏',
        ),
        StorybookBooleanControl(
          label: '启用格式化',
          defaultValue: true,
          description: '是否启用格式化功能',
        ),
        StorybookBooleanControl(
          label: '启用插入',
          defaultValue: true,
          description: '是否启用插入功能',
        ),
        StorybookBooleanControl(
          label: '启用撤销重做',
          defaultValue: true,
          description: '是否启用撤销重做功能',
        ),
        StorybookBooleanControl(
          label: '自动保存',
          defaultValue: false,
          description: '是否启用自动保存',
        ),
      ],
      codeExample: '''
// 基础富文本编辑器
chromaRichTextEditor(
  placeholder: '开始输入内容...',
  toolbar: RichTextToolbar.basic,
  onContentChanged: (content) {
    print('内容变化: $content');
  },
)

// 完整工具栏编辑器
chromaRichTextEditor(
  placeholder: '支持完整格式化的富文本编辑器...',
  toolbar: RichTextToolbar.full,
  enableAutoSave: true,
  autoSaveInterval: Duration(seconds: 30),
  onContentChanged: (content) {
    print('内容变化: $content');
  },
  onAutoSave: (content) {
    print('自动保存: $content');
  },
)

// 自定义工具栏编辑器
chromaRichTextEditor(
  placeholder: '自定义工具栏编辑器...',
  toolbar: RichTextToolbar.custom(
    buttons: [
      RichTextButton.bold,
      RichTextButton.italic,
      RichTextButton.underline,
      RichTextButton.link,
      RichTextButton.image,
    ],
  ),
  onContentChanged: (content) {
    print('内容变化: $content');
  },
)
''',
    );
  }

  /// 颜色选择器组件故事
  static StorybookStory _colorPickerStory() {
    return StorybookStory(
      name: 'chromaColorPicker',
      category: '高级组件',
      description: '颜色选择器组件，支持多种颜色模式和格式',
      component: (context, controls) => StatefulBuilder(
        builder: (context, setState) {
          Color selectedColor = Colors.blue;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('基础颜色选择器', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              chromaColorPicker(
                initialColor: selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    selectedColor = color;
                  });
                  print('选择的颜色: $color');
                },
              ),
              const SizedBox(height: 24),
              const Text('颜色预览', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    '#${selectedColor.value.toRadixString(16).substring(2).toUpperCase()}',
                    style: TextStyle(
                      color: selectedColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('高级颜色选择器', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              chromaColorPicker(
                initialColor: selectedColor,
                mode: ColorPickerMode.advanced,
                showAlphaSlider: true,
                showHexInput: true,
                showPresets: true,
                presetColors: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.orange,
                  Colors.purple,
                  Colors.pink,
                  Colors.cyan,
                ],
                onColorChanged: (color) {
                  setState(() {
                    selectedColor = color;
                  });
                  print('选择的颜色: $color');
                },
              ),
            ],
          );
        },
      ),
      controls: [
        StorybookSelectControl(
          label: '选择器模式',
          defaultValue: 'basic',
          options: ['basic', 'advanced', 'compact'],
          description: '颜色选择器的模式',
        ),
        StorybookBooleanControl(
          label: '显示透明度',
          defaultValue: false,
          description: '是否显示透明度滑块',
        ),
        StorybookBooleanControl(
          label: '显示十六进制输入',
          defaultValue: false,
          description: '是否显示十六进制颜色输入',
        ),
        StorybookBooleanControl(
          label: '显示预设颜色',
          defaultValue: false,
          description: '是否显示预设颜色',
        ),
      ],
      codeExample: '''
// 基础颜色选择器
chromaColorPicker(
  initialColor: Colors.blue,
  onColorChanged: (color) {
    print('选择的颜色: $color');
  },
)

// 高级颜色选择器
chromaColorPicker(
  initialColor: Colors.blue,
  mode: ColorPickerMode.advanced,
  showAlphaSlider: true,
  showHexInput: true,
  showPresets: true,
  presetColors: [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ],
  onColorChanged: (color) {
    print('选择的颜色: $color');
  },
)

// 紧凑型颜色选择器
chromaColorPicker(
  initialColor: Colors.blue,
  mode: ColorPickerMode.compact,
  onColorChanged: (color) {
    print('选择的颜色: $color');
  },
)
''',
    );
  }

  /// 日历组件故事
  static StorybookStory _calendarStory() {
    return StorybookStory(
      name: 'chromaCalendar',
      category: '高级组件',
      description: '日历组件，支持多种视图和事件管理',
      component: (context, controls) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('月视图日历', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('月视图日历'),
                      SizedBox(height: 8),
                      Text('支持事件显示和交互'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('周视图日历', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.view_week, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('周视图日历'),
                      SizedBox(height: 8),
                      Text('支持时间块显示'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('日视图日历', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.today, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('日视图日历'),
                      SizedBox(height: 8),
                      Text('支持详细时间安排'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      controls: [
        StorybookSelectControl(
          label: '视图模式',
          defaultValue: 'month',
          options: ['month', 'week', 'day', 'schedule'],
          description: '日历的视图模式',
        ),
        StorybookBooleanControl(
          label: '显示事件',
          defaultValue: true,
          description: '是否显示事件',
        ),
        StorybookBooleanControl(
          label: '显示周末',
          defaultValue: true,
          description: '是否显示周末',
        ),
        StorybookBooleanControl(
          label: '启用拖拽',
          defaultValue: false,
          description: '是否启用事件拖拽',
        ),
        StorybookBooleanControl(
          label: '多选模式',
          defaultValue: false,
          description: '是否启用多选模式',
        ),
      ],
      codeExample: '''
// 月视图日历
chromaCalendar(
  viewMode: CalendarViewMode.month,
  events: [
    CalendarEvent(
      title: '团队会议',
      date: DateTime.now(),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 11, minute: 0),
      color: Colors.blue,
    ),
    CalendarEvent(
      title: '项目截止',
      date: DateTime.now().add(const Duration(days: 3)),
      color: Colors.red,
    ),
  ],
  onEventSelected: (event) {
    print('选择的事件: $event');
  },
  onDateSelected: (date) {
    print('选择的日期: $date');
  },
)

// 周视图日历
chromaCalendar(
  viewMode: CalendarViewMode.week,
  events: events,
  showWeekends: true,
  enableDragAndDrop: true,
  onEventSelected: (event) {
    print('选择的事件: $event');
  },
  onEventResized: (event, newStart, newEnd) {
    print('事件调整大小: $event, $newStart, $newEnd');
  },
)

// 日视图日历
chromaCalendar(
  viewMode: CalendarViewMode.day,
  events: events,
  timeInterval: const Duration(minutes: 30),
  onEventSelected: (event) {
    print('选择的事件: $event');
  },
  onTimeSlotSelected: (date, time) {
    print('选择的时间段: $date, $time');
  },
)
''',
    );
  }

  /// 看板组件故事
  static StorybookStory _kanbanBoardStory() {
    return StorybookStory(
      name: 'chromaKanbanBoard',
      category: '高级组件',
      description: '看板组件，支持拖拽和任务管理',
      component: (context, controls) => StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('基础看板', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.view_kanban, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('看板视图'),
                      SizedBox(height: 8),
                      Text('支持拖拽任务卡片'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('看板列配置', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              chromaCard(
                content: Column(
                  children: [
                    _buildKanbanColumn('待办', Colors.blue, 5),
                    const SizedBox(height: 8),
                    _buildKanbanColumn('进行中', Colors.orange, 3),
                    const SizedBox(height: 8),
                    _buildKanbanColumn('已完成', Colors.green, 8),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('任务卡片', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              chromaCard(
                title: '任务示例',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('实现用户认证功能'),
                    const SizedBox(height: 8),
                    const Text('需要完成用户登录、注册和权限管理'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children: [
                        chromaBadge(
                          text: '高优先级',
                          variant: 'danger',
                        ),
                        chromaBadge(
                          text: '前端',
                          variant: 'primary',
                        ),
                        chromaBadge(
                          text: '3天',
                          variant: 'secondary',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      controls: [
        StorybookBooleanControl(
          label: '启用拖拽',
          defaultValue: true,
          description: '是否启用拖拽功能',
        ),
        StorybookBooleanControl(
          label: '显示计数',
          defaultValue: true,
          description: '是否显示任务计数',
        ),
        StorybookBooleanControl(
          label: '允许添加列',
          defaultValue: false,
          description: '是否允许添加新列',
        ),
        StorybookBooleanControl(
          label: '允许添加任务',
          defaultValue: true,
          description: '是否允许添加新任务',
        ),
        StorybookBooleanControl(
          label: '显示过滤器',
          defaultValue: false,
          description: '是否显示过滤器',
        ),
      ],
      codeExample: '''
// 基础看板
chromaKanbanBoard(
  columns: [
        KanbanColumn(
          title: '待办',
          id: 'todo',
          color: Colors.blue,
        ),
        KanbanColumn(
          title: '进行中',
          id: 'inProgress',
          color: Colors.orange,
        ),
        KanbanColumn(
          title: '已完成',
          id: 'done',
          color: Colors.green,
        ),
      ],
      tasks: [
        KanbanTask(
          id: '1',
          title: '实现用户认证',
          description: '需要完成用户登录、注册和权限管理',
          columnId: 'todo',
          priority: TaskPriority.high,
          tags: ['前端', '认证'],
        ),
        KanbanTask(
          id: '2',
          title: '数据库设计',
          description: '设计用户表和权限表',
          columnId: 'inProgress',
          priority: TaskPriority.medium,
          tags: ['后端', '数据库'],
        ),
      ],
      onTaskMoved: (task, fromColumn, toColumn) {
        print('任务移动: $task 从 $fromColumn 到 $toColumn');
      },
      onTaskUpdated: (task) {
        print('任务更新: $task');
      },
    )

    // 带过滤器的看板
    chromaKanbanBoard(
      columns: columns,
      tasks: tasks,
      enableFilters: true,
      filterOptions: [
        KanbanFilter(
          name: '优先级',
          field: 'priority',
          options: ['高', '中', '低'],
        ),
        KanbanFilter(
          name: '标签',
          field: 'tags',
          options: ['前端', '后端', '数据库'],
        ),
      ],
      onTaskMoved: (task, fromColumn, toColumn) {
        print('任务移动: $task 从 $fromColumn 到 $toColumn');
      },
    )
    ''',
    );
  }

  /// 思维导图组件故事
  static StorybookStory _mindMapStory() {
    return StorybookStory(
      name: 'chromaMindMap',
      category: '高级组件',
      description: '思维导图组件，支持节点编辑和布局',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础思维导图', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_tree, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('思维导图'),
                  SizedBox(height: 8),
                  Text('支持节点编辑和多种布局'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('布局选项', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              chromaButton(
                text: '径向布局',
                variant: 'secondary',
                onPressed: () {
                  print('切换到径向布局');
                },
              ),
              chromaButton(
                text: '树形布局',
                variant: 'secondary',
                onPressed: () {
                  print('切换到树形布局');
                },
              ),
              chromaButton(
                text: '层次布局',
                variant: 'secondary',
                onPressed: () {
                  print('切换到层次布局');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('节点样式', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: 3,
            spacing: 16,
            children: [
              _buildMindMapNode('中心节点', Colors.blue, true),
              _buildMindMapNode('子节点 1', Colors.green, false),
              _buildMindMapNode('子节点 2', Colors.orange, false),
            ],
          ),
        ],
      ),
      controls: [
        StorybookSelectControl(
          label: '布局模式',
          defaultValue: 'radial',
          options: ['radial', 'tree', 'hierarchical', 'organic'],
          description: '思维导图的布局模式',
        ),
        StorybookBooleanControl(
          label: '启用编辑',
          defaultValue: true,
          description: '是否启用节点编辑',
        ),
        StorybookBooleanControl(
          label: '启用拖拽',
          defaultValue: true,
          description: '是否启用节点拖拽',
        ),
        StorybookBooleanControl(
          label: '显示连接线',
          defaultValue: true,
          description: '是否显示节点连接线',
        ),
        StorybookBooleanControl(
          label: '自动布局',
          defaultValue: false,
          description: '是否启用自动布局',
        ),
      ],
      codeExample: '''
// 基础思维导图
chromaMindMap(
  rootNode: MindMapNode(
    id: 'root',
    text: '项目规划',
    children: [
      MindMapNode(
        id: 'frontend',
        text: '前端开发',
        children: [
          MindMapNode(
            id: 'ui',
            text: 'UI设计',
          ),
          MindMapNode(
            id: 'ux',
            text: '用户体验',
          ),
        ],
      ),
      MindMapNode(
        id: 'backend',
        text: '后端开发',
        children: [
          MindMapNode(
            id: 'api',
            text: 'API设计',
          ),
          MindMapNode(
            id: 'database',
            text: '数据库设计',
          ),
        ],
      ),
    ],
  ),
  layout: MindMapLayout.radial,
  onNodeSelected: (node) {
    print('选择的节点: $node');
  },
  onNodeChanged: (node) {
    print('节点变化: $node');
  },
)

// 树形布局思维导图
chromaMindMap(
  rootNode: rootNode,
  layout: MindMapLayout.tree,
  enableEditing: true,
  enableDragAndDrop: true,
  onNodeSelected: (node) {
    print('选择的节点: $node');
  },
)

// 层次布局思维导图
chromaMindMap(
  rootNode: rootNode,
  layout: MindMapLayout.hierarchical,
  showConnections: true,
  connectionStyle: MindMapConnectionStyle.curved,
  onNodeSelected: (node) {
    print('选择的节点: $node');
  },
)
''',
    );
  }

  /// 工作流设计器组件故事
  static StorybookStory _workflowDesignerStory() {
    return StorybookStory(
      name: 'chromaWorkflowDesigner',
      category: '高级组件',
      description: '工作流设计器组件，支持流程图和自动化',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础工作流设计器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.workflow, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('工作流设计器'),
                  SizedBox(height: 8),
                  Text('支持拖拽节点和连接线'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('节点类型', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildWorkflowNode('开始', Colors.green, Icons.play_arrow),
              _buildWorkflowNode('处理', Colors.blue, Icons.settings),
              _buildWorkflowNode('判断', Colors.orange, Icons.call_split),
              _buildWorkflowNode('结束', Colors.red, Icons.stop),
            ],
          ),
          const SizedBox(height: 24),
          const Text('工作流示例', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaCard(
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWorkflowNode('开始', Colors.green, Icons.play_arrow),
                    Icon(Icons.arrow_forward, color: Colors.grey),
                    _buildWorkflowNode('审核', Colors.blue, Icons.approval),
                    Icon(Icons.arrow_forward, color: Colors.grey),
                    _buildWorkflowNode('判断', Colors.orange, Icons.call_split),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward, color: Colors.grey),
                    const SizedBox(width: 80),
                    Icon(Icons.arrow_downward, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWorkflowNode('拒绝', Colors.red, Icons.cancel),
                    const SizedBox(width: 80),
                    _buildWorkflowNode('通过', Colors.green, Icons.check_circle),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '启用拖拽',
          defaultValue: true,
          description: '是否启用节点拖拽',
        ),
        StorybookBooleanControl(
          label: '启用连接',
          defaultValue: true,
          description: '是否启用节点连接',
        ),
        StorybookBooleanControl(
          label: '显示网格',
          defaultValue: true,
          description: '是否显示网格',
        ),
        StorybookBooleanControl(
          label: '启用缩放',
          defaultValue: true,
          description: '是否启用缩放功能',
        ),
        StorybookBooleanControl(
          label: '自动布局',
          defaultValue: false,
          description: '是否启用自动布局',
        ),
      ],
      codeExample: '''
// 基础工作流设计器
chromaWorkflowDesigner(
  nodes: [
    WorkflowNode(
      id: 'start',
      type: WorkflowNodeType.start,
      position: const Offset(100, 100),
      text: '开始',
    ),
    WorkflowNode(
      id: 'process',
      type: WorkflowNodeType.process,
      position: const Offset(300, 100),
      text: '处理数据',
    ),
    WorkflowNode(
      id: 'decision',
      type: WorkflowNodeType.decision,
      position: const Offset(500, 100),
      text: '判断条件',
    ),
    WorkflowNode(
      id: 'end',
      type: WorkflowNodeType.end,
      position: const Offset(700, 100),
      text: '结束',
    ),
  ],
  connections: [
    WorkflowConnection(
      from: 'start',
      to: 'process',
    ),
    WorkflowConnection(
      from: 'process',
      to: 'decision',
    ),
    WorkflowConnection(
      from: 'decision',
      to: 'end',
      label: '通过',
    ),
  ],
  onNodeSelected: (node) {
    print('选择的节点: $node');
  },
  onConnectionAdded: (connection) {
    print('添加连接: $connection');
  },
)

// 带网格的工作流设计器
chromaWorkflowDesigner(
  nodes: nodes,
  connections: connections,
  showGrid: true,
  gridSize: 20,
  enableSnapToGrid: true,
  onNodeSelected: (node) {
    print('选择的节点: $node');
  },
)

// 自动布局的工作流设计器
chromaWorkflowDesigner(
  nodes: nodes,
  connections: connections,
  autoLayout: true,
  layoutAlgorithm: WorkflowLayoutAlgorithm.hierarchical,
  onNodeSelected: (node) {
    print('选择的节点: $node');
  },
)
''',
    );
  }

  /// 仪表板组件故事
  static StorybookStory _dashboardStory() {
    return StorybookStory(
      name: 'chromaDashboard',
      category: '高级组件',
      description: '仪表板组件，支持拖拽布局和实时数据',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础仪表板', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 500,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dashboard, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('仪表板视图'),
                  SizedBox(height: 8),
                  Text('支持拖拽布局和实时数据'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('仪表板组件', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: 2,
            spacing: 16,
            children: [
              _buildDashboardCard('总用户数', '12,345', Icons.people, Colors.blue),
              _buildDashboardCard('总收入', '¥234,567', Icons.attach_money, Colors.green),
              _buildDashboardCard('订单数', '1,234', Icons.shopping_cart, Colors.orange),
              _buildDashboardCard('转化率', '2.5%', Icons.trending_up, Colors.purple),
            ],
          ),
          const SizedBox(height: 24),
          const Text('图表组件', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaGrid(
            columns: 2,
            spacing: 16,
            children: [
              _buildChartCard('销售趋势', '折线图'),
              _buildChartCard('产品分布', '饼图'),
              _buildChartCard('用户增长', '柱状图'),
              _buildChartCard('地区分析', '地图'),
            ],
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '启用拖拽',
          defaultValue: true,
          description: '是否启用组件拖拽',
        ),
        StorybookBooleanControl(
          label: '启用调整大小',
          defaultValue: true,
          description: '是否启用组件大小调整',
        ),
        StorybookBooleanControl(
          label: '实时更新',
          defaultValue: false,
          description: '是否启用实时数据更新',
        ),
        StorybookBooleanControl(
          label: '显示标题',
          defaultValue: true,
          description: '是否显示组件标题',
        ),
        StorybookBooleanControl(
          label: '全屏模式',
          defaultValue: false,
          description: '是否支持全屏模式',
        ),
      ],
      codeExample: '''
// 基础仪表板
chromaDashboard(
  layout: DashboardLayout.grid,
  widgets: [
    DashboardWidget(
      id: 'users',
      title: '用户统计',
      type: DashboardWidgetType.statistics,
      position: const DashboardPosition(0, 0, 1, 1),
      data: {'total': 12345, 'growth': 15},
    ),
    DashboardWidget(
      id: 'revenue',
      title: '收入统计',
      type: DashboardWidgetType.chart,
      position: const DashboardPosition(1, 0, 1, 1),
      chartType: ChartType.line,
      data: revenueData,
    ),
    DashboardWidget(
      id: 'orders',
      title: '订单列表',
      type: DashboardWidgetType.table,
      position: const DashboardPosition(0, 1, 2, 1),
      data: ordersData,
    ),
  ],
  onWidgetMoved: (widget, newPosition) {
    print('组件移动: $widget 到 $newPosition');
  },
  onWidgetResized: (widget, newSize) {
    print('组件调整大小: $widget 到 $newSize');
  },
)

// 实时数据仪表板
chromaDashboard(
  layout: DashboardLayout.grid,
  widgets: widgets,
  enableRealTimeUpdates: true,
  updateInterval: const Duration(seconds: 30),
  onDataUpdated: (widgetId, data) {
    print('数据更新: $widgetId, $data');
  },
  onWidgetMoved: (widget, newPosition) {
    print('组件移动: $widget 到 $newPosition');
  },
)

// 可拖拽仪表板
chromaDashboard(
  layout: DashboardLayout.freeform,
  widgets: widgets,
  enableDragAndDrop: true,
  enableResize: true,
  showGrid: true,
  onWidgetMoved: (widget, newPosition) {
    print('组件移动: $widget 到 $newPosition');
  },
  onWidgetResized: (widget, newSize) {
    print('组件调整大小: $widget 到 $newSize');
  },
)
''',
    );
  }

  /// 数据可视化组件故事
  static StorybookStory _dataVisualizationStory() {
    return StorybookStory(
      name: 'chromaDataVisualization',
      category: '高级组件',
      description: '数据可视化组件，支持大数据集和交互',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('大数据可视化', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('大数据可视化'),
                  SizedBox(height: 8),
                  Text('支持大数据集和实时渲染'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('交互功能', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              chromaButton(
                text: '缩放',
                variant: 'secondary',
                onPressed: () {
                  print('启用缩放');
                },
              ),
              chromaButton(
                text: '平移',
                variant: 'secondary',
                onPressed: () {
                  print('启用平移');
                },
              ),
              chromaButton(
                text: '选择',
                variant: 'secondary',
                onPressed: () {
                  print('启用选择');
                },
              ),
              chromaButton(
                text: '过滤',
                variant: 'secondary',
                onPressed: () {
                  print('启用过滤');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('数据格式', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaCard(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('支持的数据格式:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    chromaBadge(text: 'JSON', variant: 'primary'),
                    chromaBadge(text: 'CSV', variant: 'primary'),
                    chromaBadge(text: 'XML', variant: 'primary'),
                    chromaBadge(text: 'Excel', variant: 'primary'),
                    chromaBadge(text: '数据库', variant: 'primary'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      controls: [
        StorybookBooleanControl(
          label: '启用缩放',
          defaultValue: true,
          description: '是否启用缩放功能',
        ),
        StorybookBooleanControl(
          label: '启用平移',
          defaultValue: true,
          description: '是否启用平移功能',
        ),
        StorybookBooleanControl(
          label: '启用选择',
          defaultValue: false,
          description: '是否启用选择功能',
        ),
        StorybookBooleanControl(
          label: '启用过滤',
          defaultValue: false,
          description: '是否启用过滤功能',
        ),
        StorybookBooleanControl(
          label: '实时更新',
          defaultValue: false,
          description: '是否启用实时更新',
        ),
      ],
      codeExample: '''
// 基础数据可视化
chromaDataVisualization(
  data: [
    {'name': 'A', 'value': 100},
    {'name': 'B', 'value': 200},
    {'name': 'C', 'value': 150},
    {'name': 'D', 'value': 300},
  ],
  visualizationType: VisualizationType.bar,
  enableZoom: true,
  enablePan: true,
  onDataSelected: (data) {
    print('选择的数据: $data');
  },
)

// 大数据可视化
chromaDataVisualization(
  data: largeDataset,
  visualizationType: VisualizationType.scatter,
  enableZoom: true,
  enablePan: true,
  enableSelection: true,
  enableFilter: true,
  onDataSelected: (data) {
    print('选择的数据: $data');
  },
  onFiltered: (filteredData) {
    print('过滤后的数据: $filteredData');
  },
)

// 实时数据可视化
chromaDataVisualization(
  dataStream: dataStream,
  visualizationType: VisualizationType.line,
  enableRealTimeUpdates: true,
  updateInterval: const Duration(seconds: 1),
  onDataUpdated: (newData) {
    print('新数据: $newData');
  },
  onDataSelected: (data) {
    print('选择的数据: $data');
  },
)

// 交互式数据可视化
chromaDataVisualization(
  data: data,
  visualizationType: VisualizationType.heatmap,
  enableZoom: true,
  enablePan: true,
  enableSelection: true,
  enableTooltip: true,
  enableCrosshair: true,
  onDataSelected: (data) {
    print('选择的数据: $data');
  },
  onHover: (data) {
    print('悬停的数据: $data');
  },
)
''',
    );
  }

  /// 构建工具栏按钮
  static Widget _buildToolbarButton(String text, String action) {
    return chromaButton(
      text: text,
      variant: 'secondary',
      size: 'small',
      onPressed: () {
        print('工具栏按钮点击: $action');
      },
    );
  }

  /// 构建工具栏图标按钮
  static Widget _buildToolbarIcon(IconData icon, String action) {
    return chromaButton(
      icon: icon,
      variant: 'secondary',
      size: 'small',
      onPressed: () {
        print('工具栏图标点击: $action');
      },
    );
  }

  /// 构建看板列
  static Widget _buildKanbanColumn(String title, Color color, int count) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              chromaBadge(
                text: count.toString(),
                variant: 'primary',
                backgroundColor: color.withOpacity(0.2),
                textColor: color,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '拖拽任务到这里',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建思维导图节点
  static Widget _buildMindMapNode(String text, Color color, bool isRoot) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isRoot ? 16 : 12,
        vertical: isRoot ? 12 : 8,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isRoot ? FontWeight.bold : FontWeight.normal,
          color: color,
          fontSize: isRoot ? 16 : 14,
        ),
      ),
    );
  }

  /// 构建工作流节点
  static Widget _buildWorkflowNode(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建仪表板卡片
  static Widget _buildDashboardCard(String title, String value, IconData icon, Color color) {
    return chromaCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建图表卡片
  static Widget _buildChartCard(String title, String type) {
    return chromaCard(
      title: title,
      content: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_chart, size: 48, color: Colors.grey),
              const SizedBox(height: 8),
              Text(type),
            ],
          ),
        ),
      ),
    );
  }
}
