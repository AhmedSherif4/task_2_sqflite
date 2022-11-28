import 'package:flutter/material.dart';

import '../screens/splash_screen/splash_view.dart';
import '../screens/task_2_screen/task_view.dart';
import 'string_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String taskRoute = 'task';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.taskRoute:
        return MaterialPageRoute(builder: (_) => const TaskView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => unDefinedView(),
    );
  }

  static Widget unDefinedView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Center(
        child: Text(AppStrings.noRouteFound),
      ),
    );
  }
}
