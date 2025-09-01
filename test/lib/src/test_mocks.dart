/// Mock和Stub系统
///
/// 提供测试用的Mock对象和Stub实现
library test_mocks;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';

/// Mock NavigatorObserver
class MockNavigatorObserver extends Mock implements NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = [];
  final List<Route<dynamic>> poppedRoutes = [];
  final List<Route<dynamic>> removedRoutes = [];
  final List<Route<dynamic>> replacedRoutes = [];
  
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
  
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    poppedRoutes.add(route);
    super.didPop(route, previousRoute);
  }
  
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    removedRoutes.add(route);
    super.didRemove(route, previousRoute);
  }
  
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      replacedRoutes.add(newRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
  
  /// 验证路由是否被推送
  void verifyPushed(String routeName) {
    final route = pushedRoutes.firstWhere(
      (route) => route.settings.name == routeName,
      orElse: () => throw Exception('Route $routeName not pushed'),
    );
    expect(route.settings.name, routeName);
  }
  
  /// 验证路由是否被弹出
  void verifyPopped(String routeName) {
    final route = poppedRoutes.firstWhere(
      (route) => route.settings.name == routeName,
      orElse: () => throw Exception('Route $routeName not popped'),
    );
    expect(route.settings.name, routeName);
  }
  
  /// 验证路由是否被移除
  void verifyRemoved(String routeName) {
    final route = removedRoutes.firstWhere(
      (route) => route.settings.name == routeName,
      orElse: () => throw Exception('Route $routeName not removed'),
    );
    expect(route.settings.name, routeName);
  }
  
  /// 验证路由是否被替换
  void verifyReplaced(String routeName) {
    final route = replacedRoutes.firstWhere(
      (route) => route.settings.name == routeName,
      orElse: () => throw Exception('Route $routeName not replaced'),
    );
    expect(route.settings.name, routeName);
  }
  
  /// 重置路由历史
  void reset() {
    pushedRoutes.clear();
    poppedRoutes.clear();
    removedRoutes.clear();
    replacedRoutes.clear();
    reset(mocktail: true);
  }
}

/// Mock ScrollController
class MockScrollController extends Mock implements ScrollController {
  @override
  double get offset => 0.0;
  
  @override
  bool get hasClients => true;
  
  @override
  void animateTo(
    double offset, {
    required Duration duration,
    required Curve curve,
  }) {
    // 模拟滚动动画
  }
  
  @override
  Future<void> ensureVisible(
    RenderObject object, {
    double alignment = 0.0,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy = ScrollPositionAlignmentPolicy.explicit,
    RenderObject? targetRenderObject,
  }) async {
    // 模拟确保可见
  }
  
  @override
  void jumpTo(double offset) {
    // 模拟跳转
  }
  
  @override
  void dispose() {
    // 模拟销毁
  }
}

/// Mock TextEditingController
class MockTextEditingController extends Mock implements TextEditingController {
  String _text = '';
  final ValueNotifier<String> _textNotifier = ValueNotifier<String>('');
  
  @override
  String get text => _text;
  
  @override
  set text(String value) {
    _text = value;
    _textNotifier.value = value;
  }
  
  @override
  ValueNotifier<String> get textNotifier => _textNotifier;
  
  @override
  void clear() {
    _text = '';
    _textNotifier.value = '';
  }
  
  @override
  void dispose() {
    _textNotifier.dispose();
    super.dispose();
  }
}

/// Mock FocusNode
class MockFocusNode extends Mock implements FocusNode {
  bool _hasFocus = false;
  final ValueNotifier<bool> _hasFocusNotifier = ValueNotifier<bool>(false);
  
  @override
  bool get hasFocus => _hasFocus;
  
  @override
  ValueNotifier<bool> get hasFocusNotifier => _hasFocusNotifier;
  
  @override
  void requestFocus() {
    _hasFocus = true;
    _hasFocusNotifier.value = true;
  }
  
  @override
  void unfocus() {
    _hasFocus = false;
    _hasFocusNotifier.value = false;
  }
  
  @override
  void dispose() {
    _hasFocusNotifier.dispose();
    super.dispose();
  }
}

/// Mock AnimationController
class MockAnimationController extends Mock implements AnimationController {
  double _value = 0.0;
  AnimationStatus _status = AnimationStatus.dismissed;
  
  @override
  double get value => _value;
  
  @override
  AnimationStatus get status => _status;
  
  @override
  set value(double newValue) {
    _value = newValue;
  }
  
  @override
  Future<void> forward() async {
    _value = 1.0;
    _status = AnimationStatus.completed;
  }
  
  @override
  Future<void> reverse() async {
    _value = 0.0;
    _status = AnimationStatus.dismissed;
  }
  
  @override
  Future<void> repeat({double? min, double? max, bool reverse = false, Duration? period}) async {
    // 模拟重复动画
  }
  
