/// 测试数据工厂
///
/// 提供测试数据的生成和管理功能
library test_data_factory;

import 'package:flutter/material.dart';
import 'package:velocity_ui/src/core/constants/design_tokens.dart';
import 'package:velocity_ui/src/core/constants/enums.dart';

/// 测试数据工厂基类
abstract class TestDataFactory<T> {
  const TestDataFactory();
  
  /// 创建测试数据
  T create();
  
  /// 创建多个测试数据
  List<T> createMany(int count);
  
  /// 创建自定义测试数据
  T createCustom(T Function(T) modifier);
}

/// 用户数据工厂
class UserDataFactory extends TestDataFactory<Map<String, dynamic>> {
  const UserDataFactory();
  
  @override
  Map<String, dynamic> create() {
    return {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'name': 'Test User',
      'email': 'test@example.com',
      'avatar': 'https://example.com/avatar.jpg',
      'isOnline': true,
      'lastSeen': DateTime.now().subtract(const Duration(hours: 1)),
      'role': 'user',
      'preferences': {
        'theme': 'light',
        'language': 'zh_CN',
        'notifications': true,
      },
      'stats': {
        'posts': 42,
        'followers': 128,
        'following': 64,
      },
    };
  }
  
  @override
  List<Map<String, dynamic>> createMany(int count) {
    return List.generate(count, (index) {
      final user = create();
      user['id'] = 'user_$index';
      user['name'] = 'Test User $index';
      user['email'] = 'test$index@example.com';
      user['stats']['posts'] = index * 10;
      user['stats']['followers'] = index * 20;
      user['stats']['following'] = index * 10;
      return user;
    });
  }
  
  @override
  Map<String, dynamic> createCustom(Map<String, dynamic> Function(Map<String, dynamic>) modifier) {
    final user = create();
    return modifier(user);
  }
}

/// 产品数据工厂
class ProductDataFactory extends TestDataFactory<Map<String, dynamic>> {
  const ProductDataFactory();
  
  @override
  Map<String, dynamic> create() {
    return {
      'id': 'product_${DateTime.now().millisecondsSinceEpoch}',
      'name': 'Test Product',
      'description': 'This is a test product description',
      'price': 99.99,
      'currency': 'USD',
      'category': 'electronics',
      'images': [
        'https://example.com/product1.jpg',
        'https://example.com/product2.jpg',
      ],
      'rating': 4.5,
      'reviews': 128,
      'inStock': true,
      'features': [
        'Feature 1',
        'Feature 2',
        'Feature 3',
      ],
      'specifications': {
        'weight': '1.5kg',
        'dimensions': '30x20x10cm',
        'material': 'Plastic',
      },
    };
  }
  
  @override
  List<Map<String, dynamic>> createMany(int count) {
    return List.generate(count, (index) {
      final product = create();
      product['id'] = 'product_$index';
      product['name'] = 'Test Product $index';
      product['price'] = 99.99 + (index * 10);
      product['rating'] = 3.5 + (index % 3);
      product['reviews'] = 100 + (index * 20);
      return product;
    });
  }
  
  @override
  Map<String, dynamic> createCustom(Map<String, dynamic> Function(Map<String, dynamic>) modifier) {
    final product = create();
    return modifier(product);
  }
}

/// 订单数据工厂
class OrderDataFactory extends TestDataFactory<Map<String, dynamic>> {
  const OrderDataFactory();
  
  @override
  Map<String, dynamic> create() {
    return {
      'id': 'order_${DateTime.now().millisecondsSinceEpoch}',
      'userId': 'user_123',
      'items': [
        {
          'productId': 'product_1',
          'name': 'Test Product',
          'quantity': 2,
          'price': 99.99,
          'total': 199.98,
        },
      ],
      'subtotal': 199.98,
      'tax': 19.99,
      'shipping': 10.00,
      'total': 229.97,
      'currency': 'USD',
      'status': 'pending',
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'shippingAddress': {
        'name': 'Test User',
        'street': '123 Test St',
        'city': 'Test City',
        'state': 'Test State',
        'zipCode': '12345',
        'country': 'Test Country',
      },
      'billingAddress': {
        'name': 'Test User',
        'street': '123 Test St',
        'city': 'Test City',
        'state': 'Test State',
        'zipCode': '12345',
        'country': 'Test Country',
      },
    };
  }
  
