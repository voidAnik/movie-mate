import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/app/flavors.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/features/home/data/data_sources/home_remote_data_provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Flavor.title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
           final response = await getIt<HomeDataProviderImpl>().getTrendingMovies(5);
           log('response: $response');
          },
          child: Text(
            'Hello ${Flavor.title}',
          ),
        ),
      ),
    );
  }
}
