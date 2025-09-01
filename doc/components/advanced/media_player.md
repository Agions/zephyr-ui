# ZephyrMediaPlayer

媒体播放器组件，支持音频和视频播放。

## 基本用法

```dart
ZephyrMediaPlayer(
  source: 'https://example.com/video.mp4',
  type: ZephyrMediaType.video,
  autoPlay: false,
  controls: true,
)
```

## 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| source | String | required | 媒体源地址 |
| type | ZephyrMediaType | video | 媒体类型 |
| autoPlay | bool | false | 是否自动播放 |
| controls | bool | true | 是否显示控制条 |
| loop | bool | false | 是否循环播放 |
| muted | bool | false | 是否静音 |
| thumbnail | String? | null | 缩略图地址 |
| onStateChanged | Function(ZephyrMediaPlayerState)? | null | 状态变化回调 |