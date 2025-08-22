# ZephyrStepper 步骤条组件

步骤条组件是ZephyrUI导航系统的重要组件，提供了清晰的多步骤流程导航功能。支持多种布局模式、自定义样式和交互方式，是构建表单流程、任务引导、进度跟踪的理想选择。

## 🎯 组件概述

### 特性
- **多种布局模式**: 支持水平、垂直、自定义布局
- **灵活步骤管理**: 支持动态添加、删除、禁用步骤
- **丰富状态**: 支持待处理、进行中、已完成、错误等状态
- **自定义样式**: 支持自定义图标、颜色、连接线样式
- **交互控制**: 支持点击跳转、键盘导航、触摸滑动
- **主题适配**: 完整的主题系统支持

### 适用场景
- 表单多步骤流程
- 用户注册流程
- 订单确认流程
- 向导式操作
- 任务进度跟踪
- 安装/配置向导

## 🚀 基础用法

### 基本步骤条

```dart
class BasicStepperExample extends StatefulWidget {
  @override
  _BasicStepperExampleState createState() => _BasicStepperExampleState();
}

class _BasicStepperExampleState extends State<BasicStepperExample> {
  int _currentStep = 0;

  final List<StepData> _steps = [
    StepData(
      title: '基本信息',
      subtitle: '填写个人基本信息',
      icon: Icons.person,
    ),
    StepData(
      title: '联系方式',
      subtitle: '填写联系方式',
      icon: Icons.phone,
    ),
    StepData(
      title: '确认信息',
      subtitle: '确认所有信息',
      icon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本步骤条'),
      ),
      body: Column(
        children: [
          // 步骤条
          ZephyrStepper(
            currentStep: _currentStep,
            steps: _steps.map((step) => ZephyrStep(
              title: Text(step.title),
              subtitle: Text(step.subtitle),
              icon: Icon(step.icon),
            )).toList(),
            onStepTapped: (index) {
              setState(() => _currentStep = index);
            },
          ),
          
          // 步骤内容
          Expanded(
            child: _buildStepContent(),
          ),
          
          // 控制按钮
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildContactStep();
      case 2:
        return _buildConfirmationStep();
      default:
        return Center(child: Text('未知步骤'));
    }
  }

  Widget _buildBasicInfoStep() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '基本信息',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(
              labelText: '姓名',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '年龄',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '职业',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactStep() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '联系方式',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(
              labelText: '邮箱',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '电话',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '地址',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationStep() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '确认信息',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Text(
            '请确认您填写的信息是否正确：',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('基本信息：', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('姓名：张三'),
                  Text('年龄：25'),
                  Text('职业：工程师'),
                  SizedBox(height: 16),
                  Text('联系方式：', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('邮箱：zhangsan@example.com'),
                  Text('电话：13800138000'),
                  Text('地址：北京市朝阳区'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() => _currentStep--);
                },
                child: Text('上一步'),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < _steps.length - 1) {
                  setState(() => _currentStep++);
                } else {
                  _submitForm();
                }
              },
              child: Text(_currentStep < _steps.length - 1 ? '下一步' : '完成'),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('表单提交成功！')),
    );
  }
}

class StepData {
  final String title;
  final String subtitle;
  final IconData icon;

  StepData(this.title, this.subtitle, this.icon);
}
```

### 垂直步骤条

