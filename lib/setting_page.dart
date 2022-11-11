import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/implement_bloc.dart';
import 'notification.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    context.read<ImplementBloc>().add(GetNotificationSettings());
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Qolbi Nurwandi Yunus'),
              accountEmail: Text('p516x1099@dicoding.org'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                    child: Image.network(
                  'https://i.pinimg.com/736x/5f/01/10/5f011035deca9d28f8bb7858ccb5f5f7.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                )),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
                      fit: BoxFit.cover)),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pushNamed(context, '/favorites');
                context.read<ImplementBloc>().add(GerFavouriteRestaurants());
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              subtitle: Text('Enable request notifications'),
              trailing: BlocBuilder<ImplementBloc, ImplementState>(
                builder: (context, state) {
                  if (state is NotificationSettingState) {
                    isSwitched = state.state;
                  }
                  return Switch(
                      value: isSwitched,
                      onChanged: (val) async {
                        initializeNotifications();
                        context
                            .read<ImplementBloc>()
                            .add(StoreNotificationSetting(!val));
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
