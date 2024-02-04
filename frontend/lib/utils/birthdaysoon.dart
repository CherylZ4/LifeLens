import 'package:lifelens/utils/lifelensapi.dart';

List birthdaysSoon(String groupname) {
  List birthdays = [];
  groupBirthday(groupname).then((value) => {
        value.forEach((member, data) {
          int daysUntilBirthday = data["days_until_birthday"];

          if (daysUntilBirthday < 60) {
            birthdays.add([member, daysUntilBirthday]);
          }
        }),
      });

  print("birthdays for countdown: " + birthdays.toString());
  return birthdays;
}
