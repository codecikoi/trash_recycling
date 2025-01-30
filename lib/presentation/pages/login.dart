import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_recycling/presentation/pages/camera_page.dart';
import 'package:trash_recycling/presentation/pages/forgot_password_page.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_button.dart';
import 'package:trash_recycling/utilities/widgets/helpers/snack_bar.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          'Wrong password or email',
          true,
        );
        return;
      }
    }
    navigator.pushNamedAndRemoveUntil(
        '/camera_page', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              _pageText(),
              const SizedBox(height: 20),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 60),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: BasicAppButton(
                      onPressed: login,
                      title: 'SigIn',
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/reset_password'),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
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

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: _passwordController,
      obscureText: _obscurePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        suffix: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        hintText: 'Password',
      ),
      validator: (value) =>
          value != null && value.length < 6 ? 'Minimum 6 characters' : null,
    );
  }
}
