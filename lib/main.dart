import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebasestarter/app.dart';
import 'package:firebasestarter/core/presentation/res/app_config.dart';
import 'package:firebasestarter/core/presentation/res/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'core/presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kIsWeb) {
    runApp(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          location: BannerLocation.topEnd,
          message: "dev",
          textDirection: TextDirection.ltr,
          child: ProviderScope(
            child: App(),
            overrides: [
              configProvider.overrideWithProvider(Provider(
                (ref) => AppConfig(
                  appTitle: AppConstants.appNameDev,
                  buildFlavor: AppFlavor.dev,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  } else {
    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    runZoned(() {
      runApp(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Banner(
            location: BannerLocation.topEnd,
            message: "dev",
            textDirection: TextDirection.ltr,
            child: ProviderScope(
              child: App(),
              overrides: [
                configProvider.overrideWithProvider(Provider(
                  (ref) => AppConfig(
                    appTitle: AppConstants.appNameDev,
                    buildFlavor: AppFlavor.dev,
                  ),
                ))
              ],
            ),
          ),
        ),
      );
    }, onError: Crashlytics.instance.recordError);
  }
}
