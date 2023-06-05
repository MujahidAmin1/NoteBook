import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';

// ignore: must_be_immutable
class NoteTile extends StatelessWidget {
  Note? note;

  NoteTile({this.note, super.key});

  @override
  Widget build(BuildContext context) {
    int day = note!.dateTime.day;
    int month = note!.dateTime.month;
    int year = note!.dateTime.year;
    String time =
        "${note!.dateTime.hour}:${note!.dateTime.minute}:${note!.dateTime.second}";
    String symbol = note!.dateTime.hour < 12 ? "am" : "pm";

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: Colors.grey[300],
      child: ListTile(
        title: Text(
          note!.subtitle.length > 40
              ? note!.subtitle.substring(1, 41)
              : note!.subtitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("$day/$month/$year, $time $symbol"),
      ),
    );
  }
}
