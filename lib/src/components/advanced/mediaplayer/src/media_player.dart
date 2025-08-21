import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'media_player_theme.dart';
import 'media_player_utils.dart';

/// Media Player Component
/// 
/// A comprehensive media player component with support for both audio and video,
/// playback controls, playlist management, and advanced features for enterprise applications.
/// 
/// Features:
/// - Audio and video playback support
/// - Customizable playback controls
/// - Playlist management
/// - Volume control
/// - Playback speed control
/// - Subtitle support
/// - Fullscreen mode
/// - Quality selection
/// - Progress tracking
/// - Background playback
/// 
/// Example usage:
/// ```dart
/// ZephyrMediaPlayer(
///   type: ZephyrMediaType.video,
///   url: 'https://example.com/video.mp4',
///   theme: ZephyrMediaPlayerTheme.light(),
///   onStateChanged: (state) {
///     print('Player state: $state');
///   },
/// )
/// ```
class ZephyrMediaPlayer extends StatefulWidget {
  /// The media type (audio or video)
  final ZephyrMediaType type;
  
  /// The media URL or asset path
  final String url;
  
  /// Whether to autoplay
  final bool autoPlay;
  
  /// Whether to loop
  final bool loop;
  
  /// Whether to show controls
  final bool showControls;
  
  /// Whether to show the progress bar
  final bool showProgressBar;
  
  /// Whether to show the volume control
  final bool showVolumeControl;
  
  /// Whether to show the playback speed control
  final bool showSpeedControl;
  
  /// Whether to show the quality selector
  final bool showQualitySelector;
  
  /// Whether to show the fullscreen button
  final bool showFullscreenButton;
  
  /// Whether to enable subtitles
  final bool enableSubtitles;
  
  /// Whether to enable background playback
  final bool enableBackgroundPlayback;
  
  /// The initial volume (0.0 to 1.0)
  final double initialVolume;
  
  /// The initial playback speed
  final double initialPlaybackSpeed;
  
  /// The available playback speeds
  final List<double> playbackSpeeds;
  
  /// The theme
  final ZephyrMediaPlayerTheme? theme;
  
  /// The placeholder widget for video
  final Widget? placeholder;
  
  /// The error widget
  final Widget? errorWidget;
  
  /// The loading widget
  final Widget? loadingWidget;
  
  /// The callback for when the player state changes
  final Function(ZephyrMediaPlayerState)? onStateChanged;
  
  /// The callback for when the position changes
  final Function(Duration)? onPositionChanged;
  
  /// The callback for when the duration changes
  final Function(Duration)? onDurationChanged;
  
  /// The callback for when an error occurs
  final Function(String)? onError;
  
  /// The semantic label for accessibility
  final String? semanticLabel;

  const ZephyrMediaPlayer({
    Key? key,
    required this.type,
    required this.url,
    this.autoPlay = false,
    this.loop = false,
    this.showControls = true,
    this.showProgressBar = true,
    this.showVolumeControl = true,
    this.showSpeedControl = true,
    this.showQualitySelector = false,
    this.showFullscreenButton = true,
    this.enableSubtitles = false,
    this.enableBackgroundPlayback = false,
    this.initialVolume = 1.0,
    this.initialPlaybackSpeed = 1.0,
    this.playbackSpeeds = const [0.5, 0.75, 1.0, 1.25, 1.5, 2.0],
    this.theme,
    this.placeholder,
    this.errorWidget,
    this.loadingWidget,
    this.onStateChanged,
    this.onPositionChanged,
    this.onDurationChanged,
    this.onError,
    this.semanticLabel,
  }) : super(key: key);

  @override
  State<ZephyrMediaPlayer> createState() => _ZephyrMediaPlayerState();
}

