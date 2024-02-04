import 'package:flutter/material.dart';
import 'package:lifelens/widget/friendgroup.dart';
import 'package:lifelens/widget/friendtile.dart';

class HomeScreen extends StatefulWidget {
  final String groupname;
  final List<String> groupList;
  final Map<dynamic, dynamic> userinfo;
  const HomeScreen(
      {super.key,
      required this.groupname,
      required this.groupList,
      required this.userinfo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: isLoading
              ? Container()
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
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
                      Divider(),
                      FriendTile(name: "Conrad"),
                      SizedBox(height: 10),
                      FriendTile(name: "Sigmund"),
                      Spacer(),
                      const Text(
                        "Upcoming birthdays",
                        style: TextStyle(fontSize: 25),
                      ),
                      Divider(),
                      FriendTile(name: "Conrad"),
                      SizedBox(height: 10),
                      FriendTile(name: "Sigmund"),
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
                SizedBox(height: 10),
                FriendGroup(
                  groupname: "Ark & Co",
                  description: "A group full of crazy ppl",
                ),
                SizedBox(height: 10),
                FriendGroup(
                  groupname: "Ark & Co 2",
                  description: "A group full of crazy ppl 2",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
