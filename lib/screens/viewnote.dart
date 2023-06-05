import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../main.dart';
import '../model/model.dart';
import 'addnote.dart';

class Viewnote extends StatefulWidget {
  Note? note;
  int? index;
  Viewnote({this.note, this.index});

  @override
  State<Viewnote> createState() => _ViewnoteState();
}

class _ViewnoteState extends State<Viewnote> {
  late TextEditingController titlecontroller =
      TextEditingController(text: widget.note!.title);
  late TextEditingController subtitlecontroller =
      TextEditingController(text: widget.note!.subtitle);
  late Box<Note> noteBox;

  @override
  void initState() {
    noteBox = Hive.box<Note>(noteBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Note? note = noteBox.getAt(widget.index!);
              Note newNote = note!.copyWith(
                title: titlecontroller.text,
                subtitle: subtitlecontroller.text,
              );
              noteBox.putAt(widget.index!, newNote);

              Navigator.pop(context);
            },
            icon: const Icon(Icons.add),
            label: const Text("Ok"),
          )
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
                  const Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    onTap: () => Addnote(),
                    controller: titlecontroller,
                    style: const TextStyle(fontSize: 17),
                    decoration: const InputDecoration(border: InputBorder.none),
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
                onTap: () => Addnote(),
                scrollPadding: EdgeInsets.all(8),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: subtitlecontroller,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
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
