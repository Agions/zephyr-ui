# ZephyrProgressIndicators 进度指示器组件

进度指示器组件是ZephyrUI展示系统中的重要组件，提供了直观的进度展示功能。支持多种进度指示器模式、自定义样式和动画效果，是构建加载状态、任务进度、数据统计等场景的理想选择。

## 🎯 组件概述

### 特性
- **多种指示器模式**: 支持线性、圆形、步进等多种模式
- **灵活样式**: 支持自定义颜色、大小、动画等样式
- **丰富交互**: 支持点击、悬停、动画等交互
- **状态管理**: 支持加载、成功、错误等状态
- **动画效果**: 内置平滑的动画效果
- **主题适配**: 完整的主题系统支持

### 适用场景
- 数据加载
- 文件上传
- 任务进度
- 表单提交
- 数据统计
- 系统状态

## 🚀 基础用法

### 线性进度指示器

```dart
class LinearProgressExample extends StatefulWidget {
  @override
  _LinearProgressExampleState createState() => _LinearProgressExampleState();
}

class _LinearProgressExampleState extends State<LinearProgressExample> {
  double _progress = 0.0;
  bool _isLoading = false;

  Future<void> _simulateProgress() async {
    setState(() {
      _isLoading = true;
      _progress = 0.0;
    });

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _progress = i / 100;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('线性进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 基本线性进度条
            ZephyrLinearProgress(
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 24),
            
            // 带标签的进度条
            ZephyrLinearProgress(
              value: _progress,
              minHeight: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              showLabel: true,
              label: '${(_progress * 100).round()}%',
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            
            // 带动画的进度条
            ZephyrLinearProgress(
              value: _progress,
              minHeight: 10,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              animate: true,
              duration: Duration(milliseconds: 300),
            ),
            SizedBox(height: 24),
            
            // 缓冲进度条
            ZephyrLinearProgress(
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              bufferValue: _progress + 0.2,
              bufferColor: Colors.purple[100],
            ),
            SizedBox(height: 32),
            
            // 控制按钮
            ElevatedButton(
              onPressed: _isLoading ? null : _simulateProgress,
              child: Text(_isLoading ? '加载中...' : '开始模拟'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 圆形进度指示器

```dart
class CircularProgressExample extends StatefulWidget {
  @override
  _CircularProgressExampleState createState() => _CircularProgressExampleState();
}

class _CircularProgressExampleState extends State<CircularProgressExample> {
  double _progress = 0.0;
  bool _isLoading = false;