  @override
  List<Map<String, dynamic>> createMany(int count) {
    return List.generate(count, (index) {
      final order = create();
      order['id'] = 'order_$index';
      order['userId'] = 'user_$index';
      order['items'][0]['productId'] = 'product_$index';
      order['subtotal'] = 199.98 + (index * 50);
      order['total'] = 229.97 + (index * 50);
      return order;
    });
  }
  
  @override
  Map<String, dynamic> createCustom(Map<String, dynamic> Function(Map<String, dynamic>) modifier) {
    final order = create();
    return modifier(order);
  }
}

/// 消息数据工厂
class MessageDataFactory extends TestDataFactory<Map<String, dynamic>> {
  const MessageDataFactory();
  
  @override
  Map<String, dynamic> create() {
    return {
      'id': 'message_${DateTime.now().millisecondsSinceEpoch}',
      'senderId': 'user_1',
      'receiverId': 'user_2',
      'content': 'This is a test message',
      'type': 'text',
      'timestamp': DateTime.now(),
      'isRead': false,
      'attachments': [],
      'reactions': [],
      'isEdited': false,
      'isDeleted': false,
      'replyTo': null,
    };
  }
  
  @override
  List<Map<String, dynamic>> createMany(int count) {
    return List.generate(count, (index) {
      final message = create();
      message['id'] = 'message_$index';
      message['content'] = 'Test message $index';
      message['timestamp'] = DateTime.now().subtract(Duration(minutes: index));
      return message;
    });
  }
  
  @override
  Map<String, dynamic> createCustom(Map<String, dynamic> Function(Map<String, dynamic>) modifier) {
    final message = create();
    return modifier(message);
  }
}

/// 通知数据工厂
class NotificationDataFactory extends TestDataFactory<Map<String, dynamic>> {
  const NotificationDataFactory();
  
  @override
  Map<String, dynamic> create() {
    return {
      'id': 'notification_${DateTime.now().millisecondsSinceEpoch}',
      'userId': 'user_123',
      'title': 'Test Notification',
      'body': 'This is a test notification body',
      'type': 'info',
      'timestamp': DateTime.now(),
      'isRead': false,
      'data': {
        'action': 'open_screen',
        'screen': 'home',
      },
      'actions': [
        {
          'title': 'View',
          'action': 'open',
        },
        {
          'title': 'Dismiss',
          'action': 'dismiss',
        },
      ],
    };
  }
  
  @override
  List<Map<String, dynamic>> createMany(int count) {
    return List.generate(count, (index) {
      final notification = create();
      notification['id'] = 'notification_$index';
      notification['title'] = 'Test Notification $index';
      notification['timestamp'] = DateTime.now().subtract(Duration(hours: index));
      return notification;
    });
  }
  
  @override
  Map<String, dynamic> createCustom(Map<String, dynamic> Function(Map<String, dynamic>) modifier) {
    final notification = create();
    return modifier(notification);
  }
}

/// 主题数据工厂
class ThemeDataFactory extends TestDataFactory<ThemeData> {
  const ThemeDataFactory();
  
