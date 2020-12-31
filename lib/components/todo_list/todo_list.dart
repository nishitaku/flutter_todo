import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: 10,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
