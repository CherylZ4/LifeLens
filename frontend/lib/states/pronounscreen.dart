import 'package:flutter/material.dart';

class PronounScreen extends StatefulWidget {
  const PronounScreen({super.key});

  @override
  State<PronounScreen> createState() => _PronounScreenState();
}

class _PronounScreenState extends State<PronounScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.start, 
              children: <Widget> [
                const Text(
                    "Pronouns",
                    style: TextStyle(fontSize: 40),
                  ),
              ],),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
              FilledButton.tonal(
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
                        child: const Text('+ Add Friend')),
            ],)
        ],)
      )
    ));
  }
}