  @override
  ThemeData create() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: VelocityColors.primary500,
      scaffoldBackgroundColor: VelocityColors.neutral50,
      cardColor: Colors.white,
      dividerColor: VelocityColors.neutral200,
      focusColor: VelocityColors.primary500,
      hoverColor: VelocityColors.primary100,
      splashColor: VelocityColors.primary200,
      highlightColor: VelocityColors.primary100,
      disabledColor: VelocityColors.neutral300,
      indicatorColor: VelocityColors.primary500,
      hintColor: VelocityColors.neutral400,
      shadowColor: Colors.black.withOpacity(0.1),
      unselectedWidgetColor: VelocityColors.neutral400,
      secondaryHeaderColor: VelocityColors.neutral100,
      textTheme: _createTextTheme(),
      iconTheme: _createIconTheme(),
      appBarTheme: _createAppBarTheme(),
      buttonTheme: _createButtonTheme(),
      cardTheme: _createCardTheme(),
      chipTheme: _createChipTheme(),
      dialogTheme: _createDialogTheme(),
      floatingActionButtonTheme: _createFloatingActionButtonTheme(),
      inputDecorationTheme: _createInputDecorationTheme(),
      sliderTheme: _createSliderTheme(),
      tabBarTheme: _createTabBarTheme(),
      tooltipTheme: _createTooltipTheme(),
      badgeTheme: _createBadgeTheme(),
      bottomNavigationBarTheme: _createBottomNavigationBarTheme(),
      navigationRailTheme: _createNavigationRailTheme(),
      listTileTheme: _createListTileTheme(),
      dividerTheme: _createDividerTheme(),
      progressIndicatorTheme: _createProgressIndicatorTheme(),
      snackBarTheme: _createSnackBarTheme(),
      bottomSheetTheme: _createBottomSheetTheme(),
      popupMenuTheme: _createPopupMenuTheme(),
      expansionTileTheme: _createExpansionTileTheme(),
      dataTableTheme: _createDataTableTheme(),
      searchBarTheme: _createSearchBarTheme(),
      searchViewTheme: _createSearchViewTheme(),
      timePickerTheme: _createTimePickerTheme(),
      datePickerTheme: _createDatePickerTheme(),
      bannerTheme: _createBannerTheme(),
      stepperTheme: _createStepperTheme(),
      switchTheme: _createSwitchTheme(),
      checkboxTheme: _createCheckboxTheme(),
      radioTheme: _createRadioTheme(),
      sliderThemeData: _createSliderThemeData(),
      tabBarThemeData: _createTabBarThemeData(),
      chipThemeData: _createChipThemeData(),
      inputDecorationThemeData: _createInputDecorationThemeData(), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(surface: VelocityColors.neutral50).copyWith(error: VelocityColors.error500),
    );
  }
  
  @override
  List<ThemeData> createMany(int count) {
    return List.generate(count, (index) {
      return create().copyWith(
        primarySwatch: _getColorByIndex(index),
        brightness: index % 2 == 0 ? Brightness.light : Brightness.dark,
      );
    });
  }
  
  @override
  ThemeData createCustom(ThemeData Function(ThemeData) modifier) {
    final theme = create();
    return modifier(theme);
  }
  
  TextTheme _createTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: VelocityTypography.fontSize48,
        fontWeight: VelocityTypography.fontWeightBold,
        color: VelocityColors.neutral900,
      ),
      displayMedium: TextStyle(
        fontSize: VelocityTypography.fontSize36,
        fontWeight: VelocityTypography.fontWeightBold,
        color: VelocityColors.neutral900,
      ),
      displaySmall: TextStyle(
        fontSize: VelocityTypography.fontSize32,
        fontWeight: VelocityTypography.fontWeightBold,
        color: VelocityColors.neutral900,
      ),
      headlineLarge: TextStyle(
        fontSize: VelocityTypography.fontSize28,
        fontWeight: VelocityTypography.fontWeightSemiBold,
        color: VelocityColors.neutral900,
      ),
      headlineMedium: TextStyle(
        fontSize: VelocityTypography.fontSize24,
        fontWeight: VelocityTypography.fontWeightSemiBold,
        color: VelocityColors.neutral900,
      ),
      headlineSmall: TextStyle(
        fontSize: VelocityTypography.fontSize20,
        fontWeight: VelocityTypography.fontWeightSemiBold,
        color: VelocityColors.neutral900,
      ),
      titleLarge: TextStyle(
        fontSize: VelocityTypography.fontSize18,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral900,
      ),
      titleMedium: TextStyle(
        fontSize: VelocityTypography.fontSize16,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral900,
      ),
      titleSmall: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral900,
      ),
      bodyLarge: TextStyle(
        fontSize: VelocityTypography.fontSize16,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      bodyMedium: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      bodySmall: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
      labelLarge: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral700,
      ),
      labelMedium: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral700,
      ),
      labelSmall: TextStyle(
        fontSize: VelocityTypography.fontSize10,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral700,
      ),
    );
  }
  
  IconThemeData _createIconTheme() {
    return const IconThemeData(
      color: VelocityColors.neutral700,
      size: 24.0,
    );
  }
  
  AppBarTheme _createAppBarTheme() {
    return AppBarTheme(
      backgroundColor: VelocityColors.primary500,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize18,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24.0,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
        size: 24.0,
      ),
    );
  }
  
  ButtonThemeData _createButtonTheme() {
    return ButtonThemeData(
      buttonColor: VelocityColors.primary500,
      disabledColor: VelocityColors.neutral300,
      highlightColor: VelocityColors.primary200,
      splashColor: VelocityColors.primary100,
      focusColor: VelocityColors.primary500,
      hoverColor: VelocityColors.primary100,
      textTheme: ButtonTextTheme.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
      ),
      elevation: 0,
      focusElevation: 2,
      hoverElevation: 2,
      highlightElevation: 4,
      disabledElevation: 0,
      minWidth: 88.0,
      height: 36.0,
    );
  }
  
  CardTheme _createCardTheme() {
    return CardTheme(
      elevation: 2,
      shadowColor: VelocityColors.neutral200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
      ),
      margin: const EdgeInsets.all(VelocitySpacing.sm),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
    );
  }
  
  ChipThemeData _createChipTheme() {
    return ChipThemeData(
      backgroundColor: VelocityColors.neutral100,
      disabledColor: VelocityColors.neutral300,
      selectedColor: VelocityColors.primary100,
      secondarySelectedColor: VelocityColors.primary200,
      shadowColor: VelocityColors.neutral200,
      selectedShadowColor: VelocityColors.neutral200,
      checkmarkColor: VelocityColors.primary500,
      labelStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral700,
      ),
      secondaryLabelStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: Colors.white,
      ),
      brightness: Brightness.light,
      elevation: 0,
      pressElevation: 2,
      padding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.sm,
        vertical: VelocitySpacing.xs,
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.xs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.sm),
      ),
      side: const BorderSide(
        color: VelocityColors.neutral300,
        width: 1.0,
      ),
    );
  }
  
  DialogTheme _createDialogTheme() {
    return DialogTheme(
      backgroundColor: Colors.white,
      elevation: 24,
      shadowColor: VelocityColors.neutral200,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.lg),
      ),
      alignment: Alignment.center,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.sm,
      ),
      titleTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize20,
        fontWeight: VelocityTypography.fontWeightSemiBold,
        color: VelocityColors.neutral900,
      ),
      contentTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize16,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral700,
      ),
    );
  }
  
  FloatingActionButtonThemeData _createFloatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: VelocityColors.primary500,
      foregroundColor: Colors.white,
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
      disabledElevation: 0,
      shape: CircleBorder(),
      iconSize: 24.0,
      sizeConstraints: BoxConstraints(
        minWidth: 56.0,
        minHeight: 56.0,
        maxWidth: 56.0,
        maxHeight: 56.0,
      ),
    );
  }
  
  InputDecorationTheme _createInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: VelocityColors.neutral50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
        borderSide: const BorderSide(
          color: VelocityColors.neutral300,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
        borderSide: const BorderSide(
          color: VelocityColors.neutral300,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
        borderSide: const BorderSide(
          color: VelocityColors.primary500,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
        borderSide: const BorderSide(
          color: VelocityColors.error500,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
        borderSide: const BorderSide(
          color: VelocityColors.error500,
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
        borderSide: const BorderSide(
          color: VelocityColors.neutral200,
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.md,
      ),
      hintStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral400,
      ),
      errorStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.error500,
      ),
      helperStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
      counterStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      alignLabelWithHint: false,
      isDense: false,
    );
  }
  
  SliderThemeData _createSliderTheme() {
    return SliderThemeData(
      activeTrackColor: VelocityColors.primary500,
      inactiveTrackColor: VelocityColors.neutral200,
      thumbColor: VelocityColors.primary500,
      overlayColor: VelocityColors.primary100,
      valueIndicatorColor: VelocityColors.primary500,
      valueIndicatorTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: Colors.white,
      ),
      disabledActiveTrackColor: VelocityColors.neutral300,
      disabledInactiveTrackColor: VelocityColors.neutral100,
      disabledThumbColor: VelocityColors.neutral300,
      disabledSecondaryActiveTrackColor: VelocityColors.neutral300,
      overlappingShapeStrokeColor: Colors.white,
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  TabBarTheme _createTabBarTheme() {
    return TabBarTheme(
      labelColor: VelocityColors.primary500,
      unselectedLabelColor: VelocityColors.neutral600,
      labelStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightMedium,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
      ),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: VelocityColors.primary500,
          width: 2.0,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: VelocityColors.neutral200,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            return VelocityColors.primary100;
          }
          if (states.contains(WidgetState.focused)) {
            return VelocityColors.primary100;
          }
          if (states.contains(WidgetState.pressed)) {
            return VelocityColors.primary200;
          }
          return null;
        },
      ),
      splashFactory: InkRipple.splashFactory,
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  TooltipThemeData _createTooltipTheme() {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: VelocityColors.neutral800,
        borderRadius: BorderRadius.circular(VelocityRadius.sm),
      ),
      textStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.sm,
        vertical: VelocitySpacing.xs,
      ),
      margin: const EdgeInsets.all(VelocitySpacing.xs),
      preferBelow: true,
      verticalOffset: 24.0,
      waitDuration: const Duration(milliseconds: 500),
      showDuration: const Duration(milliseconds: 1500),
      exitDuration: const Duration(milliseconds: 200),
      enableFeedback: true,
    );
  }
  
  BadgeThemeData _createBadgeTheme() {
    return BadgeThemeData(
      backgroundColor: VelocityColors.error500,
      textColor: Colors.white,
      smallSize: 8.0,
      largeSize: 16.0,
      textStyle: TextStyle(
        fontSize: VelocityTypography.fontSize10,
        fontWeight: VelocityTypography.fontWeightBold,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.xs,
        vertical: VelocitySpacing.xs / 2,
      ),
      alignment: AlignmentDirectional.topEnd,
      offset: const Offset(-4, 4),
    );
  }
  
  BottomNavigationBarThemeData _createBottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: VelocityColors.primary500,
      unselectedItemColor: VelocityColors.neutral600,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightMedium,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  NavigationRailThemeData _createNavigationRailTheme() {
    return NavigationRailThemeData(
      backgroundColor: Colors.white,
      elevation: 4,
      unselectedItemColor: VelocityColors.neutral600,
      selectedItemColor: VelocityColors.primary500,
      indicatorColor: VelocityColors.primary100,
      labelType: NavigationRailLabelType.all,
      unselectedLabelTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
      selectedLabelTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.primary500,
      ),
      minWidth: 72.0,
      minExtendedWidth: 256.0,
      useIndicator: true,
      groupAlignment: -1.0,
    );
  }
  
  ListTileThemeData _createListTileTheme() {
    return ListTileThemeData(
      iconColor: VelocityColors.neutral600,
      textColor: VelocityColors.neutral800,
      tileColor: Colors.transparent,
      selectedTileColor: VelocityColors.primary100,
      shape: const RoundedRectangleBorder(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.sm,
      ),
      horizontalTitleGap: 16.0,
      minVerticalPadding: 8.0,
      enableFeedback: true,
      visualDensity: VisualDensity.standard,
      titleTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize16,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
    );
  }
  
  DividerThemeData _createDividerTheme() {
    return const DividerThemeData(
      color: VelocityColors.neutral200,
      thickness: 1.0,
      indent: 0.0,
      endIndent: 0.0,
      space: 16.0,
    );
  }
  
  ProgressIndicatorThemeData _createProgressIndicatorTheme() {
    return const ProgressIndicatorThemeData(
      color: VelocityColors.primary500,
      linearTrackColor: VelocityColors.neutral200,
      linearMinHeight: 4.0,
      refreshBackgroundColor: Colors.white,
    );
  }
  
  SnackBarThemeData _createSnackBarTheme() {
    return SnackBarThemeData(
      backgroundColor: VelocityColors.neutral800,
      contentTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: Colors.white,
      ),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.sm),
      ),
      behavior: SnackBarBehavior.floating,
      width: 560.0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.md,
      ),
      showCloseIcon: false,
      closeIconColor: Colors.white,
      disabledActionTextColor: VelocityColors.neutral400,
      actionTextColor: VelocityColors.primary200,
    );
  }
  
  BottomSheetThemeData _createBottomSheetTheme() {
    return const BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      dragHandleColor: VelocityColors.neutral300,
      dragHandleSize: Size(40.0, 4.0),
      modalBackgroundColor: Colors.white,
      modalElevation: 24,
      showDragHandle: true,
    );
  }
  
  PopupMenuThemeData _createPopupMenuTheme() {
    return PopupMenuThemeData(
      color: Colors.white,
      elevation: 8,
      shadowColor: VelocityColors.neutral200,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
      ),
      textStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      enableFeedback: true,
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  ExpansionTileThemeData _createExpansionTileTheme() {
    return const ExpansionTileThemeData(
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      tilePadding: EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.sm,
      ),
      expandedAlignment: Alignment.centerLeft,
      collapsedTextColor: VelocityColors.neutral800,
      textColor: VelocityColors.primary500,
      iconColor: VelocityColors.neutral600,
      collapsedIconColor: VelocityColors.neutral600,
      childrenPadding: EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.sm,
      ),
      shape: Border(),
      collapsedShape: Border(),
      controlAffinity: ListTileControlAffinity.platform,
      dividerColor: VelocityColors.neutral200,
    );
  }
  
  DataTableThemeData _createDataTableTheme() {
    return DataTableThemeData(
      dataRowColor: WidgetStateProperty.all(Colors.transparent),
      dataRowMinHeight: 48.0,
      dataRowMaxHeight: double.infinity,
      dataTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      headingRowColor: WidgetStateProperty.all(VelocityColors.neutral50),
      headingRowHeight: 56.0,
      headingTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightSemiBold,
        color: VelocityColors.neutral900,
      ),
      horizontalMargin: 24.0,
      columnSpacing: 56.0,
      dividerThickness: 1.0,
      checkboxHorizontalMargin: 24.0,
    );
  }
  
  SearchBarThemeData _createSearchBarTheme() {
    return SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(VelocityColors.neutral50),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      overlayColor: WidgetStateProperty.all(VelocityColors.neutral100),
      shadowColor: WidgetStateProperty.all(VelocityColors.neutral200),
      elevation: WidgetStateProperty.all(0.0),
      side: WidgetStateProperty.all(const BorderSide(
        color: VelocityColors.neutral300,
        width: 1.0,
      )),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.md),
      )),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
        horizontal: VelocitySpacing.md,
        vertical: VelocitySpacing.sm,
      )),
      textStyle: WidgetStateProperty.all(TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      )),
      hintStyle: WidgetStateProperty.all(TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral400,
      )),
      constraints: const BoxConstraints(
        minHeight: 56.0,
        maxHeight: 56.0,
      ),
    );
  }
  
  SearchViewThemeData _createSearchViewTheme() {
    return SearchViewThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 4.0,
      side: const BorderSide(
        color: VelocityColors.neutral300,
        width: 1.0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
      ),
      headerTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      headerHintStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral400,
      ),
      dividerColor: VelocityColors.neutral200,
    );
  }
  
  TimePickerThemeData _createTimePickerTheme() {
    return TimePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      hourMinuteColor: VelocityColors.primary100,
      hourMinuteTextColor: VelocityColors.primary500,
      dialHandColor: VelocityColors.primary500,
      dialTextColor: VelocityColors.neutral800,
      entryModeIconColor: VelocityColors.primary500,
      helpTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
      inputDecorationTheme: _createInputDecorationTheme(),
      dayPeriodColor: VelocityColors.primary100,
      dayPeriodTextColor: VelocityColors.primary500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.lg),
      ),
    );
  }
  
  DatePickerThemeData _createDatePickerTheme() {
    return DatePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 24,
      shadowColor: VelocityColors.neutral200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.lg),
      ),
      headerBackgroundColor: VelocityColors.primary500,
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: TextStyle(
        fontSize: VelocityTypography.fontSize32,
        fontWeight: VelocityTypography.fontWeightBold,
        color: Colors.white,
      ),
      headerHelpStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: Colors.white,
      ),
      weekdayStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral600,
      ),
      dayStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      dayForegroundColor: WidgetStateProperty.all(VelocityColors.neutral800),
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return VelocityColors.primary500;
          }
          if (states.contains(WidgetState.disabled)) {
            return VelocityColors.neutral100;
          }
          return Colors.transparent;
        },
      ),
      todayForegroundColor: WidgetStateProperty.all(VelocityColors.primary500),
      todayBackgroundColor: WidgetStateProperty.all(VelocityColors.primary100),
      rangeSelectionBackgroundColor: VelocityColors.primary100,
      rangeSelectionOverlayColor: WidgetStateProperty.all(VelocityColors.primary500),
      yearStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral800,
      ),
      yearForegroundColor: WidgetStateProperty.all(VelocityColors.neutral800),
      yearBackgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return VelocityColors.primary500;
          }
          return Colors.transparent;
        },
      ),
      rangePickerBackgroundColor: Colors.white,
      rangePickerElevation: 24,
      rangePickerShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.lg),
      ),
      rangePickerHeaderBackgroundColor: VelocityColors.primary500,
      rangePickerHeaderForegroundColor: Colors.white,
      rangePickerHeaderHeadlineStyle: TextStyle(
        fontSize: VelocityTypography.fontSize32,
        fontWeight: VelocityTypography.fontWeightBold,
        color: Colors.white,
      ),
      rangePickerHeaderHelpStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: Colors.white,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: VelocityColors.primary500,
        textStyle: TextStyle(
          fontSize: VelocityTypography.fontSize14,
          fontWeight: VelocityTypography.fontWeightMedium,
        ),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: VelocityColors.neutral600,
        textStyle: TextStyle(
          fontSize: VelocityTypography.fontSize14,
          fontWeight: VelocityTypography.fontWeightMedium,
        ),
      ),
    );
  }
  
  BannerThemeData _createBannerTheme() {
    return BannerThemeData(
      backgroundColor: VelocityColors.warning500,
      textColor: Colors.white,
      textStyle: TextStyle(
        fontSize: VelocityTypography.fontSize12,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: Colors.white,
      ),
      layoutDirection: TextDirection.ltr,
      location: BannerLocation.topEnd,
    );
  }
  
  StepperThemeData _createStepperTheme() {
    return StepperThemeData(
      color: VelocityColors.primary500,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      margin: const EdgeInsets.all(VelocitySpacing.md),
      padding: const EdgeInsets.all(VelocitySpacing.md),
      connectorColor: VelocityColors.neutral300,
      connectorThickness: 1.0,
      controlsColor: VelocityColors.primary500,
      iconColor: VelocityColors.primary500,
      disabledColor: VelocityColors.neutral300,
      errorColor: VelocityColors.error500,
      titleTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize16,
        fontWeight: VelocityTypography.fontWeightMedium,
        color: VelocityColors.neutral800,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral600,
      ),
      contentTextStyle: TextStyle(
        fontSize: VelocityTypography.fontSize14,
        fontWeight: VelocityTypography.fontWeightRegular,
        color: VelocityColors.neutral700,
      ),
    );
  }
  
  SwitchThemeData _createSwitchTheme() {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return VelocityColors.neutral300;
          }
          if (states.contains(WidgetState.selected)) {
            return VelocityColors.primary500;
          }
          return VelocityColors.neutral400;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return VelocityColors.neutral200;
          }
          if (states.contains(WidgetState.selected)) {
            return VelocityColors.primary200;
          }
          return VelocityColors.neutral300;
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  CheckboxThemeData _createCheckboxTheme() {
    return CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return VelocityColors.neutral300;
          }
          if (states.contains(WidgetState.selected)) {
            return VelocityColors.primary500;
          }
          return Colors.transparent;
        },
      ),
      overlayColor: WidgetStateProperty.all(VelocityColors.primary100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VelocityRadius.xs),
      ),
      side: const BorderSide(
        color: VelocityColors.neutral400,
        width: 2.0,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  RadioThemeData _createRadioTheme() {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return VelocityColors.neutral300;
          }
          if (states.contains(WidgetState.selected)) {
            return VelocityColors.primary500;
          }
          return Colors.transparent;
        },
      ),
      overlayColor: WidgetStateProperty.all(VelocityColors.primary100),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
      mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  SliderThemeData _createSliderThemeData() {
    return _createSliderTheme();
  }
  
  TabBarTheme _createTabBarThemeData() {
    return _createTabBarTheme();
  }
  
  ChipThemeData _createChipThemeData() {
    return _createChipTheme();
  }
  
  InputDecorationTheme _createInputDecorationThemeData() {
    return _createInputDecorationTheme();
  }
  
  MaterialColor _getColorByIndex(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
      Colors.pink,
      Colors.cyan,
    ];
    return colors[index % colors.length];
  }
}

