import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/screens/main_screen.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {

  //buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );

  Widget continueButton = TextButton(
    child: const Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Text("Continue"),
    ),
    onPressed:  () {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
    },
  );

  //AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('Sign out?'),
    content: const Text("Are you sure you want to sign out?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}