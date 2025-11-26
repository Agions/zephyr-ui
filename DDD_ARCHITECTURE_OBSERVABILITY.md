# ZephyrUI DDD分层架构设计与可观测性体系

## 🏗️ DDD分层架构设计

### 架构总览

```
┌─────────────────────────────────────────────────────────────────────────┐
│                            Presentation Layer                          │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │
│  │   Widgets   │ │   Pages     │ │ Navigators  │ │   Themes    │       │
│  │  (Components)│ │  (Screens)  │ │  (Routing)  │ │  (Styling)  │       │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘       │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
┌─────────────────────────────────────────────────────────────────────────┐
│                           Application Layer                           │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │
│  │  Services   │ │  Use Cases  │ │ ViewModels  │ │ Controllers │       │
│  │ (Business)  │ │ (Workflows)  │ │ (State)     │ │ (API)       │       │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘       │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
┌─────────────────────────────────────────────────────────────────────────┐
│                              Domain Layer                             │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │
│  │  Entities   │ │Value Objects│ │ Aggregates  │ │  Events     │       │
│  │  (Models)   │ │  (Types)    │ │ (Roots)     │ │ (Domain)    │       │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘       │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
┌─────────────────────────────────────────────────────────────────────────┐
│                         Infrastructure Layer                          │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │
│  │   Repositories│ │  External   │ │  Utilities  │ │  Security   │       │
│  │   (Data)     │ │  APIs       │ │  (Helpers)  │ │  (Auth)     │       │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘       │
└─────────────────────────────────────────────────────────────────────────┘
```

### 1. Presentation Layer (表现层)

#### 1.1 Widget Architecture
```dart
// 基础Widget抽象类
abstract class ZephyrWidget extends StatelessWidget {
  const ZephyrWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return _buildWithPerformance(context);
  }
  
  Widget _buildWithPerformance(BuildContext context) {
    return ZephyrPerformanceWidget(
      widgetName: runtimeType.toString(),
      child: buildWidget(context),
    );
  }
  
  @protected
  Widget buildWidget(BuildContext context);
}

// 状态管理Widget基类
abstract class ZephyrStatefulWidget extends StatefulWidget {
  const ZephyrStatefulWidget({super.key});
  
  @override
  State<ZephyrStatefulWidget> createState();
}

abstract class ZephyrState<T extends ZephyrStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceWidget(
      widgetName: widget.runtimeType.toString(),
      child: buildWidget(context),
    );
  }
  
  @protected
  Widget buildWidget(BuildContext context);
}
```

#### 1.2 Theme System
```dart
// 主题数据结构
class ZephyrThemeData {
  final ZephyrColorScheme colorScheme;
  final ZephyrTextTheme textTheme;
  final ZephyrSpacing spacing;
  final ZephyrBorderRadius borderRadius;
  final ZephyrShadows shadows;
  final ZephyrAnimations animations;
  
  const ZephyrThemeData({
    required this.colorScheme,
    required this.textTheme,
    required this.spacing,
    required this.borderRadius,
    required this.shadows,
    required this.animations,
  });
  
  ZephyrThemeData copyWith({
    ZephyrColorScheme? colorScheme,
    ZephyrTextTheme? textTheme,
    ZephyrSpacing? spacing,
    ZephyrBorderRadius? borderRadius,
    ZephyrShadows? shadows,
    ZephyrAnimations? animations,
  }) {
    return ZephyrThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
      spacing: spacing ?? this.spacing,
      borderRadius: borderRadius ?? this.borderRadius,
      shadows: shadows ?? this.shadows,
      animations: animations ?? this.animations,
    );
  }
}

// 主题扩展
class ZephyrTheme extends InheritedWidget {
  final ZephyrThemeData data;
  
  const ZephyrTheme({
    required this.data,
    required super.child,
    super.key,
  });
  
  static ZephyrThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<ZephyrTheme>();
    return theme?.data ?? ZephyrThemeData.fallback();
  }
  
  @override
  bool updateShouldNotify(ZephyrTheme oldWidget) {
    return data != oldWidget.data;
  }
}
```

#### 1.3 Component Registry
```dart
// 组件注册中心
class ZephyrComponentRegistry {
  static final Map<String, ZephyrComponentFactory> _factories = {};
  static final Map<String, ZephyrComponentMetadata> _metadata = {};
  
  static void register<T extends ZephyrWidget>({
    required String name,
    required ZephyrComponentFactory<T> factory,
    required ZephyrComponentMetadata metadata,
  }) {
    _factories[name] = factory;
    _metadata[name] = metadata;
  }
  
  static T create<T extends ZephyrWidget>(String name, Map<String, dynamic> params) {
    final factory = _factories[name] as ZephyrComponentFactory<T>?;
    if (factory == null) {
      throw StateError('Component $name not registered');
    }
    return factory(params);
  }
  
  static ZephyrComponentMetadata? getMetadata(String name) {
    return _metadata[name];
  }
  
  static List<String> getRegisteredComponents() {
    return _factories.keys.toList();
  }
}
```