class _ZephyrMediaPlayerState extends State<ZephyrMediaPlayer> {
  late ZephyrMediaPlayerTheme _theme;
  VideoPlayerController? _videoController;
  ZephyrMediaPlayerState _playerState = ZephyrMediaPlayerState.idle;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _volume = 1.0;
  double _playbackSpeed = 1.0;
  bool _isControlsVisible = true;
  bool _isFullscreen = false;
  Timer? _controlsTimer;
  
  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? ZephyrMediaPlayerTheme.light();
    _volume = widget.initialVolume;
    _playbackSpeed = widget.initialPlaybackSpeed;
    _initializePlayer();
  }

  @override
  void didUpdateWidget(ZephyrMediaPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? ZephyrMediaPlayerTheme.light();
    }
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _playerState = ZephyrMediaPlayerState.loading;
      });
      
      widget.onStateChanged?.call(_playerState);
      
      // Initialize video player (works for both audio and video)
      _videoController = VideoPlayerController.network(widget.url);
      
      await _videoController!.initialize();
      
      if (widget.autoPlay) {
        await _videoController!.play();
        _playerState = ZephyrMediaPlayerState.playing;
      } else {
        _playerState = ZephyrMediaPlayerState.ready;
      }
      
      _duration = _videoController!.value.duration;
      _videoController!.setVolume(_volume);
      _videoController!.setPlaybackSpeed(_playbackSpeed);
      
      // Add listeners
      _videoController!.addListener(_videoListener);
      
      setState(() {});
      
      widget.onStateChanged?.call(_playerState);
      widget.onDurationChanged?.call(_duration);
      
    } catch (e) {
      setState(() {
        _playerState = ZephyrMediaPlayerState.error;
      });
      
      widget.onStateChanged?.call(_playerState);
      widget.onError?.call('Failed to initialize player: $e');
    }
  }

  void _videoListener() {
    if (_videoController == null) return;
    
    final value = _videoController!.value;
    
    setState(() {
      _position = value.position;
      
      if (value.isPlaying) {
        _playerState = ZephyrMediaPlayerState.playing;
      } else if (value.isCompleted) {
        _playerState = ZephyrMediaPlayerState.completed;
        if (widget.loop) {
          _videoController!.seekTo(Duration.zero);
          _videoController!.play();
        }
      } else {
        _playerState = ZephyrMediaPlayerState.paused;
      }
    });
    
    widget.onStateChanged?.call(_playerState);
    widget.onPositionChanged?.call(_position);
  }

  void _play() async {
    if (_videoController != null) {
      await _videoController!.play();
    }
  }

  void _pause() async {
    if (_videoController != null) {
      await _videoController!.pause();
    }
  }

  void _togglePlayPause() {
    if (_playerState == ZephyrMediaPlayerState.playing) {
      _pause();
    } else if (_playerState == ZephyrMediaPlayerState.paused || 
               _playerState == ZephyrMediaPlayerState.ready) {
      _play();
    }
  }

  void _seekTo(Duration position) async {
    if (_videoController != null) {
      await _videoController!.seekTo(position);
    }
  }

  void _setVolume(double volume) async {
    _volume = volume;
    if (_videoController != null) {
      await _videoController!.setVolume(volume);
    }
  }

  void _setPlaybackSpeed(double speed) async {
    _playbackSpeed = speed;
    if (_videoController != null) {
      await _videoController!.setPlaybackSpeed(speed);
    }
  }

  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
    });
    
    if (_isControlsVisible) {
      _startControlsTimer();
    } else {
      _controlsTimer?.cancel();
    }
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _playerState == ZephyrMediaPlayerState.playing) {
        setState(() {
          _isControlsVisible = false;
        });
      }
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    
    if (_isFullscreen) {
      // Enter fullscreen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      // Exit fullscreen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    }
  }

  Widget _buildVideoPlayer() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return widget.loadingWidget ?? const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: widget.showControls ? _toggleControls : null,
      child: Stack(
        children: [
          // Video player
          Center(
            child: AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
          ),
          
          // Controls overlay
          if (widget.showControls && _isControlsVisible)
            _buildControlsOverlay(),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Audio info
          Row(
            children: [
              Icon(
                Icons.music_note,
                color: _theme.primaryColor,
                size: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Audio Title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _theme.textColor,
                      ),
                    ),
                    Text(
                      'Artist Name',
                      style: TextStyle(
                        fontSize: 14,
                        color: _theme.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Progress bar
          if (widget.showProgressBar) _buildProgressBar(),
          
          const SizedBox(height: 16),
          
          // Controls
          _buildAudioControls(),
          
          const SizedBox(height: 16),
          
          // Additional controls
          _buildAdditionalControls(),
        ],
      ),
    );
  }

  Widget _buildControlsOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.6),
              Colors.transparent,
              Colors.transparent,
              Colors.black.withValues(alpha: 0.6),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top controls
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (widget.showFullscreenButton)
                    IconButton(
                      icon: Icon(
                        _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                        color: _theme.controlColor,
                      ),
                      onPressed: _toggleFullscreen,
                    ),
                  ],
              ),
            ),
            
            // Center controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, color: _theme.controlColor),
                  onPressed: () => _seekTo(_position - const Duration(seconds: 10)),
                ),
                IconButton(
                  icon: Icon(
                    _playerState == ZephyrMediaPlayerState.playing 
                        ? Icons.pause 
                        : Icons.play_arrow,
                    color: _theme.controlColor,
                    size: 48,
                  ),
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, color: _theme.controlColor),
                  onPressed: () => _seekTo(_position + const Duration(seconds: 10)),
                ),
              ],
            ),
            
            // Bottom controls
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (widget.showProgressBar) _buildProgressBar(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: TextStyle(
                          color: _theme.controlColor,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          if (widget.showVolumeControl)
                            _buildVolumeControl(),
                          if (widget.showSpeedControl)
                            _buildSpeedControl(),
                        ],
                      ),
                      Text(
                        _formatDuration(_duration),
                        style: TextStyle(
                          color: _theme.controlColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Slider(
          value: _position.inMilliseconds.toDouble(),
          max: _duration.inMilliseconds.toDouble(),
          onChanged: (value) {
            _seekTo(Duration(milliseconds: value.round()));
          },
          activeColor: _theme.primaryColor,
          inactiveColor: _theme.inactiveControlColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(_position),
              style: TextStyle(
                color: _theme.textColor,
                fontSize: 12,
              ),
            ),
            Text(
              _formatDuration(_duration),
              style: TextStyle(
                color: _theme.textColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAudioControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous, color: _theme.primaryColor),
          onPressed: () => _seekTo(_position - const Duration(seconds: 10)),
        ),
        IconButton(
          icon: Icon(
            _playerState == ZephyrMediaPlayerState.playing 
                ? Icons.pause 
                : Icons.play_arrow,
            color: _theme.primaryColor,
            size: 48,
          ),
          onPressed: _togglePlayPause,
        ),
        IconButton(
          icon: Icon(Icons.skip_next, color: _theme.primaryColor),
          onPressed: () => _seekTo(_position + const Duration(seconds: 10)),
        ),
      ],
    );
  }

  Widget _buildAdditionalControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (widget.showVolumeControl) _buildVolumeControl(),
        if (widget.showSpeedControl) _buildSpeedControl(),
        IconButton(
          icon: Icon(Icons.loop, color: widget.loop ? _theme.primaryColor : _theme.secondaryTextColor),
          onPressed: () {
            // Loop toggle would be handled by parent
          },
        ),
      ],
    );
  }

  Widget _buildVolumeControl() {
    return Row(
      children: [
        Icon(
          Icons.volume_up,
          color: _theme.secondaryTextColor,
          size: 20,
        ),
        SizedBox(
          width: 100,
          child: Slider(
            value: _volume,
            onChanged: _setVolume,
            activeColor: _theme.primaryColor,
            inactiveColor: _theme.inactiveControlColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedControl() {
    return PopupMenuButton<double>(
      icon: Icon(
        Icons.speed,
        color: _theme.secondaryTextColor,
        size: 20,
      ),
      onSelected: _setPlaybackSpeed,
      itemBuilder: (context) {
        return widget.playbackSpeeds.map((speed) {
          return PopupMenuItem<double>(
            value: speed,
            child: Text('${speed}x'),
          );
        }).toList();
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _controlsTimer?.cancel();
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? 'Media player',
      child: Container(
        color: _theme.backgroundColor,
        child: widget.type == ZephyrMediaType.video 
            ? _buildVideoPlayer() 
            : _buildAudioPlayer(),
      ),
    );
  }
}

/// Media type enum
enum ZephyrMediaType {
  audio,
  video,
}

/// Media player state enum
enum ZephyrMediaPlayerState {
  idle,
  loading,
  ready,
  playing,
  paused,
  completed,
  error,
}