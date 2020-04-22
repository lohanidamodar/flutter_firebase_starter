import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebasestarter/core/presentation/res/analytics.dart';
import 'package:firebasestarter/core/presentation/res/app_config.dart';
import 'package:firebasestarter/core/presentation/res/routes.dart';
import 'package:firebasestarter/features/auth/presentation/pages/home.dart';
import 'package:firebasestarter/generated/l10n.dart';

import 'core/presentation/providers/providers.dart';
import 'core/presentation/res/themes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppThemes.context = context;
    return MultiProvider(
      providers: providers,
      child: Consumer<FirebaseAnalytics>(builder: (context, analytics, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Provider.of<AppConfig>(context).appTitle,
          theme: AppThemes.defaultTheme,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          navigatorObservers: [
            FirebaseAnalyticsObserver(
              analytics: analytics,
              nameExtractor: analyticsNameExtractor,
            )
          ],
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: AuthHomePage(),
        );
      }),
    );
  }
}
