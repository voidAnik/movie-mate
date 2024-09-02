import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/app/app.dart';
import 'package:movie_mate/config/firebase_options.dart';
import 'package:movie_mate/app/flavors.dart';
import 'package:movie_mate/core/injection/injection_container.dart' as di;

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _firebaseInit();
  await di.init();

  runApp(const App());
}

Future<void> _firebaseInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseCrashlytics.instance.setCustomKey('Environment', Flavor.name);

  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
