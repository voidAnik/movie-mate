import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/config/routes/router_manager.dart';
import 'package:movie_mate/config/theme/theme.dart';
import 'package:movie_mate/core/language/app_language.dart';

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
      child: MaterialApp.router(
        routerConfig: RouterManager.config,
        debugShowCheckedModeBanner: false,
        title: Flavor.title,
        theme:AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}

