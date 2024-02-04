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
  String newfriend = "";
  List localfriends = [];
  @override
  void initState() {
    print("widget friends " + widget.friends.toString());
    localfriends = widget.friends;
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

  void handleFriendCreation(String username) async {
    try {
      Map body = {"new_username": username, "groupname": widget.groupname};
      print(body);
      Map response = await addGroupMember(body);
      print(localfriends.toString());
      setState(() {
        localfriends = List.from(response[
            "members"]); // Ensure you're creating a new list to trigger a rebuild
      });
      print(localfriends.toString());
    } catch (e) {
      print("error happened when adding fren");
      print(e);
    }
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
                        onPressed: () => showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 30, 30, 30),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          'Add friend',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              newfriend = value;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Username',
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  newfriend = "";
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Close'),
                                            ),
                                            const Spacer(),
                                            FilledButton(
                                              onPressed: () {
                                                handleFriendCreation(newfriend);
                                                // newfriend = "";
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Add'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                        child: const Text('+ Add Friend')),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: localfriends.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FriendTile(name: localfriends[index]),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
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
