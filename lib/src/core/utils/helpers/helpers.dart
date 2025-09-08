/// chromaUI Helper Utilities
///
/// Collection of helper functions for common operations:
/// - String manipulation
/// - Date/time formatting
/// - Number formatting
/// - Validation helpers
/// - Conversion utilities
library helpers;

import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// String helpers
class StringHelpers {
  /// Capitalize first letter of string
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Convert to title case
  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map(capitalize).join(' ');
  }

  /// Truncate string with ellipsis
  static String truncate(String text, {int maxLength = 50, String ellipsis = '...'}) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  /// Remove special characters
  static String removeSpecialChars(String text) {
    return text.replaceAll(RegExp(r'[^\w\s]'), '');
  }

  /// Convert to slug
  static String toSlug(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s+'), '-');
  }

  /// Extract numbers from string
  static String extractNumbers(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Check if string is email
  static bool isEmail(String text) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text);
  }

  /// Check if string is phone number
  static bool isPhoneNumber(String text) {
    return RegExp(r'^[\+]?[1-9][\d]{0,15}$').hasMatch(text);
  }

  /// Check if string is URL
  static bool isUrl(String text) {
    return RegExp(r'^https?://([\w\d\-]+\.)+[\w\d\-]+(/[\w\d\-\.~!@#\$%^&*+():_/=?]*)?$').hasMatch(text);
  }

  /// Generate random string
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = math.Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// Mask sensitive data
  static String maskSensitive(String text, {int visibleChars = 4, String maskChar = '*'}) {
    if (text.length <= visibleChars) return maskChar * text.length;
    final visible = text.substring(text.length - visibleChars);
    return maskChar * (text.length - visibleChars) + visible;
  }

  /// Count words in string
  static int countWords(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  /// Reverse string
  static String reverse(String text) {
    return text.split('').reversed.join('');
  }

  /// Remove whitespace
  static String removeWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), '');
  }

  /// Normalize whitespace
  static String normalizeWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}

/// Date/time helpers
class DateTimeHelpers {
  /// Format date to readable string
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  /// Format time to readable string
  static String formatTime(DateTime time, {String format = 'HH:mm'}) {
    return DateFormat(format).format(time);
  }

  /// Format date and time to readable string
  static String formatDateTime(DateTime dateTime, {String format = 'yyyy-MM-dd HH:mm'}) {
    return DateFormat(format).format(dateTime);
  }

