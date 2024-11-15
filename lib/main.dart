// import 'dart:developer';
import 'dart:io';

import 'package:connectnext_app/utils/get_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'utils/routes.dart';
import 'utils/themedata.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      registerNotification();
    } else {
      _saveDeviceToken();
    }
    _subscribeToTopic();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  Future<void> registerNotification() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _saveDeviceToken();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {
      // print('User declined or has not accepted permission');
    }
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user

    // Get the token for this device
    String? fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      storeFcmToken(fcmToken);
    }
  }

  /// Subscribe the user to a topic
  _subscribeToTopic() async {
    // Subscribe the user to a topic
    _fcm.subscribeToTopic('app');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      initialRoute: '/',
      getPages: AppRoutes.routes,
      theme: Themes().lightTheme(),
    );
  }
}