```dart
class VerticalStepperExample extends StatefulWidget {
  @override
  _VerticalStepperExampleState createState() => _VerticalStepperExampleState();
}

class _VerticalStepperExampleState extends State<VerticalStepperExample> {
  int _currentStep = 0;

  final List<StepData> _steps = [
    StepData(
      title: '项目选择',
      subtitle: '选择要创建的项目类型',
      icon: Icons.folder,
    ),
    StepData(
      title: '配置设置',
      subtitle: '配置项目的基本设置',
      icon: Icons.settings,
    ),
    StepData(
      title: '添加成员',
      subtitle: '邀请团队成员加入项目',
      icon: Icons.group_add,
    ),
    StepData(
      title: '完成创建',
      subtitle: '项目创建完成',
      icon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('垂直步骤条'),
      ),
      body: ZephyrStepper(
        currentStep: _currentStep,
        direction: Axis.vertical,
        steps: _steps.map((step) => ZephyrStep(
          title: Text(step.title),
          subtitle: Text(step.subtitle),
          icon: Icon(step.icon),
          content: _buildStepContent(_steps.indexOf(step)),
        )).toList(),
        onStepTapped: (index) {
          setState(() => _currentStep = index);
        },
        onStepContinue: () {
          if (_currentStep < _steps.length - 1) {
            setState(() => _currentStep++);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                if (details.currentStep > 0)
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    child: Text('上一步'),
                  ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(
                      details.currentStep < _steps.length - 1 ? '下一步' : '完成'
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepContent(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return _buildProjectSelectionStep();
      case 1:
        return _buildConfigurationStep();
      case 2:
        return _buildTeamMembersStep();
      case 3:
        return _buildCompletionStep();
      default:
        return Center(child: Text('未知步骤'));
    }
  }

  Widget _buildProjectSelectionStep() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '选择项目类型',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ...['Web应用', '移动应用', '桌面应用', 'API服务'].map((type) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.radio_button_unchecked),
                title: Text(type),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('选择了: $type')),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildConfigurationStep() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '项目配置',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '项目名称',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '项目描述',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMembersStep() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '邀请团队成员',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: '邮箱地址',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.add),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '已邀请的成员：',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('A')),
              title: Text('Alice'),
              subtitle: Text('alice@example.com'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionStep() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '项目创建完成！',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.green[50],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.check_circle, size: 48, color: Colors.green),
                  SizedBox(height: 16),
                  Text(
                    '您的项目已成功创建',
                    style: TextStyle(fontSize: 16, color: Colors.green[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '项目ID: PRJ-2024-001',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义步骤条样式

```dart
class CustomStepperExample extends StatefulWidget {
  @override
  _CustomStepperExampleState createState() => _CustomStepperExampleState();
}

class _CustomStepperExampleState extends State<CustomStepperExample> {
  int _currentStep = 0;

  final List<StepData> _steps = [
    StepData(
      title: '购物车',
      subtitle: '确认商品',
      icon: Icons.shopping_cart,
      color: Colors.blue,
    ),
    StepData(
      title: '收货地址',
      subtitle: '选择收货地址',
      icon: Icons.location_on,
      color: Colors.orange,
    ),
    StepData(
      title: '支付方式',
      subtitle: '选择支付方式',
      icon: Icons.payment,
      color: Colors.green,
    ),
    StepData(
      title: '订单确认',
      subtitle: '确认订单信息',
      icon: Icons.check_circle,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义样式步骤条'),
      ),
      body: Column(
        children: [
          // 自定义样式步骤条
          ZephyrStepper(
            currentStep: _currentStep,
            steps: _steps.map((step) => ZephyrStep(
              title: Text(step.title),
              subtitle: Text(step.subtitle),
              icon: Icon(step.icon, color: Colors.white),
              isActive: _currentStep >= _steps.indexOf(step),
              state: _getStepState(_steps.indexOf(step)),
            )).toList(),
            stepStyle: ZephyrStepStyle(
              activeColor: Colors.blue,
              inactiveColor: Colors.grey[300],
              errorColor: Colors.red,
              completedColor: Colors.green,
              connectorColor: Colors.grey[300],
              connectorWidth: 2,
              stepRadius: 24,
              iconSize: 16,
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              subtitleStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            onStepTapped: (index) {
              setState(() => _currentStep = index);
            },
          ),
          
          // 步骤内容
          Expanded(
            child: _buildCustomStepContent(),
          ),
          
          // 控制按钮
          _buildCustomControlButtons(),
        ],
      ),
    );
  }

