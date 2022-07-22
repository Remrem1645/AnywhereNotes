import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:flutter/material.dart';

class NoteCreatorScreen extends StatefulWidget {
  const NoteCreatorScreen({Key? key}) : super(key: key);

  @override
  State<NoteCreatorScreen> createState() => _NoteCreatorScreenState();
}

class _NoteCreatorScreenState extends State<NoteCreatorScreen> {
  
  // ignore: non_constant_identifier_names
  int color_id = Random().nextInt(AppStyle.cardsColor.length);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? getuserID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Add a new Note", style: TextStyle( color: Colors.black)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration( 
                border: InputBorder.none,
                hintText: 'Note',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async { 
          FirebaseFirestore.instance
            .collection('users')
            .doc(getuserID())
            .collection('userNotes')
            .add({
              "note_title" : _titleController.text,
              "note_content":_mainController.text,
              "color_id":color_id
            }).then((value) {
              Navigator.pop(context);
            }).catchError(
              // ignore: invalid_return_type_for_catch_error, avoid_print
              (error) => print('Failed to add due to $error')
            );
        },
        child: const Icon(
          Icons.save,
          color: Colors.black,
          ),
      )
    );
  }
}