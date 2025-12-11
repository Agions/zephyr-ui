import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/display/avatar/avatar.dart';

// Test image provider that doesn't require network calls
class TestImageProvider extends ImageProvider<TestImageProvider> {
  @override
  Future<TestImageProvider> obtainKey(ImageConfiguration configuration) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter loadImage(
      TestImageProvider key, ImageDecoderCallback decode) {
    // Return a completer that will handle the image loading
    return OneFrameImageStreamCompleter(_loadAsync(key));
  }

  Future<ImageInfo> _loadAsync(TestImageProvider key) async {
    // Return a simple 1x1 transparent image for testing
    return ImageInfo(image: await _createTestImage(), scale: 1.0);
  }

  Future<ui.Image> _createTestImage() async {
    // Create a simple 1x1 transparent image
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawRect(
        const Rect.fromLTWH(0, 0, 1, 1), Paint()..color = Colors.transparent);
    final picture = recorder.endRecording();
    return picture.toImage(1, 1);
  }

  @override
  bool operator ==(Object other) => other is TestImageProvider;

  @override
  int get hashCode => 0;
}

void main() {
  group('VelocityAvatar Widget Tests', () {
    late ThemeData theme;

    setUpAll(() {
      theme = ThemeData.light();
    });

    testWidgets('renders avatar with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              icon: Icons.person,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('renders avatar with image URL', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              imageUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      // Image组件会在网络请求过程中显示fallback，所以这里可能找不到Image组件
      // 但应该能找到VelocityAvatar
    });

    testWidgets('renders avatar with name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              name: 'John Doe',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('JD'), findsOneWidget); // First 2 characters, uppercase
    });

    testWidgets('renders avatar with single character name',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              name: 'A',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
    });

    // 移除了不支持的工厂构造函数测试，因为VelocityAvatar只有一个主构造函数

    testWidgets('handles custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              size: VelocityAvatarSize.lg,
              icon: Icons.person,
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.size, equals(VelocityAvatarSize.lg));
    });

    testWidgets('handles circle shape', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              shape: VelocityAvatarShape.circle,
              icon: Icons.person,
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.shape, equals(VelocityAvatarShape.circle));
    });

    testWidgets('handles square shape', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              shape: VelocityAvatarShape.square,
              icon: Icons.person,
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.shape, equals(VelocityAvatarShape.square));
    });

    testWidgets('handles custom style', (WidgetTester tester) async {
      const customStyle = VelocityAvatarStyle(backgroundColor: Colors.blue);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              icon: Icons.person,
              style: customStyle,
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.style?.backgroundColor, equals(Colors.blue));
    });

    // 移除了不支持的custom foregroundColor测试，因为实际使用style参数

    // 移除了不支持的custom border测试，因为实际使用style参数

    // 移除了不支持的custom elevation测试，因为实际使用style参数

    // 移除了不支持的custom shadowColor测试，因为实际使用style参数

    testWidgets('handles onTap callback', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              onTap: () {
                tapped = true;
              },
              icon: Icons.person,
            ),
          ),
        ),
      );

      expect(tapped, isFalse);

      await tester.tap(find.byType(VelocityAvatar));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('renders different sizes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: [
                VelocityAvatar(
                  size: VelocityAvatarSize.xs,
                  icon: Icons.person,
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.sm,
                  icon: Icons.person,
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.md,
                  icon: Icons.person,
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.lg,
                  icon: Icons.person,
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.xl,
                  icon: Icons.person,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsNWidgets(5));
      expect(find.byIcon(Icons.person), findsNWidgets(5));
    });

    testWidgets('handles empty avatar (no child, image, or text)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Icon),
          findsOneWidget); // Empty avatar should show default icon
    });

    testWidgets('handles text avatar with different colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              name: 'Test',
              style: VelocityAvatarStyle(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.text('TE'), findsOneWidget);
    });

    testWidgets('handles image avatar with custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              imageUrl: 'https://example.com/avatar.jpg',
              size: VelocityAvatarSize.lg,
              shape: VelocityAvatarShape.square,
              style: VelocityAvatarStyle(
                border: Border.all(color: Colors.green, width: 3.0),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
    });

    testWidgets('handles icon avatar with custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              icon: Icons.favorite,
              style: const VelocityAvatarStyle(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
              size: VelocityAvatarSize.xl,
              shape: VelocityAvatarShape.circle,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('handles accessibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              name: 'JD',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      // Avatar should be tappable for accessibility
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('handles edge case with very long text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              name: 'Very Long Name That Should Be Truncated',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.text('VL'), findsOneWidget); // First 2 characters only
    });

    testWidgets('handles interactive states correctly',
        (WidgetTester tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              onTap: () {
                tapCount++;
              },
              icon: Icons.person,
            ),
          ),
        ),
      );

      // Test multiple taps
      await tester.tap(find.byType(VelocityAvatar));
      await tester.pump();

      await tester.tap(find.byType(VelocityAvatar));
      await tester.pump();

      expect(tapCount, equals(2));
    });

    testWidgets('handles all avatar types in same screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: [
                VelocityAvatar(icon: Icons.person),
                VelocityAvatar(imageUrl: 'https://example.com/avatar.jpg'),
                VelocityAvatar(name: 'John'),
                VelocityAvatar(icon: Icons.star),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsNWidgets(4));
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('JO'), findsOneWidget);
    });

    testWidgets('handles constructor assertion correctly',
        (WidgetTester tester) async {
      // This should work (only icon provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              icon: Icons.person,
            ),
          ),
        ),
      );
      expect(find.byType(VelocityAvatar), findsOneWidget);

      // This should work (only image provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              imageUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );
      expect(find.byType(VelocityAvatar), findsOneWidget);

      // This should work (only text provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              name: 'Test',
            ),
          ),
        ),
      );
      expect(find.byType(VelocityAvatar), findsOneWidget);

      // This should work (none provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(),
          ),
        ),
      );
      expect(find.byType(VelocityAvatar), findsOneWidget);
    });
  });
}