  @override
  Future<void> fling({double velocity = 1.0, SpringDescription? springDescription}) async {
    // 模拟弹性动画
  }
  
  @override
  void dispose() {
    // 模拟销毁
  }
}

/// Mock PageController
class MockPageController extends Mock implements PageController {
  int _initialPage = 0;
  double _viewportFraction = 1.0;
  
  @override
  int get initialPage => _initialPage;
  
  @override
  double get viewportFraction => _viewportFraction;
  
  @override
  Future<void> animateToPage(
    int page, {
    required Duration duration,
    required Curve curve,
  }) async {
    // 模拟页面切换动画
  }
  
  @override
  void jumpToPage(int page) {
    // 模拟页面跳转
  }
  
  @override
  Future<void> nextPage({Duration? duration, Curve? curve}) async {
    // 模拟下一页
  }
  
  @override
  Future<void> previousPage({Duration? duration, Curve? curve}) async {
    // 模拟上一页
  }
  
  @override
  void dispose() {
    // 模拟销毁
  }
}

/// Mock TabController
class MockTabController extends Mock implements TabController {
  int _length = 0;
  int _index = 0;
  final ValueNotifier<int> _indexNotifier = ValueNotifier<int>(0);
  
  @override
  int get length => _length;
  
  @override
  int get index => _index;
  
  @override
  ValueNotifier<int> get indexNotifier => _indexNotifier;
  
  @override
  void animateTo(int value, {Duration? duration, Curve? curve}) {
    _index = value;
    _indexNotifier.value = value;
  }
  
  @override
  void dispose() {
    _indexNotifier.dispose();
    super.dispose();
  }
}

/// Mock ValueNotifier
class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);
}

/// Mock StreamController
class MockStreamController<T> extends Mock implements StreamController<T> {
  final List<T> _events = [];
  final List<void Function(T)> _listeners = [];
  bool _isClosed = false;
  
  @override
  Stream<T> get stream => Stream.fromIterable(_events);
  
  @override
  StreamSink<T> get sink => this;
  
  @override
  void add(T event) {
    if (_isClosed) {
      throw StateError('Cannot add event to closed controller');
    }
    _events.add(event);
    for (final listener in _listeners) {
      listener(event);
    }
  }
  
  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    if (_isClosed) {
      throw StateError('Cannot add error to closed controller');
    }
    // 模拟错误处理
  }
  
  @override
  Future<void> close() async {
    _isClosed = true;
  }
  
  @override
  void addStream(Stream<T> source) {
    // 模拟添加流
  }
  
  @override
  Future<void> done => Future.value();
  
  @override
  bool get isClosed => _isClosed;
  
  @override
  bool get isPaused => false;
  
  @override
  bool get hasListener => _listeners.isNotEmpty;
  
  @override
  void onListen() {
    // 监听回调
  }
  
  @override
  void onPause() {
    // 暂停回调
  }
  
  @override
  void onResume() {
    // 恢复回调
  }
  
  @override
  void onCancel() {
    // 取消回调
  }
  
  /// 添加监听器
  void addListener(void Function(T) listener) {
    _listeners.add(listener);
  }
  
  /// 移除监听器
  void removeListener(void Function(T) listener) {
    _listeners.remove(listener);
  }
  
  /// 获取所有事件
  List<T> get events => List.unmodifiable(_events);
  
  /// 重置控制器
  void reset() {
    _events.clear();
    _listeners.clear();
    _isClosed = false;
    reset(mocktail: true);
  }
}

/// Mock StreamSubscription
class MockStreamSubscription<T> extends Mock implements StreamSubscription<T> {
  bool _isPaused = false;
  bool _isCancelled = false;
  
  @override
  Future<void> cancel() async {
    _isCancelled = true;
  }
  
  @override
  void pause() {
    _isPaused = true;
  }
  
  @override
  void resume() {
    _isPaused = false;
  }
  
  @override
  bool get isPaused => _isPaused;
  
  @override
  Future<E> asFuture<E>([E? futureValue]) async {
    return futureValue as E;
  }
  
  @override
  void onData(void Function(T)? handleData) {
    // 数据处理回调
  }
  
  @override
  void onError(Function? handleError) {
    // 错误处理回调
  }
  
  @override
  void onDone(void Function()? handleDone) {
    // 完成回调
  }
}

/// Mock Future
class MockFuture<T> extends Mock implements Future<T> {
  T? _value;
  Object? _error;
  StackTrace? _stackTrace;
  
  MockFuture.value(T value) : _value = value;
  
  MockFuture.error(Object error, [StackTrace? stackTrace]) 
      : _error = error, _stackTrace = stackTrace;
  
  @override
  Future<T> then<R>(FutureOr<R> Function(T) onValue, {Function? onError}) {
    if (_value != null) {
      return Future.value(onValue(_value as T));
    } else if (_error != null) {
      return Future.error(_error!, _stackTrace);
    }
    return Future.value();
  }
  
