import 'package:coinboost/firebase_options.dart';
import 'package:coinboost/pages/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Supports light, dark, and system mode
      theme: ThemeData.light(), // Light mode theme
      darkTheme: ThemeData.dark(), // Dark mode theme
      home: StartPage(),
    );
  }
}
