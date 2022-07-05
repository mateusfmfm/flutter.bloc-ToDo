import 'package:bloctodo/blocs/blocs.dart';
import 'package:bloctodo/pages/todos/widgets/create_todo.dart';
import 'package:bloctodo/pages/todos/widgets/search_and_filter_todo.dart';
import 'package:bloctodo/pages/todos/widgets/show_todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("BLoC TODO"),
        backgroundColor: Colors.pink[900],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<ActiveTodoCountBloc, ActiveTodoCountState>(
              builder: (context, state) {
                return Text(
                  "Active items: ${state.activeTodoCount}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.pink[700]),
                );
              },
            ),
            Text(
              "[Context Watch] Active items: ${context.watch<ActiveTodoCountBloc>().state.activeTodoCount}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink[700]),
            ),
            CreateTodo(),
            SizedBox(height: 12),
            SearchAndFilterTodo(),
            SizedBox(height: 12),
            ShowTodos()
          ],
        ),
      )),
    );
  }
}
