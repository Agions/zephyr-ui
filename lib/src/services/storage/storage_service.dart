/// chromaUI Storage Service
///
/// Comprehensive storage service for data persistence:
/// - In-memory storage with persistence capabilities
/// - Secure storage simulation
/// - Cache management
/// - Data synchronization
/// - Backup and restore
library storage_service;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../core/config/app_config.dart';
import '../../core/config/environment_config.dart';
import '../../core/config/feature_flags.dart';

/// Storage types
enum StorageType {
  local,
  secure,
  cache,
  database,
  cloud,
}

/// Storage event types
enum StorageEventType {
  read,
  write,
  delete,
  clear,
  sync,
  backup,
  restore,
}

/// Storage priority levels
enum StoragePriority {
  low,
  normal,
  high,
  critical,
}

/// Storage event data class
class StorageEvent {
  final StorageEventType type;
  final String key;
  final StorageType storageType;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const StorageEvent({
    required this.type,
    required this.key,
    required this.storageType,
    required this.timestamp,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'key': key,
      'storageType': storageType.name,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }
}

/// Storage configuration
class StorageConfig {
  final bool enableEncryption;
  final Duration cacheTimeout;
  final int maxCacheSize;
  final Duration syncInterval;
  final bool enableCompression;
  final bool enableBackup;

  const StorageConfig({
    this.enableEncryption = true,
    this.cacheTimeout = const Duration(hours: 1),
    this.maxCacheSize = 100 * 1024 * 1024, // 100MB
    this.syncInterval = const Duration(minutes: 5),
    this.enableCompression = true,
    this.enableBackup = true,
  });
}

/// Cache entry wrapper
class CacheEntry {
  final dynamic value;
  final DateTime expiry;

  CacheEntry({
    required this.value,
    required this.expiry,
  });

  bool get isExpired => DateTime.now().isAfter(expiry);

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'expiry': expiry.toIso8601String(),
    };
  }

  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry(
      value: json['value'],
      expiry: DateTime.parse(json['expiry']),
    );
  }
}

/// Storage interface
abstract class StorageService {
  /// Initialize the storage service
  Future<void> initialize();

  /// Store a value
  Future<void> set<T>(String key, T value, {StorageType storageType = StorageType.local, StoragePriority priority = StoragePriority.normal});

  /// Retrieve a value
  Future<T?> get<T>(String key, {StorageType storageType = StorageType.local, T? defaultValue});

  /// Check if a key exists
  Future<bool> containsKey(String key, {StorageType storageType = StorageType.local});

  /// Remove a value
  Future<void> remove(String key, {StorageType storageType = StorageType.local});

  /// Clear all values
  Future<void> clear({StorageType? storageType});

  /// Get all keys
  Future<Set<String>> getKeys({StorageType storageType = StorageType.local});

  /// Store multiple values
  Future<void> setAll(Map<String, dynamic> values, {StorageType storageType = StorageType.local});

  /// Retrieve multiple values
  Future<Map<String, dynamic>> getAll(Set<String> keys, {StorageType storageType = StorageType.local});

  /// Store encrypted value
  Future<void> setSecure(String key, String value);

  /// Retrieve encrypted value
  Future<String?> getSecure(String key);

  /// Cache a value
  Future<void> setCache<T>(String key, T value, {Duration? timeout});

  /// Retrieve cached value
  Future<T?> getCache<T>(String key, {T? defaultValue});

  /// Clear expired cache entries
  Future<void> clearExpiredCache();

  /// Sync data with cloud
  Future<void> sync();

  /// Backup data
  Future<String> backup();

  /// Restore data from backup
  Future<void> restore(String backupData);

  /// Get storage usage statistics
  Future<Map<String, dynamic>> getStorageStats();

  /// Enable/disable storage
  void setEnabled(bool enabled);

  /// Check if storage is enabled
  bool get isEnabled;

  /// Stream of storage events
  Stream<StorageEvent> get events;

