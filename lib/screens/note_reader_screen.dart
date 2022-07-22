import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  String? getuserID() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid;
  }

  Future removeDoc() async{
    var collection = 
      FirebaseFirestore.instance
        .collection('users')
        .doc(getuserID())
        .collection('userNotes');
    await collection.doc(widget.doc.id).delete();
  }



  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    int color_id = widget.doc['color_id'];
    
    return Scaffold(
      
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () { 
                removeDoc();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ), 
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc['note_title'], style: AppStyle.mainTitle,),  
            const SizedBox(height: 18.0,),
            Text(widget.doc['note_content'], style: AppStyle.mainContent,)
          ]
        ),
      ),
    );
  }
}