### 2. Application Layer (应用层)

#### 2.1 Use Cases
```dart
// Use Case基类
abstract class ZephyrUseCase<T, P> {
  Future<ZephyrResult<T>> execute(P params);
}

// 主题切换Use Case
class ZephyrChangeThemeUseCase extends ZephyrUseCase<void, ZephyrThemeParams> {
  final ZephyrThemeRepository _themeRepository;
  
  ZephyrChangeThemeUseCase(this._themeRepository);
  
  @override
  Future<ZephyrResult<void>> execute(ZephyrThemeParams params) async {
    try {
      await _themeRepository.saveTheme(params.themeData);
      return ZephyrResult.success(null);
    } catch (e) {
      return ZephyrResult.failure(ZephyrError(
        code: 'THEME_CHANGE_FAILED',
        message: 'Failed to change theme: ${e.toString()}',
      ));
    }
  }
}

// 组件配置Use Case
class ZephyrConfigureComponentUseCase extends ZephyrUseCase<void, ZephyrComponentConfig> {
  final ZephyrComponentRepository _componentRepository;
  
  ZephyrConfigureComponentUseCase(this._componentRepository);
  
  @override
  Future<ZephyrResult<void>> execute(ZephyrComponentConfig config) async {
    try {
      await _componentRepository.saveConfig(config);
      return ZephyrResult.success(null);
    } catch (e) {
      return ZephyrResult.failure(ZephyrError(
        code: 'CONFIG_SAVE_FAILED',
        message: 'Failed to save component config: ${e.toString()}',
      ));
    }
  }
}
```

#### 2.2 ViewModels
```dart
// ViewModel基类
abstract class ZephyrViewModel extends ChangeNotifier {
  bool _isLoading = false;
  ZephyrError? _error;
  
  bool get isLoading => _isLoading;
  ZephyrError? get error => _error;
  
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }
  
  void setError(ZephyrError? error) {
    if (_error != error) {
      _error = error;
      notifyListeners();
    }
  }
  
  void clearError() {
    setError(null);
  }
  
  @protected
  Future<T> executeUseCase<T, P>(
    ZephyrUseCase<T, P> useCase,
    P params, {
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) {
        setLoading(true);
        clearError();
      }
      
      final result = await useCase.execute(params);
      
      if (result.isFailure) {
        setError(result.error);
        return Future.error(result.error!);
      }
      
      return result.data!;
    } finally {
      if (showLoading) {
        setLoading(false);
      }
    }
  }
}

// 主题ViewModel
class ZephyrThemeViewModel extends ZephyrViewModel {
  final ZephyrChangeThemeUseCase _changeThemeUseCase;
  final ZephyrGetThemeUseCase _getThemeUseCase;
  
  ZephyrThemeData? _currentTheme;
  
  ZephyrThemeData? get currentTheme => _currentTheme;
  
  ZephyrThemeViewModel(
    this._changeThemeUseCase,
    this._getThemeUseCase,
  );
  
  Future<void> loadTheme() async {
    try {
      final theme = await executeUseCase(_getThemeUseCase, null);
      _currentTheme = theme;
      notifyListeners();
    } catch (e) {
      // Error already handled by base class
    }
  }
  
  Future<void> changeTheme(ZephyrThemeData theme) async {
    try {
      await executeUseCase(
        _changeThemeUseCase,
        ZephyrThemeParams(themeData: theme),
      );
      _currentTheme = theme;
      notifyListeners();
    } catch (e) {
      // Error already handled by base class
    }
  }
}
```

#### 2.3 Services
```dart
// 服务接口
abstract class ZephyrAnalyticsService {
  Future<void> trackEvent(String name, Map<String, dynamic> properties);
  Future<void> trackError(ZephyrError error);
  Future<void> trackPerformance(String metric, double value);
}

// 服务实现
class ZephyrAnalyticsServiceImpl implements ZephyrAnalyticsService {
  final ZephyrAnalyticsRepository _repository;
  
  ZephyrAnalyticsServiceImpl(this._repository);
  
  @override
  Future<void> trackEvent(String name, Map<String, dynamic> properties) async {
    try {
      await _repository.logEvent(name, properties);
    } catch (e) {
      // Silent fail for analytics
      debugPrint('Failed to track event: $e');
    }
  }
  
  @override
  Future<void> trackError(ZephyrError error) async {
    try {
      await _repository.logError(error);
    } catch (e) {
      debugPrint('Failed to track error: $e');
    }
  }
  
  @override
  Future<void> trackPerformance(String metric, double value) async {
    try {
      await _repository.logPerformance(metric, value);
    } catch (e) {
      debugPrint('Failed to track performance: $e');
    }
  }
}
```

### 3. Domain Layer (领域层)

