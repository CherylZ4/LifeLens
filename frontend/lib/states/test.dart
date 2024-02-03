import 'package:flutter/material.dart';

final Color darkBlue = const Color.fromARGB(255, 18, 32, 47);

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: MyWidget(),
//         ),
//       ),
//     );
//   }
// }

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool showWidget = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        showWidget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Icon(Icons.ac_unit),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Icon(Icons.accessible),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Icon(Icons.backpack),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Icon(Icons.cached),
                  ),
                ],
              )
            : Container(),
        OutlinedButton(
          onPressed: () {
            setState(() {
              showWidget = !showWidget;
            });
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}