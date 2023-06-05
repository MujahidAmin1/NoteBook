import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subtitle;
  @HiveField(2)
  DateTime dateTime;

  Note({
    required this.title,
    required this.subtitle,
    required this.dateTime,
  });

  Note copyWith({String? title, String? subtitle}) {
    return Note(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      dateTime: DateTime.now(),
    );
  }
}
