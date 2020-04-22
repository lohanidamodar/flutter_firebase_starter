import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:firebasestarter/features/auth/data/model/user_repository.dart';
import 'package:firebasestarter/features/notification/data/service/push_notification_service.dart';

List<SingleChildWidget> providers = [
  Provider<FirebaseAnalytics>(
    create: (_) => FirebaseAnalytics(),
  ),
  Provider<PushNotificationService>(
    create: (context) => PushNotificationService(),
  ),
  Consumer<PushNotificationService>(
    builder: (context, notifService, child) {
      return ChangeNotifierProvider<UserRepository>(
        create: (_) => UserRepository.instance(notifService),
        child: child,
      );
    },
  )
];
