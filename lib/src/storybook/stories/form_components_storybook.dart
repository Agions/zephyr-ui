import 'package:flutter/material.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// 表单组件 Storybook 故事
class FormComponentsStorybook {
  /// 获取所有表单组件的故事
  static List<StorybookStory> getStories() {
    return [
      _inputFieldStory(),
      _textAreaStory(),
      _selectFieldStory(),
      _checkboxStory(),
      _radioGroupStory(),
      _switchStory(),
      _sliderStory(),
      _datePickerStory(),
      _timePickerStory(),
      _formValidationStory(),
    ];
  }

  /// 输入框组件故事
  static StorybookStory _inputFieldStory() {
    return StorybookStory(
      name: 'chromaInputField',
      category: '表单组件',
      description: '企业级输入框组件，支持多种验证和状态',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础输入框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const chromaInputField(
            label: '用户名',
            placeholder: '请输入用户名',
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 24),
          const Text('不同类型的输入框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const chromaInputField(
            label: '邮箱',
            placeholder: '请输入邮箱地址',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
          ),
          const SizedBox(height: 16),
          const chromaInputField(
            label: '密码',
            placeholder: '请输入密码',
            obscureText: true,
            prefixIcon: Icons.lock,
            suffixIcon: Icons.visibility,
          ),
          const SizedBox(height: 16),
          const chromaInputField(
            label: '电话',
            placeholder: '请输入电话号码',
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone,
          ),
          const SizedBox(height: 24),
          const Text('带验证的输入框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaInputField(
            label: '必填字段',
            placeholder: '此字段为必填项',
            required: true,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return '此字段不能为空';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          chromaInputField(
            label: '邮箱验证',
            placeholder: '请输入有效的邮箱地址',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return '邮箱不能为空';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                return '请输入有效的邮箱地址';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          const Text('不同状态的输入框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const chromaInputField(
            label: '禁用状态',
            placeholder: '禁用的输入框',
            enabled: false,
          ),
          const SizedBox(height: 16),
          const chromaInputField(
            label: '只读状态',
            placeholder: '只读的输入框',
            readOnly: true,
            initialValue: '只读内容',
          ),
          const SizedBox(height: 16),
          chromaInputField(
            label: '错误状态',
            placeholder: '请输入内容',
            errorText: '此字段有错误',
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '输入框',
          description: '输入框的标签',
        ),
        StorybookStringControl(
          label: '占位符',
          defaultValue: '请输入内容',
          description: '输入框的占位符',
        ),
        StorybookBooleanControl(
          label: '必填',
          defaultValue: false,
          description: '是否为必填字段',
        ),
        StorybookBooleanControl(
          label: '禁用',
          defaultValue: false,
          description: '是否禁用输入框',
        ),
        StorybookBooleanControl(
          label: '密码',
          defaultValue: false,
          description: '是否为密码输入框',
        ),
      ],
      codeExample: '''
// 基础输入框
chromaInputField(
  label: '用户名',
  placeholder: '请输入用户名',
  onChanged: (value) {
    print('输入值: $value');
  },
)

// 带验证的输入框
chromaInputField(
  label: '邮箱',
  placeholder: '请输入邮箱地址',
  keyboardType: TextInputType.emailAddress,
  required: true,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return '邮箱不能为空';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  },
)

// 密码输入框
chromaInputField(
  label: '密码',
  placeholder: '请输入密码',
  obscureText: true,
  prefixIcon: Icons.lock,
  suffixIcon: Icons.visibility,
)
''',
    );
  }

  /// 文本域组件故事
  static StorybookStory _textAreaStory() {
    return StorybookStory(
      name: 'chromaTextArea',
      category: '表单组件',
      description: '多行文本输入组件，支持自动调整高度',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础文本域', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const chromaTextArea(
            label: '描述',
            placeholder: '请输入描述信息...',
            minLines: 3,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          const Text('自动调整高度', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const chromaTextArea(
            label: '自动调整',
            placeholder: '这个文本域会根据内容自动调整高度...',
            autoHeight: true,
            minLines: 2,
            maxLines: 6,
          ),
          const SizedBox(height: 24),
          const Text('带字符计数', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const chromaTextArea(
            label: '留言',
            placeholder: '请输入您的留言...',
            maxLength: 200,
            showCharacterCount: true,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          const Text('不同大小的文本域', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const chromaTextArea(
            label: '小型',
            placeholder: '小型文本域',
            minLines: 2,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          const chromaTextArea(
            label: '中型',
            placeholder: '中型文本域',
            minLines: 4,
            maxLines: 6,
          ),
          const SizedBox(height: 16),
          const chromaTextArea(
            label: '大型',
            placeholder: '大型文本域',
            minLines: 6,
            maxLines: 10,
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '文本域',
          description: '文本域的标签',
        ),
        StorybookStringControl(
          label: '占位符',
          defaultValue: '请输入内容...',
          description: '文本域的占位符',
        ),
        StorybookNumberControl(
          label: '最小行数',
          defaultValue: 3,
          description: '最小行数',
        ),
        StorybookNumberControl(
          label: '最大行数',
          defaultValue: 5,
          description: '最大行数',
        ),
        StorybookBooleanControl(
          label: '自动调整高度',
          defaultValue: false,
          description: '是否自动调整高度',
        ),
        StorybookNumberControl(
          label: '最大字符数',
          defaultValue: 0,
          description: '最大字符数（0表示无限制）',
        ),
      ],
      codeExample: '''
// 基础文本域
chromaTextArea(
  label: '描述',
  placeholder: '请输入描述信息...',
  minLines: 3,
  maxLines: 5,
  onChanged: (value) {
    print('文本内容: $value');
  },
)

// 自动调整高度
chromaTextArea(
  label: '留言',
  placeholder: '请输入您的留言...',
  autoHeight: true,
  minLines: 2,
  maxLines: 6,
)

// 带字符计数
chromaTextArea(
  label: '评论',
  placeholder: '请输入您的评论...',
  maxLength: 500,
  showCharacterCount: true,
  maxLines: 4,
)
''',
    );
  }

  /// 选择框组件故事
  static StorybookStory _selectFieldStory() {
    return StorybookStory(
      name: 'chromaSelectField',
      category: '表单组件',
      description: '下拉选择组件，支持单选和多选',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础选择框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSelectField<String>(
            label: '选择城市',
            placeholder: '请选择城市',
            items: [
              DropdownMenuItem(value: 'beijing', child: const Text('北京')),
              DropdownMenuItem(value: 'shanghai', child: const Text('上海')),
              DropdownMenuItem(value: 'guangzhou', child: const Text('广州')),
              DropdownMenuItem(value: 'shenzhen', child: const Text('深圳')),
            ],
            onChanged: (value) {
              print('选择的城市: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('带搜索的选择框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSelectField<String>(
            label: '选择国家',
            placeholder: '请搜索并选择国家',
            enableSearch: true,
            items: [
              DropdownMenuItem(value: 'cn', child: const Text('中国')),
              DropdownMenuItem(value: 'us', child: const Text('美国')),
              DropdownMenuItem(value: 'uk', child: const Text('英国')),
              DropdownMenuItem(value: 'jp', child: const Text('日本')),
              DropdownMenuItem(value: 'kr', child: const Text('韩国')),
            ],
            onChanged: (value) {
              print('选择的国家: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('多选选择框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSelectField<String>(
            label: '选择技能',
            placeholder: '请选择技能',
            isMultiSelect: true,
            items: [
              DropdownMenuItem(value: 'flutter', child: const Text('Flutter')),
              DropdownMenuItem(value: 'react', child: const Text('React')),
              DropdownMenuItem(value: 'vue', child: const Text('Vue')),
              DropdownMenuItem(value: 'angular', child: const Text('Angular')),
              DropdownMenuItem(value: 'nodejs', child: const Text('Node.js')),
            ],
            onChanged: (values) {
              print('选择的技能: $values');
            },
          ),
          const SizedBox(height: 24),
          const Text('带分组的选择框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSelectField<String>(
            label: '选择编程语言',
            placeholder: '请选择编程语言',
            items: [
              const DropdownMenuItem(
                value: null,
                enabled: false,
                child: Text('前端语言', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DropdownMenuItem(value: 'javascript', child: const Text('JavaScript')),
              DropdownMenuItem(value: 'typescript', child: const Text('TypeScript')),
              const DropdownMenuItem(
                value: null,
                enabled: false,
                child: Text('后端语言', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DropdownMenuItem(value: 'python', child: const Text('Python')),
              DropdownMenuItem(value: 'java', child: const Text('Java')),
              DropdownMenuItem(value: 'go', child: const Text('Go')),
            ],
            onChanged: (value) {
              print('选择的编程语言: $value');
            },
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '选择框',
          description: '选择框的标签',
        ),
        StorybookStringControl(
          label: '占位符',
          defaultValue: '请选择',
          description: '选择框的占位符',
        ),
        StorybookBooleanControl(
          label: '多选',
          defaultValue: false,
          description: '是否支持多选',
        ),
        StorybookBooleanControl(
          label: '搜索',
          defaultValue: false,
          description: '是否支持搜索',
        ),
        StorybookBooleanControl(
          label: '必填',
          defaultValue: false,
          description: '是否为必填字段',
        ),
      ],
      codeExample: '''
// 基础选择框
chromaSelectField<String>(
  label: '选择城市',
  placeholder: '请选择城市',
  items: [
    DropdownMenuItem(value: 'beijing', child: Text('北京')),
    DropdownMenuItem(value: 'shanghai', child: Text('上海')),
    DropdownMenuItem(value: 'guangzhou', child: Text('广州')),
  ],
  onChanged: (value) {
    print('选择的城市: $value');
  },
)

// 多选选择框
chromaSelectField<String>(
  label: '选择技能',
  placeholder: '请选择技能',
  isMultiSelect: true,
  items: [
    DropdownMenuItem(value: 'flutter', child: Text('Flutter')),
    DropdownMenuItem(value: 'react', child: Text('React')),
    DropdownMenuItem(value: 'vue', child: Text('Vue')),
  ],
  onChanged: (values) {
    print('选择的技能: $values');
  },
)

// 带搜索的选择框
chromaSelectField<String>(
  label: '选择国家',
  placeholder: '请搜索并选择国家',
  enableSearch: true,
  items: [
    DropdownMenuItem(value: 'cn', child: Text('中国')),
    DropdownMenuItem(value: 'us', child: Text('美国')),
    DropdownMenuItem(value: 'uk', child: Text('英国')),
  ],
  onChanged: (value) {
    print('选择的国家: $value');
  },
)
''',
    );
  }

  /// 复选框组件故事
  static StorybookStory _checkboxStory() {
    return StorybookStory(
      name: 'chromaCheckbox',
      category: '表单组件',
      description: '复选框组件，支持多种状态和样式',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础复选框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chromaCheckbox(
                label: '选项 1',
                value: true,
                onChanged: (value) {
                  print('选项 1: $value');
                },
              ),
              const SizedBox(height: 8),
              chromaCheckbox(
                label: '选项 2',
                value: false,
                onChanged: (value) {
                  print('选项 2: $value');
                },
              ),
              const SizedBox(height: 8),
              chromaCheckbox(
                label: '禁用选项',
                value: false,
                enabled: false,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('不同样式的复选框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chromaCheckbox(
                label: '主要复选框',
                value: true,
                variant: 'primary',
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              chromaCheckbox(
                label: '成功复选框',
                value: true,
                variant: 'success',
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              chromaCheckbox(
                label: '警告复选框',
                value: true,
                variant: 'warning',
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              chromaCheckbox(
                label: '危险复选框',
                value: true,
                variant: 'danger',
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('三态复选框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chromaCheckbox(
                label: '全选',
                value: true,
                tristate: true,
                onChanged: (value) {
                  print('全选状态: $value');
                },
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    chromaCheckbox(
                      label: '子选项 1',
                      value: true,
                      onChanged: null,
                    ),
                    SizedBox(height: 8),
                    chromaCheckbox(
                      label: '子选项 2',
                      value: false,
                      onChanged: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('带描述的复选框', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaCheckbox(
            label: '接收邮件通知',
            description: '我们会向您发送重要更新和促销信息',
            value: true,
            onChanged: (value) {
              print('邮件通知: $value');
            },
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '复选框',
          description: '复选框的标签',
        ),
        StorybookBooleanControl(
          label: '选中',
          defaultValue: false,
          description: '是否选中',
        ),
        StorybookBooleanControl(
          label: '禁用',
          defaultValue: false,
          description: '是否禁用',
        ),
        StorybookSelectControl(
          label: '变体',
          defaultValue: 'primary',
          options: ['primary', 'secondary', 'success', 'warning', 'danger'],
          description: '复选框的视觉变体',
        ),
      ],
      codeExample: '''
// 基础复选框
chromaCheckbox(
  label: '接受条款',
  value: false,
  onChanged: (value) {
    print('接受条款: $value');
  },
)

// 带描述的复选框
chromaCheckbox(
  label: '接收邮件通知',
  description: '我们会向您发送重要更新和促销信息',
  value: true,
  onChanged: (value) {
    print('邮件通知: $value');
  },
)

// 三态复选框
chromaCheckbox(
  label: '全选',
  value: true,
  tristate: true,
  onChanged: (value) {
    print('全选状态: $value');
  },
)

// 不同样式的复选框
chromaCheckbox(
  label: '主要选项',
  value: true,
  variant: 'primary',
  onChanged: (value) {},
)
''',
    );
  }

  /// 单选框组件故事
  static StorybookStory _radioGroupStory() {
    return StorybookStory(
      name: 'chromaRadioGroup',
      category: '表单组件',
      description: '单选框组组件，支持垂直和水平布局',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('垂直单选框组', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaRadioGroup<String>(
            label: '选择性别',
            options: [
              chromaRadioOption(value: 'male', label: '男'),
              chromaRadioOption(value: 'female', label: '女'),
              chromaRadioOption(value: 'other', label: '其他'),
            ],
            value: 'male',
            onChanged: (value) {
              print('选择的性别: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('水平单选框组', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaRadioGroup<String>(
            label: '选择支付方式',
            options: [
              chromaRadioOption(value: 'alipay', label: '支付宝'),
              chromaRadioOption(value: 'wechat', label: '微信支付'),
              chromaRadioOption(value: 'bank', label: '银行卡'),
            ],
            value: 'alipay',
            orientation: Axis.horizontal,
            onChanged: (value) {
              print('选择的支付方式: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('带描述的单选框组', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaRadioGroup<String>(
            label: '选择订阅计划',
            options: [
              chromaRadioOption(
                value: 'free',
                label: '免费版',
                description: '基础功能，适合个人使用',
              ),
              chromaRadioOption(
                value: 'pro',
                label: '专业版',
                description: '高级功能，适合专业人士',
              ),
              chromaRadioOption(
                value: 'enterprise',
                label: '企业版',
                description: '全部功能，适合团队使用',
              ),
            ],
            value: 'free',
            onChanged: (value) {
              print('选择的订阅计划: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('禁用的单选框组', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaRadioGroup<String>(
            label: '选择配送方式',
            options: [
              chromaRadioOption(value: 'standard', label: '标准配送'),
              chromaRadioOption(value: 'express', label: '快速配送'),
              chromaRadioOption(value: 'overnight', label: '隔夜配送'),
            ],
            value: 'standard',
            enabled: false,
            onChanged: (value) {
              print('选择的配送方式: $value');
            },
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '单选框组',
          description: '单选框组的标签',
        ),
        StorybookSelectControl(
          label: '布局方向',
          defaultValue: 'vertical',
          options: ['vertical', 'horizontal'],
          description: '单选框组的布局方向',
        ),
        StorybookBooleanControl(
          label: '禁用',
          defaultValue: false,
          description: '是否禁用单选框组',
        ),
        StorybookBooleanControl(
          label: '必填',
          defaultValue: false,
          description: '是否为必填字段',
        ),
      ],
      codeExample: '''
// 垂直单选框组
chromaRadioGroup<String>(
  label: '选择性别',
  options: [
    chromaRadioOption(value: 'male', label: '男'),
    chromaRadioOption(value: 'female', label: '女'),
    chromaRadioOption(value: 'other', label: '其他'),
  ],
  value: 'male',
  onChanged: (value) {
    print('选择的性别: $value');
  },
)

// 水平单选框组
chromaRadioGroup<String>(
  label: '选择支付方式',
  options: [
    chromaRadioOption(value: 'alipay', label: '支付宝'),
    chromaRadioOption(value: 'wechat', label: '微信支付'),
    chromaRadioOption(value: 'bank', label: '银行卡'),
  ],
  value: 'alipay',
  orientation: Axis.horizontal,
  onChanged: (value) {
    print('选择的支付方式: $value');
  },
)

// 带描述的单选框组
chromaRadioGroup<String>(
  label: '选择订阅计划',
  options: [
    chromaRadioOption(
      value: 'free',
      label: '免费版',
      description: '基础功能，适合个人使用',
    ),
    chromaRadioOption(
      value: 'pro',
      label: '专业版',
      description: '高级功能，适合专业人士',
    ),
  ],
  value: 'free',
  onChanged: (value) {
    print('选择的订阅计划: $value');
  },
)
''',
    );
  }

  /// 开关组件故事
  static StorybookStory _switchStory() {
    return StorybookStory(
      name: 'chromaSwitch',
      category: '表单组件',
      description: '开关组件，支持多种样式和状态',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础开关', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chromaSwitch(
                label: '启用通知',
                value: true,
                onChanged: (value) {
                  print('通知状态: $value');
                },
              ),
              const SizedBox(height: 16),
              chromaSwitch(
                label: '自动更新',
                value: false,
                onChanged: (value) {
                  print('自动更新状态: $value');
                },
              ),
              const SizedBox(height: 16),
              chromaSwitch(
                label: '禁用开关',
                value: false,
                enabled: false,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('不同样式的开关', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chromaSwitch(
                label: '主要开关',
                value: true,
                variant: 'primary',
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              chromaSwitch(
                label: '成功开关',
                value: true,
                variant: 'success',
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              chromaSwitch(
                label: '警告开关',
                value: true,
                variant: 'warning',
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              chromaSwitch(
                label: '危险开关',
                value: true,
                variant: 'danger',
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('带描述的开关', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSwitch(
            label: '深色模式',
            description: '启用深色主题以保护您的眼睛',
            value: false,
            onChanged: (value) {
              print('深色模式: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('带图标的开关', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSwitch(
            label: 'Wi-Fi',
            activeIcon: Icons.wifi,
            inactiveIcon: Icons.wifi_off,
            value: true,
            onChanged: (value) {
              print('Wi-Fi 状态: $value');
            },
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '开关',
          description: '开关的标签',
        ),
        StorybookBooleanControl(
          label: '开启',
          defaultValue: false,
          description: '是否开启',
        ),
        StorybookBooleanControl(
          label: '禁用',
          defaultValue: false,
          description: '是否禁用',
        ),
        StorybookSelectControl(
          label: '变体',
          defaultValue: 'primary',
          options: ['primary', 'secondary', 'success', 'warning', 'danger'],
          description: '开关的视觉变体',
        ),
      ],
      codeExample: '''
// 基础开关
chromaSwitch(
  label: '启用通知',
  value: true,
  onChanged: (value) {
    print('通知状态: $value');
  },
)

// 带描述的开关
chromaSwitch(
  label: '深色模式',
  description: '启用深色主题以保护您的眼睛',
  value: false,
  onChanged: (value) {
    print('深色模式: $value');
  },
)

// 带图标的开关
chromaSwitch(
  label: 'Wi-Fi',
  activeIcon: Icons.wifi,
  inactiveIcon: Icons.wifi_off,
  value: true,
  onChanged: (value) {
    print('Wi-Fi 状态: $value');
  },
)

// 不同样式的开关
chromaSwitch(
  label: '主要开关',
  value: true,
  variant: 'primary',
  onChanged: (value) {},
)
''',
    );
  }

  /// 滑块组件故事
  static StorybookStory _sliderStory() {
    return StorybookStory(
      name: 'chromaSlider',
      category: '表单组件',
      description: '滑块组件，支持单值和范围选择',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础滑块', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSlider(
            label: '音量',
            value: 50,
            min: 0,
            max: 100,
            onChanged: (value) {
              print('音量: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('带刻度的滑块', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSlider(
            label: '亮度',
            value: 75,
            min: 0,
            max: 100,
            divisions: 10,
            onChanged: (value) {
              print('亮度: $value');
            },
          ),
          const SizedBox(height: 24),
          const Text('范围滑块', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSlider(
            label: '价格范围',
            startValue: 100,
            endValue: 500,
            min: 0,
            max: 1000,
            isRange: true,
            onChanged: (start, end) {
              print('价格范围: $start - $end');
            },
          ),
          const SizedBox(height: 24),
          const Text('垂直滑块', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: chromaSlider(
              label: '进度',
              value: 30,
              min: 0,
              max: 100,
              orientation: Axis.vertical,
              onChanged: (value) {
                print('进度: $value');
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text('带图标的滑块', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaSlider(
            label: '音量',
            value: 70,
            min: 0,
            max: 100,
            leadingIcon: Icons.volume_down,
            trailingIcon: Icons.volume_up,
            onChanged: (value) {
              print('音量: $value');
            },
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '滑块',
          description: '滑块的标签',
        ),
        StorybookNumberControl(
          label: '最小值',
          defaultValue: 0.0,
          description: '滑块的最小值',
        ),
        StorybookNumberControl(
          label: '最大值',
          defaultValue: 100.0,
          description: '滑块的最大值',
        ),
        StorybookNumberControl(
          label: '当前值',
          defaultValue: 50.0,
          description: '滑块的当前值',
        ),
        StorybookBooleanControl(
          label: '范围选择',
          defaultValue: false,
          description: '是否为范围选择',
        ),
      ],
      codeExample: '''
// 基础滑块
chromaSlider(
  label: '音量',
  value: 50,
  min: 0,
  max: 100,
  onChanged: (value) {
    print('音量: $value');
  },
)

// 带刻度的滑块
chromaSlider(
  label: '亮度',
  value: 75,
  min: 0,
  max: 100,
  divisions: 10,
  onChanged: (value) {
    print('亮度: $value');
  },
)

// 范围滑块
chromaSlider(
  label: '价格范围',
  startValue: 100,
  endValue: 500,
  min: 0,
  max: 1000,
  isRange: true,
  onChanged: (start, end) {
    print('价格范围: $start - $end');
  },
)

// 垂直滑块
chromaSlider(
  label: '进度',
  value: 30,
  min: 0,
  max: 100,
  orientation: Axis.vertical,
  onChanged: (value) {
    print('进度: $value');
  },
)
''',
    );
  }

  /// 日期选择器组件故事
  static StorybookStory _datePickerStory() {
    return StorybookStory(
      name: 'chromaDatePicker',
      category: '表单组件',
      description: '日期选择器组件，支持多种选择模式',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础日期选择器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDatePicker(
            label: '选择日期',
            placeholder: '请选择日期',
            onChanged: (date) {
              print('选择的日期: $date');
            },
          ),
          const SizedBox(height: 24),
          const Text('日期范围选择器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDatePicker(
            label: '选择日期范围',
            placeholder: '请选择开始日期',
            endPlaceholder: '请选择结束日期',
            isRange: true,
            onChanged: (start, end) {
              print('日期范围: $start - $end');
            },
          ),
          const SizedBox(height: 24),
          const Text('带时间选择', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDatePicker(
            label: '选择日期和时间',
            placeholder: '请选择日期和时间',
            includeTime: true,
            onChanged: (dateTime) {
              print('选择的日期时间: $dateTime');
            },
          ),
          const SizedBox(height: 24),
          const Text('禁用日期', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDatePicker(
            label: '选择预约日期',
            placeholder: '请选择预约日期',
            disabledDates: (date) {
              // 禁用周末
              return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
            },
            onChanged: (date) {
              print('预约日期: $date');
            },
          ),
          const SizedBox(height: 24),
          const Text('日期限制', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaDatePicker(
            label: '选择出生日期',
            placeholder: '请选择出生日期',
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            onChanged: (date) {
              print('出生日期: $date');
            },
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '日期选择器',
          description: '日期选择器的标签',
        ),
        StorybookStringControl(
          label: '占位符',
          defaultValue: '请选择日期',
          description: '日期选择器的占位符',
        ),
        StorybookBooleanControl(
          label: '范围选择',
          defaultValue: false,
          description: '是否为范围选择',
        ),
        StorybookBooleanControl(
          label: '包含时间',
          defaultValue: false,
          description: '是否包含时间选择',
        ),
        StorybookBooleanControl(
          label: '必填',
          defaultValue: false,
          description: '是否为必填字段',
        ),
      ],
      codeExample: '''
// 基础日期选择器
chromaDatePicker(
  label: '选择日期',
  placeholder: '请选择日期',
  onChanged: (date) {
    print('选择的日期: $date');
  },
)

// 日期范围选择器
chromaDatePicker(
  label: '选择日期范围',
  placeholder: '请选择开始日期',
  endPlaceholder: '请选择结束日期',
  isRange: true,
  onChanged: (start, end) {
    print('日期范围: $start - $end');
  },
)

// 带时间选择
chromaDatePicker(
  label: '选择日期和时间',
  placeholder: '请选择日期和时间',
  includeTime: true,
  onChanged: (dateTime) {
    print('选择的日期时间: $dateTime');
  },
)

// 日期限制
chromaDatePicker(
  label: '选择出生日期',
  placeholder: '请选择出生日期',
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  onChanged: (date) {
    print('出生日期: $date');
  },
)
''',
    );
  }

  /// 时间选择器组件故事
  static StorybookStory _timePickerStory() {
    return StorybookStory(
      name: 'chromaTimePicker',
      category: '表单组件',
      description: '时间选择器组件，支持12小时和24小时制',
      component: (context, controls) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('基础时间选择器', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTimePicker(
            label: '选择时间',
            placeholder: '请选择时间',
            onChanged: (time) {
              print('选择的时间: $time');
            },
          ),
          const SizedBox(height: 24),
          const Text('24小时制', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTimePicker(
            label: '选择时间 (24小时制)',
            placeholder: '请选择时间',
            is24HourFormat: true,
            onChanged: (time) {
              print('选择的时间: $time');
            },
          ),
          const SizedBox(height: 24),
          const Text('时间间隔', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTimePicker(
            label: '选择预约时间',
            placeholder: '请选择时间',
            minuteInterval: 15,
            onChanged: (time) {
              print('预约时间: $time');
            },
          ),
          const SizedBox(height: 24),
          const Text('时间范围', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          chromaTimePicker(
            label: '选择工作时间',
            placeholder: '请选择开始时间',
            endPlaceholder: '请选择结束时间',
            isRange: true,
            startTime: const TimeOfDay(hour: 9, minute: 0),
            endTime: const TimeOfDay(hour: 18, minute: 0),
            onChanged: (start, end) {
              print('工作时间: $start - $end');
            },
          ),
        ],
      ),
      controls: [
        StorybookStringControl(
          label: '标签',
          defaultValue: '时间选择器',
          description: '时间选择器的标签',
        ),
        StorybookStringControl(
          label: '占位符',
          defaultValue: '请选择时间',
          description: '时间选择器的占位符',
        ),
        StorybookBooleanControl(
          label: '24小时制',
          defaultValue: false,
          description: '是否使用24小时制',
        ),
        StorybookBooleanControl(
          label: '范围选择',
          defaultValue: false,
          description: '是否为范围选择',
        ),
        StorybookNumberControl(
          label: '分钟间隔',
          defaultValue: 1,
          description: '分钟间隔（1, 5, 10, 15, 30）',
        ),
      ],
      codeExample: '''
// 基础时间选择器
chromaTimePicker(
  label: '选择时间',
  placeholder: '请选择时间',
  onChanged: (time) {
    print('选择的时间: $time');
  },
)

// 24小时制
chromaTimePicker(
  label: '选择时间 (24小时制)',
  placeholder: '请选择时间',
  is24HourFormat: true,
  onChanged: (time) {
    print('选择的时间: $time');
  },
)

// 时间间隔
chromaTimePicker(
  label: '选择预约时间',
  placeholder: '请选择时间',
  minuteInterval: 15,
  onChanged: (time) {
    print('预约时间: $time');
  },
)

// 时间范围
chromaTimePicker(
  label: '选择工作时间',
  placeholder: '请选择开始时间',
  endPlaceholder: '请选择结束时间',
  isRange: true,
  onChanged: (start, end) {
    print('工作时间: $start - $end');
  },
)
''',
    );
  }

  /// 表单验证组件故事
  static StorybookStory _formValidationStory() {
    return StorybookStory(
      name: 'chromaFormValidation',
      category: '表单组件',
      description: '表单验证组件，支持实时验证和提交验证',
      component: (context, controls) => StatefulBuilder(
        builder: (context, setState) {
          final formKey = GlobalKey<FormState>();
          String? email;
          String? password;
          bool agreedToTerms = false;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('表单验证示例', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              chromaCard(
                title: '注册表单',
                content: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      chromaInputField(
                        label: '邮箱',
                        placeholder: '请输入邮箱地址',
                        keyboardType: TextInputType.emailAddress,
                        required: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return '邮箱不能为空';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                            return '请输入有效的邮箱地址';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      chromaInputField(
                        label: '密码',
                        placeholder: '请输入密码',
                        obscureText: true,
                        required: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return '密码不能为空';
                          }
                          if (value!.length < 6) {
                            return '密码长度至少6位';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      chromaCheckbox(
                        label: '我同意服务条款和隐私政策',
                        value: agreedToTerms,
                        validator: (value) {
                          if (value != true) {
                            return '请同意服务条款';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            agreedToTerms = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: chromaButton(
                              text: '重置',
                              variant: 'secondary',
                              onPressed: () {
                                formKey.currentState?.reset();
                                setState(() {
                                  email = null;
                                  password = null;
                                  agreedToTerms = false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: chromaButton(
                              text: '提交',
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  print('表单验证通过');
                                  print('邮箱: $email');
                                  print('密码: $password');
                                  print('同意条款: $agreedToTerms');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('实时验证', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              chromaInputField(
                label: '用户名',
                placeholder: '请输入用户名',
                required: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '用户名不能为空';
                  }
                  if (value!.length < 3) {
                    return '用户名长度至少3位';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                    return '用户名只能包含字母、数字和下划线';
                  }
                  return null;
                },
                validateMode: AutovalidateMode.onUserInteraction,
              ),
            ],
          );
        },
      ),
      controls: [
        StorybookStringControl(
          label: '表单标题',
          defaultValue: '表单验证',
          description: '表单的标题',
        ),
        StorybookBooleanControl(
          label: '实时验证',
          defaultValue: false,
          description: '是否启用实时验证',
        ),
        StorybookBooleanControl(
          label: '显示验证规则',
          defaultValue: true,
          description: '是否显示验证规则说明',
        ),
      ],
      codeExample: '''
// 基础表单验证
Form(
  key: formKey,
  child: Column(
    children: [
      chromaInputField(
        label: '邮箱',
        placeholder: '请输入邮箱地址',
        keyboardType: TextInputType.emailAddress,
        required: true,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return '邮箱不能为空';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
            return '请输入有效的邮箱地址';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      chromaInputField(
        label: '密码',
        placeholder: '请输入密码',
        obscureText: true,
        required: true,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return '密码不能为空';
          }
          if (value!.length < 6) {
            return '密码长度至少6位';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      chromaButton(
        text: '提交',
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            // 表单验证通过
            print('提交成功');
          }
        },
      ),
    ],
  ),
)

// 实时验证
chromaInputField(
  label: '用户名',
  placeholder: '请输入用户名',
  required: true,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return '用户名不能为空';
    }
    if (value!.length < 3) {
      return '用户名长度至少3位';
    }
    return null;
  },
  validateMode: AutovalidateMode.onUserInteraction,
)
''',
    );
  }
}
