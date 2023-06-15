import 'package:flutter/material.dart';
import 'package:notesapp/provider/provider.dart';
import 'package:notesapp/screens/notes_screens.dart';
import 'package:notesapp/utils/database_helper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: NotesApp(),
      ),
    );
  }
}
