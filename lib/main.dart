import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yomu_reader_1/page/auth_page.dart';
import 'package:yomu_reader_1/page/login_page.dart';
import 'package:yomu_reader_1/page/register_page.dart';
import 'package:yomu_reader_1/theme/dark_mode.dart';
import 'package:yomu_reader_1/theme/light_mode.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
