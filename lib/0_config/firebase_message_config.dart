import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/message/i_message_repository.dart';

late final AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// To verify that your messages are being received, you ought to see a notification appearon your device/emulator via the flutter_local_notifications plugin.
/// Define a top-level named handler which background/terminated messages will
/// call. Be sure to annotate the handler with `@pragma('vm:entry-point')` above the function declaration.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showFlutterNotification(message);
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> showFlutterNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          priority: Priority.max,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Future<void> _addMessageListener() async {
  // 백그라운드에서 알람이 왔을 때 추가 동작
  // FirebaseMessaging.onBackgroundMessage(showFlutterNotification);

  // foreground 에서 알람이 왔을때 추가 동작
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('onMessage');
    // print(message);
    // showFlutterNotification(message);
  });

  // background 에서 앱이 켜졌을때 추가 동작
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print('onMessageOpenedApp');
    // print(message);
    // showFlutterNotification(message);
  });
  FirebaseMessaging.instance.onTokenRefresh.listen(_trySaveToken);
}

Future<void> _trySaveToken(String token) async {
  final msgRepo = Get.find<IMessageRepository>();
  final ret = await msgRepo.saveToken(token);
  ret.fold((l) => print, (r) => null);
}

Future<bool> _isMessagePermitted() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  return (settings.authorizationStatus == AuthorizationStatus.authorized);
}

Future<void> configMessage() async {
  if (!await _isMessagePermitted()) {
    return;
  }
  await setupFlutterNotifications();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  _addMessageListener();
  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) _trySaveToken(token);
}
