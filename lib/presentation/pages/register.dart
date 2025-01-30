import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trash_recycling/presentation/pages/camera_page.dart';
import 'package:trash_recycling/presentation/pages/signin_page.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> signUp() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('User registered: ${userCredential.user?.email}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPage(),
        ),
      );
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> signIn() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('signed in: ${userCredential.user?.email}');
    } catch (e) {
      print('error $e');
    }
  }

  String? validateEmailInput(String value) {
    if (!value.contains('@') || !value.contains('.')) {
      return "Not valid Email!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: const BasicAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _pageText(),
              const SizedBox(height: 20),
              _fullNameField(context),
              const SizedBox(height: 20),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 60),
              BasicAppButton(
                  title: 'Create Account',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fix the errors in the form'),
                        ),
                      );
                    }
                  }),
              Row(
                children: [
                  const SizedBox(width: 30),
                  const Text('Do You Have An Account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignInPage(),
                        ),
                      );
                    },
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

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullNameController,
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
        hintText: 'Full Name',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
      ],
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
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
      validator: (value) => validateEmailInput(value ?? ''),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
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
          icon:
              Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        hintText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