  ZephyrStepState _getStepState(int index) {
    if (index < _currentStep) {
      return ZephyrStepState.completed;
    } else if (index == _currentStep) {
      return ZephyrStepState.editing;
    } else {
      return ZephyrStepState.indexed;
    }
  }

  Widget _buildCustomStepContent() {
    final currentStepData = _steps[_currentStep];
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            currentStepData.color.withOpacity(0.1),
            currentStepData.color.withOpacity(0.05),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: currentStepData.color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    currentStepData.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentStepData.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: currentStepData.color,
                        ),
                      ),
                      Text(
                        currentStepData.subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            _buildStepSpecificContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepSpecificContent() {
    switch (_currentStep) {
      case 0:
        return _buildShoppingCartStep();
      case 1:
        return _buildAddressStep();
      case 2:
        return _buildPaymentStep();
      case 3:
        return _buildOrderConfirmationStep();
      default:
        return Center(child: Text('未知步骤'));
    }
  }

  Widget _buildShoppingCartStep() {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('商品名称'),
            subtitle: Text('数量: 1, 价格: ¥99.00'),
            trailing: Text('¥99.00'),
          ),
        ),
        SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('商品名称'),
            subtitle: Text('数量: 2, 价格: ¥49.00'),
            trailing: Text('¥98.00'),
          ),
        ),
        SizedBox(height: 16),
        Card(
          color: Colors.blue[50],
          child: ListTile(
            title: Text('总计'),
            trailing: Text(
              '¥197.00',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressStep() {
    return Column(
      children: [
        ...[
          {'name': '家', 'address': '北京市朝阳区xxx街道xxx号'},
          {'name': '公司', 'address': '北京市海淀区xxx大厦xxx层'},
          {'name': '其他', 'address': '添加新地址'},
        ].map((address) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(address['name']!),
              subtitle: Text(address['address']!),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选择了: ${address['name']}')),
                );
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildPaymentStep() {
    return Column(
      children: [
        ...[
          {'name': '支付宝', 'icon': Icons.account_balance_wallet},
          {'name': '微信支付', 'icon': Icons.wechat},
          {'name': '银行卡', 'icon': Icons.credit_card},
          {'name': '货到付款', 'icon': Icons.local_shipping},
        ].map((payment) {
          return Card(
            child: ListTile(
              leading: Icon(payment['icon'] as IconData),
              title: Text(payment['name']!),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('选择了: ${payment['name']}')),
                );
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildOrderConfirmationStep() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '订单信息',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildOrderInfoRow('商品数量', '3件'),
            _buildOrderInfoRow('商品总价', '¥197.00'),
            _buildOrderInfoRow('运费', '¥0.00'),
            _buildOrderInfoRow('优惠', '-¥10.00'),
            Divider(),
            _buildOrderInfoRow(
              '应付金额',
              '¥187.00',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomControlButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() => _currentStep--);
                },
                child: Text('上一步'),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < _steps.length - 1) {
                  setState(() => _currentStep++);
                } else {
                  _submitOrder();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _steps[_currentStep].color,
                foregroundColor: Colors.white,
              ),
              child: Text(_currentStep < _steps.length - 1 ? '下一步' : '提交订单'),
            ),
          ),
        ],
      ),
    );
  }

  void _submitOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('订单提交成功！')),
    );
  }
}
```

## 🔧 高级用法

### 带验证的步骤条

```dart
class ValidatedStepperExample extends StatefulWidget {
  @override
  _ValidatedStepperExampleState createState() => _ValidatedStepperExampleState();
}

class _ValidatedStepperExampleState extends State<ValidatedStepperExample> {
  int _currentStep = 0;
  final Map<int, bool> _stepValidation = {};
  final Map<int, String> _stepErrors = {};
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

