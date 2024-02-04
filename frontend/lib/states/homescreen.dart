import 'package:flutter/material.dart';
import 'package:lifelens/utils/birthdaysoon.dart';
import 'package:lifelens/utils/lifelensapi.dart';
import 'package:lifelens/widget/friendgroup.dart';
import 'package:lifelens/widget/friendtile.dart';

class HomeScreen extends StatefulWidget {
  final String groupname;
  final List friends;
  final List birthdays;
  final List groupListFull;
  final String? username;
  const HomeScreen(
      {super.key,
      required this.groupname,
      required this.friends,
      required this.birthdays,
      required this.groupListFull,
      required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String newgroup = "";
  @override
  void initState() {
    super.initState();
  }

  void handleApi() async {
    if (widget.groupname != "") {}
  }

  void handleGroupCreation(Map groupstuff) async {
    await newGroup(groupstuff);
    Map groupsmaps = await groupUserList(widget.username);
    List groupslist = groupsmaps["groups"];
    List birthdays = birthdaysSoon(groupstuff["groupname"]);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          username: widget.username,
          groupname: groupstuff["groupname"],
          friends: [groupstuff["members"]],
          birthdays: birthdays,
          groupListFull: groupslist,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(
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
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.friends.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FriendTile(name: widget.friends[index]),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
                const Spacer(),
                const Text(
                  "Upcoming birthdays",
                  style: TextStyle(fontSize: 25),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.birthdays.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FriendTile(name: widget.birthdays[index][0]),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
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
              children: <Widget>[
                const Text('Friend Groups',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25)),
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    children: [
                      for (var group in widget.groupListFull)
                        Column(
                          children: [
                            FriendGroup(
                              key: UniqueKey(),
                              groupname: group,
                              description: "",
                              grouplist: widget.groupListFull,
                              username: widget.username,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                    ],
                  ),
                ),
                const Spacer(),
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
                    onPressed: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => Dialog(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'New Group',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          newgroup = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Group Name',
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              newgroup = "";
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close'),
                                        ),
                                        const Spacer(),
                                        FilledButton(
                                          onPressed: () {
                                            // Navigator.pop(context);
                                            Map newgroupcreate = {
                                              "groupname": newgroup.toString(),
                                              "description": "",
                                              "members":
                                                  widget.username.toString()
                                            };
                                            print("thingys: $newgroupcreate");
                                            handleGroupCreation(newgroupcreate);
                                          },
                                          child: const Text('Create'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('New Group', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
