import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';
import 'package:flutter_todo/repositories/db/db_provider.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  DateTime _dueDate;
  String _note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("新規追加"),
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
                      onSaved: (String value) {
                        this._title = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: '説明'),
                      onSaved: (String value) {
                        this._note = value;
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                          child: const Text('追加',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blueAccent,
                          onPressed: () {
                            _submit();
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                ))));
  }

  void _submit() async {
    this._formKey.currentState.save();
    print("Submit title=${this._title} note=${this._note}");
    var todo = Todo.newTodo(this._title, this._note);
    await DBProvider.db.createTodo(todo);
  }
}