#### 3.1 Entities
```dart
// 组件实体
class ZephyrComponent {
  final String id;
  final String name;
  final String type;
  final ZephyrComponentConfig config;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  ZephyrComponent({
    required this.id,
    required this.name,
    required this.type,
    required this.config,
    required this.createdAt,
    required this.updatedAt,
  });
  
  ZephyrComponent copyWith({
    String? id,
    String? name,
    String? type,
    ZephyrComponentConfig? config,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ZephyrComponent(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      config: config ?? this.config,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrComponent &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.config == config &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
  
  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      type,
      config,
      createdAt,
      updatedAt,
    );
  }
}
```

#### 3.2 Value Objects
```dart
// 颜色值对象
class ZephyrColor {
  final int value;
  final String name;
  
  const ZephyrColor(this.value, this.name);
  
  factory ZephyrColor.fromHex(String hex) {
    final color = int.parse(hex.replaceFirst('#', ''), radix: 16);
    return ZephyrColor(color, hex);
  }
  
  Color get materialColor => Color(value);
  
  String get hex => '#${value.toRadixString(16).padLeft(8, '0')}';
  
  ZephyrColor withOpacity(double opacity) {
    return ZephyrColor(
      (value & 0x00FFFFFF) | ((opacity * 255).toInt() << 24),
      name,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrColor && other.value == value;
  }
  
  @override
  int get hashCode => value.hashCode;
}

// 间距值对象
class ZephyrSpacing {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  
  const ZephyrSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });
  
  factory ZephyrSpacing.uniform(double value) {
    return ZephyrSpacing(
      xs: value * 0.25,
      sm: value * 0.5,
      md: value,
      lg: value * 1.5,
      xl: value * 2,
      xxl: value * 3,
    );
  }
  
  double get(ZephyrSize size) {
    switch (size) {
      case ZephyrSize.xs:
        return xs;
      case ZephyrSize.sm:
        return sm;
      case ZephyrSize.md:
        return md;
      case ZephyrSize.lg:
        return lg;
      case ZephyrSize.xl:
        return xl;
    }
  }
}
```

#### 3.3 Aggregates
```dart
// 主题聚合根
class ZephyrThemeAggregate {
  final String id;
  final String name;
  final ZephyrThemeData themeData;
  final List<ZephyrComponent> components;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  ZephyrThemeAggregate({
    required this.id,
    required this.name,
    required this.themeData,
    required this.components,
    required this.createdAt,
    required this.updatedAt,
  });
  
  // 业务规则：主题名称不能为空
  bool get isValid => name.isNotEmpty;
  
  // 业务方法：添加组件
  ZephyrThemeAggregate addComponent(ZephyrComponent component) {
    if (components.any((c) => c.id == component.id)) {
      throw ArgumentError('Component with id ${component.id} already exists');
    }
    
    return copyWith(
      components: [...components, component],
      updatedAt: DateTime.now(),
    );
  }
  
  // 业务方法：移除组件
  ZephyrThemeAggregate removeComponent(String componentId) {
    final updatedComponents = components.where((c) => c.id != componentId).toList();
    
    if (updatedComponents.length == components.length) {
      throw ArgumentError('Component with id $componentId not found');
    }
    
    return copyWith(
      components: updatedComponents,
      updatedAt: DateTime.now(),
    );
  }
  
  // 业务方法：更新主题数据
  ZephyrThemeAggregate updateThemeData(ZephyrThemeData newThemeData) {
    return copyWith(
      themeData: newThemeData,
      updatedAt: DateTime.now(),
    );
  }
  
  ZephyrThemeAggregate copyWith({
    String? id,
    String? name,
    ZephyrThemeData? themeData,
    List<ZephyrComponent>? components,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ZephyrThemeAggregate(
      id: id ?? this.id,
      name: name ?? this.name,
      themeData: themeData ?? this.themeData,
      components: components ?? this.components,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
```

#### 3.4 Domain Events
```dart
// 领域事件基类
abstract class ZephyrDomainEvent {
  final String id;
  final DateTime occurredAt;
  final Map<String, dynamic> metadata;
  
  ZephyrDomainEvent({
    required this.id,
    required this.occurredAt,
    this.metadata = const {},
  });
}

// 主题变更事件
class ZephyrThemeChangedEvent extends ZephyrDomainEvent {
  final String themeId;
  final String themeName;
  final ZephyrThemeData oldThemeData;
  final ZephyrThemeData newThemeData;
  
  ZephyrThemeChangedEvent({
    required this.themeId,
    required this.themeName,
    required this.oldThemeData,
    required this.newThemeData,
    String? id,
    DateTime? occurredAt,
    Map<String, dynamic> metadata = const {},
  }) : super(
          id: id ?? const Uuid().v4(),
          occurredAt: occurredAt ?? DateTime.now(),
          metadata: metadata,
        );
}

// 组件配置变更事件
class ZephyrComponentConfigChangedEvent extends ZephyrDomainEvent {
  final String componentId;
  final String componentName;
  final ZephyrComponentConfig oldConfig;
  final ZephyrComponentConfig newConfig;
  
  ZephyrComponentConfigChangedEvent({
    required this.componentId,
    required this.componentName,
    required this.oldConfig,
    required this.newConfig,
    String? id,
    DateTime? occurredAt,
    Map<String, dynamic> metadata = const {},
  }) : super(
          id: id ?? const Uuid().v4(),
          occurredAt: occurredAt ?? DateTime.now(),
          metadata: metadata,
        );
}

// 事件发布器
class ZephyrDomainEventPublisher {
  static final Map<Type, List<Function>> _handlers = {};
  
  static void subscribe<T extends ZephyrDomainEvent>(void Function(T) handler) {
    _handlers[T] ??= [];
    _handlers[T]!.add(handler);
  }
  
  static void publish<T extends ZephyrDomainEvent>(T event) {
    if (_handlers.containsKey(T)) {
      for (final handler in _handlers[T]!) {
        handler(event as T);
      }
    }
  }
  
  static void unsubscribe<T extends ZephyrDomainEvent>(void Function(T) handler) {
    _handlers[T]?.remove(handler);
  }
}
```

