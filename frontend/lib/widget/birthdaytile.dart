import 'package:flutter/material.dart';
import 'package:lifelens/states/friendprofile.dart';

class BirthdayTile extends StatefulWidget {
  final String name;
  final int days;
  const BirthdayTile({
    super.key,
    required this.days,
    required this.name,
  });

  @override
  State<BirthdayTile> createState() => _BirthdayTileState();
}

class _BirthdayTileState extends State<BirthdayTile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          isLoading = true;
        });
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'New Group',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ));
      },
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the border radius as needed
      ),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Text(widget.days.toString()),
      ),
      title: Text(widget.name),
    );
  }
}
