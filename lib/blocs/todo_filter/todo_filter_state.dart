part of 'todo_filter_bloc.dart';

class TodoFilterState extends Equatable {
  final Filter filter;

  TodoFilterState({
    required this.filter,
  });

  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.ALL);
  }

  @override
  List<Object> get props => [filter];

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  bool get stringify => true;
}
