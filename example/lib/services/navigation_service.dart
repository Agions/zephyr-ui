import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> navigateTo<T>(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> navigateToAndReplace<T>(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context)
        .pushReplacementNamed<T, Object?>(routeName, arguments: arguments);
  }

  void navigateBack<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  Future<T?> navigateToAndRemoveUntil<T>(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void showSnackBar(BuildContext context, String message,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<T?> showDialog<T>(BuildContext context, Widget dialog) {
    return showDialog<T>(
      context: context,
      builder: (context) => dialog,
    );
  }

  Future<T?> showBottomSheet<T>(BuildContext context, Widget bottomSheet) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => bottomSheet,
    );
  }
}
