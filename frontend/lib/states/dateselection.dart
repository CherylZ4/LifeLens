import 'package:flutter/material.dart';
import 'package:lifelens/states/homescreen.dart';

class DateSelectionScreen extends StatefulWidget {
  const DateSelectionScreen({super.key, this.restorationId});
  final String? restorationId;

  @override
  State<DateSelectionScreen> createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen>
    with RestorationMixin, TickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(),
    )..addListener(() {
        setState(() {});
      });
    final Tween<double> _animationTween = Tween<double>(begin: 0.4, end: 0.6);
    animationController.animateTo(
      _animationTween.end!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  String birthday = "";
  String selectedDay = "";
  String selectedMonth = "";
  String selectedYear = "";
  RegExp regex = RegExp(r'^(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[0-2])/\d{4}$');
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );
  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        selectedDay = _selectedDate.value.day.toString();
        selectedMonth = _selectedDate.value.month.toString();
        selectedYear = _selectedDate.value.year.toString();
        _controller.text = "$selectedDay/$selectedMonth/$selectedYear";
        birthday = _controller.text;
      });
    }
  }

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
              "Add birthday",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Add your birthday so your friends can celebrate with you",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  birthday = value;
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _restorableDatePickerRouteFuture.present();
                  },
                ),
                border: OutlineInputBorder(),
                labelText: 'Date',
              ),
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
                    onPressed: regex.hasMatch(birthday)
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen(
                                        groupname: "TEST NO API")));
                          }
                        : null,
                    child: Text("Next")))
          ],
        ),
      )),
    );
  }
}
