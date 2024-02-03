import 'package:flutter/material.dart';

class FriendProfile extends StatefulWidget {
  final String name;
  const FriendProfile({
    super.key,
    required this.name,
  });

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Text(widget.name.substring(0, 1).toUpperCase()),
              ),
              title: Text(
                widget.name,
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 7.0,
              runSpacing: 10.0,
              children: <Widget>[
                ActionChip(
                  avatar: const Icon(Icons.face),
                  label: const Text('He/Him'),
                  onPressed: () {
                    print("pog");
                  },
                ),
                ActionChip(
                  avatar: const Icon(Icons.celebration),
                  label: const Text('September 30, 2004'),
                  onPressed: () {
                    print("pog");
                  },
                ),
                ActionChip(
                  avatar: const Icon(Icons.hourglass_empty),
                  label: const Text('19'),
                  onPressed: () {
                    print("pog");
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Card(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      "Contact",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('conradmo78@gmail.com'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('647-674-4488'),
                  ),
                  ListTile(
                    leading: Icon(Icons.house),
                    title: Text('151 Stonebridge Drive'),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