  @override
  Future<T> catchError(Function onError, {bool Function(Object)? test}) {
    if (_error != null) {
      try {
        return Future.value(onError(_error, _stackTrace) as T);
      } catch (e) {
        return Future.error(e);
      }
    }
    return this;
  }
  
  @override
  Future<T> whenComplete(FutureOr<void> Function() onComplete) {
    if (_value != null) {
      return Future.value(_value);
    } else if (_error != null) {
      return Future.error(_error!, _stackTrace);
    }
    return Future.value();
  }
  
  @override
  Stream<T> asStream() {
    if (_value != null) {
      return Stream.value(_value as T);
    } else if (_error != null) {
      return Stream.error(_error!, _stackTrace);
    }
    return Stream.empty();
  }
  
  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) {
    return Future.delayed(timeLimit, () {
      if (onTimeout != null) {
        return onTimeout();
      }
      throw TimeoutException('Future timed out');
    });
  }
}

/// Mock Timer
class MockTimer extends Mock implements Timer {
  bool _isActive = true;
  Duration _duration = Duration.zero;
  
  MockTimer(Duration duration) : _duration = duration;
  
  @override
  bool get isActive => _isActive;
  
  @override
  Duration get duration => _duration;
  
  @override
  void cancel() {
    _isActive = false;
  }
  
  @override
  int get tick => 0;
}

/// Mock HttpClient
class MockHttpClient extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return MockHttpClientRequest(url);
  }
  
  @override
  Future<HttpClientRequest> postUrl(Uri url) async {
    return MockHttpClientRequest(url);
  }
  
  @override
  Future<HttpClientRequest> putUrl(Uri url) async {
    return MockHttpClientRequest(url);
  }
  
  @override
  Future<HttpClientRequest> deleteUrl(Uri url) async {
    return MockHttpClientRequest(url);
  }
  
  @override
  Future<HttpClientRequest> patchUrl(Uri url) async {
    return MockHttpClientRequest(url);
  }
  
  @override
  Future<HttpClientRequest> headUrl(Uri url) async {
    return MockHttpClientRequest(url);
  }
  
  @override
  void close() {
    // 模拟关闭
  }
}

/// Mock HttpClientRequest
class MockHttpClientRequest extends Mock implements HttpClientRequest {
  final Uri _url;
  final Map<String, String> _headers = {};
  final List<int> _body = [];
  
  MockHttpClientRequest(this._url);
  
  @override
  Uri get url => _url;
  
  @override
  Map<String, String> get headers => _headers;
  
  @override
  void add(List<int> data) {
    _body.addAll(data);
  }
  
  @override
  void addStream(Stream<List<int>> stream) {
    // 模拟添加流
  }
  
  @override
  Future<HttpClientResponse> close() async {
    return MockHttpClientResponse();
  }
  
  @override
  void abort([Object? exception, StackTrace? stackTrace]) {
    // 模拟中止
  }
}

/// Mock HttpClientResponse
class MockHttpClientResponse extends Mock implements HttpClientResponse {
  int _statusCode = 200;
  String _reasonPhrase = 'OK';
  final Map<String, String> _headers = {};
  final List<int> _body = [];
  
  MockHttpClientResponse({
    int statusCode = 200,
    String reasonPhrase = 'OK',
    Map<String, String>? headers,
    List<int>? body,
  }) : _statusCode = statusCode,
       _reasonPhrase = reasonPhrase,
       _headers = headers ?? {},
       _body = body ?? [];
  
  @override
  int get statusCode => _statusCode;
  
  @override
  String get reasonPhrase => _reasonPhrase;
  
  @override
  Map<String, String> get headers => _headers;
  
  @override
  Stream<List<int>> get stream => Stream.value(_body);
  
  @override
  HttpClientResponseCompressionState get compressionState {
    return HttpClientResponseCompressionState.notCompressed;
  }
  
  @override
  int get contentLength => _body.length;
  
  @override
  bool get persistentConnection => true;
  
  @override
  bool get isRedirect => false;
  
  @override
  List<RedirectInfo> get redirects => [];
  
  @override
  Future<void> drain() async {
    // 模拟排空
  }
  
  @override
  void detachSocket() {
    // 模拟分离套接字
  }
}

