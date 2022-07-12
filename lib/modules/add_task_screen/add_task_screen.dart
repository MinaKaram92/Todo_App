import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_todo_app/models/task_category_model.dart';
import 'package:simple_todo_app/shared/components/components.dart';
import 'package:simple_todo_app/shared/cubit/cubit.dart';
import 'package:simple_todo_app/shared/cubit/states.dart';

class AddTaskScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var piriorityController = TextEditingController();
  var typeController = TextEditingController();
  late String type;
  var formKey = GlobalKey<FormState>();

  Color getColor(context) {
    if (TodoCubit.get(context).isDark) {
      return Colors.deepPurple;
    } else {
      return Colors.pink;
    }
  }

  Widget verticalContainer(context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          width: 1.0,
          height: 30.0,
          color: getColor(context),
        ));
  }

  TextStyle styleForFormFeild(context) {
    return TextStyle(color: getColor(context), fontSize: 20.0);
  }

  Widget formFeildIcon({required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Icon(
        icon,
        size: 30.0,
      ),
    );
  }

  String titleError = 'Task Title can not be empty';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: goBack(context),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getColor(context),
                        ),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        children: [
                          formFeildIcon(icon: Icons.title),
                          verticalContainer(context),
                          Expanded(
                            child: defaultTextFormField(
                              controller: titleController,
                              hint: 'Enter Task Title',
                              type: TextInputType.text,
                              border: InputBorder.none,
                              hintStyle: styleForFormFeild(context),
                              labelStyle: styleForFormFeild(context),
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Task Title can not be empty';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: getColor(context),
                          ),
                        ),
                        width: double.infinity,
                        height: 60,
                        child: Row(
                          children: [
                            formFeildIcon(icon: Icons.date_range),
                            verticalContainer(context),
                            Expanded(
                              child: defaultTextFormField(
                                labelStyle: styleForFormFeild(context),
                                controller: dateController,
                                hint: 'Enter Task Date',
                                type: TextInputType.text,
                                border: InputBorder.none,
                                hintStyle: styleForFormFeild(context),
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Task Date can not be empty';
                                  }
                                },
                                tap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-12-31'),
                                  ).then((value) {
                                    if (value != null) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getColor(context),
                        ),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        children: [
                          formFeildIcon(icon: Icons.watch),
                          verticalContainer(context),
                          Expanded(
                            child: defaultTextFormField(
                              labelStyle: styleForFormFeild(context),
                              controller: timeController,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Task Time can not be empty';
                                }
                              },
                              hint: 'Enter Task Time',
                              type: TextInputType.text,
                              border: InputBorder.none,
                              hintStyle: styleForFormFeild(context),
                              tap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    timeController.text = value.format(context);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: getColor(context),
                          ),
                        ),
                        width: double.infinity,
                        height: 60,
                        child: Row(
                          children: [
                            formFeildIcon(icon: Icons.label_important),
                            verticalContainer(context),
                            Expanded(
                              child: defaultTextFormField(
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Task Piriority can not be empty';
                                  }
                                  if (int.parse(value) < 1 ||
                                      int.parse(value) >= 10) {
                                    return 'Piriority must be from 1 to 9';
                                  }
                                },
                                labelStyle: styleForFormFeild(context),
                                controller: piriorityController,
                                hint: 'Enter Task Piriority',
                                type: TextInputType.number,
                                border: InputBorder.none,
                                hintStyle: styleForFormFeild(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: getColor(context),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          )),
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        children: [
                          formFeildIcon(icon: Icons.merge_type),
                          verticalContainer(context),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: DropdownButtonFormField(
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'Please choose task type';
                                    }
                                  },
                                  value: cubit.dropDownValue,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  hint: Text(
                                    'Choose task type',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontSize: 20.0),
                                  ),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  style: styleForFormFeild(context),
                                  items: cubit.types
                                      .map<DropdownMenuItem<String>>(
                                          (e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    type = newValue!;
                                    cubit.changeDropDownValue(newValue);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultMaterialButton(
                      color: getColor(context),
                      text: 'Add Task',
                      textTheme: ButtonTextTheme.primary,
                      height: 50.0,
                      textSize: 25.0,
                      minWidth: double.infinity,
                      pressed: () {
                        if (formKey.currentState!.validate()) {
                          Task task = Task(
                            taskTitle: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            piriority: piriorityController.text,
                            type: type,
                          );
                          cubit.insertIntoDatabase(task);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
