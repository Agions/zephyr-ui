import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zephyr_ui/src/components/basic/avatar/avatar.dart';
import 'package:zephyr_ui/src/components/basic/avatar/avatar_theme.dart';
import 'package:zephyr_ui/src/core/theme/theme_data.dart';

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
  group('ZephyrAvatar Widget Tests', () {
    late ThemeData theme;

    setUpAll(() {
      final zephyrTheme = ZephyrThemeData.light();
      theme = ThemeData(
        brightness: zephyrTheme.brightness,
        primaryColor: zephyrTheme.primaryColor,
      );
    });

    testWidgets('renders avatar with custom child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('renders avatar with image', (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar(
              image: testImage,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders avatar with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              text: 'John Doe',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('JO'), findsOneWidget); // First 2 characters, uppercase
    });

    testWidgets('renders avatar with single character text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              text: 'A',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
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
            body: ZephyrAvatar.image(
              image: testImage,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders text avatar using factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar.text(
              text: 'Alice',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('AL'), findsOneWidget);
    });

    testWidgets('renders icon avatar using factory constructor',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar.icon(
              icon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('handles custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              size: ZephyrAvatarSize.large,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.size, equals(ZephyrAvatarSize.large));
    });

    testWidgets('handles circle shape', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              shape: ZephyrAvatarShape.circle,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.shape, equals(ZephyrAvatarShape.circle));
    });

    testWidgets('handles square shape', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              shape: ZephyrAvatarShape.square,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.shape, equals(ZephyrAvatarShape.square));
    });

    testWidgets('handles custom backgroundColor', (WidgetTester tester) async {
      const customBackgroundColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              backgroundColor: customBackgroundColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.backgroundColor, equals(customBackgroundColor));
    });

    testWidgets('handles custom foregroundColor', (WidgetTester tester) async {
      const customForegroundColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              foregroundColor: customForegroundColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.foregroundColor, equals(customForegroundColor));
    });

    testWidgets('handles custom border', (WidgetTester tester) async {
      const customBorderWidth = 2.0;
      const customBorderColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              borderWidth: customBorderWidth,
              borderColor: customBorderColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.borderWidth, equals(customBorderWidth));
      expect(avatar.borderColor, equals(customBorderColor));
    });

    testWidgets('handles custom elevation', (WidgetTester tester) async {
      const customElevation = 4.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              elevation: customElevation,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.elevation, equals(customElevation));
    });

    testWidgets('handles custom shadowColor', (WidgetTester tester) async {
      const customShadowColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              shadowColor: customShadowColor,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      final avatarFinder = find.byType(ZephyrAvatar);
      expect(avatarFinder, findsOneWidget);

      final avatar = tester.widget<ZephyrAvatar>(avatarFinder);
      expect(avatar.shadowColor, equals(customShadowColor));
    });

    testWidgets('handles onTap callback', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar(
              onTap: () {
                tapped = true;
              },
              child: const Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(tapped, isFalse);

      await tester.tap(find.byType(ZephyrAvatar));
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
                ZephyrAvatar(
                  size: ZephyrAvatarSize.extraSmall,
                  child: Icon(Icons.person),
                ),
                ZephyrAvatar(
                  size: ZephyrAvatarSize.small,
                  child: Icon(Icons.person),
                ),
                ZephyrAvatar(
                  size: ZephyrAvatarSize.medium,
                  child: Icon(Icons.person),
                ),
                ZephyrAvatar(
                  size: ZephyrAvatarSize.large,
                  child: Icon(Icons.person),
                ),
                ZephyrAvatar(
                  size: ZephyrAvatarSize.extraLarge,
                  child: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsNWidgets(5));
      expect(find.byIcon(Icons.person), findsNWidgets(5));
    });

    testWidgets('handles empty avatar (no child, image, or text)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('handles text avatar with different colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              text: 'Test',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.text('TE'), findsOneWidget);
    });

    testWidgets('handles image avatar with custom properties',
        (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar(
              image: testImage,
              size: ZephyrAvatarSize.large,
              shape: ZephyrAvatarShape.square,
              borderWidth: 3.0,
              borderColor: Colors.green,
              elevation: 6.0,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('handles icon avatar with custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar.icon(
              icon: Icons.favorite,
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              size: ZephyrAvatarSize.extraLarge,
              shape: ZephyrAvatarShape.circle,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('handles accessibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar(
              text: 'JD',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      // Avatar should be tappable for accessibility
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('handles theme inheritance', (WidgetTester tester) async {
      final customTheme = ThemeData(
        extensions: const <ThemeExtension<dynamic>>[
          ZephyrAvatarTheme(
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
            body: ZephyrAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('handles edge case with very long text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              text: 'Very Long Name That Should Be Truncated',
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.text('VE'), findsOneWidget); // First 2 characters only
    });

    testWidgets('handles interactive states correctly',
        (WidgetTester tester) async {
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar(
              onTap: () {
                tapCount++;
              },
              child: const Icon(Icons.person),
            ),
          ),
        ),
      );

      // Test multiple taps
      await tester.tap(find.byType(ZephyrAvatar));
      await tester.pump();

      await tester.tap(find.byType(ZephyrAvatar));
      await tester.pump();

      expect(tapCount, equals(2));
    });

    testWidgets('handles border with zero width', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              borderWidth: 0.0,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('handles elevation with zero value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              elevation: 0.0,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('handles image avatar without theme',
        (WidgetTester tester) async {
      final testImage = TestImageProvider();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(), // Empty theme
          home: Scaffold(
            body: ZephyrAvatar(
              image: testImage,
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsOneWidget);
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
                const ZephyrAvatar(child: Icon(Icons.person)),
                ZephyrAvatar.image(image: testImage),
                ZephyrAvatar.text(text: 'John'),
                ZephyrAvatar.icon(icon: Icons.star),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ZephyrAvatar), findsNWidgets(4));
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
            body: ZephyrAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ),
      );
      expect(find.byType(ZephyrAvatar), findsOneWidget);

      // This should work (only image provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ZephyrAvatar(
              image: TestImageProvider(),
            ),
          ),
        ),
      );
      expect(find.byType(ZephyrAvatar), findsOneWidget);

      // This should work (only text provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(
              text: 'Test',
            ),
          ),
        ),
      );
      expect(find.byType(ZephyrAvatar), findsOneWidget);

      // This should work (none provided)
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: ZephyrAvatar(),
          ),
        ),
      );
      expect(find.byType(ZephyrAvatar), findsOneWidget);
    });
  });
}
