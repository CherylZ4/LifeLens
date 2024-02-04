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
  Map userinfo = {};
  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    try {
      Map fetchedUserInfo = await getUser(widget.username);
      Map usergroupinfo = await groupUserList(widget.username) as Map;
      List<dynamic> grouplist = usergroupinfo["groups"];
      setState(() {
        userinfo = fetchedUserInfo;
      });
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
    } catch (error) {
      // Handle errors if needed
      print('Error initializing data: $error');
    }
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
                Text("Logging in"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
