import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/config/routes/router_manager.dart';
import 'package:movie_mate/config/theme/theme.dart';
import 'package:movie_mate/core/language/app_language.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: _materialRouter(context),
    );
  }

  MaterialApp _materialRouter(BuildContext context) {
    return MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: RouterManager.config,
        debugShowCheckedModeBanner: false,
        title: Flavor.title,
        theme:AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      );
  }
}

