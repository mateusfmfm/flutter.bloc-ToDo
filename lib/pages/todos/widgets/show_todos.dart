// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloctodo/blocs/blocs.dart';
import 'package:bloctodo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.todos;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(listener: (context, state) {
          context.read<FilteredTodosBloc>().setFilteredTodos();
        }),
        BlocListener<TodoFilterBloc, TodoFilterState>(
            listener: (context, state) {
          context.read<FilteredTodosBloc>().setFilteredTodos();
        }),
        BlocListener<TodoSearchBloc, TodoSearchState>(
            listener: (context, state) {
          context.read<FilteredTodosBloc>().setFilteredTodos();
        }),
      ],
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: todos.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) => Dismissible(
              key: ValueKey(todos[index].id),
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              onDismissed: (_) => context
                  .read<TodoListBloc>()
                  .add(RemoveTodoEvent(todo: todos[index])),
              child: TodoItem(todo: todos[index]))),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textController.text = widget.todo.desc;
              return StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                        title: Text("Edit Todo"),
                        content: TextField(
                          controller: textController,
                          autofocus: true,
                          decoration: InputDecoration(
                              errorText:
                                  _error ? 'Value cannot be empty' : null),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('CANCEL')),
                          TextButton(
                              onPressed: () => setState(() {
                                    _error = textController.text.isEmpty
                                        ? true
                                        : false;
                                    if (!_error) {
                                      context.read<TodoListBloc>().add(
                                          EditTodoEvent(
                                              id: widget.todo.id,
                                              todoDesc: textController.text));
                                      Navigator.pop(context);
                                    }
                                  }),
                              child: Text('EDIT')),
                        ],
                      ));
            });
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checkked) => context
            .read<TodoListBloc>()
            .add(ToggleTodoEvent(id: widget.todo.id)),
      ),
      title: Text(widget.todo.desc,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.pink[700])),
    );
  }
}
