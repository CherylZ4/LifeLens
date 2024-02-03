import 'package:flutter/material.dart';
import 'package:lifelens/states/dateselection.dart';

class PronounScreen extends StatefulWidget {
  const PronounScreen({super.key});

  @override
  State<PronounScreen> createState() => _PronounScreenState();
}

class _PronounScreenState extends State<PronounScreen> {
  bool showOther = false;

  TextEditingController otherPronounController = TextEditingController();
  bool isOther = false;
  String pronoun = "";
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Add pronoun",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Add your pronouns so your friends can address you correctly",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.maxFinite,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: pronoun != "He/Him"
                      ? () {
                          setState(() {
                            pronoun = "He/Him";
                            isOther = false;
                            _controller.clear();
                          });
                        }
                      : null,
                  child: const Text("He/Him"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.maxFinite,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: pronoun != "She/Her"
                      ? () {
                          setState(() {
                            pronoun = "She/Her";
                            isOther = false;
                            _controller.clear();
                          });
                        }
                      : null,
                  child: const Text("She/Her"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.maxFinite,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: pronoun != "They/Them"
                      ? () {
                          setState(() {
                            pronoun = "They/Them";
                            isOther = false;
                            _controller.clear();
                          });
                        }
                      : null,
                  child: const Text("They/Them"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: sized_box_for_whitespace
              SizedBox(
                width: double.maxFinite,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: isOther == false
                      ? () {
                          setState(() {
                            pronoun = "";
                            isOther = true;
                          });
                        }
                      : null,
                  child: const Text("Other"),
                ),
              ),
              isOther
                  ? TextField(
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          pronoun = value;
                          print(pronoun);
                        });
                      },
                    )
                  : Container(),
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
                      onPressed: pronoun != ""
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DateSelectionScreen(
                                            restorationId: "Date1",
                                          )));
                            }
                          : null,
                      child: Text("Next")))
            ],
          ),
        ),
      ),
    );
  }
}
