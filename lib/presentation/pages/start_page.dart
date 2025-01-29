import 'package:flutter/material.dart';
import 'package:trash_recycling/presentation/pages/signin_page.dart';
import 'package:trash_recycling/presentation/pages/register.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_bar.dart';
import 'package:trash_recycling/utilities/widgets/helpers/app_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                  image: AssetImage('asset/icons/logo.png'),
                ),
              ),
            ),
            const Text(
              'Trash Recycling',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff2E6D41),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const Expanded(
              child: SizedBox(height: 10),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: BasicAppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => RegisterPage(),
                            ),
                          );
                        },
                        title: 'Register',
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SignInPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'SigIn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
