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
  late TextEditingController _emailcontroller;
  String address = "";
  String phone = "";
  String email = "";

  RegExp addressregex = RegExp(r'^\d+\s+[\w\s]+\s+\w+$');
  RegExp phoneregex =
      RegExp(r'^(\+\d{1,3}\s?)?(\()?(\d{3})(\))?[-.\s]?(\d{3})[-.\s]?(\d{4})$');
  RegExp emailregex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  void initState() {
    super.initState();
    _phonecontroller = TextEditingController();
    _addresscontroller = TextEditingController();
    _emailcontroller = TextEditingController();
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
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                setState(() {
                  phone = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              controller: _emailcontroller,
              onChanged: (value) {
                setState(() {
                  email = value;
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
                    onPressed: (addressregex.hasMatch(address) &&
                            phoneregex.hasMatch(phone) &&
                            emailregex.hasMatch(email))
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
