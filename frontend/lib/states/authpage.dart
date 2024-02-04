import 'package:flutter/material.dart';
import 'package:lifelens/states/homescreen.dart';
import 'package:lifelens/utils/lifelensapi.dart';

class AuthPage extends StatefulWidget {
  final String? username;
  const AuthPage({super.key, required this.username});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    Map userinfo = getUser(widget.username) as Map;
    Map usergroupinfo = groupUserList(widget.username) as Map;
    List<String> grouplist = usergroupinfo["groups"];
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          groupname: "",
          groupList: grouplist,
          userinfo: userinfo,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  value: null,
                  semanticsLabel: 'Circular progress indicator',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Saving preferences"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
