// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:bloctodo/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;
  FilteredTodosCubit({
    required this.initialTodos,
  }) : super(FilteredTodosState(todos: initialTodos));

  void setFilteredTodos(Filter filter, List<Todo> todos, String searchTerm) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.ACTIVE:
        _filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.COMPLETED:
        _filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.ALL:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }

    emit(state.copyWith(todos: _filteredTodos));
  }
}
