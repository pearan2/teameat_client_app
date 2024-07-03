import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

enum MessageHelperCallbackType {
  inApp,
  openApp,
}

class MessageWrapper {
  final RemoteMessage remoteMessage;
  final MessageHelperCallbackType callbackType;

  MessageWrapper._({required this.remoteMessage, required this.callbackType});

  factory MessageWrapper.fromInApp(RemoteMessage remoteMessage) {
    return MessageWrapper._(
        remoteMessage: remoteMessage,
        callbackType: MessageHelperCallbackType.inApp);
  }

  factory MessageWrapper.fromOpenApp(RemoteMessage remoteMessage) {
    return MessageWrapper._(
        remoteMessage: remoteMessage,
        callbackType: MessageHelperCallbackType.openApp);
  }
}

class MessageHelper {
  static Duration retryDuration = const Duration(seconds: 1);

  static final _messages = <MessageWrapper>[];
  static bool Function(MessageWrapper)? consumeCallback;

  static late final AndroidNotificationChannel _channel;
  static bool _isFlutterLocalNotificationsInitialized = false;
  static bool _isListenerAdded = false;
  static late final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin;

  static Future<void> _setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }
    _channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _isFlutterLocalNotificationsInitialized = true;
  }

  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  static Future<bool> isMessagePermitted() async {
    final notificationSetting =
        await FirebaseMessaging.instance.getNotificationSettings();
    return (notificationSetting.authorizationStatus ==
        AuthorizationStatus.authorized);
  }

  static Future<bool> _requestPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
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

  // main 에서 호출되어야 한다. 그래야 안드로이드에서 정상적으로 동작한다.
  // ios 는 17버전에서는 동작하며 16버전에서는 동작하지 않음.
  static void startConsumeInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        _push(MessageWrapper.fromOpenApp(event));
      }
    });
  }

  static Future<void> _addMessageListener() async {
    if (_isListenerAdded) return;

    // foreground 에서 알람이 왔을때 추가 동작 (android 의 경우 추가 동작 필요)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (GetPlatform.isAndroid) {
        // 안드의 경우만 따로 보여줘야함
        _showFlutterNotification(message);
      }
      _push(MessageWrapper.fromInApp(message));
    });
    // background 에서 앱이 켜졌을때 추가 동작 (terminated 에서 켜졌을때는 동작하지 않음)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _push(MessageWrapper.fromOpenApp(message));
    });
    _isListenerAdded = true;
  }

  static Future<String?> getToken() async {
    if (GetPlatform.isWeb) {
      return null;
    } else {
      return FirebaseMessaging.instance.getToken();
    }
  }

  static void startUpdateToken(void Function(String token) updater) {
    getToken().then((token) {
      if (token != null) {
        updater(token);
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen(updater);
  }

  static Future<void> subscribeTopic(String topic) async {
    if (GetPlatform.isWeb) return;
    return FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static Future<void> unSubscribeTopic(String topic) async {
    if (GetPlatform.isWeb) return;
    return FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  static Future<bool> configMessage() async {
    final isPermitted = await _requestPermission();
    await _setupFlutterNotifications();
    _addMessageListener();
    return isPermitted;
  }

  static void _push(MessageWrapper message) {
    _messages.add(message);
    _tryConsume();
  }

  static void _tryConsume() {
    if (_messages.isEmpty || consumeCallback == null) {
      return _reTryConsumeAfterDuration();
    }
    final message = _messages.removeAt(0);
    final isConsumed = consumeCallback!(message);
    if (isConsumed) {
      /// 정상적으로 처리되었다면
      if (_messages.isNotEmpty) {
        _reTryConsumeAfterDuration();
      }
      return;
    } else {
      /// 정상적으로 처리되지 않았다면
      _messages.add(message);
      _reTryConsumeAfterDuration();
      return;
    }
  }

  static void _reTryConsumeAfterDuration() {
    Timer(retryDuration, _tryConsume);
  }
}
