# ZephyrUI 最佳实践指南

本指南提供了使用 ZephyrUI 组件库的最佳实践，帮助开发者构建高质量、可维护的 Flutter 应用程序。

## 🎯 设计原则

### 1. 一致性

在整个应用中保持一致的视觉和交互模式。

```dart
// ✅ 好的做法：使用统一的按钮样式
ZephyrButton.primary(
  text: '保存',
  onPressed: _saveData,
)

// ❌ 避免：混用不同的按钮样式做相同的事情
ElevatedButton(
  onPressed: _saveData,
  child: Text('保存'),
)
```

### 2. 可访问性

确保所有用户都能使用您的应用。

```dart
// ✅ 好的做法：为图标提供语义标签
ZephyrIcon(
  Icons.search,
  semanticLabel: '搜索',
  onPressed: _showSearch,
)

// ✅ 好的做法：提供足够的颜色对比度
ZephyrText(
  '重要信息',
  color: ZephyrColors.primary, // 使用主题色确保对比度
)
```

### 3. 响应式设计

为不同屏幕尺寸提供最佳体验。

```dart
// ✅ 好的做法：根据屏幕尺寸调整布局
Widget _buildResponsiveLayout(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  
  if (width < 600) {
    return _buildMobileLayout();
  } else if (width < 900) {
    return _buildTabletLayout();
  } else {
    return _buildDesktopLayout();
  }
}
```

## 🎨 组件使用指南

### 按钮组件

#### 层级结构

```dart
// ✅ 好的做法：清晰的视觉层级
Column(
  children: [
    // 主要操作
    ZephyrButton.primary(
      text: '确认订单',
      onPressed: _confirmOrder,
    ),
    
    SizedBox(height: 8),
    
    // 次要操作
    ZephyrButton.secondary(
      text: '取消',
      onPressed: _cancelOrder,
    ),
    
    SizedBox(height: 8),
    
    // 危险操作
    ZephyrButton(
      text: '删除订单',
      backgroundColor: ZephyrColors.error,
      textColor: Colors.white,
      onPressed: _deleteOrder,
    ),
  ],
)
```

#### 状态管理

```dart
// ✅ 好的做法：处理加载状态
class SubmitButton extends StatefulWidget {
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false;
  
  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    
    try {
      await widget.onSubmit();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('提交成功')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('提交失败: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ZephyrButton(
      text: '提交',
      loading: _isLoading,
      onPressed: _isLoading ? null : _handleSubmit,
    );
  }
}
```

### 文本组件

#### 层级结构

```dart
// ✅ 好的做法：正确的文本层级
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ZephyrText(
      '页面标题',
      style: ZephyrTextStyle.headline4,
    ),
    SizedBox(height: 8),
    ZephyrText(
      '页面描述文本，提供更多的上下文信息...',
      style: ZephyrTextStyle.body2,
      color: ZephyrColors.secondary,
    ),
    SizedBox(height: 16),
    ZephyrText(
      '章节标题',
      style: ZephyrTextStyle.headline6,
    ),
    SizedBox(height: 4),
    ZephyrText(
      '章节内容...',
      style: ZephyrTextStyle.body1,
    ),
  ],
)
```

#### 文本处理

```dart
// ✅ 好的做法：处理长文本
ZephyrText(
  '这是一段很长的文本，可能会超出容器的范围...',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)

// ✅ 好的做法：富文本显示
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: '价格: ',
        style: ZephyrTextStyle.body1,
      ),
      TextSpan(
        text: '¥99.00',
        style: ZephyrTextStyle.body1.copyWith(
          color: ZephyrColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
)
```

### 图标组件

#### 图标选择

```dart
// ✅ 好的做法：选择易于理解的图标
Row(
  children: [
    ZephyrIcon(Icons.phone, size: 16),
    SizedBox(width: 4),
    Text('138-0000-0000'),
  ],
)

// ✅ 好的做法：状态图标
Widget _buildStatusIcon(bool isActive) {
  return ZephyrIcon(
    isActive ? Icons.check_circle : Icons.radio_button_unchecked,
    size: 20,
    color: isActive ? ZephyrColors.success : ZephyrColors.disabled,
  );
}
```

#### 交互图标

```dart
// ✅ 好的做法：提供视觉反馈
class FavoriteIcon extends StatefulWidget {
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool _isFavorite = false;
  
  @override
  Widget build(BuildContext context) {
    return ZephyrIcon(
      _isFavorite ? Icons.favorite : Icons.favorite_border,
      size: 24,
      color: _isFavorite ? ZephyrColors.error : ZephyrColors.disabled,
      onPressed: () {
        setState(() => _isFavorite = !_isFavorite);
        widget.onChanged?.call(_isFavorite);
      },
    );
  }
}
```

## 🎨 主题定制

### 颜色系统

```dart
// ✅ 好的做法：定义完整的颜色系统
class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF757575);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  
  // 背景色
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  
  // 文本色
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
}
```

