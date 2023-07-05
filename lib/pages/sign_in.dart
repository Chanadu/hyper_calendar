import 'package:flutter/material.dart';

import '../util/create_task/basic/text_input_list_tile.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: TextInputListTile(
                  controller: TextEditingController(),
                  title: 'Email',
                  hint: 'Enter Email',
                  maxLines: 1,
                  isUsername: true,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: TextInputListTile(
                  controller: TextEditingController(),
                  title: 'Password',
                  hint: 'Enter Password',
                  maxLines: 1,
                  isPassword: true,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                  padding: const EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
