import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/favorites_page.dart';
import 'package:restaurant_2_api/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/implement_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize('', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Restaurant Notification',
      channelDescription: 'Have a look our restaurant recommendation!',
      defaultColor: Colors.blue,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    )
  ]);
  final pref = await SharedPreferences.getInstance();
  runApp(MyApp(shared: pref));
}

class MyApp extends StatelessWidget {
  final SharedPreferences shared;
  const MyApp({super.key, required this.shared});

  @override
  Widget build(BuildContext context) {
    final bloc = ImplementBloc(shared)
      ..add(GetAllRestaurant())
      ..add(CheckConection());
    return MaterialApp(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                const TextTheme(bodyText2: TextStyle(color: Colors.white)),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xFF0777a7),
                secondary: const Color(0xFF94d4ef)),
            backgroundColor: Colors.white),
        routes: {
          '/': (BuildContext context) => BlocProvider.value(
                value: bloc,
                child: HomePage(shared: shared),
              ),
          '/favorites': (BuildContext context) => BlocProvider.value(
                value: bloc,
                child: Favorites(
                  shared: shared,
                ),
              ),
        });
  }
}
