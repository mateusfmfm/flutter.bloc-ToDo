import 'package:bloctodo/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders {
  providers(Widget child) {
    return MultiBlocProvider(providers: [
    BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
    BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
    BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
    BlocProvider<ActiveTodoCountBloc>(
        create: (context) => ActiveTodoCountBloc(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todos.length,
            todoListBloc: BlocProvider.of<TodoListBloc>(context))),
    BlocProvider<FilteredTodosBloc>(
        create: (context) => FilteredTodosBloc(
            initialTodos: context.read<TodoListBloc>().state.todos,
            todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
            todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
            todoListBloc: BlocProvider.of<TodoListBloc>(context)))
  ], child: child);
  }
}
