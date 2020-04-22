import 'package:flutter/material.dart';
import 'package:firebasestarter/core/presentation/res/analytics.dart';
import 'package:firebasestarter/features/home/presentation/pages/home.dart';
import 'package:firebasestarter/features/onboarding/presentation/pages/intro.dart';
import '../../data/model/user_repository.dart';
import 'package:provider/provider.dart';
import './splash.dart';
import './login.dart';

class AuthHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Unauthenticated:
            case Status.Authenticating:
              setCurrentScreen(context, AnalyticsScreenNames.welcome);
              return WelcomePage();
            case Status.Authenticated:
              setUserProperties(context,id: user.fbUser?.uid, name: user.fbUser?.displayName, email: user.fbUser?.email);
              setCurrentScreen(context, AnalyticsScreenNames.userInfo);
              if(user.isLoading) return Splash();
              return user.user?.introSeen ?? false ? HomePage() : IntroPage();
            case Status.Uninitialized:
            default:
              setCurrentScreen(context, AnalyticsScreenNames.splash);
              return Splash();
          }
        },
      );
  }
}
