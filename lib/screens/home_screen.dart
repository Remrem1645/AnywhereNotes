import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/screens/note_editor_screen.dart';
import 'package:firebaseflutternote/screens/note_reader_screen.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:firebaseflutternote/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  String getuserID() {
    final uid = user.uid;
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "AnyWhere Notes", 
          style: TextStyle(
            color: Colors.black87,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),

      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Text(
              "  Your recent Notes",
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                  color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20,),
            ),
            const SizedBox(
              height: 10.0,
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("notes").doc(user.uid).collection('userNotes').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasData){
                    return GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                      children: snapshot.data!.docs.map((note) => noteCard(() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => 
                            NoteReaderScreen(note), 
                          )
                        );
                      }, note) ).toList(),
                    );
                  }
                  return Text("There is nothing yet...", style: GoogleFonts.nunito(color: Colors.black87) ,);
                },
              ),
            ),

            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepOrange[200],
              child: const Text('SignOut'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoteEditorScreen()));
        }, 
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
