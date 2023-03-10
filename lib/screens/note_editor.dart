// ignore_for_file: unused_field, prefer_final_fields

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/style/app_style.dart';
import 'package:flutter/material.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({super.key});

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  int color_code = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_code],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[color_code],
        elevation: 0,
        title: Text("Add a New Note",style:TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8,),
            Text(date,style:AppStyle.dateTitle),
            SizedBox(height:28),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Content",
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: AppStyle.accentColor,
      onPressed: () async{
        FirebaseFirestore.instance.collection("notes").add({
          "note_title":_titleController.text,
          "creation_date":date,
          "note_content":_mainController.text,
          "color_id":color_code
        }).then((value) => {
          Navigator.pop(context)}
        ).catchError((error)=>print("Failed to add"));
      },
      child: Icon(Icons.save),
      ),
    );
  }
}