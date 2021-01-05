import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class Todo {
  // ID
  String id;
  // タイトル
  String title;
  // 完了期限
  DateTime dueDate;
  // 説明
  String note;
  // 完了済み
  bool isCompleted;

  Todo(
      {@required this.id,
      @required this.title,
      @required this.dueDate,
      @required this.note,
      @required this.isCompleted});

  Todo.newTodo(String title, String note) {
    this.id = Uuid().toString();
    this.title = title;
    this.dueDate = DateTime.now();
    this.note = note;
  }

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
      id: json["id"],
      title: json["title"],
      // 文字列をDateTime型に変換
      dueDate: DateTime.parse(json["dueDate"]).toLocal(),
      note: json["note"],
      // 数値をbool型に変換
      isCompleted: json["isCompleted"] == 1);

  Map<String, dynamic> toMap() => {
        "id": this.id,
        "title": this.title,
        "dueDate": this.dueDate.toUtc().toIso8601String(),
        "note": this.note,
        "isCompleted": this.isCompleted == true ? 1 : 0
      };
}
