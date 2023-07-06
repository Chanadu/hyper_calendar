import 'package:flutter/material.dart';
import 'package:hyper_calendar/util/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_db;

import '../main.dart';
import '../util/create_task/basic/text_input_list_tile.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
    required this.setSignIn,
  });

  final void Function(bool) setSignIn;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  controller: usernameController,
                  title: 'Username',
                  hint: 'Enter Username',
                  maxLines: 1,
                  isUsername: true,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: TextInputListTile(
                  controller: passwordController,
                  title: 'Password',
                  hint: 'Enter Password',
                  maxLines: 1,
                  isPassword: true,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      List<Map<String, dynamic>>? holder;
                      do {
                        try {
                          holder = await MongoDB.authenticationColl!.find().toList();
                        } catch (_) {
                          await Future.delayed(const Duration(milliseconds: 10));
                        }
                      } while (holder == null);
                      if (await MongoDB.authenticationColl!.find({'username': usernameController.text}).isEmpty || usernameController.text.isEmpty || passwordController.text.isEmpty) {
                        String result = await MongoDB.insertAuthentication(
                          MongoDbAuthenticationModel(
                            username: usernameController.text,
                            password: passwordController.text,
                          ),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  result,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                  ),
                                ),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'That Username is already in use.',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                  ),
                                ),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Theme.of(context).colorScheme.primary),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: Text(
                      'Create New Account',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      List<Map<String, dynamic>>? holder;
                      do {
                        try {
                          holder = await MongoDB.authenticationColl!.find().toList();
                        } catch (_) {
                          await Future.delayed(const Duration(milliseconds: 10));
                        }
                      } while (holder == null);

                      Map<String, dynamic>? auth = await MongoDB.authenticationColl!.findOne(
                        {
                          'username': usernameController.text,
                          'password': passwordController.text,
                        },
                      );

                      if (!(auth == null || auth.isEmpty)) {
                        widget.setSignIn(true);

                        usernameId = auth['_id'] as mongo_db.ObjectId;

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Sign in Successful!',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                  ),
                                ),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Incorrect Username or Password.',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                  ),
                                ),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          );
                        }
                      }
                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
