import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';
import '../pages/my_home_page.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: F.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlavorBanner(
        show: kDebugMode,
        child: MyHomePage(),
      ),
    );
  }


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
      message: F.name,
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

