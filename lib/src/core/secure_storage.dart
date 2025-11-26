/// ZephyrUI Secure Storage System
///
/// Provides secure data storage with encryption for sensitive information.

library secure_storage;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/security.dart';

/// Secure Storage Service
class ZephyrSecureStorage {
  factory ZephyrSecureStorage() =>
      _instance ??= ZephyrSecureStorage._internal();

  ZephyrSecureStorage._internal();
  static ZephyrSecureStorage? _instance;

  final Map<String, String> _encryptedStorage = {};
  final Map<String, DateTime> _expiryTimes = {};

  /// Initialize secure storage
  Future<void> initialize() async {
    // In a real app, initialize platform-specific secure storage
    // like flutter_secure_storage for mobile
    await _cleanupExpiredData();
  }

  /// Store encrypted data
  Future<void> store({
    required String key,
    required String value,
    Duration? expiry,
    bool sensitive = true,
  }) async {
    final encryptedValue = sensitive ? await _encrypt(value) : value;

    _encryptedStorage[key] = encryptedValue;

    if (expiry != null) {
      _expiryTimes[key] = DateTime.now().add(expiry);
    }

    // Log storage operation
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: 'system',
      action: 'store_data',
      resource: 'secure_storage',
      details: {
        'key': key,
        'sensitive': sensitive,
        'expiry': expiry?.inSeconds,
      },
    ));
  }

  /// Retrieve and decrypt data
  Future<String?> retrieve(String key) async {
    // Check expiry
    if (_expiryTimes.containsKey(key)) {
      final expiryTime = _expiryTimes[key]!;
      if (DateTime.now().isAfter(expiryTime)) {
        await remove(key);
        return null;
      }
    }

    final encryptedValue = _encryptedStorage[key];
    if (encryptedValue == null) return null;

    // Check if data is encrypted
    if (_isEncrypted(encryptedValue)) {
      return await _decrypt(encryptedValue);
    }

    return encryptedValue;
  }

  /// Remove data from storage
  Future<void> remove(String key) async {
    _encryptedStorage.remove(key);
    _expiryTimes.remove(key);

    // Log removal
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: 'system',
      action: 'remove_data',
      resource: 'secure_storage',
      details: {'key': key},
    ));
  }

  /// Clear all data
  Future<void> clear() async {
    _encryptedStorage.clear();
    _expiryTimes.clear();

    // Log clear operation
    ZephyrAuditLogger.log(AuditLogEntry(
      userId: 'system',
      action: 'clear_data',
      resource: 'secure_storage',
      details: {},
    ));
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _encryptedStorage.containsKey(key);
  }

  /// Get all keys
  List<String> getKeys() {
    return _encryptedStorage.keys.toList();
  }

  /// Store sensitive user data
  Future<void> storeUserData({
    required String userId,
    required Map<String, dynamic> data,
    Duration? expiry,
  }) async {
    final key = 'user_data_$userId';
    final jsonValue = jsonEncode(data);

    await store(
      key: key,
      value: jsonValue,
      expiry: expiry,
      sensitive: true,
    );
  }

  /// Retrieve user data
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final key = 'user_data_$userId';
    final jsonValue = await retrieve(key);

    if (jsonValue == null) return null;

    try {
      return jsonDecode(jsonValue) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Store session data
  Future<void> storeSessionData({
    required String sessionId,
    required Map<String, dynamic> data,
  }) async {
    final key = 'session_$sessionId';
    final jsonValue = jsonEncode(data);

    await store(
      key: key,
      value: jsonValue,
      expiry: ZephyrSecurityConfig().sessionTimeout,
      sensitive: true,
    );
  }

  /// Retrieve session data
  Future<Map<String, dynamic>?> getSessionData(String sessionId) async {
    final key = 'session_$sessionId';
    final jsonValue = await retrieve(key);

    if (jsonValue == null) return null;

    try {
      return jsonDecode(jsonValue) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Cleanup expired data
  Future<void> _cleanupExpiredData() async {
    final now = DateTime.now();
    final expiredKeys = <String>[];

    for (final entry in _expiryTimes.entries) {
      if (now.isAfter(entry.value)) {
        expiredKeys.add(entry.key);
      }
    }

    for (final key in expiredKeys) {
      await remove(key);
    }
  }

  /// Simple encryption (in real app, use proper encryption)
  Future<String> _encrypt(String plaintext) async {
    // This is a simple XOR encryption for demo purposes
    // In a real app, use proper encryption like AES
    const key = 'zephyr-ui-secure-key-2024';
    final bytes = utf8.encode(plaintext);
    final keyBytes = utf8.encode(key);

    final encrypted = List<int>.generate(bytes.length, (i) {
      return bytes[i] ^ keyBytes[i % keyBytes.length];
    });

    return base64Encode(encrypted);
  }

  /// Simple decryption
  Future<String> _decrypt(String ciphertext) async {
    try {
      const key = 'zephyr-ui-secure-key-2024';
      final keyBytes = utf8.encode(key);
      final encrypted = base64Decode(ciphertext);

      final decrypted = List<int>.generate(encrypted.length, (i) {
        return encrypted[i] ^ keyBytes[i % keyBytes.length];
      });

      return utf8.decode(decrypted);
    } catch (e) {
      return ciphertext;
    }
  }

  /// Check if data is encrypted
  bool _isEncrypted(String data) {
    try {
      base64Decode(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Secure Cache Service
class ZephyrSecureCache {
  factory ZephyrSecureCache() => _instance;

  ZephyrSecureCache._internal();
  static final ZephyrSecureCache _instance = ZephyrSecureCache._internal();

  final Map<String, _CacheEntry> _cache = {};
  final int _maxSize = 1000;

  /// Store data in cache
  Future<void> set({
    required String key,
    required dynamic value,
    Duration? expiry,
  }) async {
    // Check cache size
    if (_cache.length >= _maxSize) {
      _evictOldest();
    }

    _cache[key] = _CacheEntry(
      value: value,
      expiry: expiry != null ? DateTime.now().add(expiry) : null,
      createdAt: DateTime.now(),
    );
  }

  /// Retrieve data from cache
  Future<T?> get<T>(String key) async {
    final entry = _cache[key];
    if (entry == null) return null;

    // Check expiry
    if (entry.expiry != null && DateTime.now().isAfter(entry.expiry!)) {
      _cache.remove(key);
      return null;
    }

    return entry.value as T?;
  }

  /// Remove data from cache
  Future<void> remove(String key) async {
    _cache.remove(key);
  }

  /// Clear cache
  Future<void> clear() async {
    _cache.clear();
  }

  /// Check if key exists in cache
  bool containsKey(String key) {
    return _cache.containsKey(key);
  }

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    return {
      'size': _cache.length,
      'max_size': _maxSize,
      'expired_entries': _cache.values
          .where((e) => e.expiry != null && DateTime.now().isAfter(e.expiry!))
          .length,
    };
  }

  /// Evict oldest entry
  void _evictOldest() {
    if (_cache.isEmpty) return;

    final oldestKey = _cache.entries
        .reduce((a, b) => a.value.createdAt.isBefore(b.value.createdAt) ? a : b)
        .key;

    _cache.remove(oldestKey);
  }
}

/// Cache Entry
class _CacheEntry {
  _CacheEntry({
    required this.value,
    required this.expiry,
    required this.createdAt,
  });
  final dynamic value;
  final DateTime? expiry;
  final DateTime createdAt;
}

/// Secure Preferences Service
class ZephyrSecurePreferences {
  factory ZephyrSecurePreferences() => _instance;

  ZephyrSecurePreferences._internal();
  static final ZephyrSecurePreferences _instance =
      ZephyrSecurePreferences._internal();

  final ZephyrSecureStorage _storage = ZephyrSecureStorage();

  /// Store boolean preference
  Future<void> setBool(String key, bool value) async {
    await _storage.store(
      key: 'pref_$key',
      value: value.toString(),
      sensitive: false,
    );
  }

  /// Get boolean preference
  Future<bool?> getBool(String key) async {
    final value = await _storage.retrieve('pref_$key');
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }

  /// Store string preference
  Future<void> setString(String key, String value) async {
    await _storage.store(
      key: 'pref_$key',
      value: value,
      sensitive: false,
    );
  }

  /// Get string preference
  Future<String?> getString(String key) async {
    return await _storage.retrieve('pref_$key');
  }

  /// Store integer preference
  Future<void> setInt(String key, int value) async {
    await _storage.store(
      key: 'pref_$key',
      value: value.toString(),
      sensitive: false,
    );
  }

  /// Get integer preference
  Future<int?> getInt(String key) async {
    final value = await _storage.retrieve('pref_$key');
    if (value == null) return null;
    return int.tryParse(value);
  }

  /// Store double preference
  Future<void> setDouble(String key, double value) async {
    await _storage.store(
      key: 'pref_$key',
      value: value.toString(),
      sensitive: false,
    );
  }

  /// Get double preference
  Future<double?> getDouble(String key) async {
    final value = await _storage.retrieve('pref_$key');
    if (value == null) return null;
    return double.tryParse(value);
  }

  /// Store string list preference
  Future<void> setStringList(String key, List<String> value) async {
    await _storage.store(
      key: 'pref_$key',
      value: jsonEncode(value),
      sensitive: false,
    );
  }

  /// Get string list preference
  Future<List<String>?> getStringList(String key) async {
    final value = await _storage.retrieve('pref_$key');
    if (value == null) return null;

    try {
      final decoded = jsonDecode(value) as List;
      return decoded.map((e) => e.toString()).toList();
    } catch (e) {
      return null;
    }
  }

  /// Remove preference
  Future<void> remove(String key) async {
    await _storage.remove('pref_$key');
  }

  /// Clear all preferences
  Future<void> clear() async {
    final keys = _storage.getKeys();
    for (final key in keys) {
      if (key.startsWith('pref_')) {
        await _storage.remove(key);
      }
    }
  }
}

/// Secure Storage Extensions
extension ZephyrSecureStorageExtensions on BuildContext {
  Future<void> storeSecureData({
    required String key,
    required String value,
    Duration? expiry,
  }) async {
    await ZephyrSecureStorage().store(
      key: key,
      value: value,
      expiry: expiry,
      sensitive: true,
    );
  }

  Future<String?> retrieveSecureData(String key) async {
    return await ZephyrSecureStorage().retrieve(key);
  }

  Future<void> removeSecureData(String key) async {
    await ZephyrSecureStorage().remove(key);
  }

  Future<void> setSecurePreference(String key, dynamic value) async {
    final storage = ZephyrSecureStorage();

    if (value is bool) {
      await storage.store(
          key: 'pref_$key', value: value.toString(), sensitive: false);
    } else if (value is int) {
      await storage.store(
          key: 'pref_$key', value: value.toString(), sensitive: false);
    } else if (value is double) {
      await storage.store(
          key: 'pref_$key', value: value.toString(), sensitive: false);
    } else if (value is List<String>) {
      await storage.store(
          key: 'pref_$key', value: jsonEncode(value), sensitive: false);
    } else {
      await storage.store(
          key: 'pref_$key', value: value.toString(), sensitive: false);
    }
  }

  Future<T?> getSecurePreference<T>(String key) async {
    final storage = ZephyrSecureStorage();
    final value = await storage.retrieve('pref_$key');

    if (value == null) return null;

    switch (T) {
      case bool:
        return value.toLowerCase() == 'true' as T;
      case int:
        return int.tryParse(value) as T?;
      case double:
        return double.tryParse(value) as T?;
      case List<String>:
        try {
          final decoded = jsonDecode(value) as List;
          return decoded.map((e) => e.toString()).toList() as T?;
        } catch (e) {
          return null;
        }
      default:
        return value as T?;
    }
  }
}
