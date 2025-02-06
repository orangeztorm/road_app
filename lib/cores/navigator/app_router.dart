import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._internal();

  static final AppRouter instance = AppRouter._internal();

  factory AppRouter() => instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final List<String> _route = <String>[];

  void addRoute(String route) => _route.add(route);

  void addRoutes(List<String> routes) => _route.addAll(routes);

  void clearRoutes() => _route.clear();

  bool shouldShowLoginOnLogOut = true;

  // Hack: Improve Later
  DateTime lastLogoutTimestamp = DateTime.now();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigate(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<dynamic> navigateToAndReplace(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateToAndReplacePage(Widget page) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<dynamic> clearRouteAndPush(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName('/'),
    );
  }

  void goBack([dynamic result]) {
    return navigatorKey.currentState!.pop(result);
  }

  Future<bool> maybePop([dynamic result]) async {
    return await navigatorKey.currentState!.maybePop();
  }

  bool hasRoutes() => _route.isNotEmpty;

  Future<dynamic> moveToNextRoute() {
    try {
      final String routeName = _route.removeAt(0);
      // if (_route.isNotEmpty) {
      //   return clearRouteAndPush(routeName);
      // }

      return navigateToAndReplace(routeName);
    } catch (e) {
      return navigateTo('/error');
    }
  }

  Future<void> logOut() async {
    final DateTime now = DateTime.now();

    final int difference = now.difference(lastLogoutTimestamp).inSeconds;
    if (difference < 1) return;

    if (!shouldShowLoginOnLogOut) return;
    lastLogoutTimestamp = DateTime.now();

    // AppRouter.instance.clearRouteAndPush(LoginView.routeName);
    // await navigatorKey.currentState!.pushNamedAndRemoveUntil(
    //   "/login",
    //   ModalRoute.withName('/login'),
    // );
  }
}
