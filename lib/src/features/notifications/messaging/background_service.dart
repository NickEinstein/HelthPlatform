import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_messaging_config.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
    if (message.notification != null) {
      await NotificationRepositoryImpl()
          .displayLocalNotification(message.notification!);
    }
  }
