import 'package:flutter/material.dart';
import 'package:lifelens/states/pronounscreen.dart';

class NameCreation extends StatefulWidget {
  const NameCreation({super.key});

  @override
  State<NameCreation> createState() => _NameCreationState();
}

class _NameCreationState extends State<NameCreation> {
  String name = "";
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Add name",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Add your name so your friends can recognize you",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  name = value;
                  print(name);
                });
              },
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
                    onPressed: name != ""
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PronounScreen()));
                          }
                        : null,
                    child: const Text("Next")))
          ],
        ),
      )),
    );
  }
}
