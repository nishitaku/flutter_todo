import 'package:uuid/uuid.dart';

class Todo {
  // ID
  String id = Uuid().toString();
  // タイトル
  String title;
  // 完了期限
  DateTime dueDate;
  // 説明
  String note;
  // 完了済み
  bool isCompleted = false;

  Todo(this.title, this.dueDate, this.note);
}
