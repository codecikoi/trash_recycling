import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_recycling/presentation/pages/login.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_button.dart';
import 'package:trash_recycling/utilities/widgets/helpers/snack_bar.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    if (_passwordController.text != _passwordRepeatController.text) {
      SnackBarService.showSnackBar(context, 'Passwords must match ', true);
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'This email already in use',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Unknown error',
          true,
        );
      }
    }
    navigator.pushNamed('/camera_page');
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
              const SizedBox(height: 20),
              _pageText(),
              const SizedBox(height: 20),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 20),
              _passwordRepeatField(context),
              const SizedBox(height: 60),
              BasicAppButton(
                title: 'Create Account',
                onPressed: signUp,
              ),
              Row(
                children: [
                  const SizedBox(width: 30),
                  const Text('Do You Have An Account?'),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed('/sigIn'),
                    child: const Text(
                      'Click Here',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
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
      'Register',
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

  Widget _passwordRepeatField(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: _passwordRepeatController,
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