### 主题配置

```dart
// ✅ 好的做法：配置全局主题
ZephyrThemeData(
  primaryColor: AppColors.primary,
  secondaryColor: AppColors.secondary,
  textTheme: ZephyrTextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    body1: TextStyle(fontSize: 16),
    body2: TextStyle(fontSize: 14),
    button: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    caption: TextStyle(fontSize: 12),
    overline: TextStyle(fontSize: 10),
  ),
  buttonTheme: ZephyrButtonThemeData(
    primaryColor: AppColors.primary,
    secondaryColor: AppColors.secondary,
    borderRadius: 8,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
)
```

## 🚀 性能优化

### 列表优化

```dart
// ✅ 好的做法：使用 ListView.builder
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Card(
      child: ListTile(
        title: ZephyrText(items[index].title),
        subtitle: ZephyrText(
          items[index].description,
          style: ZephyrTextStyle.body2,
        ),
        trailing: ZephyrIcon(
          Icons.chevron_right,
          size: 20,
        ),
      ),
    );
  },
)
```

### 图片优化

```dart
// ✅ 好的做法：使用缓存图片
ZephyrImage.network(
  'https://example.com/image.jpg',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
  placeholder: (context) => ZephyrIcon(Icons.image, size: 48),
  errorWidget: (context, error, stackTrace) => ZephyrIcon(Icons.error, size: 48),
)
```

### 状态管理

```dart
// ✅ 好的做法：使用 StatefulWidget 管理状态
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ZephyrIcon(
          Icons.remove,
          onPressed: () => setState(() => _count--),
        ),
        SizedBox(width: 16),
        ZephyrText('$_count'),
        SizedBox(width: 16),
        ZephyrIcon(
          Icons.add,
          onPressed: () => setState(() => _count++),
        ),
      ],
    );
  }
}
```

## 📱 响应式设计

### 断点设置

```dart
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < ResponsiveBreakpoints.mobile;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= ResponsiveBreakpoints.mobile && 
           width < ResponsiveBreakpoints.tablet;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= ResponsiveBreakpoints.tablet;
  }
}
```

### 响应式组件

```dart
// ✅ 好的做法：响应式组件
class ResponsiveContainer extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  
  const ResponsiveContainer({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isDesktop(context) && desktop != null) {
      return desktop!;
    } else if (ResponsiveUtils.isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
```

## 🧪 测试策略

### 单元测试

```dart
// ✅ 好的做法：测试组件功能
void main() {
  testWidgets('ZephyrButton shows loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ZephyrButton(
          text: 'Test',
          loading: true,
          onPressed: () {},
        ),
      ),
    );
    
    // 验证加载状态
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });
}
```

### 集成测试

```dart
// ✅ 好的做法：测试用户交互
void main() {
  testWidgets('Rating component updates value on tap', (WidgetTester tester) async {
    double? ratingValue;
    
    await tester.pumpWidget(
      MaterialApp(
        home: ZephyrRating(
          value: 0,
          onRatingChanged: (value) => ratingValue = value,
        ),
      ),
    );
    
    // 点击第三个星星
    await tester.tap(find.byType(ZephyrRating).first);
    await tester.pump();
    
    // 验证评分更新
    expect(ratingValue, equals(3.0));
  });
}
```

## 🔒 错误处理

### 网络错误

```dart
// ✅ 好的做法：优雅处理错误
class DataFetcher extends StatefulWidget {
  @override
  _DataFetcherState createState() => _DataFetcherState();
}

class _DataFetcherState extends State<DataFetcher> {
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    
    try {
      final data = await api.fetchData();
      setState(() {
        _isLoading = false;
        // 处理数据
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = '获取数据失败: $e';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    
    if (_hasError) {
      return Column(
        children: [
          ZephyrIcon(Icons.error, size: 48, color: ZephyrColors.error),
          SizedBox(height: 16),
          ZephyrText(_errorMessage),
          SizedBox(height: 16),
          ZephyrButton(
            text: '重试',
            onPressed: _fetchData,
          ),
        ],
      );
    }
    
    // 显示数据
    return _buildDataView();
  }
}
```

### 输入验证

```dart
// ✅ 好的做法：验证用户输入
class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱地址';
    }
    
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    
    if (value.length < 6) {
      return '密码长度不能少于6位';
    }
    
    return null;
  }
}
```

## 📝 总结

遵循这些最佳实践，您可以构建出：

- **一致的用户体验**：统一的视觉和交互模式
- **可访问的应用**：所有用户都能正常使用
- **高性能的应用**：流畅的用户体验
- **可维护的代码**：清晰的结构和文档
- **健壮的应用**：良好的错误处理和测试覆盖

记住，最好的实践是适合您项目需求的实践。根据具体情况灵活应用这些建议。

---

**文档版本**: 1.0.0  
**最后更新**: 2024年8月18日