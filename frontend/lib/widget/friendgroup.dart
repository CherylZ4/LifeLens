import 'package:flutter/material.dart';
import 'package:lifelens/states/homescreen.dart';
import 'package:lifelens/utils/lifelensapi.dart';

class FriendGroup extends StatefulWidget {
  final String? username;
  final String groupname;
  final String description;

  const FriendGroup(
      {super.key,
      required this.groupname,
      required this.username,
      required this.description});

  @override
  State<FriendGroup> createState() => _FriendGroupState();
}

class _FriendGroupState extends State<FriendGroup> {
  List<String> grouplist = [];
  Map userinfo = {};
  @override
  void initState() {
    Map usergroupinfo = groupUserList(widget.username) as Map;
    setState(() {
      userinfo = getUser(widget.username) as Map;
      grouplist = usergroupinfo["groups"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      groupname: widget.groupname,
                      userinfo: userinfo,
                      groupList: grouplist,
                    )));
      },
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      leading: CircleAvatar(
        child: Text(widget.groupname.substring(0, 1).toUpperCase()),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      title: Text(widget.groupname),
      subtitle: Text(widget.description),
    );
  }
}
