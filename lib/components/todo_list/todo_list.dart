import 'package:flutter/material.dart';
import 'package:flutter_todo/components/todo_add/todo_add.dart';
import 'package:flutter_todo/components/todo_edit/todo_edit.dart';
import 'package:flutter_todo/components/todo_list/todo_list_item.dart';
import 'package:flutter_todo/models/Todo.dart';
import 'package:flutter_todo/repositories/db/db_provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key key, this.title, this.routeObserver})
      : super(key: key);

  final String title;
  final RouteObserver<PageRoute> routeObserver;

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> with RouteAware {
  Future<List<Todo>> _todoList;

  _moveToEditView(Todo todo) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => TodoEditPage(todo: todo)));

  _moveToAddView() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => TodoAddPage()));

  _updateTodo(Todo todo) async {
    await DBProvider.db.updateTodo(todo);
    _todoList = DBProvider.db.getAllTodos();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _todoList = DBProvider.db.getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _todoList,
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
                return TodoListItem(todo: todo);
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  // 一度、別の画面に遷移したあとで、再度この画面に戻ってきた時にコールされる
  @override
  void didPopNext() {
    _todoList = DBProvider.db.getAllTodos();
    setState(() {});
  }
}
