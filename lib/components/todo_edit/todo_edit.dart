import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';

class TodoEditPage extends StatefulWidget {
  TodoEditPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoEditPageState createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            Todo todo = Todo("タイトル $index", DateTime.now(), "タイトル $index のメモ");
            return Card(
                child: ListTile(
              onTap: () {},
              title: Text("${todo.title}"),
              subtitle: Text("${todo.note}"),
              trailing: Text("${todo.dueDate.toLocal().toString()}"),
              isThreeLine: true,
            ));
          }),
    );
  }
}
