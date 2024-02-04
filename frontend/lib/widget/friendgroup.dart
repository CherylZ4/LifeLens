import 'package:flutter/material.dart';
import 'package:lifelens/states/homescreen.dart';
import 'package:lifelens/utils/birthdaysoon.dart';
import 'package:lifelens/utils/lifelensapi.dart';

class FriendGroup extends StatefulWidget {
  final String? username;
  final String groupname;
  final String description;
  final List grouplist;

  const FriendGroup(
      {super.key,
      required this.grouplist,
      required this.groupname,
      required this.username,
      required this.description});

  @override
  State<FriendGroup> createState() => _FriendGroupState();
}

class _FriendGroupState extends State<FriendGroup> {
  List friends = [];
  List birthdays = [];
  bool isLoading = true;
  @override
  void initState() {
    handleFriendGroupState();
    super.initState();
  }

  void handleFriendGroupState() async {
    if (mounted) {
      setState(() {
        isLoading = true; // Set loading state to true
      });
      Map friendsmap = await getGroupInfo(widget.groupname);
      birthdays = await birthdaysSoon(widget.groupname);

      setState(() {
        friends = friendsmap["members"];
        isLoading = false;
        print("bday " + birthdays.toString());
        print("FG: " + friends.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Return a loading indicator or an empty container
      return Container();
    }
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      birthdays: birthdays,
                      friends: friends,
                      groupname: widget.groupname,
                      username: widget.username,
                      groupListFull: widget.grouplist,
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