/// Mock SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {
  final Map<String, dynamic> _data = {};
  
  @override
  bool containsKey(String key) {
    return _data.containsKey(key);
  }
  
  @override
  dynamic get(String key) {
    return _data[key];
  }
  
  @override
  bool? getBool(String key) {
    return _data[key] as bool?;
  }
  
  @override
  int? getInt(String key) {
    return _data[key] as int?;
  }
  
  @override
  double? getDouble(String key) {
    return _data[key] as double?;
  }
  
  @override
  String? getString(String key) {
    return _data[key] as String?;
  }
  
  @override
  List<String>? getStringList(String key) {
    return _data[key] as List<String>?;
  }
  
  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }
  
  @override
  Future<bool> commit() async {
    return true;
  }
  
  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }
  
  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }
  
  @override
  Future<bool> setInt(String key, int value) async {
    _data[key] = value;
    return true;
  }
  
  @override
  Future<bool> setDouble(String key, double value) async {
    _data[key] = value;
    return true;
  }
  
  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }
  
  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _data[key] = value;
    return true;
  }
  
  @override
  Set<String> getKeys() {
    return _data.keys.toSet();
  }
  
  /// 获取所有数据
  Map<String, dynamic> getAll() => Map.unmodifiable(_data);
  
  /// 设置数据
  void setData(String key, dynamic value) {
    _data[key] = value;
  }
  
  /// 重置数据
  void reset() {
    _data.clear();
    reset(mocktail: true);
  }
}

/// Mock Dio
class MockDio extends Mock implements Dio {
  final Map<String, dynamic> _responses = {};
  final List<RequestOptions> _requests = [];
  
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final request = RequestOptions(
      path: path,
      method: 'GET',
      queryParameters: queryParameters,
    );
    _requests.add(request);
    
    final key = 'GET:$path';
    if (_responses.containsKey(key)) {
      return _responses[key] as Response<T>;
    }
    
    return Response<T>(
      requestOptions: request,
      data: null,
      statusCode: 200,
    );
  }
  
  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final request = RequestOptions(
      path: path,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
    );
    _requests.add(request);
    
    final key = 'POST:$path';
    if (_responses.containsKey(key)) {
      return _responses[key] as Response<T>;
    }
    
    return Response<T>(
      requestOptions: request,
      data: null,
      statusCode: 200,
    );
  }
  
  @override
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final request = RequestOptions(
      path: path,
      method: 'PUT',
      data: data,
      queryParameters: queryParameters,
    );
    _requests.add(request);
    
    final key = 'PUT:$path';
    if (_responses.containsKey(key)) {
      return _responses[key] as Response<T>;
    }
    
    return Response<T>(
      requestOptions: request,
      data: null,
      statusCode: 200,
    );
  }
  
  @override
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final request = RequestOptions(
      path: path,
      method: 'DELETE',
      data: data,
      queryParameters: queryParameters,
    );
    _requests.add(request);
    
    final key = 'DELETE:$path';
    if (_responses.containsKey(key)) {
      return _responses[key] as Response<T>;
    }
    
    return Response<T>(
      requestOptions: request,
      data: null,
      statusCode: 200,
    );
  }
  
  /// 设置模拟响应
  void setResponse<T>(String method, String path, Response<T> response) {
    final key = '$method:$path';
    _responses[key] = response;
  }
  
  /// 设置模拟错误
  void setError(String method, String path, DioException error) {
    final key = '$method:$path';
    _responses[key] = error;
  }
  
  /// 获取所有请求
  List<RequestOptions> get requests => List.unmodifiable(_requests);
  
  /// 验证请求
  void verifyRequest(String method, String path) {
    final found = _requests.any((request) => 
      request.method == method && request.path == path);
    expect(found, isTrue, reason: 'Request $method $path not found');
  }
  
  /// 重置
  void reset() {
    _responses.clear();
    _requests.clear();
    reset(mocktail: true);
  }
}

/// Mock DioException
class MockDioException extends Mock implements DioException {
  @override
  DioExceptionType get type => DioExceptionType.unknown;
  
  @override
  Object? get error => null;
  
  @override
  StackTrace? get stackTrace => null;
  
  @override
  String get message => 'Mock DioException';
  
  @override
  RequestOptions get requestOptions => RequestOptions(path: '/mock');
  
  @override
  Response? get response => null;
}

/// Mock Platform
class MockPlatform extends Mock implements Platform {
  String _operatingSystem = 'android';
  String _localHostname = 'mock';
  int _numberOfProcessors = 4;
  String _pathSeparator = '/';
  String _locale = 'en_US';
  
  MockPlatform({
    String operatingSystem = 'android',
    String localHostname = 'mock',
    int numberOfProcessors = 4,
    String pathSeparator = '/',
    String locale = 'en_US',
  }) : _operatingSystem = operatingSystem,
       _localHostname = localHostname,
       _numberOfProcessors = numberOfProcessors,
       _pathSeparator = pathSeparator,
       _locale = locale;
  
  @override
  String get operatingSystem => _operatingSystem;
  
  @override
  String get localHostname => _localHostname;
  
  @override
  int get numberOfProcessors => _numberOfProcessors;
  
  @override
  String get pathSeparator => _pathSeparator;
  
  @override
  String get locale => _locale;
  
  @override
  bool get isAndroid => _operatingSystem == 'android';
  
  @override
  bool get isIOS => _operatingSystem == 'ios';
  
  @override
  bool get isLinux => _operatingSystem == 'linux';
  
