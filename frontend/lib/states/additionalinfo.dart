import 'package:flutter/material.dart';
import 'package:lifelens/states/newuserscreen.dart';

class AdditionalInfoPage extends StatefulWidget {
  final Map user;
  const AdditionalInfoPage({super.key, required this.user});

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late List<Widget> additionalInfoWidgets;
  late List<TextEditingController> textControllers;
  late List<String> textValues;
  late List<List<String>> formattedValues;
  bool isEmpty = true;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(),
    )..addListener(() {
        setState(() {});
      });
    final Tween<double> _animationTween = Tween<double>(begin: 0.8, end: 1);
    animationController.animateTo(
      _animationTween.end!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    additionalInfoWidgets = [];
    textControllers = [];
    textValues = [];
    formattedValues = [];
  }

  void addAdditionalInfo() {
    // Create a new controller for each TextField
    TextEditingController controllerq = TextEditingController();
    TextEditingController controllera = TextEditingController();
    textControllers.add(controllerq);
    textControllers.add(controllera);

    // Add TextField, set its controller, and add a divider to the list

    setState(() {
      additionalInfoWidgets.addAll([
        TextField(
            onChanged: (value) {
              setState(() {
                isEmpty =
                    (controllerq.text.isEmpty || controllera.text.isEmpty);
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Custom Question',
            ),
            controller: controllerq),
        const SizedBox(
          height: 10,
        ),
        TextField(
            onChanged: (value) {
              setState(() {
                isEmpty =
                    (controllerq.text.isEmpty || controllera.text.isEmpty);
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Custom Answer',
            ),
            controller: controllera),
        const Divider(),
      ]);
    });

    // Update the UI
  }

  void formatTextValues() {
    formattedValues = [];
    setState(() {
      formattedValues = List.generate(
        textControllers.length ~/ 2,
        (index) => [
          textControllers[index * 2].text,
          textControllers[index * 2 + 1].text,
        ],
      ).toList();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(60, 30, 60, 30),
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
                "Add additional info",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let your friends know anything they might want to know",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: additionalInfoWidgets.length,
                  itemBuilder: (context, index) {
                    return additionalInfoWidgets[index];
                  },
                ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.maxFinite,
                  child: FilledButton.tonal(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isEmpty = true;
                        });
                        addAdditionalInfo();
                      },
                      child: Text("Add Question"))),
              const SizedBox(
                height: 10,
              ),
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
                      onPressed: isEmpty
                          ? null
                          : () {
                              formatTextValues();
                              widget.user["questions"] = formattedValues;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewUserScreen(
                                    user: widget.user,
                                  ),
                                ),
                                (Route<dynamic> route) => route
                                    is NewUserScreen, // Keep NewUserScreen on the stack
                              );
                            },
                      child: Text("Next")))
            ],
          ),
        ),
      ),
    );
  }
}