### 4. Infrastructure Layer (基础设施层)

#### 4.1 Repositories
```dart
// 主题仓库接口
abstract class ZephyrThemeRepository {
  Future<ZephyrThemeData?> getTheme();
  Future<void> saveTheme(ZephyrThemeData themeData);
  Future<void> deleteTheme();
  Stream<ZephyrThemeData?> watchTheme();
}

// 本地存储实现
class ZephyrThemeLocalRepository implements ZephyrThemeRepository {
  final SharedPreferences _prefs;
  final String _key = 'zephyr_theme';
  
  ZephyrThemeLocalRepository(this._prefs);
  
  @override
  Future<ZephyrThemeData?> getTheme() async {
    final themeJson = _prefs.getString(_key);
    if (themeJson == null) return null;
    
    try {
      final themeMap = json.decode(themeJson) as Map<String, dynamic>;
      return ZephyrThemeData.fromJson(themeMap);
    } catch (e) {
      debugPrint('Failed to parse theme data: $e');
      return null;
    }
  }
  
  @override
  Future<void> saveTheme(ZephyrThemeData themeData) async {
    final themeJson = json.encode(themeData.toJson());
    await _prefs.setString(_key, themeJson);
  }
  
  @override
  Future<void> deleteTheme() async {
    await _prefs.remove(_key);
  }
  
  @override
  Stream<ZephyrThemeData?> watchTheme() {
    return _prefs.getString(_key).asBroadcastStream().map((themeJson) {
      if (themeJson == null) return null;
      try {
        final themeMap = json.decode(themeJson) as Map<String, dynamic>;
        return ZephyrThemeData.fromJson(themeMap);
      } catch (e) {
        debugPrint('Failed to parse theme data: $e');
        return null;
      }
    });
  }
}
```

#### 4.2 External APIs
```dart
// 分析服务接口
abstract class ZephyrAnalyticsRepository {
  Future<void> logEvent(String name, Map<String, dynamic> properties);
  Future<void> logError(ZephyrError error);
  Future<void> logPerformance(String metric, double value);
}

// Firebase分析实现
class ZephyrFirebaseAnalyticsRepository implements ZephyrAnalyticsRepository {
  final FirebaseAnalytics _analytics;
  
  ZephyrFirebaseAnalyticsRepository(this._analytics);
  
  @override
  Future<void> logEvent(String name, Map<String, dynamic> properties) async {
    await _analytics.logEvent(
      name: name,
      parameters: properties,
    );
  }
  
  @override
  Future<void> logError(ZephyrError error) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      StackTrace.current,
      reason: error.message,
    );
  }
  
  @override
  Future<void> logPerformance(String metric, double value) async {
    await _analytics.logEvent(
      name: 'performance',
      parameters: {
        'metric': metric,
        'value': value,
      },
    );
  }
}
```

#### 4.3 Security Services
```dart
// 安全服务接口
abstract class ZephyrSecurityService {
  Future<bool> authenticate(String username, String password);
  Future<void> logout();
  Future<bool> hasPermission(String permission);
  Future<String> generateToken();
  Future<bool> validateToken(String token);
}

// 安全服务实现
class ZephyrSecurityServiceImpl implements ZephyrSecurityService {
  final ZephyrAuthRepository _authRepository;
  
  ZephyrSecurityServiceImpl(this._authRepository);
  
  @override
  Future<bool> authenticate(String username, String password) async {
    try {
      final credentials = ZephyrCredentials(
        username: username,
        password: _hashPassword(password),
      );
      
      final result = await _authRepository.authenticate(credentials);
      return result != null;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<void> logout() async {
    await _authRepository.clearCredentials();
  }
  
  @override
  Future<bool> hasPermission(String permission) async {
    final user = await _authRepository.getCurrentUser();
    return user?.permissions.contains(permission) ?? false;
  }
  
  @override
  Future<String> generateToken() async {
    final user = await _authRepository.getCurrentUser();
    if (user == null) {
      throw StateError('No authenticated user');
    }
    
    return _generateJwtToken(user);
  }
  
  @override
  Future<bool> validateToken(String token) async {
    try {
      final decoded = _decodeJwtToken(token);
      final user = await _authRepository.getCurrentUser();
      return user?.id == decoded['userId'];
    } catch (e) {
      return false;
    }
  }
  
  String _hashPassword(String password) {
    // 实现密码哈希
    return password; // 简化示例
  }
  
  String _generateJwtToken(ZephyrUser user) {
    // 实现JWT生成
    return 'token_${user.id}_${DateTime.now().millisecondsSinceEpoch}';
  }
  
  Map<String, dynamic> _decodeJwtToken(String token) {
    // 实现JWT解码
    return {'userId': token.split('_')[1]};
  }
}
```

