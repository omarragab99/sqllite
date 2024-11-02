import 'package:flutter/material.dart';
import 'package:sqllite/addnotes.dart';
import 'package:sqllite/edit.dart';

import 'package:sqllite/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        "addnote" :(context) => AddNotes(),
        "home" :(context) => Home(),
        "edit":(context) => Edit(),
      },
    );
  }
}