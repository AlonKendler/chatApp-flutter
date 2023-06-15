import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'chat.screen.dart';
import 'drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chat App'),
        ),
        body: const ChatScreen(),
        drawer: const AppDrawer(),
      ),
    );
  }
}
