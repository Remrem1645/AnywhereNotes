import 'package:firebaseflutternote/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widgets/side_bar_menu.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  var currentScreen = "Setting_Screen";
  var darkmode = false;
  
  bool darkmodeToggle() {
      return darkmode = !darkmode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,

      drawer: NavDrawer( currScreen: currentScreen,),

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.mainColor,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common', style: TextStyle(color: AppStyle.textColor ),),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.phone_android),
                initialValue: darkmode,
                onToggle: (value) {
                  setState(() {
                    darkmodeToggle();
                });
                }, 
              ),
            ],
          ),
        ],
      ) ,
    );
  }
}

