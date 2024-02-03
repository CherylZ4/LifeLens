import 'package:flutter/material.dart';
import 'package:lifelens/states/namecreation.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({super.key});

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
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
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NameCreation()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child:
                            Text('Get Started', style: TextStyle(fontSize: 17)),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledButton.tonal(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        print("CLICKED");
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text('Already have an account',
                            style: TextStyle(fontSize: 17)),
                      )),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
