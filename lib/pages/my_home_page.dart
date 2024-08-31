import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/app/flavors.dart';

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
          onTap: () {
            FirebaseCrashlytics.instance.crash();
          },
          child: Text(
            'Hello ${Flavor.title}',
          ),
        ),
      ),
    );
  }
}
