import 'package:flutter/material.dart';
import 'package:flutter_todo/components/todo_add/todo_add.dart';
import 'package:flutter_todo/components/todo_edit/todo_edit.dart';
import 'package:flutter_todo/models/Todo.dart';
import 'package:flutter_todo/repositories/db/db_provider.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  _moveToEditView(Todo todo) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => TodoEditPage(todo: todo)));

  _moveToAddView() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => TodoAddPage()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: DBProvider.db.getAllTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text(snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return Text("No data.");
          }

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Todo todo = snapshot.data[index];
                return Card(
                    child: ListTile(
                  onTap: () {
                    _moveToEditView(todo);
                  },
                  title: Text("${todo.title}"),
                  subtitle: Text("${todo.note}"),
                  trailing: Text("${todo.dueDate.toLocal().toString()}"),
                  isThreeLine: true,
                ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _moveToAddView();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