  final List<StepData> _steps = [
    StepData(
      title: '个人信息',
      subtitle: '填写个人基本信息',
      icon: Icons.person,
    ),
    StepData(
      title: '公司信息',
      subtitle: '填写公司相关信息',
      icon: Icons.business,
    ),
    StepData(
      title: '提交审核',
      subtitle: '确认并提交信息',
      icon: Icons.send,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('带验证的步骤条'),
      ),
      body: ZephyrStepper(
        currentStep: _currentStep,
        steps: _steps.map((step) => ZephyrStep(
          title: Text(step.title),
          subtitle: Text(step.subtitle),
          icon: Icon(step.icon),
          isActive: _currentStep >= _steps.indexOf(step),
          state: _getValidatedStepState(_steps.indexOf(step)),
          errorText: _stepErrors[_steps.indexOf(step)],
        )).toList(),
        onStepTapped: (index) {
          if (_canNavigateToStep(index)) {
            setState(() => _currentStep = index);
          }
        },
        onStepContinue: () {
          if (_validateCurrentStep()) {
            if (_currentStep < _steps.length - 1) {
              setState(() => _currentStep++);
            } else {
              _submitForm();
            }
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        controlsBuilder: (context, details) {
          return _buildCustomControls(details);
        },
      ),
    );
  }

  ZephyrStepState _getValidatedStepState(int index) {
    if (index < _currentStep) {
      return _stepValidation[index] == true 
          ? ZephyrStepState.completed 
          : ZephyrStepState.error;
    } else if (index == _currentStep) {
      return ZephyrStepState.editing;
    } else {
      return ZephyrStepState.indexed;
    }
  }

  bool _canNavigateToStep(int index) {
    if (index <= _currentStep) return true;
    
    // 验证前面的步骤是否都已完成
    for (int i = 0; i < index; i++) {
      if (_stepValidation[i] != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('请先完成步骤 ${i + 1}')),
        );
        return false;
      }
    }
    return true;
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      return _validatePersonalInfo();
    } else if (_currentStep == 1) {
      return _validateCompanyInfo();
    }
    return true;
  }

  bool _validatePersonalInfo() {
    final formState = _formKeys[0].currentState;
    if (formState != null && formState.validate()) {
      setState(() {
        _stepValidation[0] = true;
        _stepErrors.remove(0);
      });
      return true;
    } else {
      setState(() {
        _stepValidation[0] = false;
        _stepErrors[0] = '请填写完整的个人信息';
      });
      return false;
    }
  }

  bool _validateCompanyInfo() {
    final formState = _formKeys[1].currentState;
    if (formState != null && formState.validate()) {
      setState(() {
        _stepValidation[1] = true;
        _stepErrors.remove(1);
      });
      return true;
    } else {
      setState(() {
        _stepValidation[1] = false;
        _stepErrors[1] = '请填写完整的公司信息';
      });
      return false;
    }
  }

  Widget _buildCustomControls(ControlsDetails details) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (details.currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: details.onStepCancel,
                child: Text('上一步'),
              ),
            ),
          if (details.currentStep > 0) SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text(
                details.currentStep < _steps.length - 1 ? '下一步' : '提交'
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // 最终验证
    bool allValid = true;
    for (int i = 0; i < _steps.length - 1; i++) {
      if (_stepValidation[i] != true) {
        allValid = false;
        break;
      }
    }

    if (allValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('表单提交成功！')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请完成所有必填步骤')),
      );
    }
  }
}
```

### 动态步骤条

```dart
class DynamicStepperExample extends StatefulWidget {
  @override
  _DynamicStepperExampleState createState() => _DynamicStepperExampleState();
}

