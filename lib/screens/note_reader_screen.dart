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
  final GlobalKey<FormState> _formKeyTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyContent = GlobalKey<FormState>();

  String noteTitle = '';
  String noteContent = '';
  var disableEdit = true;


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

  Future updateDoc() async{
    var collection = 
      FirebaseFirestore.instance
        .collection('users')
        .doc(getuserID())
        .collection('userNotes');
    await collection.doc(widget.doc.id)
      .update({
        "note_title" : noteTitle,
        "note_content":noteContent,
      });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    int color_id = widget.doc['color_id'];
    
    return Scaffold(
      //Page style, Edit and Del buttons
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppStyle.textColor),
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
              child: Icon(
                Icons.delete,
                color: AppStyle.textColor,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                 setState(() {
                   disableEdit = !disableEdit;
                 });
              },
              child: Icon(
                Icons.edit,
                color: (disableEdit) ? Colors.black : Colors.black38,
              ),
            ),
          ),
        ],
      ),

      //Reader and Editor
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKeyTitle,
              child: TextFormField(
                initialValue: (noteTitle == '') ? widget.doc['note_title'] : noteTitle,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
                onSaved: (value) => setState(() => noteTitle = value!),
                style: AppStyle.mainTitle,
                readOnly: disableEdit,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Form(
              key: _formKeyContent,
              child: TextFormField(
                initialValue: (noteContent == '') ? widget.doc['note_content'] : noteContent,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Notes',
                ),
                onSaved: (value) => setState(() => noteContent = value!),
                style: AppStyle.mainContent,
                readOnly: disableEdit,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),  
      ),

      //Save Button
      floatingActionButton: Visibility(
        visible: !disableEdit,
        child: FloatingActionButton(
          backgroundColor: AppStyle.accentColor,
          onPressed: () { 
            setState(() {
              disableEdit = !disableEdit;
            });
            _formKeyTitle.currentState?.save();
            _formKeyContent.currentState?.save();          
            updateDoc();
          },
          child: Icon(
            Icons.save,
            color: AppStyle.textColor,
          ),
        ),
      ),
    );
  }
}