  @override
  bool get isMacOS => _operatingSystem == 'macos';
  
  @override
  bool get isWindows => _operatingSystem == 'windows';
  
  @override
  bool get isFuchsia => _operatingSystem == 'fuchsia';
}

/// Mock MethodChannel
class MockMethodChannel extends Mock implements MethodChannel {
  final Map<String, dynamic> _responses = {};
  final List<MethodCall> _methodCalls = [];
  
  @override
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    _methodCalls.add(MethodCall(method, arguments));
    
    final key = method;
    if (_responses.containsKey(key)) {
      return _responses[key] as T?;
    }
    
    return null;
  }
  
  /// 设置模拟响应
  void setResponse<T>(String method, T response) {
    _responses[method] = response;
  }
  
  /// 设置模拟错误
  void setError(String method, PlatformException error) {
    _responses[method] = error;
  }
  
  /// 获取所有方法调用
  List<MethodCall> get methodCalls => List.unmodifiable(_methodCalls);
  
  /// 验证方法调用
  void verifyMethodCall(String method) {
    final found = _methodCalls.any((call) => call.method == method);
    expect(found, isTrue, reason: 'Method $method not called');
  }
  
  /// 重置
  void reset() {
    _responses.clear();
    _methodCalls.clear();
    reset(mocktail: true);
  }
}

/// Mock EventChannel
class MockEventChannel extends Mock implements EventChannel {
  final StreamController<dynamic> _controller = StreamController<dynamic>();
  
  @override
  Stream<T> receiveBroadcastStream<T>([dynamic arguments]) {
    return _controller.stream as Stream<T>;
  }
  
  /// 发送事件
  void sendEvent(dynamic event) {
    _controller.add(event);
  }
  
  /// 发送错误
  void sendError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }
  
  /// 关闭流
  void close() {
    _controller.close();
  }
  
  /// 重置
  void reset() {
    _controller.close();
    reset(mocktail: true);
  }
}

/// Mock AssetBundle
class MockAssetBundle extends Mock implements AssetBundle {
  final Map<String, String> _assets = {};
  
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (_assets.containsKey(key)) {
      return _assets[key]!;
    }
    throw Exception('Asset not found: $key');
  }
  
  @override
  Future<ByteData> load(String key) async {
    if (_assets.containsKey(key)) {
      final string = _assets[key]!;
      return ByteData.view(string.codeUnits.buffer);
    }
    throw Exception('Asset not found: $key');
  }
  
  @override
  Future<ByteData> loadStructuredData<T>(String key, Future<T> Function(String value) parser) async {
    final string = await loadString(key);
    return parser(string);
  }
  
  /// 设置模拟资源
  void setAsset(String key, String value) {
    _assets[key] = value;
  }
  
  /// 获取所有资源
  Map<String, String> get assets => Map.unmodifiable(_assets);
  
  /// 重置
  void reset() {
    _assets.clear();
    reset(mocktail: true);
  }
}

/// Mock ImageProvider
class MockImageProvider extends Mock implements ImageProvider<Object> {
  final ImageStreamCompleter _completer = MockImageStreamCompleter();
  
  @override
  ImageStream resolve(ImageConfiguration configuration) {
    return ImageStream(_completer);
  }
  
  @override
  Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty}) async {
    return true;
  }
  
  @override
  String get key => 'mock_image_provider';
}

/// Mock ImageStreamCompleter
class MockImageStreamCompleter extends Mock implements ImageStreamCompleter {
  final ImageInfo _imageInfo = MockImageInfo();
  
  @override
  void addListener(ImageStreamListener listener) {
    listener.onImage(_imageInfo, true);
  }
  
  @override
  void removeListener(ImageStreamListener listener) {
    // 模拟移除监听器
  }
}

/// Mock ImageInfo
class MockImageInfo extends Mock implements ImageInfo {
  @override
  Image get image => MockImage();
  
  @override
  double get scale => 1.0;
}

/// Mock Image
class MockImage extends Mock implements Image {
  @override
  int get width => 100;
  
  @override
  int get height => 100;
  
  @override
  void dispose() {
    // 模拟销毁
  }
}

/// Mock BuildContext
class MockBuildContext extends Mock implements BuildContext {
  @override
  Widget get widget => Container();
  
  @override
  RenderObject get renderObject => MockRenderObject();
  
  @override
  Size get size => const Size(100, 100);
  
  @override
  MediaQueryData get mediaQuery => MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  
  @override
  ThemeMode get themeMode => ThemeMode.system;
  
  @override
  ThemeData get theme => ThemeData.light();
  
  @override
  ThemeData get darkTheme => ThemeData.dark();
  
  @override
  Locale get locale => const Locale('en', 'US');
  
  @override
  bool get debugDoingBuild => false;
  
  @override
  void setState(VoidCallback fn) {
    // 模拟设置状态
  }
  