  /// Dispose of resources
  Future<void> dispose();
}

/// Default storage service implementation
class DefaultStorageService implements StorageService {
  static DefaultStorageService? _instance;
  static DefaultStorageService get instance => _instance ??= DefaultStorageService._internal();

  DefaultStorageService._internal();

  final StreamController<StorageEvent> _eventController = StreamController.broadcast();

  final Map<String, dynamic> _localStorage = {};
  final Map<String, CacheEntry> _cacheStorage = {};
  final Map<String, String> _secureStorage = {};

  Timer? _syncTimer;

  bool _isEnabled = false;
  bool _isInitialized = false;
  final StorageConfig _config = const StorageConfig();

  @override
  Future<void> initialize() async {
    if (!featureFlags.isEnabled('storage')) {
      if (kDebugMode) {
        debugPrint('Storage service disabled by feature flag');
      }
      return;
    }

    _isEnabled = appConfig.enableAnalytics && environmentConfig.isAnalyticsEnabled;

    if (!_isEnabled) return;

    try {
      // Load persisted data from file (simulated)
      await _loadPersistedData();

      // Start sync timer
      _startSyncTimer();

      _isInitialized = true;

      if (kDebugMode) {
        debugPrint('Storage service initialized');
      }

      // Clear expired cache on startup
      await clearExpiredCache();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to initialize storage service: $e');
      }
      _isEnabled = false;
    }
  }

  Future<void> _loadPersistedData() async {
    // In a real implementation, this would load from SharedPreferences or file storage
    // For now, we'll simulate with empty data
    _localStorage.clear();
    _cacheStorage.clear();
    _secureStorage.clear();
  }

  Future<void> _savePersistedData() async {
    // In a real implementation, this would save to SharedPreferences or file storage
    // For now, we'll just keep in memory
  }

  void _startSyncTimer() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(_config.syncInterval, (_) async {
      await sync();
    });
  }

  @override
  Future<void> set<T>(String key, T value, {StorageType storageType = StorageType.local, StoragePriority priority = StoragePriority.normal}) async {
    if (!_isEnabled || !_isInitialized) return;

    try {
      switch (storageType) {
        case StorageType.local:
          await _setLocal(key, value);
          break;
        case StorageType.cache:
          await setCache(key, value);
          break;
        case StorageType.secure:
          if (value is String) {
            await _setSecure(key, value);
          }
          break;
        default:
          throw UnimplementedError('Storage type $storageType not implemented');
      }

      _emitEvent(StorageEvent(
        type: StorageEventType.write,
        key: key,
        storageType: storageType,
        timestamp: DateTime.now(),
        metadata: {'priority': priority.name},
      ));

      await _savePersistedData();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to set value for key $key: $e');
      }
      rethrow;
    }
  }

  Future<void> _setLocal<T>(String key, T value) async {
    _localStorage[key] = value;
  }

  @override
  Future<T?> get<T>(String key, {StorageType storageType = StorageType.local, T? defaultValue}) async {
    if (!_isEnabled || !_isInitialized) return defaultValue;

    try {
      switch (storageType) {
        case StorageType.local:
          return await _getLocal<T>(key, defaultValue);
        case StorageType.cache:
          return await _getCache<T>(key, defaultValue);
        case StorageType.secure:
          if (T == String) {
            return await _getSecure(key) as T?;
          }
          return defaultValue;
        default:
          throw UnimplementedError('Storage type $storageType not implemented');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to get value for key $key: $e');
      }
      return defaultValue;
    }
  }

  Future<T?> _getLocal<T>(String key, T? defaultValue) async {
    final value = _localStorage[key];
    if (value == null) return defaultValue;
    return value as T?;
  }

  @override
  Future<bool> containsKey(String key, {StorageType storageType = StorageType.local}) async {
    if (!_isEnabled || !_isInitialized) return false;

    try {
      switch (storageType) {
        case StorageType.local:
          return _localStorage.containsKey(key);
        case StorageType.cache:
          return _cacheStorage.containsKey(key);
        case StorageType.secure:
          return _secureStorage.containsKey(key);
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> remove(String key, {StorageType storageType = StorageType.local}) async {
    if (!_isEnabled || !_isInitialized) return;

    try {
      switch (storageType) {
        case StorageType.local:
          _localStorage.remove(key);
          break;
        case StorageType.cache:
          _cacheStorage.remove(key);
          break;
        case StorageType.secure:
          _secureStorage.remove(key);
          break;
        default:
          throw UnimplementedError('Storage type $storageType not implemented');
      }

      _emitEvent(StorageEvent(
        type: StorageEventType.delete,
        key: key,
        storageType: storageType,
        timestamp: DateTime.now(),
      ));

      await _savePersistedData();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to remove key $key: $e');
      }
    }
  }

  @override
  Future<void> clear({StorageType? storageType}) async {
    if (!_isEnabled || !_isInitialized) return;

    try {
      if (storageType == null || storageType == StorageType.local) {
        _localStorage.clear();
      }
      if (storageType == null || storageType == StorageType.cache) {
        _cacheStorage.clear();
      }
      if (storageType == null || storageType == StorageType.secure) {
        _secureStorage.clear();
      }

      _emitEvent(StorageEvent(
        type: StorageEventType.clear,
        key: 'all',
        storageType: storageType ?? StorageType.local,
        timestamp: DateTime.now(),
      ));

      await _savePersistedData();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to clear storage: $e');
      }
    }
  }

  @override
  Future<Set<String>> getKeys({StorageType storageType = StorageType.local}) async {
    if (!_isEnabled || !_isInitialized) return {};

    try {
      switch (storageType) {
        case StorageType.local:
          return _localStorage.keys.toSet();
        case StorageType.cache:
          return _cacheStorage.keys.toSet();
        case StorageType.secure:
          return _secureStorage.keys.toSet();
        default:
          return {};
      }
    } catch (e) {
      return {};
    }
  }

  @override
  Future<void> setAll(Map<String, dynamic> values, {StorageType storageType = StorageType.local}) async {
    for (final entry in values.entries) {
      await set(entry.key, entry.value, storageType: storageType);
    }
  }

  @override
  Future<Map<String, dynamic>> getAll(Set<String> keys, {StorageType storageType = StorageType.local}) async {
    final result = <String, dynamic>{};
    for (final key in keys) {
      final value = await get(key, storageType: storageType);
      if (value != null) {
        result[key] = value;
      }
    }
    return result;
  }

  @override
  Future<void> setSecure(String key, String value) async {
    if (!_isEnabled || !_isInitialized) return;

    await _setSecure(key, value);

    _emitEvent(StorageEvent(
      type: StorageEventType.write,
      key: key,
      storageType: StorageType.secure,
      timestamp: DateTime.now(),
    ));

    await _savePersistedData();
  }

  Future<void> _setSecure(String key, String value) async {
    // Simple base64 encoding for "security" (in real app, use proper encryption)
    final encoded = base64Encode(utf8.encode(value));
    _secureStorage[key] = encoded;
  }

  @override
  Future<String?> getSecure(String key) async {
    if (!_isEnabled || !_isInitialized) return null;

    return await _getSecure(key);
  }

  Future<String?> _getSecure(String key) async {
    final value = _secureStorage[key];
    if (value == null) return null;

    try {
      // Simple base64 decoding for "security" (in real app, use proper encryption)
      final decoded = utf8.decode(base64Decode(value));
      return decoded;
    } catch (e) {
      return value;
    }
  }

  @override
  Future<void> setCache<T>(String key, T value, {Duration? timeout}) async {
    if (!_isEnabled || !_isInitialized) return;

    final cacheEntry = CacheEntry(
      value: value,
      expiry: DateTime.now().add(timeout ?? _config.cacheTimeout),
    );

    _cacheStorage[key] = cacheEntry;

    _emitEvent(StorageEvent(
      type: StorageEventType.write,
      key: key,
      storageType: StorageType.cache,
      timestamp: DateTime.now(),
      metadata: {'timeout': timeout?.inSeconds},
    ));

    await _savePersistedData();
  }

  @override
  Future<T?> getCache<T>(String key, {T? defaultValue}) async {
    if (!_isEnabled || !_isInitialized) return defaultValue;

    return await _getCache<T>(key, defaultValue);
  }

  Future<T?> _getCache<T>(String key, T? defaultValue) async {
    final cacheEntry = _cacheStorage[key];
    if (cacheEntry == null) return defaultValue;

    if (cacheEntry.isExpired) {
      await _cacheStorage.remove(key);
      await _savePersistedData();
      return defaultValue;
    }

    return cacheEntry.value as T?;
  }

  @override
  Future<void> clearExpiredCache() async {
    if (!_isEnabled || !_isInitialized) return;

    final expiredKeys = <String>[];
    for (final entry in _cacheStorage.entries) {
      if (entry.value.isExpired) {
        expiredKeys.add(entry.key);
      }
    }

    for (final key in expiredKeys) {
      await _cacheStorage.remove(key);
    }

    if (expiredKeys.isNotEmpty) {
      await _savePersistedData();
    }
  }

  @override
  Future<void> sync() async {
    if (!_isEnabled || !_isInitialized) return;

    // In a real implementation, this would sync with cloud storage
    _emitEvent(StorageEvent(
      type: StorageEventType.sync,
      key: 'sync',
      storageType: StorageType.cloud,
      timestamp: DateTime.now(),
    ));
  }

  @override
  Future<String> backup() async {
    if (!_isEnabled || !_isInitialized) {
      throw StateError('Storage service not initialized');
    }

    final data = <String, dynamic>{};

    // Backup local storage
    data['local'] = Map<String, dynamic>.from(_localStorage);

    // Backup cache
    final cacheData = <String, dynamic>{};
    for (final entry in _cacheStorage.entries) {
      cacheData[entry.key] = entry.value.toJson();
    }
    data['cache'] = cacheData;

    // Backup secure storage
    data['secure'] = Map<String, dynamic>.from(_secureStorage);

    final backupData = jsonEncode(data);

    _emitEvent(StorageEvent(
      type: StorageEventType.backup,
      key: 'backup',
      storageType: StorageType.local,
      timestamp: DateTime.now(),
    ));

    return backupData;
  }

  @override
  Future<void> restore(String backupData) async {
    if (!_isEnabled || !_isInitialized) {
      throw StateError('Storage service not initialized');
    }

    try {
      final data = jsonDecode(backupData) as Map<String, dynamic>;

      // Clear existing data
      await clear();

      // Restore local storage
      if (data['local'] is Map<String, dynamic>) {
        _localStorage.addAll(data['local'] as Map<String, dynamic>);
      }

      // Restore cache
      if (data['cache'] is Map<String, dynamic>) {
        final cacheData = data['cache'] as Map<String, dynamic>;
        for (final entry in cacheData.entries) {
          if (entry.value is Map<String, dynamic>) {
            _cacheStorage[entry.key] = CacheEntry.fromJson(entry.value as Map<String, dynamic>);
          }
        }
      }

      // Restore secure storage
      if (data['secure'] is Map<String, dynamic>) {
        final secureData = data['secure'] as Map<String, dynamic>;
        for (final entry in secureData.entries) {
          if (entry.value is String) {
            _secureStorage[entry.key] = entry.value as String;
          }
        }
      }

      await _savePersistedData();

      _emitEvent(StorageEvent(
        type: StorageEventType.restore,
        key: 'restore',
        storageType: StorageType.local,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to restore backup: $e');
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getStorageStats() async {
    if (!_isEnabled || !_isInitialized) {
      return {};
    }

    final stats = <String, dynamic>{};

    // Local storage stats
    stats['local_keys'] = _localStorage.length;

    // Cache stats
    stats['cache_keys'] = _cacheStorage.length;

    // Secure storage stats
    stats['secure_keys'] = _secureStorage.length;

    // Calculate cache size (approximate)
    var cacheSize = 0;
    for (final entry in _cacheStorage.entries) {
      cacheSize += jsonEncode(entry.value.toJson()).length;
    }
    stats['cache_size_bytes'] = cacheSize;

    return stats;
  }

  @override
  void setEnabled(bool enabled) {
    _isEnabled = enabled;

    if (enabled) {
      _startSyncTimer();
    } else {
      _syncTimer?.cancel();
    }

    if (kDebugMode) {
      debugPrint('Storage service ${enabled ? 'enabled' : 'disabled'}');
    }
  }

  @override
  bool get isEnabled => _isEnabled;

  @override
  Stream<StorageEvent> get events => _eventController.stream;

  void _emitEvent(StorageEvent event) {
    _eventController.add(event);
  }

  @override
  Future<void> dispose() async {
    _syncTimer?.cancel();
    await _eventController.close();
    _localStorage.clear();
    _cacheStorage.clear();
    _secureStorage.clear();
  }
}

/// Storage utilities
class StorageUtils {
  static final StorageService _service = DefaultStorageService.instance;

  /// Store user preferences
  static Future<void> setUserPreference(String key, dynamic value) async {
    await _service.set('user_$key', value);
  }

  /// Get user preference
  static Future<T?> getUserPreference<T>(String key, {T? defaultValue}) async {
    return await _service.get('user_$key', defaultValue: defaultValue);
  }

  /// Store app state
  static Future<void> setAppState(String key, dynamic value) async {
    await _service.set('state_$key', value);
  }

  /// Get app state
  static Future<T?> getAppState<T>(String key, {T? defaultValue}) async {
    return await _service.get('state_$key', defaultValue: defaultValue);
  }

  /// Cache API response
  static Future<void> cacheApiResponse(String url, dynamic response, {Duration? timeout}) async {
    final cacheKey = 'api_${url.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}';
    await _service.setCache(cacheKey, response, timeout: timeout);
  }

  /// Get cached API response
  static Future<T?> getCachedApiResponse<T>(String url, {T? defaultValue}) async {
    final cacheKey = 'api_${url.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}';
    return await _service.getCache(cacheKey, defaultValue: defaultValue);
  }

  /// Store authentication token
  static Future<void> setAuthToken(String token) async {
    await _service.setSecure('auth_token', token);
  }

  /// Get authentication token
  static Future<String?> getAuthToken() async {
    return await _service.getSecure('auth_token');
  }

  /// Clear authentication data
  static Future<void> clearAuthData() async {
    await _service.remove('auth_token', storageType: StorageType.secure);
    await _service.remove('user_data', storageType: StorageType.secure);
  }

  /// Store user data
  static Future<void> setUserData(Map<String, dynamic> userData) async {
    await _service.setSecure('user_data', jsonEncode(userData));
  }

  /// Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final userDataString = await _service.getSecure('user_data');
    if (userDataString == null) return null;

    try {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Clear all user data
  static Future<void> clearUserData() async {
    await clearAuthData();
    await _service.remove('user_preferences');
    await _service.remove('user_settings');
  }

  /// Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  /// Store app settings
  static Future<void> setAppSettings(Map<String, dynamic> settings) async {
    await _service.set('app_settings', settings);
  }

  /// Get app settings
  static Future<Map<String, dynamic>> getAppSettings() async {
    return await _service.get('app_settings', defaultValue: <String, dynamic>{}) ?? <String, dynamic>{};
  }

  /// Create storage backup
  static Future<String> createBackup() async {
    return await _service.backup();
  }

  /// Restore from backup
  static Future<void> restoreFromBackup(String backupData) async {
    await _service.restore(backupData);
  }
}
