import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';

/// ZephyrUI Media Player Utilities
/// 
/// Provides utility functions for media processing,
/// validation, and playback management.
class ZephyrMediaPlayerUtils {
  /// Validates media URL
  static bool isValidMediaUrl(String url) {
    if (url.isEmpty) return false;
    
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// Validates media file
  static bool isValidMediaFile(String path) {
    if (!File(path).existsSync()) return false;
    
    final extension = path.toLowerCase().split('.').last;
    final videoExtensions = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv'];
    final audioExtensions = ['mp3', 'wav', 'aac', 'flac', 'ogg', 'm4a'];
    
    return videoExtensions.contains(extension) || audioExtensions.contains(extension);
  }

  /// Gets media type from URL or file path
  static ZephyrMediaType getMediaType(String source) {
    final extension = source.toLowerCase().split('.').last;
    final videoExtensions = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv'];
    
    return videoExtensions.contains(extension) ? ZephyrMediaType.video : ZephyrMediaType.audio;
  }

  /// Gets media file size
  static int getFileSize(String path) {
    try {
      final file = File(path);
      return file.lengthSync();
    } catch (e) {
      return 0;
    }
  }

  /// Formats file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Formats duration
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }

  /// Formats duration in seconds
  static String formatDurationSeconds(int seconds) {
    return formatDuration(Duration(seconds: seconds));
  }

  /// Estimates bitrate from file size and duration
  static double estimateBitrate(int fileSizeBytes, Duration duration) {
    if (duration.inSeconds == 0) return 0;
    final fileSizeBits = fileSizeBytes * 8;
    return fileSizeBits / duration.inSeconds;
  }

  /// Formats bitrate
  static String formatBitrate(double bitrate) {
    if (bitrate < 1000) return '${bitrate.toStringAsFixed(0)} bps';
    if (bitrate < 1000000) return '${(bitrate / 1000).toStringAsFixed(1)} kbps';
    return '${(bitrate / 1000000).toStringAsFixed(1)} Mbps';
  }

  /// Gets supported video formats
  static List<String> getSupportedVideoFormats() {
    return ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mkv'];
  }

  /// Gets supported audio formats
  static List<String> getSupportedAudioFormats() {
    return ['mp3', 'wav', 'aac', 'flac', 'ogg', 'm4a'];
  }

  /// Generates thumbnail from video
  static Future<Uint8List?> generateVideoThumbnail(String videoPath, {Duration? position}) async {
    // Mock implementation - in real implementation, this would:
    // 1. Use video processing library to extract frame
    // 2. Convert to image bytes
    // 3. Return thumbnail data
    
    return null;
  }

  /// Extracts audio metadata
  static Future<Map<String, dynamic>> getAudioMetadata(String audioPath) async {
    // Mock implementation - in real implementation, this would:
    // 1. Parse audio file headers
    // 2. Extract metadata (title, artist, album, etc.)
    // 3. Return metadata dictionary
    
    return {
      'title': 'Unknown Title',
      'artist': 'Unknown Artist',
      'album': 'Unknown Album',
      'duration': Duration.zero,
      'bitrate': 0,
      'sampleRate': 44100,
      'channels': 2,
    };
  }

  /// Extracts video metadata
  static Future<Map<String, dynamic>> getVideoMetadata(String videoPath) async {
    // Mock implementation - in real implementation, this would:
    // 1. Parse video file headers
    // 2. Extract metadata (resolution, duration, codec, etc.)
    // 3. Return metadata dictionary
    
    return {
      'width': 1920,
      'height': 1080,
      'duration': Duration.zero,
      'bitrate': 0,
      'frameRate': 30,
      'codec': 'h264',
      'audioCodec': 'aac',
    };
  }

  /// Converts audio format
  static Future<bool> convertAudio(
    String inputPath,
    String outputPath,
    String outputFormat, {
    int bitrate = 128,
    int sampleRate = 44100,
  }) async {
    // Mock implementation - in real implementation, this would:
    // 1. Use audio processing library
    // 2. Convert to specified format
    // 3. Write output file
    
    return false;
  }

  /// Converts video format
  static Future<bool> convertVideo(
    String inputPath,
    String outputPath,
    String outputFormat, {
    int? width,
    int? height,
    int bitrate = 1000,
    String codec = 'h264',
  }) async {
    // Mock implementation - in real implementation, this would:
    // 1. Use video processing library
    // 2. Convert to specified format
    // 3. Apply resolution and bitrate settings
    // 4. Write output file
    
    return false;
  }

  /// Extracts audio from video
  static Future<bool> extractAudio(
    String videoPath,
    String audioPath, {
    String format = 'mp3',
    int bitrate = 128,
  }) async {
    // Mock implementation - in real implementation, this would:
    // 1. Use video processing library
    // 2. Extract audio track
    // 3. Convert to specified format
    // 4. Write audio file
    
    return false;
  }

