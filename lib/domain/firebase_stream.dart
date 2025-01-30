import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_recycling/presentation/pages/start_page.dart';
import 'package:trash_recycling/presentation/pages/verify_email_page.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;

          if (!user.emailVerified) {
            return const VerifyEmailPage();
          }
          return const StartPage();
        } else {
          return const StartPage();
        }
      },
    );
  }
}