class _DynamicStepperExampleState extends State<DynamicStepperExample> {
  int _currentStep = 0;
  List<StepData> _steps = [
    StepData(
      title: '开始',
      subtitle: '流程开始',
      icon: Icons.play_arrow,
    ),
    StepData(
      title: '处理',
      subtitle: '数据处理',
      icon: Icons.settings,
    ),
    StepData(
      title: '完成',
      subtitle: '流程完成',
      icon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态步骤条'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addStep,
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _removeStep,
          ),
        ],
      ),
      body: Column(
        children: [
          // 动态步骤条
          ZephyrStepper(
            currentStep: _currentStep,
            steps: _steps.map((step) => ZephyrStep(
              title: Text(step.title),
              subtitle: Text(step.subtitle),
              icon: Icon(step.icon),
              isActive: _currentStep >= _steps.indexOf(step),
              state: _getDynamicStepState(_steps.indexOf(step)),
            )).toList(),
            onStepTapped: (index) {
              setState(() => _currentStep = index);
            },
          ),
          
          // 步骤内容
          Expanded(
            child: _buildDynamicStepContent(),
          ),
          
          // 控制按钮
          _buildDynamicControlButtons(),
        ],
      ),
    );
  }

  ZephyrStepState _getDynamicStepState(int index) {
    if (index < _currentStep) {
      return ZephyrStepState.completed;
    } else if (index == _currentStep) {
      return ZephyrStepState.editing;
    } else {
      return ZephyrStepState.indexed;
    }
  }

  Widget _buildDynamicStepContent() {
    final currentStepData = _steps[_currentStep];
    
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  currentStepData.icon,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentStepData.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentStepData.subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          Text(
            '这是第 ${_currentStep + 1} 步的内容',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            '总共有 ${_steps.length} 个步骤',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          if (_currentStep == _steps.length - 1)
            Card(
              color: Colors.green[50],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, size: 48, color: Colors.green),
                    SizedBox(height: 16),
                    Text(
                      '所有步骤已完成！',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDynamicControlButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() => _currentStep--);
                },
                child: Text('上一步'),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < _steps.length - 1) {
                  setState(() => _currentStep++);
                } else {
                  _completeProcess();
                }
              },
              child: Text(_currentStep < _steps.length - 1 ? '下一步' : '完成'),
            ),
          ),
        ],
      ),
    );
  }

  void _addStep() {
    final newStepIndex = _steps.length + 1;
    final newStep = StepData(
      title: '步骤 $newStepIndex',
      subtitle: '新增的步骤',
      icon: Icons.add_circle,
    );
    
    setState(() {
      _steps.add(newStep);
    });
  }

  void _removeStep() {
    if (_steps.length > 1) {
      setState(() {
        _steps.removeLast();
        if (_currentStep >= _steps.length) {
          _currentStep = _steps.length - 1;
        }
      });
    }
  }

  void _completeProcess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('动态流程完成！')),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrStepper()

