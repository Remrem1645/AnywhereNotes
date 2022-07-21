import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/screens/auth_screen.dart';
import 'package:firebaseflutternote/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{
  const MainPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snaphot){
          if (snaphot.hasData){
            return const HomeScreen();
          } 
          else{
            return const AuthPage();
          }
        },
      ),
    );
  }
}