# ZephyrProgress 进度组件

进度组件是ZephyrUI反馈系统中的重要组件，用于显示任务的执行进度。支持多种进度类型、自定义样式和动画效果，是构建用户友好界面的重要组成部分。

## 🎯 组件概述

### 特性
- **多种进度类型**: 支持线性、圆形、步进等多种类型
- **灵活样式**: 支持自定义颜色、大小、动画等样式
- **丰富交互**: 支持暂停、恢复、取消等交互
- **状态管理**: 支持加载、成功、错误等状态
- **动画效果**: 内置平滑的动画效果
- **主题适配**: 完整的主题系统支持

### 适用场景
- 文件上传/下载
- 数据处理
- 表单提交
- 系统加载
- 任务执行
- 批量操作

## 🚀 基础用法

### 基本进度组件

```dart
class BasicProgressExample extends StatefulWidget {
  @override
  _BasicProgressExampleState createState() => _BasicProgressExampleState();
}

class _BasicProgressExampleState extends State<BasicProgressExample> {
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
        title: Text('基本进度组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 线性进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 24),
            
            // 圆形进度条
            ZephyrProgress(
              type: ZephyrProgressType.circular,
              value: _progress,
              size: 60,
              strokeWidth: 6,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 24),
            
            // 带标签的进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              showLabel: true,
              label: '${(_progress * 100).round()}%',
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

### 不确定进度组件

```dart
class IndeterminateProgressExample extends StatefulWidget {
  @override
  _IndeterminateProgressExampleState createState() => _IndeterminateProgressExampleState();
}

