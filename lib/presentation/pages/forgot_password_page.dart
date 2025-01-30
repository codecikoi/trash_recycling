import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_button.dart';
import 'package:trash_recycling/utilities/widgets/helpers/snack_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        SnackBarService.showSnackBar(
          context,
          'Email not found',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Unknown error',
          true,
        );
        return;
      }
    }
    const snackBar = SnackBar(
      content: Text('Check your email'),
      backgroundColor: Colors.green,
    );

    scaffoldMessenger.showSnackBar(snackBar);

    navigator.pushNamedAndRemoveUntil(
        '/start_page', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _emailField(context),
              const SizedBox(height: 30),
              BasicAppButton(
                height: 60,
                onPressed: resetPassword,
                title: 'Recovery Password',
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      controller: _emailController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(30),
        filled: true,
        fillColor: Colors.white30,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.white30,
            width: 0.4,
          ),
        ),
        hintText: 'Enter Your Email',
      ),
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Not Valid Email'
          : null,
    );
  }
}
