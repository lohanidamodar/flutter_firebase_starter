import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as dev;

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool initialized = false;
  String? token;

  PushNotificationService();

  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  Future<String?> init() async {
    if (!initialized) {
      if (Platform.isIOS) {
        _requestPermission();
      }
      FirebaseMessaging.onMessage.listen((message) {
        dev.log("notification onMessage", error: message, time: DateTime.now());
        return;
      });

      RemoteMessage? message = await _firebaseMessaging.getInitialMessage();
      dev.log("notification onMessage", error: message, time: DateTime.now());

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        dev.log("notification onMessage", error: message, time: DateTime.now());
      });
      token = await _firebaseMessaging.getToken();
      if (token != null) {
        initialized = true;
      }
      dev.log("token", error: token);
      return token;
    }
    return token;
  }

  FutureOr<bool> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
