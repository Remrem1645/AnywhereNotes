import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:flutter/material.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  
  // ignore: non_constant_identifier_names
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
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
        padding: const EdgeInsets.all(8.0),
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

            const SizedBox(height: 8.0,),
            Text(date, style: AppStyle.dateTitle),
            const SizedBox(height: 28.0),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration( 
                border: InputBorder.none,
                hintText: 'Note',
              ),
              style: AppStyle.mainContent,
            )

          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async { 
          FirebaseFirestore.instance
            .collection('notes')
            .doc(getuserID())
            .collection('userNotes')
            .add({
              "note_title" : _titleController.text,
              "creation_date": date,
              "note_content":_mainController.text,
              "color_id":color_id
            }).then((value) {
              Navigator.pop(context);
            }).catchError(
              // ignore: invalid_return_type_for_catch_error, avoid_print
              (error) => print('Failed to add due to $error')
            );
        },
        child: const Icon(Icons.save),
      )
    );
  }
}