  @override
  void markNeedsBuild() {
    // 模拟标记需要构建
  }
  
  @override
  void rebuild({bool force = false}) {
    // 模拟重新构建
  }
  
  @override
  T dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({Object? aspect}) {
    throw UnimplementedError();
  }
  
  @override
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    throw UnimplementedError();
  }
  
  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
    throw UnimplementedError();
  }
  
  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
    throw UnimplementedError();
  }
  
  @override
  void visitAncestorElements(bool Function(Element element) visitor) {
    // 模拟访问祖先元素
  }
  
  @override
  void visitChildElements(ElementVisitor visitor) {
    // 模拟访问子元素
  }
}

/// Mock RenderObject
class MockRenderObject extends Mock implements RenderObject {
  @override
  bool get hasSize => true;
  
  @override
  Size get size => const Size(100, 100);
  
  @override
  void performLayout() {
    // 模拟布局
  }
  
  @override
  void performResize() {
    // 模拟调整大小
  }
  
  @override
  void performCompositing() {
    // 模拟合成
  }
  
  @override
  void paint(PaintingContext context, Offset offset) {
    // 模拟绘制
  }
  
  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    // 模拟应用绘制变换
  }
  
  @override
  void showOnScreen({RenderObject? descendant, Rect? rect, Duration duration = Duration.zero, Curve curve = Curves.ease}) {
    // 模拟显示在屏幕上
  }
  
  @override
  void sendSemanticsEvent(SemanticsEvent semanticsEvent) {
    // 模拟发送语义事件
  }
  
  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    // 模拟处理事件
  }
}

/// Mock RenderBox
class MockRenderBox extends MockRenderObject implements RenderBox {
  @override
  Size get size => const Size(100, 100);
  
  @override
  Rect get paintBounds => const Rect.fromLTWH(0, 0, 100, 100);
  
  @override
  double get distanceToBaseline => 20.0;
  
  @override
  double get minIntrinsicWidth => 50.0;
  
  @override
  double get maxIntrinsicWidth => 200.0;
  
  @override
  double get minIntrinsicHeight => 30.0;
  
  @override
  double get maxIntrinsicHeight => 150.0;
  
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return true;
  }
  
  @override
  void performLayout() {
    // 模拟布局
  }
  
  @override
  void paint(PaintingContext context, Offset offset) {
    // 模拟绘制
  }
}

/// Mock Element
class MockElement extends Mock implements Element {
  @override
  Widget get widget => Container();
  
  @override
  RenderObject get renderObject => MockRenderObject();
  
  @override
  BuildContext get context => this;
  
  @override
  bool get mounted => true;
  
  @override
  bool get debugDoingBuild => false;
  
  @override
  void mount(Element? parent, dynamic newSlot) {
    // 模拟挂载
  }
  
  @override
  void unmount() {
    // 模拟卸载
  }
  
  @override
  void update(Widget newWidget) {
    // 模拟更新
  }
  
  @override
  void rebuild({bool force = false}) {
    // 模拟重新构建
  }
  
  @override
  void markNeedsBuild() {
    // 模拟标记需要构建
  }
  
  @override
  void visitChildren(ElementVisitor visitor) {
    // 模拟访问子元素
  }
  
  @override
  void visitAncestorElements(bool Function(Element element) visitor) {
    // 模拟访问祖先元素
  }
}

/// Mock State
class MockState<T extends StatefulWidget> extends Mock implements State<T> {
  @override
  Widget get widget => Container();
  
  @override
  BuildContext get context => MockBuildContext();
  
  @override
  bool get mounted => true;
  
  @override
  void initState() {
    // 模拟初始化状态
  }
  
  @override
  void didChangeDependencies() {
    // 模拟依赖变化
  }
  
  @override
  void didUpdateWidget(T oldWidget) {
    // 模拟组件更新
  }
  
  @override
  void setState(VoidCallback fn) {
    // 模拟设置状态
  }
  
  @override
  void deactivate() {
    // 模拟停用
  }
  
  @override
  void dispose() {
    // 模拟销毁
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 模拟应用生命周期变化
  }
  
  @override
  void didUpdateLocale(Locale locale) {
    // 模拟语言环境更新
  }
  
  @override
  void didChangeTextScaleFactor() {
    // 模拟文本缩放因子变化
  }
  
  @override
  void didChangePlatformBrightness() {
    // 模拟平台亮度变化
  }
  
  @override
  void didChangeAccessibilityFeatures() {
    // 模拟无障碍特性变化
  }
}

/// Mock GlobalKey
class MockGlobalKey<T extends State<StatefulWidget>> extends Mock implements GlobalKey<T> {
  @override
  T? get currentState => MockState<T>() as T;
  
  @override
  BuildContext? get currentContext => MockBuildContext();
  
  @override
  Widget get currentWidget => Container();
}

/// Mock Route
class MockRoute<T> extends Mock implements Route<T> {
  @override
  String? get name => '/mock';
  
