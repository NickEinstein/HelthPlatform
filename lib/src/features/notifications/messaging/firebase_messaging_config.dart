import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../../../utils/packages.dart';
import '../../../routes/routes.dart';
import '../../chats/presentation/model/widget/show_incoming_call.dart';
import '../model/notification_model.dart' as notification;
import 'background_service.dart';

abstract class NotificationRepository {
  Future<void> initializeFirebase(WidgetRef ref);
  Future<void> initializeLocalNotifications();
  Future<void> requestPermission();
  Future<String?> getFCMToken();
  Future<void> subscribeToTopic(String topic);
  Future<void> displayLocalNotification(RemoteNotification message);
  void handleNotificationTap(NotificationResponse response);
  void handleNotificationOnOpenApp(RemoteMessage message);
}

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl._privateConstructor();

  static final NotificationRepositoryImpl _instance =
      NotificationRepositoryImpl._privateConstructor();

  factory NotificationRepositoryImpl() {
    return _instance;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String firebaseToken = '';
  static const String darwinNotificationCategoryPlain = 'plainCategory';

  // final _debouncer = Debouncer(milliseconds: 250);
  // final UtilityService _utilityService = locator<UtilityService>();
  // final NavigationService _navigationService = locator<NavigationService>();
  Future<void> initializeFirebase(WidgetRef ref) async {
    try {
      await requestPermission();

      if (Platform.isIOS) {
        final String? apnsToken = await _firebaseMessaging.getAPNSToken();
        debugPrint('✅ APNS Token: $apnsToken');
        await Future.delayed(const Duration(seconds: 2));
      }

      final String? token = await _firebaseMessaging
          .getToken()
          .timeout(const Duration(seconds: 5), onTimeout: () {
        debugPrint("❌ Timeout while getting FCM token");
        return null;
      });

      debugPrint('✅ FCM Token: $token');
      firebaseToken = token ?? '';

      await _firebaseMessaging
          .subscribeToTopic('all')
          .timeout(const Duration(seconds: 3), onTimeout: () {
        debugPrint("❌ Timeout subscribing to topic");
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final data = message.data;

        if (data['type'] == 'incoming_call') {
          final channelName = data['channelName'];
          final callerName = data['callerName'];

          final context = rootNavigatorKey.currentContext;
          if (context != null) {
            showIncomingCallDialog(ref, context, channelName, callerName);
          }
        }

        if (message.notification != null) {
          await displayLocalNotification(message.notification!);
        }
      });

      FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        try {
          handleNotificationOnOpenApp(message);
        } catch (e) {
          debugPrint("❌ Error in onMessageOpenedApp: $e");
        }
      });

      debugPrint("✅ Firebase initialized");
    } catch (e) {
      debugPrint("❌ Firebase init error: $e");
    }
  }

  @override
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('logo'); // Changed here

    final DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            notificationCategories: <DarwinNotificationCategory>[
          DarwinNotificationCategory(darwinNotificationCategoryPlain,
              actions: <DarwinNotificationAction>[
                DarwinNotificationAction.plain(
                  'navigationActionId',
                  'Action 3 (foreground)',
                  options: <DarwinNotificationActionOption>{
                    DarwinNotificationActionOption.foreground
                  },
                ),
              ])
        ]);

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitSettings, iOS: iosInitSettings);

    await _localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: handleNotificationTap);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'important_channel', 'Important Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
        playSound: true);

    if (Platform.isAndroid) {
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } else {
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  @override
  void handleNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      var result = json.decode(payload);
      final timestamp = DateTime.now().toIso8601String();
      notification.PushNotificationItemOnTap pushNotificationItemOnTap =
          notification.PushNotificationItemOnTap(
              title: result['title'] ?? '',
              body: result['body'] ?? '',
              timeStamp: timestamp);
    }
  }

  @override
  void handleNotificationOnOpenApp(RemoteMessage message) {
    final timestamp = DateTime.now().toIso8601String();
    notification.PushNotificationItemOnTap pushNotificationItemOnTap =
        notification.PushNotificationItemOnTap(
            title: message.notification?.title ?? '',
            body: message.notification?.body ?? '',
            timeStamp: timestamp);
  }

  @override
  Future<void> requestPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
              alert: true,
              announcement: true,
              badge: true,
              carPlay: false,
              criticalAlert: true,
              provisional: false,
              sound: true);

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        openAppSettings();
      }
    } else if (Platform.isAndroid) {
      final NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        openAppSettings();
      }
    }
  }

  @override
  Future<String?> getFCMToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
    } catch (_) {}
  }

  Future<void> displayLocalNotification(RemoteNotification message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'important_channel',
      'Important Notifications',
      channelDescription: 'This channel is for some important notifications.',
      importance: Importance.max,
      // priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      message.title,
      message.body,
      notificationDetails,
      payload: json.encode(message.toMap()),
    );
  }
}
