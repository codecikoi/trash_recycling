import 'package:flutter/material.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 40),
          _emailField(context),
          const SizedBox(height: 20),
          _passwordField(context),
          const SizedBox(height: 60),
          Row(
            children: [
              const Text('Forgot password?'),
              TextButton(
                onPressed: () {},
                child: const Text('Sing In'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Enter Your Email',
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(
        hintText: 'Password',
        suffix: Icon(
          Icons.remove_red_eye_outlined,
        ),
      ),
    );
  }
}