  @override
  RouteSettings get settings => RouteSettings(name: name);
  
  @override
  bool get isCurrent => true;
  
  @override
  bool get isFirst => true;
  
  @override
  bool get isActive => true;
  
  @override
  bool get isPaused => false;
  
  @override
  Future<T?> get popped => Future.value();
  
  @override
  void install() {
    // 模拟安装
  }
  
  @override
  Ticker createTicker(TickerCallback onTick) {
    return MockTicker(onTick);
  }
  
  @override
  void dispose() {
    // 模拟销毁
  }
  
  @override
  bool get finished => false;
  
  @override
  bool get opaque => true;
  
  @override
  String get debugLabel => 'MockRoute';
}

/// Mock Ticker
class MockTicker extends Mock implements Ticker {
  final TickerCallback _onTick;
  bool _isActive = false;
  bool _isTicking = false;
  
  MockTicker(this._onTick);
  
  @override
  bool get isActive => _isActive;
  
  @override
  bool get isTicking => _isTicking;
  
  @override
  void start() {
    _isActive = true;
    _isTicking = true;
  }
  
  @override
  void stop({bool canceled = false}) {
    _isActive = false;
    _isTicking = false;
  }
  
  @override
  void absorbTicker(Ticker originalTicker) {
    // 模拟吸收ticker
  }
  
  @override
  void dispose() {
    _isActive = false;
    _isTicking = false;
  }
  
  @override
  String get debugLabel => 'MockTicker';
}

/// Mock Animation
class MockAnimation<T> extends Mock implements Animation<T> {
  T _value = 0 as T;
  AnimationStatus _status = AnimationStatus.dismissed;
  
  @override
  T get value => _value;
  
  @override
  AnimationStatus get status => _status;
  
  @override
  void addListener(VoidCallback listener) {
    // 模拟添加监听器
  }
  
  @override
  void removeListener(VoidCallback listener) {
    // 模拟移除监听器
  }
  
  @override
  void addStatusListener(AnimationStatusListener listener) {
    // 模拟添加状态监听器
  }
  
  @override
  void removeStatusListener(AnimationStatusListener listener) {
    // 模拟移除状态监听器
  }
}

/// Mock Curve
class MockCurve extends Mock implements Curve {
  @override
  double transform(double t) {
    return t;
  }
  
  @override
  String get name => 'MockCurve';
}

/// Mock ScaffoldState
class MockScaffoldState extends Mock implements ScaffoldState {
  @override
  BuildContext get context => MockBuildContext();
  
  @override
  Widget get widget => Scaffold();
  
  @override
  bool get mounted => true;
  
  @override
  void showSnackBar(SnackBar snackBar) {
    // 模拟显示SnackBar
  }
  
  @override
  void hideCurrentSnackBar({SnackBarClosedReason reason = SnackBarClosedReason.hide}) {
    // 模拟隐藏当前SnackBar
  }
  
  @override
  void removeCurrentSnackBar({SnackBarClosedReason reason = SnackBarClosedReason.remove}) {
    // 模拟移除当前SnackBar
  }
  
  @override
  void openDrawer() {
    // 模拟打开抽屉
  }
  
  @override
  void openEndDrawer() {
    // 模拟打开结束抽屉
  }
  
  @override
  void showBottomSheet<T>(WidgetBuilder builder) {
    // 模拟显示底部表单
  }
}

/// Mock ScaffoldMessengerState
class MockScaffoldMessengerState extends Mock implements ScaffoldMessengerState {
  @override
  BuildContext get context => MockBuildContext();
  
  @override
  Widget get widget => ScaffoldMessenger(child: Container());
  
  @override
  bool get mounted => true;
  
  @override
  void showSnackBar(SnackBar snackBar) {
    // 模拟显示SnackBar
  }
  
  @override
  void hideCurrentSnackBar({SnackBarClosedReason reason = SnackBarClosedReason.hide}) {
    // 模拟隐藏当前SnackBar
  }
  
  @override
  void removeCurrentSnackBar({SnackBarClosedReason reason = SnackBarClosedReason.remove}) {
    // 模拟移除当前SnackBar
  }
  
  @override
  void clearSnackBars() {
    // 模拟清除所有SnackBar
  }
}

/// Mock MediaQuery
class MockMediaQuery extends Mock implements MediaQuery {
  @override
  MediaQueryData get data => MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  
  @override
  Widget get widget => Container();
  
  @override
  BuildContext get context => MockBuildContext();
}

/// Mock Theme
class MockTheme extends Mock implements Theme {
  @override
  ThemeData get data => ThemeData.light();
  
  @override
  Widget get widget => Container();
  
  @override
  BuildContext get context => MockBuildContext();
}

/// Mock Localizations
class MockLocalizations extends Mock implements Localizations {
  @override
  Widget get widget => Container();
  
