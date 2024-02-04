import 'package:flutter/material.dart';
import 'package:lifelens/states/friendprofile.dart';
import 'package:lifelens/utils/lifelensapi.dart';

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
  bool isLoading = true;
  Map presents = {};

  @override
  void initState() {
    present();
    super.initState();
  }

  void present() async {
    Map futurepres = await genBirthday(widget.name);
    if (mounted) {
      setState(() {
        presents = futurepres;
        isLoading = false;
      });
    }

    print("presents = " + presents.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListTile(
        onTap: () {
          // present();
          // setState(() {
          //   isLoading = false;
          // });
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
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
    return ListTile(
      onTap: () {
        // present();
        // setState(() {
        //   isLoading = false;
        // });
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            itemCount: presents["items"].length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      presents["items"][index],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          ),
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
