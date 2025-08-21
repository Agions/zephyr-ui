import 'package:flutter/material.dart';

/// ZephyrUI QR Code Utilities
/// 
/// Provides utility functions for QR code generation,
/// validation, and formatting.
class ZephyrQRCodeUtils {
  /// Validates QR code data
  static bool validateQRCodeData(String data) {
    if (data.isEmpty) return false;
    
    // Basic validation - max length for QR codes
    if (data.length > 4296) return false;
    
    // URL validation if it's a URL
    if (data.startsWith('http://') || data.startsWith('https://')) {
      return Uri.tryParse(data) != null;
    }
    
    return true;
  }

  /// Estimates QR code version based on data length and error correction
  static int estimateQRCodeVersion(String data, ZephyrQRErrorCorrectionLevel errorCorrectionLevel) {
    final length = data.length;
    
    // Simplified estimation based on data length
    if (length <= 25) return 1;
    if (length <= 47) return 2;
    if (length <= 77) return 3;
    if (length <= 114) return 4;
    if (length <= 154) return 5;
    if (length <= 195) return 6;
    if (length <= 244) return 7;
    if (length <= 293) return 8;
    if (length <= 346) return 9;
    if (length <= 404) return 10;
    
    return 40; // Maximum version
  }

  /// Formats data for QR code encoding
  static String formatQRCodeData(String data) {
    // Remove extra whitespace
    data = data.trim();
    
    // Normalize line endings
    data = data.replaceAll('\r\n', '\n');
    
    return data;
  }

  /// Gets QR code error correction capacity percentage
  static double getErrorCorrectionCapacity(ZephyrQRErrorCorrectionLevel level) {
    switch (level) {
      case ZephyrQRErrorCorrectionLevel.low:
        return 0.07; // 7%
      case ZephyrQRErrorCorrectionLevel.medium:
        return 0.15; // 15%
      case ZephyrQRErrorCorrectionLevel.quartile:
        return 0.25; // 25%
      case ZephyrQRErrorCorrectionLevel.high:
        return 0.30; // 30%
    }
  }

  /// Suggests error correction level based on use case
  static ZephyrQRErrorCorrectionLevel suggestErrorCorrectionLevel({
    bool indoorEnvironment = true,
    bool smallSize = false,
    bool highDensity = false,
    bool criticalData = false,
  }) {
    if (criticalData) {
      return ZephyrQRErrorCorrectionLevel.high;
    }
    
    if (highDensity || smallSize) {
      return ZephyrQRErrorCorrectionLevel.quartile;
    }
    
    if (indoorEnvironment) {
      return ZephyrQRErrorCorrectionLevel.medium;
    }
    
    return ZephyrQRErrorCorrectionLevel.low;
  }

  /// Calculates optimal QR code size based on version and modules
  static double calculateOptimalSize(int version, {double moduleSize = 4.0}) {
    // Each version adds 4 modules, starting from 21x21 for version 1
    final modules = 21 + (version - 1) * 4;
    return modules * moduleSize;
  }

  /// Validates logo size for QR code
  static bool validateLogoSize(double qrSize, double logoSize) {
    // Logo should not exceed 30% of QR code size
    return logoSize <= qrSize * 0.3;
  }

  /// Generates QR code data for different content types
  static String generateQRCodeData({
    String? text,
    String? url,
    String? email,
    String? phone,
    String? wifiSsid,
    String? wifiPassword,
    ZephyrQRCodeWifiEncryptionType wifiEncryption = ZephyrQRCodeWifiEncryptionType.wpa,
    Map<String, String>? vCardData,
  }) {
    if (url != null) {
      return url.startsWith('http') ? url : 'https://$url';
    }
    
    if (email != null) {
      return 'mailto:$email';
    }
    
    if (phone != null) {
      return 'tel:$phone';
    }
    
    if (wifiSsid != null) {
      final encryption = wifiEncryption == ZephyrQRCodeWifiEncryptionType.open 
          ? 'nopass' 
          : wifiEncryption.name.toUpperCase();
      return 'WIFI:T:$encryption;S:$wifiSsid;P:${wifiPassword ?? ''};;';
    }
    
    if (vCardData != null) {
      return _generateVCard(vCardData);
    }
    
    return text ?? '';
  }

  /// Generates vCard data
  static String _generateVCard(Map<String, String> data) {
    final buffer = StringBuffer();
    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:3.0');
    
    if (data['fn'] != null) buffer.writeln('FN:${data['fn']}');
    if (data['n'] != null) buffer.writeln('N:${data['n']}');
    if (data['tel'] != null) buffer.writeln('TEL:${data['tel']}');
    if (data['email'] != null) buffer.writeln('EMAIL:${data['email']}');
    if (data['org'] != null) buffer.writeln('ORG:${data['org']}');
    if (data['title'] != null) buffer.writeln('TITLE:${data['title']}');
    if (data['url'] != null) buffer.writeln('URL:${data['url']}');
    if (data['adr'] != null) buffer.writeln('ADR:${data['adr']}');
    
    buffer.writeln('END:VCARD');
    return buffer.toString();
  }

  /// Estimates scanning distance based on QR code size
  static double estimateScanningDistance(double qrSize) {
    // Rule of thumb: scanning distance ≈ 10x QR code size
    return qrSize * 10;
  }
}

/// QR Code error correction levels
enum ZephyrQRErrorCorrectionLevel {
  low,
  medium,
  quartile,
  high,
}

/// QR Code WiFi encryption types
enum ZephyrQRCodeWifiEncryptionType {
  open,
  wep,
  wpa,
}