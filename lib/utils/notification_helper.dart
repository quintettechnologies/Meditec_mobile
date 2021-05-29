import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static void showNotification({
    String title,
    String body,
  }) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.',
        icon: 'ic_launcher',
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('arrive'));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}
