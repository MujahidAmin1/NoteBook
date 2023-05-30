import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/screens/addnote.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const String noteBoxName = "notes";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(noteBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomepage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/first': (context) => Notepage(),
        });
  }
}