  /// Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years years ago';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
           date.month == yesterday.month &&
           date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
           date.month == tomorrow.month &&
           date.day == tomorrow.day;
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of week
  static DateTime startOfWeek(DateTime date) {
    final daysToSubtract = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: daysToSubtract));
  }

  /// Get end of week
  static DateTime endOfWeek(DateTime date) {
    final daysToAdd = DateTime.sunday - date.weekday;
    return date.add(Duration(days: daysToAdd));
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Add business days
  static DateTime addBusinessDays(DateTime date, int days) {
    var result = date;
    var remainingDays = days.abs();

    while (remainingDays > 0) {
      result = result.add(days > 0 ? const Duration(days: 1) : const Duration(days: -1));
      if (result.weekday != DateTime.saturday && result.weekday != DateTime.sunday) {
        remainingDays--;
      }
    }

    return result;
  }

  /// Parse date from string
  static DateTime? parseDate(String dateString, {String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Get age from birth date
  static int getAge(DateTime birthDate) {
    final now = DateTime.now();
    var age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}

/// Number helpers
class NumberHelpers {
  /// Format number with commas
  static String formatNumber(num number, {int decimalDigits = 0}) {
    return NumberFormat('#,##0${decimalDigits > 0 ? '.' + '0' * decimalDigits : ''}').format(number);
  }

  /// Format currency
  static String formatCurrency(num number, {String symbol = '\$', int decimalDigits = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(number);
  }

  /// Format percentage
  static String formatPercentage(num number, {int decimalDigits = 1}) {
    return '${(number * 100).toStringAsFixed(decimalDigits)}%';
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    if (bytes == 0) return '0 B';

    var size = bytes.toDouble();
    var unitIndex = 0;

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(unitIndex == 0 ? 0 : 1)} ${units[unitIndex]}';
  }

  /// Parse number from string
  static num? parseNumber(String text) {
    try {
      return NumberFormat().parse(text);
    } catch (e) {
      return null;
    }
  }

  /// Round to decimal places
  static double roundTo(double number, int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces);
    return (number * factor).round() / factor;
  }

  /// Check if number is between min and max
  static bool isBetween(num number, num min, num max) {
    return number >= min && number <= max;
  }

  /// Clamp number between min and max
  static num clamp(num number, num min, num max) {
    return number < min ? min : (number > max ? max : number);
  }

  /// Generate random number in range
  static int randomInt(int min, int max) {
    return min + math.Random().nextInt(max - min + 1);
  }

  /// Generate random double in range
  static double randomDouble(double min, double max) {
    return min + math.Random().nextDouble() * (max - min);
  }

  /// Check if number is even
  static bool isEven(int number) {
    return number % 2 == 0;
  }

  /// Check if number is odd
  static bool isOdd(int number) {
    return number % 2 != 0;
  }

  /// Get greatest common divisor
  static int gcd(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  /// Get least common multiple
  static int lcm(int a, int b) {
    return (a * b).abs() ~/ gcd(a, b);
  }
}

/// Validation helpers
class ValidationHelpers {
  /// Validate required field
  static String? validateRequired(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Validate email
  static String? validateEmail(String? value, {String message = 'Please enter a valid email'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!StringHelpers.isEmail(value)) {
      return message;
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value, {String message = 'Password must be at least 8 characters'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return message;
    }
    return null;
  }

  /// Validate phone number
  static String? validatePhone(String? value, {String message = 'Please enter a valid phone number'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (!StringHelpers.isPhoneNumber(value)) {
      return message;
    }
    return null;
  }

  /// Validate URL
  static String? validateUrl(String? value, {String message = 'Please enter a valid URL'}) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }
    if (!StringHelpers.isUrl(value)) {
      return message;
    }
    return null;
  }

  /// Validate minimum length
  static String? validateMinLength(String? value, int minLength, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.length < minLength) {
      return message ?? 'Minimum length is $minLength characters';
    }
    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(String? value, int maxLength, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.length > maxLength) {
      return message ?? 'Maximum length is $maxLength characters';
    }
    return null;
  }

  /// Validate number range
  static String? validateNumberRange(num? value, num min, num max, {String? message}) {
    if (value == null) {
      return 'This field is required';
    }
    if (!NumberHelpers.isBetween(value, min, max)) {
      return message ?? 'Value must be between $min and $max';
    }
    return null;
  }

  /// Validate date is not in future
  static String? validateDateNotInFuture(DateTime? value, {String message = 'Date cannot be in the future'}) {
    if (value == null) {
      return 'Date is required';
    }
    if (value.isAfter(DateTime.now())) {
      return message;
    }
    return null;
  }

  /// Validate date is not in past
  static String? validateDateNotInPast(DateTime? value, {String message = 'Date cannot be in the past'}) {
    if (value == null) {
      return 'Date is required';
    }
    if (value.isBefore(DateTime.now())) {
      return message;
    }
    return null;
  }
}

/// Conversion helpers
class ConversionHelpers {
  /// Convert bytes to megabytes
  static double bytesToMB(int bytes) {
    return bytes / (1024 * 1024);
  }

  /// Convert megabytes to bytes
  static int mbToBytes(double mb) {
    return (mb * 1024 * 1024).round();
  }

  /// Convert Celsius to Fahrenheit
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9/5) + 32;
  }

  /// Convert Fahrenheit to Celsius
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5/9;
  }

  /// Convert kilometers to miles
  static double kilometersToMiles(double kilometers) {
    return kilometers * 0.621371;
  }

  /// Convert miles to kilometers
  static double milesToKilometers(double miles) {
    return miles * 1.60934;
  }

  /// Convert kilograms to pounds
  static double kilogramsToPounds(double kilograms) {
    return kilograms * 2.20462;
  }

  /// Convert pounds to kilograms
  static double poundsToKilograms(double pounds) {
    return pounds * 0.453592;
  }

  /// Convert meters to feet
  static double metersToFeet(double meters) {
    return meters * 3.28084;
  }

  /// Convert feet to meters
  static double feetToMeters(double feet) {
    return feet * 0.3048;
  }

  /// Convert seconds to duration string
  static String secondsToDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m ${remainingSeconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${remainingSeconds}s';
    } else {
      return '${remainingSeconds}s';
    }
  }

  /// Convert duration string to seconds
  static int? durationToSeconds(String duration) {
    final regex = RegExp(r'(?:(\d+)h)?(?:(\d+)m)?(?:(\d+)s)?');
    final match = regex.firstMatch(duration);

    if (match == null) return null;

    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
    final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;

    return hours * 3600 + minutes * 60 + seconds;
  }
}

/// Math helpers
class MathHelpers {
  /// Calculate percentage
  static double percentage(num value, num total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }

  /// Calculate percentage change
  static double percentageChange(num oldValue, num newValue) {
    if (oldValue == 0) return 0;
    return ((newValue - oldValue) / oldValue) * 100;
  }

  /// Calculate average
  static double average(List<num> values) {
    if (values.isEmpty) return 0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  /// Calculate median
  static double median(List<num> values) {
    if (values.isEmpty) return 0;

    final sorted = List<num>.from(values)..sort();
    final middle = sorted.length ~/ 2;

    if (sorted.length.isOdd) {
      return sorted[middle].toDouble();
    } else {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    }
  }

  /// Calculate standard deviation
  static double standardDeviation(List<num> values) {
    if (values.isEmpty) return 0;

    final avg = average(values);
    final variance = values.map((x) => math.pow(x - avg, 2)).reduce((a, b) => a + b) / values.length;
    return math.sqrt(variance);
  }

  /// Calculate factorial
  static int factorial(int n) {
    if (n < 0) return 0;
    if (n == 0) return 1;
    return n * factorial(n - 1);
  }

  /// Calculate Fibonacci number
  static int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  /// Check if number is prime
  static bool isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;

    for (var i = 5; i * i <= n; i += 6) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
    }

    return true;
  }
}
