import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';

class TodoEditPage extends StatefulWidget {
  TodoEditPage({Key key, this.todo}) : super(key: key);

  final Todo todo;

  @override
  _TodoEditPageState createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.todo.title}"),
        ),
        body: Container(
            margin: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'タイトル'),
                  initialValue: widget.todo.title,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'メモ'),
                  initialValue: widget.todo.note,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                      child: const Text('更新',
                          style: TextStyle(color: Colors.white)),
                      color: Colors.blueAccent,
                      onPressed: () {}),
                )
              ],
            ))));
  }
}