  @override
  BuildContext get context => MockBuildContext();
  
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

/// Mock WidgetsBinding
class MockWidgetsBinding extends Mock implements WidgetsBinding {
  @override
  SchedulerBinding get scheduler => MockSchedulerBinding();
  
  @override
  RenderingBinding get rendering => MockRenderingBinding();
  
  @override
  GestureBinding get gesture => MockGestureBinding();
  
  @override
  SemanticsBinding get semantics => MockSemanticsBinding();
  
  @override
  ServicesBinding get services => MockServicesBinding();
  
  @override
  PlatformDispatcher get platformDispatcher => MockPlatformDispatcher();
  
  @override
  void addPersistentFrameCallback(FrameCallback callback) {
    // 模拟添加持久帧回调
  }
  
  @override
  void scheduleFrame() {
    // 模拟调度帧
  }
  
  @override
  void handleBeginFrame(Duration rawTimeStamp) {
    // 模拟处理开始帧
  }
  
  @override
  void handleDrawFrame() {
    // 模拟处理绘制帧
  }
  
  @override
  void ensureVisualUpdate() {
    // 模拟确保视觉更新
  }
}

/// Mock SchedulerBinding
class MockSchedulerBinding extends Mock implements SchedulerBinding {
  @override
  void addPersistentFrameCallback(FrameCallback callback) {
    // 模拟添加持久帧回调
  }
  
  @override
  void scheduleFrame() {
    // 模拟调度帧
  }
  
  @override
  void handleBeginFrame(Duration rawTimeStamp) {
    // 模拟处理开始帧
  }
  
  @override
  void handleDrawFrame() {
    // 模拟处理绘制帧
  }
  
  @override
  void ensureVisualUpdate() {
    // 模拟确保视觉更新
  }
}

/// Mock RenderingBinding
class MockRenderingBinding extends Mock implements RenderingBinding {
  @override
  void ensureVisualUpdate() {
    // 模拟确保视觉更新
  }
}

/// Mock GestureBinding
class MockGestureBinding extends Mock implements GestureBinding {
  @override
  void handlePointerEvent(PointerEvent event) {
    // 模拟处理指针事件
  }
}

/// Mock SemanticsBinding
class MockSemanticsBinding extends Mock implements SemanticsBinding {
  @override
  void performSemanticsAction(SemanticsActionEvent action) {
    // 模拟执行语义动作
  }
}

/// Mock ServicesBinding
class MockServicesBinding extends Mock implements ServicesBinding {
  @override
  void sendPlatformMessage(String name, ByteData? data, PlatformMessageResponseCallback? callback) {
    // 模拟发送平台消息
  }
}

/// Mock PlatformDispatcher
class MockPlatformDispatcher extends Mock implements PlatformDispatcher {
  @override
  void sendPlatformMessage(String name, ByteData? data, PlatformMessageResponseCallback? callback) {
    // 模拟发送平台消息
  }
  
  @override
  void clearPlatformMessageCache() {
    // 模拟清除平台消息缓存
  }
}

/// Mock Manager - 统一管理所有Mock对象
class MockManager {
  static final Map<Type, Mock> _mocks = {};
  
  /// 注册Mock对象
  static void registerMock<T extends Mock>(T mock) {
    _mocks[T] = mock;
  }
  
  /// 获取Mock对象
  static T getMock<T extends Mock>() {
    return _mocks[T] as T;
  }
  
  /// 重置所有Mock对象
  static void resetAll() {
    for (final mock in _mocks.values) {
      if (mock is MockNavigatorObserver) {
        (mock as MockNavigatorObserver).reset();
      } else if (mock is MockSharedPreferences) {
        (mock as MockSharedPreferences).reset();
      } else if (mock is MockDio) {
        (mock as MockDio).reset();
      } else if (mock is MockMethodChannel) {
        (mock as MockMethodChannel).reset();
      } else if (mock is MockEventChannel) {
        (mock as MockEventChannel).reset();
      } else if (mock is MockAssetBundle) {
        (mock as MockAssetBundle).reset();
      } else {
        reset(mocktail: mock);
      }
    }
  }
  
  /// 初始化常用Mock对象
  static void initializeCommonMocks() {
    registerMock(MockNavigatorObserver());
    registerMock(MockScrollController());
    registerMock(MockTextEditingController());
    registerMock(MockFocusNode());
    registerMock(MockAnimationController());
    registerMock(MockPageController());
    registerMock(MockTabController());
    registerMock(MockSharedPreferences());
    registerMock(MockDio());
    registerMock(MockAssetBundle());
  }
  
  /// 获取所有Mock对象
  static Map<Type, Mock> getAllMocks() => Map.unmodifiable(_mocks);
  
  /// 移除Mock对象
  static void removeMock<T extends Mock>() {
    _mocks.remove(T);
  }
  
  /// 清空所有Mock对象
  static void clear() {
    _mocks.clear();
  }
}