  Future<void> _simulateProgress() async {
    setState(() {
      _isLoading = true;
      _progress = 0.0;
    });

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _progress = i / 100;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆形进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 基本圆形进度
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ZephyrCircularProgress(
                  value: _progress,
                  size: 60,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                ZephyrCircularProgress(
                  value: _progress,
                  size: 80,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                ZephyrCircularProgress(
                  value: _progress,
                  size: 100,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 32),
            
            // 带标签的圆形进度
            ZephyrCircularProgress(
              value: _progress,
              size: 120,
              strokeWidth: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              showLabel: true,
              label: '${(_progress * 100).round()}%',
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            
            // 带图标的圆形进度
            ZephyrCircularProgress(
              value: _progress,
              size: 100,
              strokeWidth: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              centerWidget: Icon(
                Icons.download,
                size: 32,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 32),
            
            // 控制按钮
            ElevatedButton(
              onPressed: _isLoading ? null : _simulateProgress,
              child: Text(_isLoading ? '加载中...' : '开始模拟'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 步进进度指示器

```dart
class StepProgressExample extends StatefulWidget {
  @override
  _StepProgressExampleState createState() => _StepProgressExampleState();
}

class _StepProgressExampleState extends State<StepProgressExample> {
  int _currentStep = 0;
  final List<String> _steps = ['步骤1', '步骤2', '步骤3', '步骤4'];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('步进进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 水平步进进度
            ZephyrStepProgress(
              steps: _steps,
              currentStep: _currentStep,
              direction: Axis.horizontal,
              type: ZephyrStepProgressType.linear,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey[300],
              completedColor: Colors.green,
            ),
            SizedBox(height: 32),
            
            // 垂直步进进度
            Expanded(
              child: ZephyrStepProgress(
                steps: _steps,
                currentStep: _currentStep,
                direction: Axis.vertical,
                type: ZephyrStepProgressType.stepper,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300],
                completedColor: Colors.green,
              ),
            ),
            SizedBox(height: 32),
            
            // 带图标的步进进度
            ZephyrStepProgress(
              steps: _steps.map((step) {
                return ZephyrStep(
                  title: step,
                  icon: Icon(Icons.check_circle),
                );
              }).toList(),
              currentStep: _currentStep,
              direction: Axis.horizontal,
              type: ZephyrStepProgressType.icon,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey[300],
              completedColor: Colors.green,
            ),
            SizedBox(height: 32),
            
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _currentStep > 0 ? _previousStep : null,
                  child: Text('上一步'),
                ),
                ElevatedButton(
                  onPressed: _currentStep < _steps.length - 1 ? _nextStep : null,
                  child: Text('下一步'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义颜色进度指示器

```dart
class CustomColorProgressExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义颜色进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 多彩线性进度条
            ZephyrLinearProgress(
              value: 0.75,
              minHeight: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
            ),
            SizedBox(height: 24),
            
            // 彩色圆形进度
            ZephyrCircularProgress(
              value: 0.6,
              size: 100,
              strokeWidth: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              gradient: SweepGradient(
                colors: [Colors.green, Colors.yellow, Colors.red],
              ),
            ),
            SizedBox(height: 24),
            
            // 渐变步进进度
            ZephyrStepProgress(
              steps: ['开始', '进行中', '即将完成', '完成'],
              currentStep: 2,
              direction: Axis.horizontal,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey[300],
              completedColor: Colors.green,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 自定义形状进度指示器

```dart
class CustomShapeProgressExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义形状进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 圆角线性进度条
            ZephyrLinearProgress(
              value: 0.8,
              minHeight: 20,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(height: 24),
            
            // 方形圆形进度
            ZephyrCircularProgress(
              value: 0.7,
              size: 100,
              strokeWidth: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              shape: BoxShape.rectangle,
            ),
            SizedBox(height: 24),
            
            // 自定义步进形状
            ZephyrStepProgress(
              steps: ['第一步', '第二步', '第三步'],
              currentStep: 1,
              direction: Axis.horizontal,
              activeColor: Colors.orange,
              inactiveColor: Colors.grey[300],
              completedColor: Colors.purple,
              stepShape: BoxShape.rectangle,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 动画进度指示器

```dart
class AnimatedProgressExample extends StatefulWidget {
  @override
  _AnimatedProgressExampleState createState() => _AnimatedProgressExampleState();
}

class _AnimatedProgressExampleState extends State<AnimatedProgressExample> {
  double _progress = 0.0;
  bool _isAnimating = false;

  void _startAnimation() {
    setState(() {
      _isAnimating = true;
      _progress = 0.0;
    });

    // 模拟进度变化
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          timer.cancel();
          setState(() => _isAnimating = false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 脉冲动画进度条
            ZephyrLinearProgress(
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              animationType: ProgressAnimationType.pulse,
            ),
            SizedBox(height: 24),
            
            // 弹性动画进度条
            ZephyrLinearProgress(
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              animationType: ProgressAnimationType.elastic,
            ),
            SizedBox(height: 24),
            
            // 旋转动画圆形进度
            ZephyrCircularProgress(
              value: _progress,
              size: 80,
              strokeWidth: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              animationType: ProgressAnimationType.rotate,
            ),
            SizedBox(height: 24),
            
            // 控制按钮
            ElevatedButton(
              onPressed: _isAnimating ? null : _startAnimation,
              child: Text(_isAnimating ? '动画中...' : '开始动画'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔧 高级用法

### 文件上传进度指示器

```dart
class FileUploadProgressExample extends StatefulWidget {
  @override
  _FileUploadProgressExampleState createState() => _FileUploadProgressExampleState();
}

class _FileUploadProgressExampleState extends State<FileUploadProgressExample> {
  Map<String, double> _uploadProgress = {};
  Map<String, String> _uploadStatus = {};

  Future<void> _simulateFileUpload(String fileName) async {
    setState(() {
      _uploadProgress[fileName] = 0.0;
      _uploadStatus[fileName] = '上传中';
    });

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _uploadProgress[fileName] = i / 100;
      });
    }

    setState(() {
      _uploadStatus[fileName] = '上传完成';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件上传进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 文件选择按钮
            ElevatedButton(
              onPressed: () {
                _simulateFileUpload('document.pdf');
                _simulateFileUpload('image.jpg');
                _simulateFileUpload('video.mp4');
              },
              child: Text('模拟文件上传'),
            ),
            SizedBox(height: 24),
            
            // 上传进度列表
            Expanded(
              child: ListView(
                children: _uploadProgress.keys.map((fileName) {
                  final progress = _uploadProgress[fileName]!;
                  final status = _uploadStatus[fileName]!;
                  
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                fileName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                status,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: status == '上传完成' ? Colors.green : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          ZephyrLinearProgress(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              status == '上传完成' ? Colors.green : Colors.blue,
                            ),
                            showLabel: true,
                            label: '${(progress * 100).round()}%',
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 任务进度指示器

```dart
class TaskProgressExample extends StatefulWidget {
  @override
  _TaskProgressExampleState createState() => _TaskProgressExampleState();
}

class _TaskProgressExampleState extends State<TaskProgressExample> {
  List<Map<String, dynamic>> _tasks = [
    {'name': '数据备份', 'progress': 0.3, 'status': '进行中'},
    {'name': '系统更新', 'progress': 0.7, 'status': '进行中'},
    {'name': '文件清理', 'progress': 1.0, 'status': '已完成'},
    {'name': '安全扫描', 'progress': 0.0, 'status': '等待中'},
  ];

  Future<void> _updateTaskProgress(int index) async {
    setState(() {
      _tasks[index]['status'] = '进行中';
    });

    for (int i = (_tasks[index]['progress'] * 100).round(); i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        _tasks[index]['progress'] = i / 100;
      });
    }

    setState(() {
      _tasks[index]['status'] = '已完成';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('任务进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: _tasks.asMap().entries.map((entry) {
            final index = entry.key;
            final task = entry.value;
            
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(task['status']),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                task['status'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            if (task['status'] == '等待中')
                              IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () => _updateTaskProgress(index),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ZephyrLinearProgress(
                      value: task['progress'],
                      minHeight: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getStatusColor(task['status']),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${(task['progress'] * 100).round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '已完成':
        return Colors.green;
      case '进行中':
        return Colors.blue;
      case '等待中':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
```

### 下载进度指示器

```dart
class DownloadProgressExample extends StatefulWidget {
  @override
  _DownloadProgressExampleState createState() => _DownloadProgressExampleState();
}

class _DownloadProgressExampleState extends State<DownloadProgressExample> {
  Map<String, double> _downloadProgress = {};
  Map<String, bool> _isDownloading = {};

  Future<void> _simulateDownload(String fileName) async {
    setState(() {
      _isDownloading[fileName] = true;
      _downloadProgress[fileName] = 0.0;
    });

    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        _downloadProgress[fileName] = i / 100;
      });
    }

    setState(() {
      _isDownloading[fileName] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 下载文件列表
            Expanded(
              child: ListView(
                children: [
                  _buildDownloadItem('app-v1.0.0.apk', 'Android应用'),
                  _buildDownloadItem('app-v1.0.0.dmg', 'macOS应用'),
                  _buildDownloadItem('app-v1.0.0.exe', 'Windows应用'),
                  _buildDownloadItem('documentation.pdf', '用户文档'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadItem(String fileName, String description) {
    final isDownloading = _isDownloading[fileName] ?? false;
    final progress = _downloadProgress[fileName] ?? 0.0;

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isDownloading ? Icons.downloading : Icons.file_download,
                  color: Colors.blue,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isDownloading)
                  IconButton(
                    icon: Icon(Icons.download),
                    onPressed: () => _simulateDownload(fileName),
                  ),
              ],
            ),
            if (isDownloading) ...[
              SizedBox(height: 12),
              ZephyrLinearProgress(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).round()}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${_formatFileSize(progress * 1024 * 1024)} / ${_formatFileSize(1024 * 1024)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
```

### 多任务进度指示器

```dart
class MultiTaskProgressExample extends StatefulWidget {
  @override
  _MultiTaskProgressExampleState createState() => _MultiTaskProgressExampleState();
}

class _MultiTaskProgressExampleState extends State<MultiTaskProgressExample> {
  List<Map<String, dynamic>> _tasks = [
    {'name': '任务1', 'progress': 0.0, 'color': Colors.blue},
    {'name': '任务2', 'progress': 0.0, 'color': Colors.green},
    {'name': '任务3', 'progress': 0.0, 'color': Colors.orange},
    {'name': '任务4', 'progress': 0.0, 'color': Colors.purple},
  ];

  Future<void> _startAllTasks() async {
    for (int i = 0; i < _tasks.length; i++) {
      _startTask(i);
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  Future<void> _startTask(int index) async {
    for (int j = 0; j <= 100; j += 2) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        _tasks[index]['progress'] = j / 100;
      });
    }
  }

  double _getTotalProgress() {
    return _tasks.fold(0.0, (sum, task) => sum + task['progress']) / _tasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多任务进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 总进度
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '总进度',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ZephyrLinearProgress(
                      value: _getTotalProgress(),
                      minHeight: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                      showLabel: true,
                      label: '${(_getTotalProgress() * 100).round()}%',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // 各任务进度
            Expanded(
              child: ListView(
                children: _tasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final task = entry.value;
                  
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          ZephyrLinearProgress(
                            value: task['progress'],
                            minHeight: 8,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(task['color']),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${(task['progress'] * 100).round()}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24),
            
            // 控制按钮
            ElevatedButton(
              onPressed: _startAllTasks,
              child: Text('开始所有任务'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrLinearProgress()

```dart
const ZephyrLinearProgress({
  Key? key,
  required double value,
  double? minHeight,
  Color? backgroundColor,
  Animation<Color>? valueColor,
  Gradient? gradient,
  double? bufferValue,
  Color? bufferColor,
  bool showLabel = false,
  String? label,
  TextStyle? labelStyle,
  BorderRadius? borderRadius,
  ProgressAnimationType? animationType,
  Duration? duration,
  Curve? curve,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

#### ZephyrCircularProgress()

```dart
const ZephyrCircularProgress({
  Key? key,
  required double value,
  double? size,
  double? strokeWidth,
  Color? backgroundColor,
  Animation<Color>? valueColor,
  Gradient? gradient,
  BoxShape? shape,
  Widget? centerWidget,
  bool showLabel = false,
  String? label,
  TextStyle? labelStyle,
  ProgressAnimationType? animationType,
  Duration? duration,
  Curve? curve,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

#### ZephyrStepProgress()

```dart
const ZephyrStepProgress({
  Key? key,
  required List<String> steps,
  required int currentStep,
  Axis direction = Axis.horizontal,
  ZephyrStepProgressType type = ZephyrStepProgressType.linear,
  Color? activeColor,
  Color? inactiveColor,
  Color? completedColor,
  Gradient? gradient,
  BoxShape? stepShape,
  double? stepSize,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

### 枚举类型

#### ProgressAnimationType

```dart
enum ProgressAnimationType {
  none,    // 无动画
  linear,  // 线性动画
  pulse,   // 脉冲动画
  elastic, // 弹性动画
  rotate,  // 旋转动画
}
```

#### ZephyrStepProgressType

```dart
enum ZephyrStepProgressType {
  linear,  // 线性步进
  stepper, // 步进器
  icon,    // 图标步进
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrProgressTheme(
        defaultLinearProgressStyle: ZephyrLinearProgressStyle(
          minHeight: 8,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          borderRadius: BorderRadius.circular(4),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        defaultCircularProgressStyle: ZephyrCircularProgressStyle(
          size: 48,
          strokeWidth: 6,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          centerWidgetStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        defaultStepProgressStyle: ZephyrStepProgressStyle(
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[300],
          completedColor: Colors.green,
          stepSize: 24,
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        loadingColor: Colors.blue,
        successColor: Colors.green,
        errorColor: Colors.red,
        warningColor: Colors.orange,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultLinearProgressStyle`: 默认线性进度样式
- `defaultCircularProgressStyle`: 默认圆形进度样式
- `defaultStepProgressStyle`: 默认步进进度样式
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `loadingColor`: 加载颜色
- `successColor`: 成功颜色
- `errorColor`: 错误颜色
- `warningColor`: 警告颜色

## 🏆 最佳实践

### 1. 合理的进度展示

```dart
// ✅ 好的做法：使用合适的进度指示器类型
// 长时间操作使用圆形进度
ZephyrCircularProgress(
  value: _progress,
  size: 48,
)

// 短时间操作使用线性进度
ZephyrLinearProgress(
  value: _progress,
  minHeight: 4,
)

// ✅ 好的做法：多步骤使用步进进度
ZephyrStepProgress(
  steps: ['步骤1', '步骤2', '步骤3'],
  currentStep: _currentStep,
)

// ❌ 避免的做法：进度指示器类型不匹配
ZephyrCircularProgress(
  value: _progress,
  size: 200, // 过大，不适合简单进度
)
```

### 2. 清晰的状态反馈

```dart
// ✅ 好的做法：提供状态标签
ZephyrLinearProgress(
  value: _progress,
  showLabel: true,
  label: '${(_progress * 100).round()}%',
)

// ✅ 好的做法：使用颜色区分状态
ZephyrLinearProgress(
  value: _progress,
  valueColor: AlwaysStoppedAnimation<Color>(
    _progress == 1.0 ? Colors.green : Colors.blue,
  ),
)

// ✅ 好的做法：提供完成状态
if (_progress == 1.0) {
  Icon(Icons.check_circle, color: Colors.green);
}

// ❌ 避免的做法：缺乏状态反馈
ZephyrLinearProgress(
  value: _progress,
  // 用户不知道当前状态
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：避免过度动画
ZephyrLinearProgress(
  value: _progress,
  animationType: ProgressAnimationType.none, // 静态进度不需要动画
)

// ✅ 好的做法：使用合适的更新频率
Timer.periodic(Duration(milliseconds: 100), (timer) {
  setState(() {
    _progress = calculateProgress();
  });
});

// ✅ 好的做法：暂停时停止更新
if (_isPaused) {
  return;
}

// ❌ 避免的做法：频繁的UI更新
Timer.periodic(Duration(milliseconds: 10), (timer) {
  setState(() {
    _progress = calculateProgress(); // 更新过于频繁
  });
});
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：添加语义标签
ZephyrLinearProgress(
  value: _progress,
  semanticLabel: '文件上传进度',
  showLabel: true,
  label: '${(_progress * 100).round()}%',
)

// ✅ 好的做法：为状态变化提供提示
if (_progress == 1.0) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('上传完成')),
  );
}

// ✅ 好的做法：确保足够的对比度
ZephyrLinearProgress(
  value: _progress,
  backgroundColor: Colors.grey[200],
  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
)

// ❌ 避免的做法：缺乏语义信息
ZephyrLinearProgress(
  value: _progress,
  // 缺乏无障碍支持
)
```

## 🔄 相关组件

- **ZephyrLoading**: 加载组件
- **ZephyrSkeleton**: 骨架屏组件
- **ZephyrStatusIndicators**: 状态指示器组件
- **ZephyrToast**: 提示组件
- **ZephyrModal**: 模态框组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种进度指示器类型
- ✅ 支持自定义样式和动画
- ✅ 支持状态管理
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/display/progress_indicators/`
**示例路径**: `example/lib/components/progress_indicators_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日