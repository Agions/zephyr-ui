/// 测试数据工厂
///
/// 提供测试数据的生成和管理功能
library test_data_factory;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/constants/design_tokens.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart';

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
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      primaryColor: ZephyrColors.primary500,
      scaffoldBackgroundColor: ZephyrColors.neutral50,
      cardColor: Colors.white,
      dividerColor: ZephyrColors.neutral200,
      focusColor: ZephyrColors.primary500,
      hoverColor: ZephyrColors.primary100,
      splashColor: ZephyrColors.primary200,
      highlightColor: ZephyrColors.primary100,
      disabledColor: ZephyrColors.neutral300,
      errorColor: ZephyrColors.error500,
      backgroundColor: ZephyrColors.neutral50,
      dialogBackgroundColor: Colors.white,
      indicatorColor: ZephyrColors.primary500,
      hintColor: ZephyrColors.neutral400,
      shadowColor: Colors.black.withOpacity(0.1),
      selectedRowColor: ZephyrColors.primary100,
      unselectedWidgetColor: ZephyrColors.neutral400,
      secondaryHeaderColor: ZephyrColors.neutral100,
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
      inputDecorationThemeData: _createInputDecorationThemeData(),
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
        fontSize: ZephyrTypography.fontSize48,
        fontWeight: ZephyrTypography.fontWeightBold,
        color: ZephyrColors.neutral900,
      ),
      displayMedium: TextStyle(
        fontSize: ZephyrTypography.fontSize36,
        fontWeight: ZephyrTypography.fontWeightBold,
        color: ZephyrColors.neutral900,
      ),
      displaySmall: TextStyle(
        fontSize: ZephyrTypography.fontSize32,
        fontWeight: ZephyrTypography.fontWeightBold,
        color: ZephyrColors.neutral900,
      ),
      headlineLarge: TextStyle(
        fontSize: ZephyrTypography.fontSize28,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: ZephyrColors.neutral900,
      ),
      headlineMedium: TextStyle(
        fontSize: ZephyrTypography.fontSize24,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: ZephyrColors.neutral900,
      ),
      headlineSmall: TextStyle(
        fontSize: ZephyrTypography.fontSize20,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: ZephyrColors.neutral900,
      ),
      titleLarge: TextStyle(
        fontSize: ZephyrTypography.fontSize18,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral900,
      ),
      titleMedium: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral900,
      ),
      titleSmall: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral900,
      ),
      bodyLarge: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      bodyMedium: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      bodySmall: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
      labelLarge: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral700,
      ),
      labelMedium: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral700,
      ),
      labelSmall: TextStyle(
        fontSize: ZephyrTypography.fontSize10,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral700,
      ),
    );
  }
  
  IconThemeData _createIconTheme() {
    return IconThemeData(
      color: ZephyrColors.neutral700,
      size: 24.0,
    );
  }
  
  AppBarTheme _createAppBarTheme() {
    return AppBarTheme(
      backgroundColor: ZephyrColors.primary500,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize18,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 24.0,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
        size: 24.0,
      ),
    );
  }
  
  ButtonThemeData _createButtonTheme() {
    return ButtonThemeData(
      buttonColor: ZephyrColors.primary500,
      disabledColor: ZephyrColors.neutral300,
      highlightColor: ZephyrColors.primary200,
      splashColor: ZephyrColors.primary100,
      focusColor: ZephyrColors.primary500,
      hoverColor: ZephyrColors.primary100,
      textTheme: ButtonTextTheme.primary,
      padding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
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
      shadowColor: ZephyrColors.neutral200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
      ),
      margin: EdgeInsets.all(ZephyrSpacing.sm),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
    );
  }
  
  ChipThemeData _createChipTheme() {
    return ChipThemeData(
      backgroundColor: ZephyrColors.neutral100,
      disabledColor: ZephyrColors.neutral300,
      selectedColor: ZephyrColors.primary100,
      secondarySelectedColor: ZephyrColors.primary200,
      shadowColor: ZephyrColors.neutral200,
      selectedShadowColor: ZephyrColors.neutral200,
      checkmarkColor: ZephyrColors.primary500,
      labelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral700,
      ),
      secondaryLabelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: Colors.white,
      ),
      brightness: Brightness.light,
      elevation: 0,
      pressElevation: 2,
      padding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.sm,
        vertical: ZephyrSpacing.xs,
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.xs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.sm),
      ),
      side: BorderSide(
        color: ZephyrColors.neutral300,
        width: 1.0,
      ),
    );
  }
  
  DialogTheme _createDialogTheme() {
    return DialogTheme(
      backgroundColor: Colors.white,
      elevation: 24,
      shadowColor: ZephyrColors.neutral200,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.lg),
      ),
      alignment: Alignment.center,
      actionsPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize20,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: ZephyrColors.neutral900,
      ),
      contentTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral700,
      ),
    );
  }
  
  FloatingActionButtonThemeData _createFloatingActionButtonTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: ZephyrColors.primary500,
      foregroundColor: Colors.white,
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
      disabledElevation: 0,
      shape: const CircleBorder(),
      iconSize: 24.0,
      sizeConstraints: const BoxConstraints(
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
      fillColor: ZephyrColors.neutral50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
        borderSide: BorderSide(
          color: ZephyrColors.neutral300,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
        borderSide: BorderSide(
          color: ZephyrColors.neutral300,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
        borderSide: BorderSide(
          color: ZephyrColors.primary500,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
        borderSide: BorderSide(
          color: ZephyrColors.error500,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
        borderSide: BorderSide(
          color: ZephyrColors.error500,
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
        borderSide: BorderSide(
          color: ZephyrColors.neutral200,
          width: 1.0,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.md,
      ),
      hintStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral400,
      ),
      errorStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.error500,
      ),
      helperStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
      counterStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      alignLabelWithHint: false,
      isDense: false,
    );
  }
  
  SliderThemeData _createSliderTheme() {
    return SliderThemeData(
      activeTrackColor: ZephyrColors.primary500,
      inactiveTrackColor: ZephyrColors.neutral200,
      thumbColor: ZephyrColors.primary500,
      overlayColor: ZephyrColors.primary100,
      valueIndicatorColor: ZephyrColors.primary500,
      valueIndicatorTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: Colors.white,
      ),
      disabledActiveTrackColor: ZephyrColors.neutral300,
      disabledInactiveTrackColor: ZephyrColors.neutral100,
      disabledThumbColor: ZephyrColors.neutral300,
      disabledSecondaryActiveTrackColor: ZephyrColors.neutral300,
      overlappingShapeStrokeColor: Colors.white,
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  TabBarTheme _createTabBarTheme() {
    return TabBarTheme(
      labelColor: ZephyrColors.primary500,
      unselectedLabelColor: ZephyrColors.neutral600,
      labelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ZephyrColors.primary500,
          width: 2.0,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: ZephyrColors.neutral200,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return ZephyrColors.primary100;
          }
          if (states.contains(MaterialState.focused)) {
            return ZephyrColors.primary100;
          }
          if (states.contains(MaterialState.pressed)) {
            return ZephyrColors.primary200;
          }
          return null;
        },
      ),
      splashFactory: InkRipple.splashFactory,
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  TooltipThemeData _createTooltipTheme() {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: ZephyrColors.neutral800,
        borderRadius: BorderRadius.circular(ZephyrRadius.sm),
      ),
      textStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.sm,
        vertical: ZephyrSpacing.xs,
      ),
      margin: EdgeInsets.all(ZephyrSpacing.xs),
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
      backgroundColor: ZephyrColors.error500,
      textColor: Colors.white,
      smallSize: 8.0,
      largeSize: 16.0,
      textStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize10,
        fontWeight: ZephyrTypography.fontWeightBold,
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.xs,
        vertical: ZephyrSpacing.xs / 2,
      ),
      alignment: AlignmentDirectional.topEnd,
      offset: const Offset(-4, 4),
    );
  }
  
  BottomNavigationBarThemeData _createBottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: ZephyrColors.primary500,
      unselectedItemColor: ZephyrColors.neutral600,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  NavigationRailThemeData _createNavigationRailTheme() {
    return NavigationRailThemeData(
      backgroundColor: Colors.white,
      elevation: 4,
      unselectedItemColor: ZephyrColors.neutral600,
      selectedItemColor: ZephyrColors.primary500,
      indicatorColor: ZephyrColors.primary100,
      labelType: NavigationRailLabelType.all,
      unselectedLabelTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
      selectedLabelTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.primary500,
      ),
      minWidth: 72.0,
      minExtendedWidth: 256.0,
      useIndicator: true,
      groupAlignment: -1.0,
    );
  }
  
  ListTileThemeData _createListTileTheme() {
    return ListTileThemeData(
      iconColor: ZephyrColors.neutral600,
      textColor: ZephyrColors.neutral800,
      tileColor: Colors.transparent,
      selectedTileColor: ZephyrColors.primary100,
      shape: const RoundedRectangleBorder(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      horizontalTitleGap: 16.0,
      minVerticalPadding: 8.0,
      enableFeedback: true,
      visualDensity: VisualDensity.standard,
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
    );
  }
  
  DividerThemeData _createDividerTheme() {
    return DividerThemeData(
      color: ZephyrColors.neutral200,
      thickness: 1.0,
      indent: 0.0,
      endIndent: 0.0,
      space: 16.0,
    );
  }
  
  ProgressIndicatorThemeData _createProgressIndicatorTheme() {
    return ProgressIndicatorThemeData(
      color: ZephyrColors.primary500,
      linearTrackColor: ZephyrColors.neutral200,
      linearMinHeight: 4.0,
      refreshBackgroundColor: Colors.white,
    );
  }
  
  SnackBarThemeData _createSnackBarTheme() {
    return SnackBarThemeData(
      backgroundColor: ZephyrColors.neutral800,
      contentTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: Colors.white,
      ),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.sm),
      ),
      behavior: SnackBarBehavior.floating,
      width: 560.0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.md,
      ),
      showCloseIcon: false,
      closeIconColor: Colors.white,
      disabledActionTextColor: ZephyrColors.neutral400,
      actionTextColor: ZephyrColors.primary200,
    );
  }
  
  BottomSheetThemeData _createBottomSheetTheme() {
    return BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 24,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      dragHandleColor: ZephyrColors.neutral300,
      dragHandleSize: const Size(40.0, 4.0),
      modalBackgroundColor: Colors.white,
      modalElevation: 24,
      showDragHandle: true,
    );
  }
  
  PopupMenuThemeData _createPopupMenuTheme() {
    return PopupMenuThemeData(
      color: Colors.white,
      elevation: 8,
      shadowColor: ZephyrColors.neutral200,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
      ),
      textStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      enableFeedback: true,
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  ExpansionTileThemeData _createExpansionTileTheme() {
    return ExpansionTileThemeData(
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      tilePadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      expandedAlignment: Alignment.centerLeft,
      collapsedTextColor: ZephyrColors.neutral800,
      textColor: ZephyrColors.primary500,
      iconColor: ZephyrColors.neutral600,
      collapsedIconColor: ZephyrColors.neutral600,
      childrenPadding: EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      shape: const Border(),
      collapsedShape: const Border(),
      controlAffinity: ListTileControlAffinity.platform,
      dividerColor: ZephyrColors.neutral200,
    );
  }
  
  DataTableThemeData _createDataTableTheme() {
    return DataTableThemeData(
      dataRowColor: MaterialStateProperty.all(Colors.transparent),
      dataRowMinHeight: 48.0,
      dataRowMaxHeight: double.infinity,
      dataTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      headingRowColor: MaterialStateProperty.all(ZephyrColors.neutral50),
      headingRowHeight: 56.0,
      headingTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: ZephyrColors.neutral900,
      ),
      horizontalMargin: 24.0,
      columnSpacing: 56.0,
      dividerThickness: 1.0,
      checkboxHorizontalMargin: 24.0,
    );
  }
  
  SearchBarThemeData _createSearchBarTheme() {
    return SearchBarThemeData(
      backgroundColor: MaterialStateProperty.all(ZephyrColors.neutral50),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      overlayColor: MaterialStateProperty.all(ZephyrColors.neutral100),
      shadowColor: MaterialStateProperty.all(ZephyrColors.neutral200),
      elevation: MaterialStateProperty.all(0.0),
      side: MaterialStateProperty.all(BorderSide(
        color: ZephyrColors.neutral300,
        width: 1.0,
      )),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.md),
      )),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      )),
      textStyle: MaterialStateProperty.all(TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      )),
      hintStyle: MaterialStateProperty.all(TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral400,
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
      side: BorderSide(
        color: ZephyrColors.neutral300,
        width: 1.0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
      ),
      headerTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      headerHintStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral400,
      ),
      dividerColor: ZephyrColors.neutral200,
    );
  }
  
  TimePickerThemeData _createTimePickerTheme() {
    return TimePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      hourMinuteColor: ZephyrColors.primary100,
      hourMinuteTextColor: ZephyrColors.primary500,
      dialHandColor: ZephyrColors.primary500,
      dialTextColor: ZephyrColors.neutral800,
      entryModeIconColor: ZephyrColors.primary500,
      helpTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
      inputDecorationTheme: _createInputDecorationTheme(),
      dayPeriodColor: ZephyrColors.primary100,
      dayPeriodTextColor: ZephyrColors.primary500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.lg),
      ),
    );
  }
  
  DatePickerThemeData _createDatePickerTheme() {
    return DatePickerThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 24,
      shadowColor: ZephyrColors.neutral200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.lg),
      ),
      headerBackgroundColor: ZephyrColors.primary500,
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize32,
        fontWeight: ZephyrTypography.fontWeightBold,
        color: Colors.white,
      ),
      headerHelpStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: Colors.white,
      ),
      weekdayStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral600,
      ),
      dayStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      dayForegroundColor: MaterialStateProperty.all(ZephyrColors.neutral800),
      dayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return ZephyrColors.primary500;
          }
          if (states.contains(MaterialState.disabled)) {
            return ZephyrColors.neutral100;
          }
          return Colors.transparent;
        },
      ),
      todayForegroundColor: MaterialStateProperty.all(ZephyrColors.primary500),
      todayBackgroundColor: MaterialStateProperty.all(ZephyrColors.primary100),
      rangeSelectionBackgroundColor: ZephyrColors.primary100,
      rangeSelectionOverlayColor: MaterialStateProperty.all(ZephyrColors.primary500),
      yearStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral800,
      ),
      yearForegroundColor: MaterialStateProperty.all(ZephyrColors.neutral800),
      yearBackgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return ZephyrColors.primary500;
          }
          return Colors.transparent;
        },
      ),
      rangePickerBackgroundColor: Colors.white,
      rangePickerElevation: 24,
      rangePickerShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.lg),
      ),
      rangePickerHeaderBackgroundColor: ZephyrColors.primary500,
      rangePickerHeaderForegroundColor: Colors.white,
      rangePickerHeaderHeadlineStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize32,
        fontWeight: ZephyrTypography.fontWeightBold,
        color: Colors.white,
      ),
      rangePickerHeaderHelpStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: Colors.white,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: ZephyrColors.primary500,
        textStyle: TextStyle(
          fontSize: ZephyrTypography.fontSize14,
          fontWeight: ZephyrTypography.fontWeightMedium,
        ),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: ZephyrColors.neutral600,
        textStyle: TextStyle(
          fontSize: ZephyrTypography.fontSize14,
          fontWeight: ZephyrTypography.fontWeightMedium,
        ),
      ),
    );
  }
  
  BannerThemeData _createBannerTheme() {
    return BannerThemeData(
      backgroundColor: ZephyrColors.warning500,
      textColor: Colors.white,
      textStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: Colors.white,
      ),
      layoutDirection: TextDirection.ltr,
      location: BannerLocation.topEnd,
    );
  }
  
  StepperThemeData _createStepperTheme() {
    return StepperThemeData(
      color: ZephyrColors.primary500,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      margin: EdgeInsets.all(ZephyrSpacing.md),
      padding: EdgeInsets.all(ZephyrSpacing.md),
      connectorColor: ZephyrColors.neutral300,
      connectorThickness: 1.0,
      controlsColor: ZephyrColors.primary500,
      iconColor: ZephyrColors.primary500,
      disabledColor: ZephyrColors.neutral300,
      errorColor: ZephyrColors.error500,
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: ZephyrColors.neutral800,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral600,
      ),
      contentTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.neutral700,
      ),
    );
  }
  
  SwitchThemeData _createSwitchTheme() {
    return SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return ZephyrColors.neutral300;
          }
          if (states.contains(MaterialState.selected)) {
            return ZephyrColors.primary500;
          }
          return ZephyrColors.neutral400;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return ZephyrColors.neutral200;
          }
          if (states.contains(MaterialState.selected)) {
            return ZephyrColors.primary200;
          }
          return ZephyrColors.neutral300;
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  CheckboxThemeData _createCheckboxTheme() {
    return CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return ZephyrColors.neutral300;
          }
          if (states.contains(MaterialState.selected)) {
            return ZephyrColors.primary500;
          }
          return Colors.transparent;
        },
      ),
      overlayColor: MaterialStateProperty.all(ZephyrColors.primary100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZephyrRadius.xs),
      ),
      side: BorderSide(
        color: ZephyrColors.neutral400,
        width: 2.0,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
    );
  }
  
  RadioThemeData _createRadioTheme() {
    return RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return ZephyrColors.neutral300;
          }
          if (states.contains(MaterialState.selected)) {
            return ZephyrColors.primary500;
          }
          return Colors.transparent;
        },
      ),
      overlayColor: MaterialStateProperty.all(ZephyrColors.primary100),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
      mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
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
  final T Function() _creator;
  final List<void Function(T)> _modifiers = [];
  
  TestDataBuilder(this._creator);
  
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