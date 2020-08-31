import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebasestarter/core/presentation/res/app_config.dart';
import 'package:firebasestarter/core/presentation/res/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebasestarter/features/auth/data/model/user_repository.dart';
import 'package:firebasestarter/features/notification/data/service/push_notification_service.dart';

final analyticsProvider = Provider((ref) => FirebaseAnalytics());
final pnProvider = Provider((ref) => PushNotificationService());

final userRepoProvider = ChangeNotifierProvider<UserRepository>((ref) {
  final notifService = ref.watch(pnProvider);
  return UserRepository.instance(notifService);
});
final configProvider = Provider<AppConfig>((ref) => AppConfig(
      appTitle: AppConstants.appName,
      buildFlavor: AppFlavor.prod,
    ));