```dart
const ZephyrStepper({
  Key? key,
  required List<ZephyrStep> steps,
  int currentStep = 0,
  Axis direction = Axis.horizontal,
  ValueChanged<int>? onStepTapped,
  VoidCallback? onStepContinue,
  VoidCallback? onStepCancel,
  ZephyrStepStyle? stepStyle,
  Widget Function(BuildContext, ControlsDetails)? controlsBuilder,
  bool enableStepTapping = true,
  bool enableKeyboardNavigation = true,
  Duration? animationDuration,
  Curve? animationCurve,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `steps`: 步骤列表
- `currentStep`: 当前步骤索引
- `direction`: 步骤条方向
- `onStepTapped`: 步骤点击回调
- `onStepContinue`: 继续按钮回调
- `onStepCancel`: 取消按钮回调
- `stepStyle`: 步骤样式
- `controlsBuilder`: 控制按钮构建器
- `enableStepTapping`: 是否启用步骤点击
- `enableKeyboardNavigation`: 是否启用键盘导航
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `padding`: 内边距
- `margin`: 外边距
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

#### ZephyrStep()

```dart
const ZephyrStep({
  Key? key,
  required Widget title,
  Widget? subtitle,
  Widget? content,
  Widget? icon,
  bool isActive = false,
  ZephyrStepState state = ZephyrStepState.indexed,
  String? errorText,
  bool enabled = true,
  String? semanticLabel,
})
```

### 枚举类型

#### ZephyrStepState

```dart
enum ZephyrStepState {
  indexed,    // 索引状态
  editing,    // 编辑状态
  completed,  // 完成状态
  disabled,   // 禁用状态
  error,      // 错误状态
}
```

### 样式类

#### ZephyrStepStyle

```dart
class ZephyrStepStyle {
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? errorColor;
  final Color? completedColor;
  final Color? connectorColor;
  final double? connectorWidth;
  final double? stepRadius;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? errorTextStyle;
  final EdgeInsetsGeometry? stepPadding;
  final EdgeInsetsGeometry? contentPadding;
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrStepperTheme(
        activeColor: Colors.blue,
        inactiveColor: Colors.grey[300],
        errorColor: Colors.red,
        completedColor: Colors.green,
        connectorColor: Colors.grey[300],
        connectorWidth: 2,
        stepRadius: 20,
        iconSize: 16,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        subtitleStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        errorTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        stepPadding: EdgeInsets.symmetric(horizontal: 24),
        contentPadding: EdgeInsets.all(16),
        disabledColor: Colors.grey[400],
        hoverColor: Colors.grey.withOpacity(0.1),
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `activeColor`: 激活颜色
- `inactiveColor`: 非激活颜色
- `errorColor`: 错误颜色
- `completedColor`: 完成颜色
- `connectorColor`: 连接线颜色
- `connectorWidth`: 连接线宽度
- `stepRadius`: 步骤圆圈半径
- `iconSize`: 图标大小
- `titleStyle`: 标题样式
- `subtitleStyle`: 副标题样式
- `errorTextStyle`: 错误文本样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `stepPadding`: 步骤内边距
- `contentPadding`: 内容内边距
- `disabledColor`: 禁用颜色
- `hoverColor`: 悬停颜色

## 🏆 最佳实践

### 1. 合理的步骤数量

```dart
// ✅ 好的做法：步骤数量适中
ZephyrStepper(
  steps: [
    ZephyrStep(title: Text('步骤1')),
    ZephyrStep(title: Text('步骤2')),
    ZephyrStep(title: Text('步骤3')),
  ],
)

// ✅ 好的做法：复杂流程分解为多个步骤
ZephyrStepper(
  steps: [
    ZephyrStep(title: Text('基本信息')),
    ZephyrStep(title: Text('详细信息')),
    ZephyrStep(title: Text('确认信息')),
    ZephyrStep(title: Text('完成')),
  ],
)

// ❌ 避免的做法：步骤过多
ZephyrStepper(
  steps: [
    // 8个以上步骤
  ],
)
```

### 2. 步骤验证

```dart
// ✅ 好的做法：在步骤切换时进行验证
onStepContinue: () {
  if (_validateCurrentStep()) {
    setState(() => _currentStep++);
  }
}

// ✅ 好的做法：提供清晰的错误信息
ZephyrStep(
  title: Text('个人信息'),
  errorText: _stepErrors[0],
)

// ❌ 避免的做法：不进行验证就允许切换
onStepContinue: () {
  setState(() => _currentStep++);
}
```

### 3. 用户体验

```dart
// ✅ 好的做法：提供进度指示
ZephyrStepper(
  steps: _steps.map((step) => ZephyrStep(
    title: Text('${_steps.indexOf(step) + 1}. ${step.title}'),
  )).toList(),
)

// ✅ 好的做法：保存用户输入
class _StepperState extends State<Stepper> {
  final Map<int, Map<String, dynamic>> _stepData = {};
  
  void _saveStepData(int step, Map<String, dynamic> data) {
    setState(() {
      _stepData[step] = data;
    });
  }
}

// ❌ 避免的做法：不保存用户输入
```

### 4. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整布局
class ResponsiveStepper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return ZephyrStepper(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      steps: _buildSteps(),
    );
  }
}
```

## 🔄 相关组件

- **ZephyrTabs**: 选项卡组件
- **ZephyrPagination**: 分页组件
- **ZephyrProgress**: 进度条组件
- **ZephyrFormBuilder**: 表单构建器

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持水平和垂直步骤条
- ✅ 支持步骤验证和错误处理
- ✅ 支持动态步骤管理
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/stepper/`
**示例路径**: `example/lib/components/stepper_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日