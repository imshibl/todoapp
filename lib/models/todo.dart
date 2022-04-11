import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  bool complete;
  @HiveField(1)
  String task;

  Todo({this.complete = false, required this.task});
}
