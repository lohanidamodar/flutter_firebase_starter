import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:firebasestarter/core/presentation/res/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class AppAnalyticsEvents {
  static const String logOut = "log_out";

}

class AnalyticsScreenNames {
  static const String welcome = "Welcome page";
  static const String splash = "Splash screen";
  static const String login = "Login Screen";
  static const String userInfo = "User profile";
  static const String root = "Root page";

}

FirebaseAnalytics _getAnalytics(BuildContext context) => Provider.of<FirebaseAnalytics>(context, listen: false);

Future<void> logEvent(BuildContext context, String name, {Map<String,dynamic> params}) {
  if(!kIsWeb)
    return _getAnalytics(context).logEvent(name: name, parameters: params);
  return null;
}

Future<void> setCurrentScreen(BuildContext context, String name) {
  if(!kIsWeb)
    return _getAnalytics(context).setCurrentScreen(screenName: name);
  return null;
}

Future<void> setUserProperties(BuildContext context, {String id, String name, String email}) async {
  if(!kIsWeb) {
    await _getAnalytics(context).setUserId(id);
    await _getAnalytics(context).setUserProperty(name: "email", value: email);
    await _getAnalytics(context).setUserProperty(name: "name", value: name);
  }
  return;

}

String analyticsNameExtractor(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.userInfo:
      return AnalyticsScreenNames.userInfo;
    case AppRoutes.login:
      return AnalyticsScreenNames.login;
    case AppRoutes.splash:
      return AnalyticsScreenNames.splash;
    case AppRoutes.home:
    default:
      return AnalyticsScreenNames.root;
      
  }
}