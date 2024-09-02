
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_mate/app/flavors.dart';
import 'package:movie_mate/config/routes/navigator_observer.dart';
import 'package:movie_mate/features/home/presentation/pages/home_page.dart';

class RouterManager {
  static final config = GoRouter(
      observers: [
        CustomNavigatorObserver(),
      ],
      initialLocation: HomePage.path,
      routes: [
        GoRoute(
          path: HomePage.path,
          builder: (context, state) => const FlavorBanner(show: kDebugMode,
              child: HomePage()),
        ),

      ]);
}

class FlavorBanner extends StatelessWidget {
  final Widget child;
  final bool show;
  const FlavorBanner({super.key, required this.child, required this.show});

  @override
  Widget build(BuildContext context) {
    return show
        ? Banner(
      location: BannerLocation.topEnd,
      message: Flavor.appFlavor == FlavorType.development ? 'dev' : 'prod',
      color: Colors.green.withOpacity(0.6),
      textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12.0,
          letterSpacing: 1.0),
      textDirection: TextDirection.ltr,
      child: child,
    )
        : Container(
      child: child,
    );
  }
}