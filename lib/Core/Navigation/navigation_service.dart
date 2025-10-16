import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get _nav => navigatorKey.currentState!;

  static Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return _nav.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(String routeName, {Object? arguments, TO? result}) {
    return _nav.pushReplacementNamed<T, TO>(routeName, arguments: arguments, result: result);
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String newRouteName, RoutePredicate predicate, {Object? arguments}) {
    return _nav.pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments);
  }

  static void pop<T extends Object?>([T? result]) {
    if (_nav.canPop()) _nav.pop<T>(result);
  }

  static void popToHome() {
    _nav.popUntil((route) => route.settings.name == AppRoutes.home || route.isFirst);
  }
}


