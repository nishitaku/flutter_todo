class Todo {
  String id;
  String title;
  DateTime dueDate;
  String note;

  Todo(this.title, this.dueDate, this.note);

  Todo.newTodo() {
    title = "";
    dueDate = DateTime.now();
    note = "";
  }
}
