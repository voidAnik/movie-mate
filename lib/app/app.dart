import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/core/language/app_language.dart';
import 'package:movie_mate/core/theme/theme.dart';

import '../pages/my_home_page.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return el.EasyLocalization(
      supportedLocales: AppLanguage.all,
      path: AppLanguage.path,
      fallbackLocale: AppLanguage.english,
      startLocale: AppLanguage.english,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Flavor.title,
        theme:AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const FlavorBanner(
          show: kDebugMode,
          child: MyHomePage(),
        ),
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
