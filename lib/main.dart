import 'package:deshi_ponno/core/theme/material_theme.dart';
import 'package:deshi_ponno/home_page.dart';
import 'package:deshi_ponno/services/firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Deshi Ponno',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system, // Follow system theme
          theme: lightMaterialTheme(lightDynamic),
          darkTheme: darkMaterialTheme(darkDynamic),
          home: const HomePage(),
        );
      },
    );
  }
}