## 📊 可观测性指标体系

### 1. 性能监控指标

#### 1.1 渲染性能指标
```dart
// 渲染性能监控
class ZephyrRenderingMetrics {
  static final Map<String, List<double>> _frameTimes = {};
  static final Map<String, List<double>> _buildTimes = {};
  
  static void recordFrameTime(String widgetName, double frameTime) {
    _frameTimes[widgetName] ??= [];
    _frameTimes[widgetName]!.add(frameTime);
  }
  
  static void recordBuildTime(String widgetName, double buildTime) {
    _buildTimes[widgetName] ??= [];
    _buildTimes[widgetName]!.add(buildTime);
  }
  
  static Map<String, double> getAverageFrameTimes() {
    return _frameTimes.map((key, times) {
      return MapEntry(key, times.reduce((a, b) => a + b) / times.length);
    });
  }
  
  static Map<String, double> getAverageBuildTimes() {
    return _buildTimes.map((key, times) {
      return MapEntry(key, times.reduce((a, b) => a + b) / times.length);
    });
  }
  
  static ZephyrRenderingReport generateReport() {
    return ZephyrRenderingReport(
      averageFrameTimes: getAverageFrameTimes(),
      averageBuildTimes: getAverageBuildTimes(),
      worstPerformingWidgets: _getWorstPerformingWidgets(),
      timestamp: DateTime.now(),
    );
  }
  
  static List<String> _getWorstPerformingWidgets() {
    final frameTimes = getAverageFrameTimes();
    return frameTimes.entries
        .where((entry) => entry.value > 16.0) // 超过16ms
        .map((entry) => entry.key)
        .toList()
        ..sort((a, b) => frameTimes[b]!.compareTo(frameTimes[a]!));
  }
}
```

#### 1.2 内存使用指标
```dart
// 内存使用监控
class ZephyrMemoryMetrics {
  static final Map<String, double> _memoryUsage = {};
  static final Map<String, int> _objectCounts = {};
  
  static void recordMemoryUsage(String category, double usageMB) {
    _memoryUsage[category] = usageMB;
  }
  
  static void recordObjectCount(String type, int count) {
    _objectCounts[type] = count;
  }
  
  static double getTotalMemoryUsage() {
    return _memoryUsage.values.fold(0, (sum, usage) => sum + usage);
  }
  
  static int getTotalObjectCount() {
    return _objectCounts.values.fold(0, (sum, count) => sum + count);
  }
  
  static ZephyrMemoryReport generateReport() {
    return ZephyrMemoryReport(
      totalMemoryUsage: getTotalMemoryUsage(),
      totalObjectCount: getTotalObjectCount(),
      memoryByCategory: Map.from(_memoryUsage),
      objectCountsByType: Map.from(_objectCounts),
      timestamp: DateTime.now(),
    );
  }
  
  static void checkMemoryLeaks() {
    final currentUsage = getTotalMemoryUsage();
    if (currentUsage > 100.0) { // 100MB阈值
      ZephyrLogger.warning('High memory usage detected: ${currentUsage}MB');
    }
  }
}
```

#### 1.3 网络性能指标
```dart
// 网络性能监控
class ZephyrNetworkMetrics {
  static final Map<String, List<double>> _requestTimes = {};
  static final Map<String, int> _errorCounts = {};
  
  static void recordRequestTime(String endpoint, double requestTime) {
    _requestTimes[endpoint] ??= [];
    _requestTimes[endpoint]!.add(requestTime);
  }
  
  static void recordError(String endpoint) {
    _errorCounts[endpoint] = (_errorCounts[endpoint] ?? 0) + 1;
  }
  
  static Map<String, double> getAverageRequestTimes() {
    return _requestTimes.map((key, times) {
      return MapEntry(key, times.reduce((a, b) => a + b) / times.length);
    });
  }
  
  static Map<String, double> getErrorRates() {
    return _errorCounts.map((endpoint, errorCount) {
      final totalRequests = _requestTimes[endpoint]?.length ?? 0;
      final errorRate = totalRequests > 0 ? errorCount / totalRequests : 0.0;
      return MapEntry(endpoint, errorRate);
    });
  }
  
  static ZephyrNetworkReport generateReport() {
    return ZephyrNetworkReport(
      averageRequestTimes: getAverageRequestTimes(),
      errorRates: getErrorRates(),
      totalRequests: _requestTimes.values.fold(0, (sum, times) => sum + times.length),
      totalErrors: _errorCounts.values.fold(0, (sum, count) => sum + count),
      timestamp: DateTime.now(),
    );
  }
}
```

