import 'package:firebaseflutternote/screens/home_screen.dart';
import 'package:firebaseflutternote/screens/setting_sreen.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:firebaseflutternote/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class NavDrawer extends StatelessWidget{

  final String currScreen;
  const NavDrawer({Key? key, required this.currScreen}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return 
    Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // ignore: sort_child_properties_last
            child: const Text(
              'AnyWhere Notes',
              style: TextStyle(fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: AppStyle.accentColor,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen())) },
            selected: (currScreen == "Home_Screen") ? true : false,
            selectedColor: AppStyle.accentColor,
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen())) },
            selected: (currScreen == "Setting_Screen") ? true : false,
            selectedColor: AppStyle.accentColor,
          ),

          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {showAlertDialog(context)},
          ),
        ],
      ),
    );
  }
}