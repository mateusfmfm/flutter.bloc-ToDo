import 'package:bloctodo/blocs/blocs.dart';
import 'package:bloctodo/models/todo_model.dart';
import 'package:bloctodo/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({Key? key}) : super(key: key);

  final debounce = Debounce(miliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            decoration: InputDecoration(
                labelText: "Search...",
                border: InputBorder.none,
                filled: true,
                prefixIcon: Icon(Icons.search)),
            onChanged: (String? newSearchTerm) {
              debounce.run(() {
                context
                    .read<TodoSearchBloc>()
                    .add(SetSearchTermEvent(newSearchTerm: newSearchTerm!));
              });
            }),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.ALL),
            filterButton(context, Filter.ACTIVE),
            filterButton(context, Filter.COMPLETED),
          ],
        )
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () => context
          .read<TodoFilterBloc>()
          .add(ChangeFilterEvent(newFilter: filter)),
      child: Text(
        filter == Filter.ALL
            ? 'All'
            : filter == Filter.ACTIVE
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          fontSize: 18,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    return currentFilter == filter ? Colors.pinkAccent : Colors.grey;
  }
}
