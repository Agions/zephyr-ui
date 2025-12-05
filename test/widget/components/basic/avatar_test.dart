import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:velocity_ui/src/components/basic/avatar/avatar.dart';
import 'package:velocity_ui/src/components/basic/avatar/avatar_theme.dart';
import 'package:velocity_ui/src/core/theme/theme_data.dart';

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
      final velocityTheme = VelocityThemeData.light();
      theme = ThemeData(
        brightness: velocityTheme.brightness,
        primaryColor: velocityTheme.primaryColor,
      );
    });

    testWidgets('renders avatar with custom child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('renders avatar with image', (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              image: testImage,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders avatar with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              text: 'John Doe',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('JO'), findsOneWidget); // First 2 characters, uppercase
    });

    testWidgets('renders avatar with single character text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              text: 'A',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('renders image avatar using factory constructor',
        (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar.image(
              image: testImage,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders text avatar using factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar.text(
              text: 'Alice',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('AL'), findsOneWidget);
    });

    testWidgets('renders icon avatar using factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar.icon(
              icon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('handles custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              size: VelocityAvatarSize.large,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.size, equals(VelocityAvatarSize.large));
    });

    testWidgets('handles circle shape', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              shape: VelocityAvatarShape.circle,
              child: Icon(Icons.person),
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
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.shape, equals(VelocityAvatarShape.square));
    });

    testWidgets('handles custom backgroundColor', (WidgetTester tester) async {
      const customBackgroundColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              backgroundColor: customBackgroundColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.backgroundColor, equals(customBackgroundColor));
    });

    testWidgets('handles custom foregroundColor', (WidgetTester tester) async {
      const customForegroundColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              foregroundColor: customForegroundColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.foregroundColor, equals(customForegroundColor));
    });

    testWidgets('handles custom border', (WidgetTester tester) async {
      const customBorderWidth = 2.0;
      const customBorderColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              borderWidth: customBorderWidth,
              borderColor: customBorderColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.borderWidth, equals(customBorderWidth));
      expect(avatar.borderColor, equals(customBorderColor));
    });

    testWidgets('handles custom elevation', (WidgetTester tester) async {
      const customElevation = 4.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              elevation: customElevation,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.elevation, equals(customElevation));
    });

    testWidgets('handles custom shadowColor', (WidgetTester tester) async {
      const customShadowColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              shadowColor: customShadowColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(VelocityAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<VelocityAvatar>(avatarFinder);
      expect(avatar.shadowColor, equals(customShadowColor));
    });

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
              child: const Icon(Icons.person),
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
                  size: VelocityAvatarSize.extraSmall,
                  child: Icon(Icons.person),
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.small,
                  child: Icon(Icons.person),
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.medium,
                  child: Icon(Icons.person),
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.large,
                  child: Icon(Icons.person),
                ),
                VelocityAvatar(
                  size: VelocityAvatarSize.extraLarge,
                  child: Icon(Icons.person),
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
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('handles text avatar with different colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              text: 'Test',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.text('TE'), findsOneWidget);
    });

    testWidgets('handles image avatar with custom properties',
        (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              image: testImage,
              size: VelocityAvatarSize.large,
              shape: VelocityAvatarShape.square,
              borderWidth: 3.0,
              borderColor: Colors.green,
              elevation: 6.0,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('handles icon avatar with custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar.icon(
              icon: Icons.favorite,
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              size: VelocityAvatarSize.extraLarge,
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
              text: 'JD',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      // Avatar should be tappable for accessibility
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('handles theme inheritance', (WidgetTester tester) async {
      final customTheme = ThemeData(
        extensions: const <ThemeExtension<dynamic>>[
          VelocityAvatarTheme(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            borderWidth: 2.0,
            borderColor: Colors.brown,
            elevation: 3.0,
            shadowColor: Colors.black,
            squareBorderRadius: 8.0,
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: customTheme,
          home: const Scaffold(
            body: VelocityAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('handles edge case with very long text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              text: 'Very Long Name That Should Be Truncated',
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.text('VE'), findsOneWidget); // First 2 characters only
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
              child: const Icon(Icons.person),
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

    testWidgets('handles border with zero width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              borderWidth: 0.0,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('handles elevation with zero value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              elevation: 0.0,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('handles image avatar without theme',
        (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(), // Empty theme
          home: Scaffold(
            body: VelocityAvatar(
              image: testImage,
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('handles all avatar types in same screen',
        (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: [
                const VelocityAvatar(child: Icon(Icons.person)),
                VelocityAvatar.image(image: testImage),
                VelocityAvatar.text(text: 'John'),
                VelocityAvatar.icon(icon: Icons.star),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VelocityAvatar), findsNWidgets(4));
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('JO'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('handles constructor assertion correctly',
        (WidgetTester tester) async {
      // This should work (only child provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: VelocityAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ),
      );
      expect(find.byType(VelocityAvatar), findsOneWidget);

      // This should work (only image provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: VelocityAvatar(
              image: TestImageProvider(),
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
              text: 'Test',
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