### 2. 业务监控指标

#### 2.1 用户行为指标
```dart
// 用户行为监控
class ZephyrUserBehaviorMetrics {
  static final Map<String, int> _eventCounts = {};
  static final Map<String, List<Duration>> _sessionDurations = {};
  
  static void recordEvent(String eventName) {
    _eventCounts[eventName] = (_eventCounts[eventName] ?? 0) + 1;
  }
  
  static void recordSessionDuration(String userId, Duration duration) {
    _sessionDurations[userId] ??= [];
    _sessionDurations[userId]!.add(duration);
  }
  
  static Map<String, int> getEventCounts() {
    return Map.from(_eventCounts);
  }
  
  static double getAverageSessionDuration() {
    final allDurations = _sessionDurations.values.expand((durations) => durations);
    if (allDurations.isEmpty) return 0.0;
    
    final totalDuration = allDurations.fold(
      Duration.zero,
      (sum, duration) => sum + duration,
    );
    return totalDuration.inMilliseconds / allDurations.length / 1000.0;
  }
  
  static ZephyrUserBehaviorReport generateReport() {
    return ZephyrUserBehaviorReport(
      eventCounts: getEventCounts(),
      averageSessionDuration: getAverageSessionDuration(),
      totalEvents: _eventCounts.values.fold(0, (sum, count) => sum + count),
      totalSessions: _sessionDurations.length,
      timestamp: DateTime.now(),
    );
  }
}
```

#### 2.2 组件使用指标
```dart
// 组件使用监控
class ZephyrComponentUsageMetrics {
  static final Map<String, int> _componentUsage = {};
  static final Map<String, List<double>> _renderTimes = {};
  
  static void recordComponentUsage(String componentName) {
    _componentUsage[componentName] = (_componentUsage[componentName] ?? 0) + 1;
  }
  
  static void recordComponentRenderTime(String componentName, double renderTime) {
    _renderTimes[componentName] ??= [];
    _renderTimes[componentName]!.add(renderTime);
  }
  
  static Map<String, int> getComponentUsageCounts() {
    return Map.from(_componentUsage);
  }
  
  static Map<String, double> getAverageRenderTimes() {
    return _renderTimes.map((key, times) {
      return MapEntry(key, times.reduce((a, b) => a + b) / times.length);
    });
  }
  
  static List<String> getMostUsedComponents({int limit = 10}) {
    return _componentUsage.entries
        .map((entry) => MapEntry(entry.key, entry.value))
        .toList()
        ..sort((a, b) => b.value.compareTo(a.value));
  }
  
  static ZephyrComponentUsageReport generateReport() {
    return ZephyrComponentUsageReport(
      componentUsageCounts: getComponentUsageCounts(),
      averageRenderTimes: getAverageRenderTimes(),
      mostUsedComponents: getMostUsedComponents(),
      totalComponentUsages: _componentUsage.values.fold(0, (sum, count) => sum + count),
      timestamp: DateTime.now(),
    );
  }
}
```

### 3. 健康检查系统

