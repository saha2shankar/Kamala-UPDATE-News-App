import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kamala_update/firebase_options.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    //initialize firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    //Request Permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted Permission");
    } else {
      print("User declined or has not accepted permission");
    }

//Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

//Handle foreground  message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message in the foreground ');
      _showNotification(message);
    });

//Handle Background Message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<String> getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM TOKEN: $token');
    return token ?? "";
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    _showNotification(message);
  }

  static void _showNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high);
    const NotificationDetails platformChannelSpecifies =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(0, message.notification?.title,
        message.notification?.body, platformChannelSpecifies);
  }
}
