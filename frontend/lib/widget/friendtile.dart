import 'package:flutter/material.dart';
import 'package:lifelens/states/friendprofile.dart';

class FriendTile extends StatefulWidget {
  final String name;
  const FriendTile({
    super.key,
    required this.name,
  });

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FriendProfile(name: widget.name)));
      },
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      leading: CircleAvatar(
        child: Text(widget.name.substring(0, 1).toUpperCase()),
      ),
      title: Text(widget.name),
    );
  }
}
