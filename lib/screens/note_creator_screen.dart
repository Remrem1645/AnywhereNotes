import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      //Page Style
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppStyle.textColor),
        title: Text("Add a new Note", style: TextStyle( color: AppStyle.textColor)),
      ),

      //Title and notes
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
                hintStyle: GoogleFonts.roboto(fontSize: 19.0, fontWeight: FontWeight.normal, color: Colors.black),
              ),
              style: GoogleFonts.roboto(fontSize: 19.0, fontWeight: FontWeight.normal, color: Colors.black),
            ),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration( 
                border: InputBorder.none,
                hintText: 'Note',
                hintStyle: GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
              ),
              style: GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
            ),
          ],
        ),
      ),

      //Adds data into Firebase Database
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
        child: Icon(
          Icons.save,
          color: AppStyle.textColor,
        ),
      ),
    );
  }
}