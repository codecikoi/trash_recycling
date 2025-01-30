import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_recycling/presentation/pages/start_page.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';
import 'package:trash_recycling/utilities/widgets/helpers/snack_bar.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('there isnt user');
      return;
    }
    isEmailVerified = user.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 2),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await user.reload();

    setState(() {
      isEmailVerified = user.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 4));

      if (mounted) {
        setState(() => canResendEmail = true);
      }
    } catch (e) {
      print(e);
      if (mounted) {
        SnackBarService.showSnackBar(
          context,
          '$e',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const StartPage()
      : Scaffold(
          appBar: const BasicAppBar(
            title: Text('Email Verification'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('A confirmation email has been sent to your email.'),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                  label: const Text('Resend'),
                  icon: const Icon(Icons.mail),
                ),
                TextButton(
                  onPressed: () async {
                    timer?.cancel();
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await user.delete();
                    }
                    if (mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => StartPage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
}