#### 3.1 系统健康检查
```dart
// 系统健康检查
class ZephyrHealthChecker {
  static final List<ZephyrHealthCheck> _checks = [];
  
  static void registerCheck(ZephyrHealthCheck check) {
    _checks.add(check);
  }
  
  static Future<ZephyrHealthReport> runChecks() async {
    final results = <String, ZephyrHealthCheckResult>{};
    
    for (final check in _checks) {
      try {
        final result = await check.run();
        results[check.name] = result;
      } catch (e) {
        results[check.name] = ZephyrHealthCheckResult(
          status: ZephyrHealthStatus.unhealthy,
          message: 'Check failed: ${e.toString()}',
        );
      }
    }
    
    return ZephyrHealthReport(
      results: results,
      overallStatus: _calculateOverallStatus(results),
      timestamp: DateTime.now(),
    );
  }
  
  static ZephyrHealthStatus _calculateOverallStatus(
    Map<String, ZephyrHealthCheckResult> results,
  ) {
    if (results.values.any((result) => result.status == ZephyrHealthStatus.unhealthy)) {
      return ZephyrHealthStatus.unhealthy;
    }
    
    if (results.values.any((result) => result.status == ZephyrHealthStatus.degraded)) {
      return ZephyrHealthStatus.degraded;
    }
    
    return ZephyrHealthStatus.healthy;
  }
}

// 健康检查基类
abstract class ZephyrHealthCheck {
  String get name;
  Future<ZephyrHealthCheckResult> run();
}

// 内存健康检查
class ZephyrMemoryHealthCheck extends ZephyrHealthCheck {
  @override
  String get name => 'memory';
  
  @override
  Future<ZephyrHealthCheckResult> run() async {
    final memoryReport = ZephyrMemoryMetrics.generateReport();
    
    if (memoryReport.totalMemoryUsage > 100.0) {
      return ZephyrHealthCheckResult(
        status: ZephyrHealthStatus.unhealthy,
        message: 'Memory usage too high: ${memoryReport.totalMemoryUsage}MB',
      );
    }
    
    if (memoryReport.totalMemoryUsage > 50.0) {
      return ZephyrHealthCheckResult(
        status: ZephyrHealthStatus.degraded,
        message: 'Memory usage elevated: ${memoryReport.totalMemoryUsage}MB',
      );
    }
    
    return ZephyrHealthCheckResult(
      status: ZephyrHealthStatus.healthy,
      message: 'Memory usage normal: ${memoryReport.totalMemoryUsage}MB',
    );
  }
}

// 渲染性能健康检查
class ZephyrRenderingHealthCheck extends ZephyrHealthCheck {
  @override
  String get name => 'rendering';
  
  @override
  Future<ZephyrHealthCheckResult> run() async {
    final renderingReport = ZephyrRenderingMetrics.generateReport();
    final worstWidgets = renderingReport.worstPerformingWidgets;
    
    if (worstWidgets.isNotEmpty) {
      return ZephyrHealthCheckResult(
        status: ZephyrHealthStatus.degraded,
        message: 'Some widgets have poor rendering performance: ${worstWidgets.join(', ')}',
      );
    }
    
    return ZephyrHealthCheckResult(
      status: ZephyrHealthStatus.healthy,
      message: 'All widgets render within acceptable time',
    );
  }
}
```

#### 3.2 错误监控
```dart
// 错误监控系统
class ZephyrErrorMonitor {
  static final List<ZephyrErrorReport> _errors = [];
  static final Map<String, int> _errorCounts = {};
  
  static void recordError(ZephyrError error, StackTrace? stackTrace) {
    final report = ZephyrErrorReport(
      error: error,
      stackTrace: stackTrace,
      timestamp: DateTime.now(),
    );
    
    _errors.add(report);
    _errorCounts[error.code] = (_errorCounts[error.code] ?? 0) + 1;
    
    // 发送到错误追踪服务
    _sendToErrorTracking(report);
  }
  
  static List<ZephyrErrorReport> getRecentErrors({Duration? duration}) {
    final cutoff = duration != null 
        ? DateTime.now().subtract(duration)
        : DateTime.now().subtract(const Duration(hours: 24));
    
    return _errors.where((error) => error.timestamp.isAfter(cutoff)).toList();
  }
  
  static Map<String, int> getErrorCounts() {
    return Map.from(_errorCounts);
  }
  
  static List<ZephyrErrorReport> getCriticalErrors() {
    return _errors.where((error) => error.error.isCritical).toList();
  }
  
  static void _sendToErrorTracking(ZephyrErrorReport report) {
    // 实现错误追踪集成
    debugPrint('Error tracked: ${report.error.code} - ${report.error.message}');
  }
  
  static ZephyrErrorReport generateSummary() {
    final recentErrors = getRecentErrors();
    final criticalErrors = getCriticalErrors();
    
    return ZephyrErrorReport(
      error: ZephyrError(
        code: 'ERROR_SUMMARY',
        message: 'Error summary generated',
        isCritical: criticalErrors.isNotEmpty,
      ),
      timestamp: DateTime.now(),
      metadata: {
        'totalErrors': recentErrors.length,
        'criticalErrors': criticalErrors.length,
        'uniqueErrorCodes': _errorCounts.length,
      },
    );
  }
}
```

### 4. 监控仪表板

