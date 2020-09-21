import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebasestarter/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZonedGuarded<Future<void>>(
    () async {
      runApp(
        ProviderScope(child: App()),
      );
    },
    (Object error, StackTrace stackTrace) =>
        Crashlytics.instance.recordError(error, stackTrace),
  );
}
