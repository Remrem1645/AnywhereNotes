import 'package:firebaseflutternote/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';

import '../style/app_themes.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawer: NavDrawer( currScreen: currentScreen,),

      appBar: AppBar(
        iconTheme: IconThemeData(color:  AppStyle.textColor),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),

      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Common', style: TextStyle(),),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.phone_android),
                initialValue: themeProvider.isDarkMode,
                onToggle: (value) {
                  final provider = Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(value);
                }
              ),
            ],
          ),
        ],
      ) ,
    );
  }
}

