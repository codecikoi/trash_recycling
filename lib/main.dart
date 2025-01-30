import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trash_recycling/domain/firebase_stream.dart';
import 'package:trash_recycling/firebase_options.dart';
import 'package:trash_recycling/presentation/pages/camera_page.dart';
import 'package:trash_recycling/presentation/pages/forgot_password_page.dart';
import 'package:trash_recycling/presentation/pages/register.dart';
import 'package:trash_recycling/presentation/pages/login.dart';
import 'package:trash_recycling/presentation/pages/splash_page.dart';
import 'package:trash_recycling/presentation/pages/start_page.dart';
import 'package:trash_recycling/presentation/pages/verify_email_page.dart';

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
      routes: {
        '/stream': (context) => const FirebaseStream(),
        '/splash': (context) => const SplashPage(),
        '/start': (context) => const StartPage(),
        '/register': (context) => RegisterPage(),
        '/signIn': (context) => SignInPage(),
        '/reset_password': (context) => ForgotPasswordPage(),
        '/verify_email': (context) => const VerifyEmailPage(),
        '/camera_page': (context) => const CameraPage(),
      },
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        debugPrint('unknown page ${settings.name}');
        return MaterialPageRoute(
          builder: (context) => const StartPage(),
        );
      },
    );
  }
}