class _IndeterminateProgressExampleState extends State<IndeterminateProgressExample> {
  bool _isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 3));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('不确定进度组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 不确定线性进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: null, // null表示不确定进度
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 24),
            
            // 不确定圆形进度条
            ZephyrProgress(
              type: ZephyrProgressType.circular,
              value: null, // null表示不确定进度
              size: 48,
              strokeWidth: 4,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 24),
            
            // 带文本的不确定进度
            Row(
              children: [
                ZephyrProgress(
                  type: ZephyrProgressType.circular,
                  value: null,
                  size: 24,
                  strokeWidth: 2,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                SizedBox(width: 16),
                Text('正在加载...'),
              ],
            ),
            SizedBox(height: 32),
            
            // 控制按钮
            ElevatedButton(
              onPressed: _isLoading ? null : _simulateLoading,
              child: Text(_isLoading ? '加载中...' : '开始加载'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 缓冲进度组件

```dart
class BufferProgressExample extends StatefulWidget {
  @override
  _BufferProgressExampleState createState() => _BufferProgressExampleState();
}

class _BufferProgressExampleState extends State<BufferProgressExample> {
  double _progress = 0.0;
  double _bufferProgress = 0.0;
  bool _isLoading = false;

  Future<void> _simulateBufferProgress() async {
    setState(() {
      _isLoading = true;
      _progress = 0.0;
      _bufferProgress = 0.0;
    });

    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        _progress = i / 100;
        _bufferProgress = math.min(1.0, _progress + 0.2);
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
        title: Text('缓冲进度组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 缓冲线性进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              bufferValue: _bufferProgress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              bufferColor: Colors.blue[100],
            ),
            SizedBox(height: 16),
            
            // 进度信息
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('当前进度: ${(_progress * 100).round()}%'),
                Text('缓冲进度: ${(_bufferProgress * 100).round()}%'),
              ],
            ),
            SizedBox(height: 32),
            
            // 控制按钮
            ElevatedButton(
              onPressed: _isLoading ? null : _simulateBufferProgress,
              child: Text(_isLoading ? '加载中...' : '开始模拟'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🎨 样式定制

### 自定义颜色进度组件

```dart
class CustomColorProgressExample extends StatefulWidget {
  @override
  _CustomColorProgressExampleState createState() => _CustomColorProgressExampleState();
}

class _CustomColorProgressExampleState extends State<CustomColorProgressExample> {
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
        title: Text('自定义颜色进度组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 渐变色线性进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
            ),
            SizedBox(height: 24),
            
            // 彩色圆形进度条
            ZephyrProgress(
              type: ZephyrProgressType.circular,
              value: _progress,
              size: 80,
              strokeWidth: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              gradient: SweepGradient(
                colors: [Colors.green, Colors.yellow, Colors.red],
              ),
            ),
            SizedBox(height: 24),
            
            // 分段颜色进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 10,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                _progress < 0.5
                    ? Colors.orange
                    : _progress < 0.8
                        ? Colors.blue
                        : Colors.green,
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

### 自定义形状进度组件

```dart
class CustomShapeProgressExample extends StatefulWidget {
  @override
  _CustomShapeProgressExampleState createState() => _CustomShapeProgressExampleState();
}

class _CustomShapeProgressExampleState extends State<CustomShapeProgressExample> {
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
        title: Text('自定义形状进度组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 圆角线性进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 20,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(height: 24),
            
            // 方形圆形进度条
            ZephyrProgress(
              type: ZephyrProgressType.circular,
              value: _progress,
              size: 80,
              strokeWidth: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              shape: BoxShape.rectangle,
            ),
            SizedBox(height: 24),
            
            // 自定义高度进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 30,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
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

### 带动画的进度组件

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
        title: Text('带动画的进度组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 脉冲动画进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              animationType: ProgressAnimationType.pulse,
            ),
            SizedBox(height: 24),
            
            // 弹性动画进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              animationType: ProgressAnimationType.elastic,
            ),
            SizedBox(height: 24),
            
            // 旋转动画圆形进度条
            ZephyrProgress(
              type: ZephyrProgressType.circular,
              value: _progress,
              size: 60,
              strokeWidth: 6,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              animationType: ProgressAnimationType.rotate,
            ),
            SizedBox(height: 32),
            
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

### 可控制进度组件

```dart
class ControllableProgressExample extends StatefulWidget {
  @override
  _ControllableProgressExampleState createState() => _ControllableProgressExampleState();
}

class _ControllableProgressExampleState extends State<ControllableProgressExample> {
  double _progress = 0.0;
  bool _isPlaying = false;
  Timer? _timer;

  void _startProgress() {
    setState(() => _isPlaying = true);
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _timer?.cancel();
          setState(() => _isPlaying = false);
        }
      });
    });
  }

  void _pauseProgress() {
    _timer?.cancel();
    setState(() => _isPlaying = false);
  }

  void _resetProgress() {
    _timer?.cancel();
    setState(() {
      _progress = 0.0;
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可控制进度组件'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 可控制进度条
            ZephyrProgress(
              type: ZephyrProgressType.linear,
              value: _progress,
              minHeight: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              showLabel: true,
              label: '${(_progress * 100).round()}%',
            ),
            SizedBox(height: 24),
            
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isPlaying ? null : _startProgress,
                  child: Text('开始'),
                ),
                ElevatedButton(
                  onPressed: _isPlaying ? _pauseProgress : null,
                  child: Text('暂停'),
                ),
                ElevatedButton(
                  onPressed: _resetProgress,
                  child: Text('重置'),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // 进度滑块
            Text('手动调整进度:'),
            SizedBox(height: 8),
            Slider(
              value: _progress,
              onChanged: (value) {
                setState(() => _progress = value);
              },
              min: 0.0,
              max: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 多任务进度组件

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
        title: Text('多任务进度组件'),
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
                    ZephyrProgress(
                      type: ZephyrProgressType.linear,
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
                          ZephyrProgress(
                            type: ZephyrProgressType.linear,
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

### 文件上传进度组件

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
        title: Text('文件上传进度组件'),
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
                          ZephyrProgress(
                            type: ZephyrProgressType.linear,
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

### 下载进度组件

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

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载进度组件'),
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
              ZephyrProgress(
                type: ZephyrProgressType.linear,
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
                    '${_formatFileSize((progress * 1024 * 1024).round())} / ${_formatFileSize(1024 * 1024)}',
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
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrProgress()

```dart
const ZephyrProgress({
  Key? key,
  required ZephyrProgressType type,
  double? value,
  double? size,
  double? strokeWidth,
  Color? backgroundColor,
  Animation<Color>? valueColor,
  Gradient? gradient,
  double? bufferValue,
  Color? bufferColor,
  bool showLabel = false,
  String? label,
  TextStyle? labelStyle,
  BorderRadius? borderRadius,
  BoxShape? shape,
  ProgressAnimationType? animationType,
  Duration? duration,
  Curve? curve,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `type`: 进度类型
- `value`: 进度值 (0.0-1.0, null表示不确定进度)
- `size`: 尺寸 (圆形进度条)
- `strokeWidth`: 边框宽度 (圆形进度条)
- `backgroundColor`: 背景颜色
- `valueColor`: 进度颜色
- `gradient`: 渐变色
- `bufferValue`: 缓冲值
- `bufferColor`: 缓冲颜色
- `showLabel`: 是否显示标签
- `label`: 标签文本
- `labelStyle`: 标签样式
- `borderRadius`: 边框圆角
- `shape`: 形状
- `animationType`: 动画类型
- `duration`: 动画持续时间
- `curve`: 动画曲线
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrProgressType

```dart
enum ZephyrProgressType {
  linear,   // 线性进度
  circular, // 圆形进度
}
```

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
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `loadingColor`: 加载颜色
- `successColor`: 成功颜色
- `errorColor`: 错误颜色
- `warningColor`: 警告颜色

## 🏆 最佳实践

### 1. 合理的进度类型选择

```dart
// ✅ 好的做法：根据场景选择合适的进度类型
// 长时间操作使用圆形进度
ZephyrProgress(
  type: ZephyrProgressType.circular,
  value: null, // 不确定进度
)

// 短时间操作使用线性进度
ZephyrProgress(
  type: ZephyrProgressType.linear,
  value: _progress,
)

// ✅ 好的做法：显示具体进度值
ZephyrProgress(
  type: ZephyrProgressType.linear,
  value: _progress,
  showLabel: true,
  label: '${(_progress * 100).round()}%',
)

// ❌ 避免的做法：进度类型不匹配
ZephyrProgress(
  type: ZephyrProgressType.circular,
  value: _progress, // 圆形进度通常用于不确定进度
  size: 200, // 过大
)
```

### 2. 清晰的状态反馈

```dart
// ✅ 好的做法：提供进度标签
ZephyrProgress(
  type: ZephyrProgressType.linear,
  value: _progress,
  showLabel: true,
  label: '${(_progress * 100).round()}%',
)

// ✅ 好的做法：使用颜色区分状态
ZephyrProgress(
  type: ZephyrProgressType.linear,
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
ZephyrProgress(
  type: ZephyrProgressType.linear,
  value: _progress,
  // 用户不知道当前状态
)
```

### 3. 性能优化

```dart
// ✅ 好的做法：避免过度动画
ZephyrProgress(
  type: ZephyrProgressType.linear,
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
ZephyrProgress(
  type: ZephyrProgressType.linear,
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
ZephyrProgress(
  type: ZephyrProgressType.linear,
  backgroundColor: Colors.grey[200],
  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
)

// ❌ 避免的做法：缺乏语义信息
ZephyrProgress(
  type: ZephyrProgressType.linear,
  value: _progress,
  // 缺乏无障碍支持
)
```

## 🔄 相关组件

- **ZephyrProgressIndicators**: 进度指示器组件
- **ZephyrLoading**: 加载组件
- **ZephyrSkeleton**: 骨架屏组件
- **ZephyrStatusIndicators**: 状态指示器组件
- **ZephyrSpinner**: 旋转器组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持多种进度类型
- ✅ 支持自定义样式和动画
- ✅ 支持缓冲进度
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/feedback/progress/`
**示例路径**: `example/lib/components/progress_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日