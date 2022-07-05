part of 'filtered_todos_bloc.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> todos;
  FilteredTodosState({
    required this.todos,
  });

  factory FilteredTodosState.initial() {
    return FilteredTodosState(todos: []);
  }

  FilteredTodosState copyWith({
    List<Todo>? todos,
  }) {
    return FilteredTodosState(
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [todos];

  @override
  bool get stringify => true;
}
