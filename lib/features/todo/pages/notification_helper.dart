import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../common/models/task_model.dart';
import 'view_note.dart';

class NotificationHelper {
  final WidgetRef ref;

  NotificationHelper({required this.ref});
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? selectedNotificationPayload;
  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  initilizeNotification() async {
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestSoundPermission: true,
            requestBadgePermission: true,
            onDidReceiveLocalNotification: onDidReceivedLocalNotification);
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("download");
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (data) async {
      debugPrint("notification payload ${data.payload}");
      selectNotificationSubject.add(data.payload);
    });
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    String timeZoneName = 'Asia/Karachi';
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future onDidReceivedLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
        context: ref.context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title ?? ""),
              content: Text(body ?? ""),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('View')),
              ],
            ));
  }

  scheduledNotification(int days, int hours, int minutes, int seconds,
      TaskModel taskModel) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      taskModel.id ?? 0,
      taskModel.title,
      taskModel.description,
      tz.TZDateTime.now(tz.local).add(Duration(
          days: days, hours: hours, minutes: minutes, seconds: seconds)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload:
          "${taskModel.title}|${taskModel.description}${taskModel.date}${taskModel.startTime}${taskModel.endTime}",
    );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      var title = payload!.split('|')[0];
      var body = payload.split('|')[1];
      showDialog(
          context: ref.context,
          builder: (BuildContext context) => AlertDialog(
                title: Text(title),
                content: Text(
                  body,
                  textAlign: TextAlign.justify,
                  maxLines: 4,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationsPage(
                                      payload: payload,
                                    )));
                      },
                      child: const Text('View')),
                ],
              ));
    });
  }
}
