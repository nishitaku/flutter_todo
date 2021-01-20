import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';
import 'package:flutter_todo/repositories/db/db_provider.dart';

class TodoEditPage extends StatefulWidget {
  TodoEditPage({Key key, this.todo}) : super(key: key);

  final Todo todo;

  @override
  _TodoEditPageState createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.todo.title),
        ),
        body: Container(
            margin: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'タイトル'),
                      initialValue: widget.todo.title,
                      onSaved: (String value) {
                        this._title = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'メモ'),
                      initialValue: widget.todo.note,
                      onSaved: (String value) {
                        this._note = value;
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                          child: const Text('更新',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blueAccent,
                          onPressed: () {
                            _update(widget.todo);
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                ))));
  }

  void _update(Todo todo) async {
    this._formKey.currentState.save();
    print("Submit title=${this._title} note=${this._note}");
    todo.title = this._title;
    todo.note = this._note;
    await DBProvider.db.updateTodo(todo);
  }
}
