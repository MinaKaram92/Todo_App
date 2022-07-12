import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/modules/add_task_screen/add_task_screen.dart';
import 'package:simple_todo_app/shared/components/components.dart';
import 'package:simple_todo_app/shared/cubit/cubit.dart';
import 'package:simple_todo_app/shared/cubit/states.dart';

class TodoLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
        if (state is DeleteTaskItemSuccessState) {
          showToast(
              msg: 'Task Deleted Successfully', state: ToastStates.SUCCESS);
        } else if (state is InsertIntoDatabaseSuccessState) {
          showToast(
              msg: 'Task Inserted Successfully', state: ToastStates.SUCCESS);
        } else if (state is UpdateTaskItemSuccessState) {
          showToast(
              msg: 'Task Updated Successfully', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            //backgroundColor: Colors.white,
            title: Text(
              'Todo App',
              style: Theme.of(context).textTheme.headline5,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  navigateTo(context, AddTaskScreen());
                },
                child: Text(
                  'Add Task',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 20.0),
                ),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeThemeMode();
                },
                icon: Icon(Icons.dark_mode),
              ),
            ],
          ),
          body: Container(
              color: cubit.isDark ? Colors.black : Colors.amber.shade200,
              child: cubit.screens[cubit.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            items: cubit.navItems,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
