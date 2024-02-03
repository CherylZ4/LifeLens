import 'package:flutter/material.dart';
import 'package:lifelens/states/homescreen.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({super.key});

  @override
  State<ContactInfoPage> createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late TextEditingController _phonecontroller;
  late TextEditingController _addresscontroller;
  String address = "";
  String phone = "";
  @override
  void initState() {
    super.initState();
    _phonecontroller = TextEditingController();
    _addresscontroller = TextEditingController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(),
    )..addListener(() {
        setState(() {});
      });
    final Tween<double> _animationTween = Tween<double>(begin: 0.6, end: 0.8);
    animationController.animateTo(
      _animationTween.end!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    _phonecontroller.dispose();
    _addresscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LinearProgressIndicator(
              value: animationController.value,
              semanticsLabel: 'Linear progress indicator',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Add contact info",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Add contact info so your friends can reach you",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
              controller: _addresscontroller,
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone number',
              ),
              controller: _phonecontroller,
              onChanged: (value) {
                phone = value;
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
                    onPressed: true
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeScreen(groupname: "no api")));
                          }
                        : null,
                    child: const Text("Next")))
          ],
        ),
      )),
    );
  }
}
