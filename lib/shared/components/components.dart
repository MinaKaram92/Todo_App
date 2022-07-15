import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_todo_app/models/task_category_model.dart';
import 'package:simple_todo_app/shared/cubit/cubit.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget goBack(context) {
  return IconButton(
    icon: Icon(Icons.arrow_back_ios_new),
    color: TodoCubit.get(context).isDark ? Colors.deepPurple : Colors.pink,
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

Widget tasksSeparator() {
  return SizedBox(height: 10.0);
}

Widget buildTaskItem(context, Task task) {
  return Dismissible(
    key: Key(task.id.toString()),
    onDismissed: (direction) {
      TodoCubit.get(context).deleteTaskItem(id: task.id!);
    },
    child: Container(
      decoration: BoxDecoration(
        color: TodoCubit.get(context).isDark ? Colors.deepPurple : Colors.pink,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              radius: 40.0,
              backgroundColor:
                  TodoCubit.get(context).isDark ? Colors.blue : Colors.amber,
              child: Text(
                '${task.type}',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 18.0),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '${task.taskTitle}',
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CircleAvatar(
                    radius: 10.0,
                    backgroundColor: TodoCubit.get(context).isDark
                        ? Colors.blue
                        : Colors.amber,
                    child: Text(
                      '${task.piriority}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Text(
                    '${task.date}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    '${task.time}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          if (task.status == 'complete')
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.check_circle_outline,
                color:
                    TodoCubit.get(context).isDark ? Colors.blue : Colors.amber,
              ),
            ),
          if (task.status == 'incomplete')
            IconButton(
              icon: Icon(Icons.circle_outlined),
              color: TodoCubit.get(context).isDark ? Colors.blue : Colors.amber,
              onPressed: () {
                TodoCubit.get(context).updateDatabase(id: task.id!);
              },
            ),
        ],
      ),
    ),
  );
}

Widget defaultTextFormField({
  String? label,
  IconData? prefix,
  IconData? suffix,
  String? hint,
  Function? submit,
  Function? changed,
  Function? validate,
  VoidCallback? tap,
  VoidCallback? suffixPressed,
  TextEditingController? controller,
  bool suggestions = true,
  TextInputType? type,
  bool isPassword = false,
  TextStyle? labelStyle,
  TextStyle? hintStyle,
  required InputBorder border,
  String? errorText,
}) {
  return TextFormField(
    decoration: InputDecoration(
      counterText: '',
      labelText: label,
      hintStyle: hintStyle,
      //prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
            )
          : null,
      hintText: hint,
      border: border,
    ),
    onFieldSubmitted: (value) {
      if (submit != null) {
        submit(value);
      }
    },
    onChanged: (value) {
      if (changed != null) {
        changed(value);
      }
    },
    validator: (value) {
      if (validate != null) {
        return validate(value);
      }
    },
    onTap: tap,
    controller: controller,
    enableSuggestions: suggestions,
    keyboardType: type,
    obscureText: isPassword,
    style: labelStyle,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    maxLines: 1,
    maxLength: 15,
  );
}

Widget defaultMaterialButton({
  required String? text,
  double? textSize,
  Color? color,
  double? elevation,
  double? height,
  Color? textColor,
  ButtonTextTheme? textTheme,
  double? minWidth,
  required VoidCallback pressed,
}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Text(
      text!,
      style: TextStyle(fontSize: textSize),
    ),
    color: color,
    elevation: elevation,
    height: height,
    textColor: textColor,
    textTheme: textTheme,
    minWidth: minWidth,
    onPressed: pressed,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

void showToast({required String msg, required ToastStates state}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: changeToastStates(state),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
  );
}

Color changeToastStates(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget tasksBuilder(List<Task>? list) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: ConditionalBuilder(
      condition: list!.length > 0,
      builder: (context) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return buildTaskItem(context, list[index]);
          },
          separatorBuilder: (context, index) => tasksSeparator(),
          itemCount: list.length,
        );
      },
      fallback: (context) => Center(
          child: Text(
        'No Tasks Yet',
        style: Theme.of(context).textTheme.headline5,
      )),
    ),
  );
}
