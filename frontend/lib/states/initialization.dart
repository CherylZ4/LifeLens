import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lifelens/states/homescreen.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:lifelens/states/namecreation.dart';
import 'package:lifelens/utils/lifelensapi.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  Credentials? _credentials;
  late Auth0 auth0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-jgv85hakgz2rswn1.us.auth0.com',
        'FtGV0LeFqzUcE904GQFpHpj5ZSZvyDxO');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LifeLens",
              style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Life connecting insights",
              style: TextStyle(fontSize: 27),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (_credentials == null) {
                          try {
                            final credentials =
                                await auth0.webAuthentication().login();

                            setState(() {
                              isLoading = true;
                              _credentials = credentials;
                            });
                            print(_credentials!.user.nickname);
                            Timer(const Duration(seconds: 1), () {
                              checkAndNavigate(context);
                            });
                          } catch (e) {
                            print("failed");
                          }
                        }
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: isLoading
                      ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('Get Started',
                          style: TextStyle(fontSize: 17)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void checkAndNavigate(
    BuildContext context,
  ) async {
    if (_credentials != null) {
      // Navigate to HomeScreen when _credentials is not null
      bool exists = await checkUserExist(_credentials?.user.nickname);
      if (!context.mounted) return;
      if (exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(groupname: "haha"),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NameCreation(
              username: _credentials?.user.nickname,
              email: _credentials?.user.email,
            ),
          ),
        );
      }
    }
  }
}
