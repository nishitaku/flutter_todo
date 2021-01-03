import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';

class TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("新規追加"),
        ),
        body: Container(
            margin: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'タイトル'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'メモ'),
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                      child: const Text('追加',
                          style: TextStyle(color: Colors.white)),
                      color: Colors.blueAccent,
                      onPressed: () {}),
                )
              ],
            ))));
  }
}
