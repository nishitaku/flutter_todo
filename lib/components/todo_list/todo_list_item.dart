import 'package:flutter/material.dart';
import 'package:flutter_todo/models/Todo.dart';
import 'package:flutter_todo/components/todo_edit/todo_edit.dart';
import 'package:flutter_todo/repositories/db/db_provider.dart';

class TodoListItem extends StatefulWidget {
  TodoListItem({Key key, this.todo})
      : super(key: key);

  final Todo todo;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> with RouteAware {
  _moveToEditView(Todo todo) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => TodoEditPage(todo: todo)));

  _updateTodo(Todo todo) async {
    await DBProvider.db.updateTodo(todo);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _moveToEditView(widget.todo);
        },
        child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.todo.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold)),
                    (widget.todo.note.isEmpty)
                        ? Container()
                        : Column(
                            children: [
                              SizedBox(height: 4),
                              Text(widget.todo.note,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1)
                            ],
                          )
                  ],
                )),
                Checkbox(
                  value: widget.todo.isCompleted,
                  onChanged: (value) {
                    widget.todo.isCompleted = value;
                    _updateTodo(widget.todo);
                  },
                  activeColor: Colors.lightGreen,
                )
              ],
            )));
  }
}
