import 'package:lifelens/utils/lifelensapi.dart';

Future<List> birthdaysSoon(String groupname) async {
  List birthdays = [];
  Map temp = await groupBirthday(groupname);
  print("bd api: " + temp.toString());
  temp.forEach((member, data) {
    int daysUntilBirthday = data["days_until_birthday"];

    if (daysUntilBirthday < 60) {
      birthdays.add([member, daysUntilBirthday]);
    }
  });

  print("birthdays for countdown: " + birthdays.toString());
  return birthdays;
}
