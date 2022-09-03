import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutternote/screens/note_creator_screen.dart';
import 'package:firebaseflutternote/screens/note_reader_screen.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:firebaseflutternote/widgets/note_card.dart';
import 'package:firebaseflutternote/widgets/side_bar_menu.dart';
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

  var currentScreen = "Home_Screen";

  @override
  Widget build(BuildContext context) {

    final textcolor = MediaQuery.of(context).platformBrightness == Brightness.dark
      ? 'DarkTheme'
      : 'LightTheme';

    return Scaffold(

      drawer: NavDrawer( currScreen: currentScreen,),

      //Title and logout
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          iconTheme: IconThemeData(color: AppStyle.textColor),
          elevation: 5.0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Notes", 
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).secondaryHeaderColor
            ),
          ),
          centerTitle: true,
        ),
      ),
      
      //Notepads
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(user.uid).collection('userNotes').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasData){
                    return GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2
                      ),
                      children: snapshot.data!.docs.map((note) => noteCard(() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => 
                            NoteReaderScreen(note), 
                          )
                        );
                      }, 
                      note)).toList(),
                    );
                  }
                  return Text("There is nothing yet...", style: GoogleFonts.nunito(color: AppStyle.textColor) ,);
                },
              ),
            ),
          ],
        ),
      ),

      //Create new button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoteCreatorScreen()));
        }, 
        label: Text(
          "Add Note",
          style: TextStyle (
            color: AppStyle.textColor, 
          ),
        ),
        icon: Icon(
          Icons.add,
          color: AppStyle.textColor,
        ),
        backgroundColor: AppStyle.accentColor,
      ),
    );
  }
}
