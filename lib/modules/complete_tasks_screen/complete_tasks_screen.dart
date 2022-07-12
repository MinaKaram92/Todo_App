import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/shared/components/components.dart';
import 'package:simple_todo_app/shared/cubit/cubit.dart';
import 'package:simple_todo_app/shared/cubit/states.dart';

class CompleteTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          return tasksBuilder(cubit.completeTasks);
        });
  }
}
