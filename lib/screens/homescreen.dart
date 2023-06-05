import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/screens/addnote.dart';
import 'package:flutter_application_1/screens/viewnote.dart';
import 'package:hive_flutter/adapters.dart';
import '../main.dart';
import '../widget/notetile.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({
    super.key,
  });

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  late Box<Note> noteBox;
  

  @override
  void initState() {
    noteBox = Hive.box<Note>(noteBoxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notebook"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: noteBox.listenable(),
          builder: (context, Box<Note> notes, _) {
            List<int> keys = notes.keys.cast<int>().toList();

            return noteBox.isEmpty
                ? const Center(
                    child: Text(
                      "No Notes",
                      style: TextStyle(fontSize: 19),
                    ),
                  )
                : ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (context, index) {
                      final int key = keys[index];
                      final Note? note = notes.get(key);
                      return Dismissible(
                        onDismissed: (_) {
                          noteBox.deleteAt(index);
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.delete,
                              ),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete),
                            ],
                          ),
                        ),
                        key: UniqueKey(),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Viewnote(
                                  note: Note(
                                    title: note.title,
                                    subtitle: note.subtitle,
                                    dateTime: note.dateTime,
                                  ),
                                  index: index,
                                );
                              }),
                            );
                          },
                          child: NoteTile(
                            note: Note(
                              title: note!.title,
                              subtitle: note.subtitle,
                              dateTime: note.dateTime,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Addnote();
            }));
          }),
    );
  }
}
