import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:restaurant_2_api/notification_utilities.dart';

Future<void> createRestaurantNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_channel',
          title:
              '${Emojis.money_money_bag + Emojis.building_cityscape} Most Visited Bistro!!',
          body: 'This description is used for showing dummy text restaurant',
          notificationLayout: NotificationLayout.BigPicture
          // bigPicture:
          ));
}

Future<void> createReminderNotification(
    NotificationWeekAndTime notificationSchedule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title:
          '${Emojis.food_pizza + Emojis.building_cityscape} RECOMMENDED RESTAURANT!',
      body: 'This description is used for showing dummy text restaurant',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      )
    ],
    schedule: NotificationCalendar(
      repeats: true,
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
    ),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
