import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as dev;

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool initialized = false;
  String token;

  PushNotificationService();

  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  Future<String> init() async {
    if(!initialized) {

      if(Platform.isIOS) {
        _requestPermission();
      }
      _firebaseMessaging.configure(
        onMessage: (Map<String,dynamic> message) {
          dev.log("notification onMessage",error: message,time: DateTime.now());
          return;
        },
        onResume: (Map<String,dynamic> message) {
          dev.log("notification onMessage",error: message,time: DateTime.now());
          return;
        },
        onLaunch: (Map<String,dynamic> message) {
          dev.log("notification onMessage",error: message,time: DateTime.now());
          return;
        },
      );
      token =  await _firebaseMessaging.getToken();
      if(token != null) {
        initialized = true;
      }
      dev.log("token",error: token);
      return token;
    }
    return token;
  }

  FutureOr<bool> _requestPermission() {
    return _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: false,
      )
    );
  }
}