/// 测试数据工厂管理器
class TestDataFactoryManager {
  static final Map<Type, TestDataFactory> _factories = {};
  
  /// 注册数据工厂
  static void registerFactory<T>(TestDataFactory<T> factory) {
    _factories[T] = factory;
  }
  
  /// 获取数据工厂
  static TestDataFactory<T>? getFactory<T>() {
    return _factories[T] as TestDataFactory<T>?;
  }
  
  /// 创建测试数据
  static T create<T>() {
    final factory = getFactory<T>();
    if (factory == null) {
      throw Exception('No factory registered for type $T');
    }
    return factory.create();
  }
  
  /// 创建多个测试数据
  static List<T> createMany<T>(int count) {
    final factory = getFactory<T>();
    if (factory == null) {
      throw Exception('No factory registered for type $T');
    }
    return factory.createMany(count);
  }
  
  /// 创建自定义测试数据
  static T createCustom<T>(T Function(T) modifier) {
    final factory = getFactory<T>();
    if (factory == null) {
      throw Exception('No factory registered for type $T');
    }
    return factory.createCustom(modifier);
  }
  
  /// 初始化默认工厂
  static void initializeDefaultFactories() {
    registerFactory(const UserDataFactory());
    registerFactory(const ProductDataFactory());
    registerFactory(const OrderDataFactory());
    registerFactory(const MessageDataFactory());
    registerFactory(const NotificationDataFactory());
    registerFactory(const ThemeDataFactory());
  }
}

/// 测试数据构建器
class TestDataBuilder<T> {
  
  TestDataBuilder(this._creator);
  final T Function() _creator;
  final List<void Function(T)> _modifiers = [];
  
  /// 修改数据
  TestDataBuilder<T> modify(void Function(T) modifier) {
    _modifiers.add(modifier);
    return this;
  }
  
  /// 构建数据
  T build() {
    final data = _creator();
    for (final modifier in _modifiers) {
      modifier(data);
    }
    return data;
  }
  
  /// 构建多个数据
  List<T> buildMany(int count) {
    return List.generate(count, (index) {
      final data = _creator();
      for (final modifier in _modifiers) {
        modifier(data);
      }
      return data;
    });
  }
}