  /// Trims media file
  static Future<bool> trimMedia(
    String inputPath,
    String outputPath,
    Duration startTime,
    Duration endTime,
  ) async {
    // Mock implementation - in real implementation, this would:
    // 1. Use media processing library
    // 2. Extract specified time range
    // 3. Write trimmed file
    
    return false;
  }

  /// Merges multiple media files
  static Future<bool> mergeMedia(
    List<String> inputPaths,
    String outputPath,
  ) async {
    // Mock implementation - in real implementation, this would:
    // 1. Use media processing library
    // 2. Concatenate files
    // 3. Write merged file
    
    return false;
  }

  /// Adds audio to video
  static Future<bool> addAudioToVideo(
    String videoPath,
    String audioPath,
    String outputPath,
  ) async {
    // Mock implementation - in real implementation, this would:
    // 1. Use video processing library
    // 2. Replace or add audio track
    // 3. Write output file
    
    return false;
  }

  /// Creates playlist from directory
  static List<String> createPlaylistFromDirectory(String directoryPath) {
    try {
      final directory = Directory(directoryPath);
      if (!directory.existsSync()) return [];
      
      final files = directory.listSync();
      final mediaFiles = <String>[];
      
      for (final file in files) {
        if (file is File) {
          final path = file.path;
          if (isValidMediaFile(path)) {
            mediaFiles.add(path);
          }
        }
      }
      
      return mediaFiles;
    } catch (e) {
      return [];
    }
  }

  /// Shuffles playlist
  static List<String> shufflePlaylist(List<String> playlist) {
    final shuffled = List<String>.from(playlist);
    shuffled.shuffle();
    return shuffled;
  }

  /// Validates volume level
  static bool validateVolume(double volume) {
    return volume >= 0.0 && volume <= 1.0;
  }

  /// Validates playback speed
  static bool validatePlaybackSpeed(double speed) {
    return speed > 0.0 && speed <= 10.0;
  }

  /// Suggests optimal volume based on content type
  static double suggestOptimalVolume(ZephyrMediaType mediaType) {
    switch (mediaType) {
      case ZephyrMediaType.audio:
        return 0.8; // 80% for music
      case ZephyrMediaType.video:
        return 0.6; // 60% for videos (often have dialogue)
    }
  }

  /// Calculates remaining time
  static Duration calculateRemainingTime(Duration position, Duration duration) {
    if (position >= duration) return Duration.zero;
    return duration - position;
  }

  /// Calculates progress percentage
  static double calculateProgressPercentage(Duration position, Duration duration) {
    if (duration.inSeconds == 0) return 0.0;
    return position.inSeconds / duration.inSeconds;
  }

  /// Gets media quality options
  static List<Map<String, dynamic>> getQualityOptions() {
    return [
      {'label': '240p', 'value': '240p', 'bitrate': 400},
      {'label': '360p', 'value': '360p', 'bitrate': 800},
      {'label': '480p', 'value': '480p', 'bitrate': 1200},
      {'label': '720p', 'value': '720p', 'bitrate': 2500},
      {'label': '1080p', 'value': '1080p', 'bitrate': 5000},
      {'label': '4K', 'value': '4K', 'bitrate': 15000},
    ];
  }

  /// Suggests quality based on network speed
  static String suggestQuality(double networkSpeedMbps) {
    if (networkSpeedMbps < 1) return '240p';
    if (networkSpeedMbps < 2) return '360p';
    if (networkSpeedMbps < 4) return '480p';
    if (networkSpeedMbps < 8) return '720p';
    if (networkSpeedMbps < 20) return '1080p';
    return '4K';
  }

  /// Estimates bandwidth usage
  static double estimateBandwidthUsage(Duration duration, double bitrateKbps) {
    final durationSeconds = duration.inSeconds;
    return (durationSeconds * bitrateKbps) / 8000; // Convert to MB
  }

  /// Gets audio visualization data
  static List<double> getAudioVisualizationData(String audioPath) {
    // Mock implementation - in real implementation, this would:
    // 1. Parse audio file
    // 2. Extract waveform data
    // 3. Return visualization data
    
    // Generate mock waveform data
    return List.generate(100, (index) {
      return math.sin(index * 0.1) * 0.5 + 0.5;
    });
  }

  /// Creates media streaming URL
  static String createStreamingUrl(String baseUrl, String mediaId, String quality) {
    return '$baseUrl/stream/$mediaId/$quality/manifest.m3u8';
  }

  /// Validates streaming URL
  static bool validateStreamingUrl(String url) {
    return url.contains('.m3u8') || url.contains('.mpd');
  }

  /// Gets adaptive streaming qualities
  static List<Map<String, dynamic>> getAdaptiveQualities() {
    return [
      {'label': 'Auto', 'value': 'auto', 'bandwidth': 0},
      {'label': 'Low', 'value': 'low', 'bandwidth': 500},
      {'label': 'Medium', 'value': 'medium', 'bandwidth': 1500},
      {'label': 'High', 'value': 'high', 'bandwidth': 3000},
    ];
  }
}

/// Media type enum
enum ZephyrMediaType {
  audio,
  video,
}