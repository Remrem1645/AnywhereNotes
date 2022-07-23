import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutternote/style/app_style.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(9.0),
      margin: const EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc['note_title'], 
            style: AppStyle.mainTitle, 
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),  
          const SizedBox(height: 5.0,),
          Text(doc['note_content'], 
            style: AppStyle.mainContent, 
            maxLines: 4, 
            overflow: TextOverflow.ellipsis, 
          ),
        ],
      ),
    ),
  );
}