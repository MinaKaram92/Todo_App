import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:simple_todo_app/models/task_category_model.dart';
import 'package:simple_todo_app/shared/components/components.dart';
import 'package:simple_todo_app/shared/cubit/cubit.dart';
import 'package:simple_todo_app/shared/cubit/states.dart';

class HomeTasksScreen extends StatelessWidget {
  var listController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.taskCategories.isNotEmpty,
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return buildTaskCategory(
                              context, cubit.taskCategories[index]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                        itemCount: cubit.taskCategories.length,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ConditionalBuilder(
                      condition: cubit.currentList!.length > 0,
                      builder: (context) {
                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return buildTaskItem(
                                  context, cubit.currentList![index]);
                            },
                            separatorBuilder: (context, index) =>
                                tasksSeparator(),
                            itemCount: cubit.currentList!.length,
                          ),
                        );
                      },
                      fallback: (context) => Expanded(
                          child: Center(
                              child: Text(
                        'No tasks yet',
                        style: Theme.of(context).textTheme.headline5,
                      ))),
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildTaskCategory(context, TaskCategory task) {
    return InkWell(
      onTap: () {
        TodoCubit.get(context).changeTaskList(task.title!);
      },
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          color:
              TodoCubit.get(context).isDark ? Colors.deepPurple : Colors.pink,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor:
                  TodoCubit.get(context).isDark ? Colors.blue : Colors.amber,
              radius: 20.0,
              child: Icon(
                task.icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                task.title!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Text(
              '${task.tasks!.length}',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
