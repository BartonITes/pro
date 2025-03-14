import 'package:flutter/material.dart';
import 'package:csi/home.dart';
import 'package:flutter/services.dart';
import 'package:csi/class_todo.dart';  // Import the cltodo class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'ToDoApp',
      debugShowCheckedModeBanner: false,
      // Passing a sample cltodo object to the Home widget
      home: Home(tasks:[cltodo(id: '01',todoitem: "task1", done:  true),
        cltodo(id: '02',todoitem: "task2", done:  true),
        cltodo(id: '03',todoitem: "task3"),]),
    );
  }
}
