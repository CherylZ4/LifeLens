import 'package:flutter/material.dart';
import 'package:lifelens/states/homescreen.dart';

class FriendGroup extends StatefulWidget {
  final String groupname;
  final String description;

  const FriendGroup(
      {super.key, required this.groupname, required this.description});

  @override
  State<FriendGroup> createState() => _FriendGroupState();
}

class _FriendGroupState extends State<FriendGroup> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(groupname: widget.groupname)));
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
