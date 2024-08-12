import 'package:deshi_ponno/firebase_options.dart';
import 'package:deshi_ponno/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      scaffoldBackgroundColor: Colors.black,
      primaryColorDark: Colors.white,
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.dark(primary: Colors.white),
      useMaterial3: true,
    );
    return MaterialApp(
      title: 'Deshi Ponno',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const HomePage(),
    );
  }
}
