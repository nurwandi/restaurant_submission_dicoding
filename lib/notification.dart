import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:restaurant_2_api/notification_utilities.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

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

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'canal_principal',
        title: 'Just in time!',
        body: 'This notification was schedule to shows at ',
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        // notificationLayout: NotificationLayout.BigPicture,
        payload: {'uuid': 'uuid-test'},
        autoDismissible: false,
      ),
      schedule: NotificationCalendar.fromDate(
          date: DateTime.now().add(Duration(seconds: 10)),
          allowWhileIdle: true,
          repeats: true));
}

// Future<void> createRestaurantNotification() async {
//   await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: createUniqueId(),
//           channelKey: 'basic_channel',
//           title:
//               '${Emojis.money_money_bag + Emojis.building_cityscape} Most Visited Bistro!!',
//           body: 'This description is used for showing dummy text restaurant',
//           notificationLayout: NotificationLayout.BigPicture
//           // bigPicture:
//           ));
// }

// Future<void> createReminderNotification(
//     NotificationWeekAndTime notificationSchedule) async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: createUniqueId(),
//       channelKey: 'scheduled_channel',
//       title:
//           '${Emojis.food_pizza + Emojis.building_cityscape} RECOMMENDED RESTAURANT!',
//       body: 'This description is used for showing dummy text restaurant',
//       notificationLayout: NotificationLayout.Default,
//     ),
//     actionButtons: [
//       NotificationActionButton(
//         key: 'MARK_DONE',
//         label: 'Mark Done',
//       )
//     ],
//     schedule: NotificationCalendar(
//       repeats: true,
//       weekday: notificationSchedule.dayOfTheWeek,
//       hour: notificationSchedule.timeOfDay.hour,
//       minute: notificationSchedule.timeOfDay.minute,
//       second: 0,
//       millisecond: 0,
//     ),
//   );
// }

// Future<void> cancelScheduledNotifications() async {
//   await AwesomeNotifications().cancelAllSchedules();
// }

// Future<void> initializeNotifications() async {
//   await AwesomeNotifications().initialize(
//     null,
//     [
//       NotificationChannel(
//           channelGroupKey: 'canal_principal',
//           channelKey: 'canal_principal',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic tests',
//           defaultColor: const Color(0xFF9D50DD),
//           ledColor: Colors.white,
//           importance: NotificationImportance.High),
//     ],
//     channelGroups: [
//       NotificationChannelGroup(
//           channelGroupName: 'basic chanel', channelGroupKey: 'canal_principal'),
//     ],
//     debug: true,
//   );

//   await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//     if (!isAllowed) {
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   });

//   await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 1,
//         channelKey: 'scheduled',
//         title: 'Just in time!',
//         body: 'This notification was schedule to shows at ',
//         wakeUpScreen: true,
//         category: NotificationCategory.Reminder,
//         notificationLayout: NotificationLayout.BigPicture,
//         bigPicture: null,
//         payload: {'uuid': 'uuid-test'},
//         autoDismissible: false,
//       ),
//       schedule: NotificationCalendar.fromDate(
//           date: DateTime.now().add(Duration(seconds: 1)),
//           allowWhileIdle: true,
//           repeats: true));
// }