#### 4.1 实时监控仪表板
```dart
// 监控仪表板
class ZephyrMonitoringDashboard extends StatefulWidget {
  const ZephyrMonitoringDashboard({super.key});
  
  @override
  State<ZephyrMonitoringDashboard> createState() => _ZephyrMonitoringDashboardState();
}

class _ZephyrMonitoringDashboardState extends State<ZephyrMonitoringDashboard> {
  Timer? _updateTimer;
  ZephyrRenderingReport? _renderingReport;
  ZephyrMemoryReport? _memoryReport;
  ZephyrHealthReport? _healthReport;
  
  @override
  void initState() {
    super.initState();
    _updateReports();
    _updateTimer = Timer.periodic(const Duration(seconds: 5), (_) => _updateReports());
  }
  
  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }
  
  void _updateReports() {
    setState(() {
      _renderingReport = ZephyrRenderingMetrics.generateReport();
      _memoryReport = ZephyrMemoryMetrics.generateReport();
      _healthReport = ZephyrHealthChecker.runChecks() as ZephyrHealthReport?;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZephyrUI Monitoring Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHealthStatus(),
            const SizedBox(height: 24),
            _buildRenderingMetrics(),
            const SizedBox(height: 24),
            _buildMemoryMetrics(),
            const SizedBox(height: 24),
            _buildComponentUsage(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHealthStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'System Health',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_healthReport != null) ...[
              _buildHealthIndicator(_healthReport!.overallStatus),
              const SizedBox(height: 8),
              Text('Overall Status: ${_healthReport!.overallStatus.name}'),
              const SizedBox(height: 8),
              ..._healthReport!.results.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('${entry.key}: ${entry.value.status.name}'),
                );
              }),
            ] else ...[
              const Text('Loading health status...'),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildHealthIndicator(ZephyrHealthStatus status) {
    Color color;
    switch (status) {
      case ZephyrHealthStatus.healthy:
        color = Colors.green;
        break;
      case ZephyrHealthStatus.degraded:
        color = Colors.orange;
        break;
      case ZephyrHealthStatus.unhealthy:
        color = Colors.red;
        break;
    }
    
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
  
  Widget _buildRenderingMetrics() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rendering Performance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_renderingReport != null) ...[
              Text('Worst Performing Widgets:'),
              ..._renderingReport!.worstPerformingWidgets.map((widget) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $widget'),
                );
              }),
            ] else ...[
              const Text('Loading rendering metrics...'),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildMemoryMetrics() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Memory Usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_memoryReport != null) ...[
              Text('Total Memory Usage: ${_memoryReport!.totalMemoryUsage.toStringAsFixed(2)} MB'),
              Text('Total Objects: ${_memoryReport!.totalObjectCount}'),
            ] else ...[
              const Text('Loading memory metrics...'),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildComponentUsage() {
    final usageReport = ZephyrComponentUsageMetrics.generateReport();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Component Usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Total Component Usages: ${usageReport.totalComponentUsages}'),
            const SizedBox(height: 8),
            Text('Most Used Components:'),
            ...usageReport.mostUsedComponents.take(5).map((component) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $component'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
```

## 📈 数据模型定义

### 监控数据模型
```dart
// 健康状态枚举
enum ZephyrHealthStatus {
  healthy,
  degraded,
  unhealthy,
}

// 健康检查结果
class ZephyrHealthCheckResult {
  final ZephyrHealthStatus status;
  final String message;
  final Map<String, dynamic>? details;
  
  ZephyrHealthCheckResult({
    required this.status,
    required this.message,
    this.details,
  });
}

// 健康报告
class ZephyrHealthReport {
  final Map<String, ZephyrHealthCheckResult> results;
  final ZephyrHealthStatus overallStatus;
  final DateTime timestamp;
  
  ZephyrHealthReport({
    required this.results,
    required this.overallStatus,
    required this.timestamp,
  });
}

// 渲染性能报告
class ZephyrRenderingReport {
  final Map<String, double> averageFrameTimes;
  final Map<String, double> averageBuildTimes;
  final List<String> worstPerformingWidgets;
  final DateTime timestamp;
  
  ZephyrRenderingReport({
    required this.averageFrameTimes,
    required this.averageBuildTimes,
    required this.worstPerformingWidgets,
    required this.timestamp,
  });
}

// 内存报告
class ZephyrMemoryReport {
  final double totalMemoryUsage;
  final int totalObjectCount;
  final Map<String, double> memoryByCategory;
  final Map<String, int> objectCountsByType;
  final DateTime timestamp;
  
  ZephyrMemoryReport({
    required this.totalMemoryUsage,
    required this.totalObjectCount,
    required this.memoryByCategory,
    required this.objectCountsByType,
    required this.timestamp,
  });
}

// 错误报告
class ZephyrErrorReport {
  final ZephyrError error;
  final StackTrace? stackTrace;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;
  
  ZephyrErrorReport({
    required this.error,
    this.stackTrace,
    required this.timestamp,
    this.metadata,
  });
}
```

## 🎯 监控策略

### 1. 实时监控
- **渲染性能**: 实时监控组件渲染时间和帧率
- **内存使用**: 监控内存使用趋势和泄漏检测
- **错误追踪**: 实时捕获和报告应用错误

### 2. 告警机制
- **性能告警**: 当渲染时间超过16ms时触发
- **内存告警**: 当内存使用超过100MB时触发
- **错误告警**: 当发生关键错误时立即触发

### 3. 数据收集
- **本地存储**: 在本地存储监控数据
- **远程同步**: 定期同步到远程分析平台
- **数据聚合**: 支持数据聚合和分析

### 4. 可视化展示
- **实时仪表板**: 提供实时监控数据展示
- **历史趋势**: 支持历史数据趋势分析
- **性能报告**: 自动生成性能分析报告

通过这个完整的DDD分层架构设计和可观测性体系，ZephyrUI将具备企业级的架构质量和监控能力，确保系统的稳定性、可维护性和可观测性。

---

**文档版本**: 1.0  
**最后更新**: 2024年  
**制定人**: 架构师团队  
**审批状态**: 待批准