import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseflutternote/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

