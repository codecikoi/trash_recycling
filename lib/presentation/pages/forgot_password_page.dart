import 'package:flutter/material.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
        child: Column(
          children: [
            TextField(
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
            ),
            const SizedBox(height: 30),
            BasicAppButton(
              height: 60,
              onPressed: () {},
              title: 'Recovery Password',
            )
          ],
        ),
      ),
    );
  }
}
