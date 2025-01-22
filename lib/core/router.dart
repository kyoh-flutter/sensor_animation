import 'package:go_router/go_router.dart';
import 'package:sensor_animation/feats/home/presentation/screens/home_screen.dart';
import 'package:sensor_animation/feats/sensor/presentation/screens/sensor_animation_screen.dart';

enum Paths {
  home,
  sensor;

  String get relativePath {
    switch (this) {
      case Paths.home:
        return '/';
      case Paths.sensor:
        return 'sensor';
    }
  }
}

final GoRouter router = GoRouter(
  initialLocation: Paths.home.relativePath,
  routes: <RouteBase>[
    GoRoute(
      path: Paths.home.relativePath,
      name: Paths.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: Paths.sensor.relativePath,
          name: Paths.sensor.name,
          builder: (context, state) => const SensorAnimationScreen(),
        ),
      ],
    ),
  ],
);
