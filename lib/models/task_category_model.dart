import 'package:flutter/cupertino.dart';

class TaskCategory {
  IconData? icon;
  String? title;
  List<Task>? tasks;

  TaskCategory({required this.icon, required this.title, this.tasks});
}

class Task {
  int? id;
  String? taskTitle;
  String? date;
  String? time;
  String? piriority;
  String? type;
  String? status;

  Task({
    required this.taskTitle,
    required this.date,
    required this.time,
    required this.piriority,
    required this.type,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskTitle = json['task'];
    date = json['date'];
    time = json['time'];
    piriority = json['piriority'];
    status = json['status'];
    type = json['type'];
  }
}
