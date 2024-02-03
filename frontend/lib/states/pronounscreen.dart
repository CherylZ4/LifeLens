import 'package:flutter/material.dart';

class PronounScreen extends StatefulWidget {
  const PronounScreen({super.key});

  @override
  State<PronounScreen> createState() => _PronounScreenState();
}

class _PronounScreenState extends State<PronounScreen> {
  bool showWidget = false;
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
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget> [
                const Text(
                    "Pronouns",
                    style: TextStyle(fontSize: 40),
                  ),
              ],),
            SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
                Expanded(child: OutlinedButton(
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
                          child: const Text('she/her')),
                )
              ],
            ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
                Expanded(child: OutlinedButton(
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
                          child: const Text('he/him')),
                )
              ],
            ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
                Expanded(child: OutlinedButton(
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
                          child: const Text('they/them')),
                )
              ],
            ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
                Expanded(child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              showWidget = !showWidget;
                            });
                          },
                          child: const Text('other')),
                )
              ],
            ),
          showWidget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: 
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [

                          OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text('fgrnjkens')),
                      ])
                  ),
                ],
              )
            : Container(),
        ],)
      )
    ));
  }
}