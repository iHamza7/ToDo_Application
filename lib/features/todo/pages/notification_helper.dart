import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationHelper {
  final WidgetRef ref;

  NotificationHelper({required this.ref});
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? selectedNotificationPayload;
  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();
}
