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
