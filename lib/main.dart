import 'package:flutter/material.dart';
import 'package:flutter_todo/components/todo_list/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(
          title: 'Flutter Demo Home Page', routeObserver: _routeObserver),
      navigatorObservers: [
        _routeObserver,
      ],
    );
  }
}
