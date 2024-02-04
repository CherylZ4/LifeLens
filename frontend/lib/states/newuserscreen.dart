import 'package:flutter/material.dart';

class NewUserScreen extends StatefulWidget {
  final Map user;
  const NewUserScreen({super.key, required this.user});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  @override
  void initState() {
    // TODO: implement initState

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
      )),
    );
  }
}
