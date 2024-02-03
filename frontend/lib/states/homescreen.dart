import 'package:flutter/material.dart';
import 'package:lifelens/widget/friendgroup.dart';

class HomeScreen extends StatefulWidget {
  final String groupname;
  const HomeScreen({super.key, required this.groupname});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "People",
                  style: TextStyle(fontSize: 25),
                ),
                const Spacer(),
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
              ],
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.groupname),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
            child: ListView(
              children: const <Widget>[
                Text('Friend Groups',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25)),
                FriendGroup(
                  groupname: "Ark & Co",
                  description: "A group full of crazy ppl",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
