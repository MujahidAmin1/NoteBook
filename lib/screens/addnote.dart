import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:hive/hive.dart';

class Notepage extends StatefulWidget {
  const Notepage({
    super.key,
  });

  @override
  State<Notepage> createState() => _NotepageState();
}

final TextEditingController titlecontroller = TextEditingController();
final TextEditingController subtitlecontroller = TextEditingController();

class _NotepageState extends State<Notepage> {
  late Box<Note> noteBox;
  @override
  void initState() {
    // TODO: implement initState
    noteBox = Hive.box<Note>(noteBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add Note"),
        actions: [
          TextButton(
              onPressed: () {
                //add note in hive
                final String title = titlecontroller.text;
                final String subtitle = subtitlecontroller.text;

                Note note = Note(title: title, subtitle: subtitle, dateTime: DateTime.now());
                noteBox.add(note);

                Navigator.pop(context);
                titlecontroller.clear();
                subtitlecontroller.clear();
              },
              child: Text("Done"))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: titlecontroller,
                    style: TextStyle(fontSize: 17),
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                scrollPadding: EdgeInsets.all(8),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: subtitlecontroller,
                style: TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Enter Note Here',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
