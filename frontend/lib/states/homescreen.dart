import 'package:flutter/material.dart';
import 'package:lifelens/utils/lifelensapi.dart';
import 'package:lifelens/widget/friendgroup.dart';
import 'package:lifelens/widget/friendtile.dart';

class HomeScreen extends StatefulWidget {
  final String groupname;
  final List groupList;
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
  late List grouplistfull = [];
  String newgroup = "";
  String newdescription = "";
  bool isLoading = true;
  late List<Widget> friendWidgets = [];
  late List<Widget> birthdayWidgets = [];
  List<String> users = [];
  List<List<String>> birthdays = [];
  List<List<String>> getUpcoming(Map birthdayMap) {
    List<List<String>> birthdays = [];
    birthdayMap.forEach((name, data) {
      int daysUntilBirthday = data['daysUntilBirthday'];
      if (daysUntilBirthday < 60) {
        birthdays.add([name, daysUntilBirthday.toString()]);
      }
    });
    return birthdays;
  }

  @override
  void initState() {
    handleApi();
    super.initState();
  }

  void handleApi() async {
    if (widget.groupname != "") {
      Map groupInfo = await getGroupInfo(widget.groupname);
      Map upcomingBirthdays = await groupBirthday(widget.groupname);
      setState(() {
        users = groupInfo["members"];
        birthdays = getUpcoming(upcomingBirthdays);
      });
    }
    for (int i = 0; i < widget.groupList.length; i++) {
      Map tempgroup = await getGroupInfo(widget.groupList[i]);
      setState(() {
        grouplistfull.add([tempgroup["name"], tempgroup["description"]]);
      });
    }
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
                      const Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                FriendTile(name: users[index]),
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
                          itemCount: birthdays.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                FriendTile(name: birthdays[index][0]),
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
                      for (var group in grouplistfull)
                        Column(
                          children: [
                            FriendGroup(
                              groupname: group[0],
                              description: group[1],
                              username: widget.userinfo["username"],
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
                                          newgroup = "";
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Group Name',
                                      ),
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          newdescription = "";
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Description',
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
                                              "groupname": newgroup,
                                              "description": newdescription,
                                              "members":
                                                  widget.userinfo["username"]
                                            };
                                            newGroup(newgroupcreate);
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
