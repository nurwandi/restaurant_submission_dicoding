import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeNotifications() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'canal_principal',
        channelKey: 'canal_principal',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupName: 'basic chanel', channelGroupKey: 'canal_principal'),
    ],
    debug: true,
  );

  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  final calendar = NotificationCalendar(
    hour: 11,
    allowWhileIdle: true,
    preciseAlarm: true,
  );

  final shared = await SharedPreferences.getInstance();

  final bool notificationsSetting =
      shared.getBool("NotificationSetting") ?? false;

  if (notificationsSetting) {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'canal_principal',
          title: shared.getString('title'),
          body: shared.getString('body'),
          wakeUpScreen: true,
          category: NotificationCategory.Reminder,
          // notificationLayout: NotificationLayout.BigPicture,
          payload: {'uuid': 'uuid-test'},
          autoDismissible: false,
        ),
        schedule: calendar);
  } else {
    AwesomeNotifications().cancelAllSchedules();
  }
}
