import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trash_recycling/firebase_options.dart';
import 'package:trash_recycling/presentation/pages/splash_page.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffD3DFDB),
      ),
      home: const SplashPage(),
    );
  }
}
