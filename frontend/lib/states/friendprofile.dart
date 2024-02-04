import 'package:flutter/material.dart';
import 'package:lifelens/utils/lifelensapi.dart';

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
  Map info = {};
  bool isLoading = true;
  @override
  void initState() {
    handleApi();
    super.initState();
  }

  void handleApi() async {
    Map response = await getUser(widget.name);
    setState(() {
      info = response;
      isLoading = false;
    });
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold();
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                child: Text(widget.name.substring(0, 1).toUpperCase()),
              ),
              title: Text(
                info["first_name"] + " " + info["last_name"],
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
                  label: Text(info["pronoun"]),
                  onPressed: () {
                    print("pog");
                  },
                ),
                ActionChip(
                  avatar: const Icon(Icons.celebration),
                  label: Text(info["birthday"]),
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
            Card(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      "Contact",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(info["interests"]),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(info["phone_number"]),
                  ),
                  ListTile(
                    leading: Icon(Icons.house),
                    title: Text(info["address"]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: info["questions"].length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.question_mark),
                        title: Text(info["questions"][index][0]),
                        subtitle: Text(info["questions"][index][1]),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
