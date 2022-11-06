import 'package:flutter/material.dart';
import 'package:restaurant_2_api/favorites_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final SharedPreferences shared;

  const SettingPage({super.key, required this.shared});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
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
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              subtitle: Text('Enable request notifications'),
              trailing: Switch(
                  value: _isSwitched,
                  onChanged: (val) {
                    setState(() {
                      _isSwitched = val;
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
