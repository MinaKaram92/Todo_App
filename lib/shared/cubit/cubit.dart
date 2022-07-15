import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/models/task_category_model.dart';
import 'package:simple_todo_app/models/task_model.dart';
import 'package:simple_todo_app/modules/complete_tasks_screen/complete_tasks_screen.dart';
import 'package:simple_todo_app/modules/home_tasks_screen/home_tasks_screen.dart';
import 'package:simple_todo_app/modules/incomplete_tasks_screen/incomplete_tasks_screen.dart';
import 'package:simple_todo_app/shared/components/components.dart';
import 'package:simple_todo_app/shared/cubit/states.dart';
import 'package:simple_todo_app/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  List<Widget> screens = [
    HomeTasksScreen(),
    CompleteTasksScreen(),
    IncompleteTasksScreen(),
  ];

  List<String> titles = ['Home', 'Done', 'Archived'];

  void changeThemeMode() {
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(ChangeThemeModeState());
    });
  }

  void cachedThemeMode(bool? isDark) {
    if (isDark != null) {
      this.isDark = isDark;
    } else {
      this.isDark = this.isDark;
    }
  }

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.check_circle_outline),
      label: 'Complete',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.circle_outlined),
      label: 'Incomplete',
    ),
  ];

  int currentIndex = 0;

  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeTodoNavBarState());
  }

  late Database database;
  void createDatabase() async {
    await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db
            .execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, task TEXT, date TEXT, time TEXT, piriority TEXT, type TEXT, status TEXT)',
        )
            .then((value) {
          print('table created successfully');
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (database) {
        getAllTasksFromDatabase(database);
      },
    ).then((value) {
      database = value;
      print(database.toString());
      emit(CreateDatabaseSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateDatabaseErrorState(error.toString()));
    });
  }

  void insertIntoDatabase(Task task) async {
    await database
        .rawInsert(
      'INSERT INTO Tasks(task, date, time, piriority, type,  status) VALUES("${task.taskTitle}","${task.date}","${task.time}", "${task.piriority}", "${task.type}", "incomplete")',
    )
        .then((value) {
      emit(InsertIntoDatabaseSuccessState());
      getAllTasksFromDatabase(database);
    }).catchError((error) {
      print(error.toString());
      emit(InsertIntoDatabaseErrorState(error.toString()));
    });
  }

  List<String> types = [
    'Personal',
    'Sports',
    'Reading',
    'Watching',
    'Studying',
    'Other',
  ];

  String? dropDownValue;

  void changeDropDownValue(String value) {
    dropDownValue = value;
    emit(ChangeDropDownValueState());
  }

  List<Task> allTasks = [];
  List<Task> inCompleteTasks = [];
  List<Task> completeTasks = [];

  List<Task> personal = [];
  List<Task> sports = [];
  List<Task> reading = [];
  List<Task> watching = [];
  List<Task> studying = [];
  List<Task> other = [];

  void getAllTasksFromDatabase(database) async {
    allTasks = [];
    inCompleteTasks = [];
    completeTasks = [];
    personal = [];
    sports = [];
    reading = [];
    watching = [];
    studying = [];
    other = [];
    await database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element) {
        allTasks.add(Task.fromJson(element));
        if (element['status'] == 'incomplete') {
          inCompleteTasks.add(Task.fromJson(element));
        } else if (element['status'] == 'complete') {
          completeTasks.add(Task.fromJson(element));
        }
      });
      currentList = allTasks;
      getCategoryTasks(type: 'Personal', list: personal);
      getCategoryTasks(type: 'Sports', list: sports);
      getCategoryTasks(type: 'Reading', list: reading);
      getCategoryTasks(type: 'Watching', list: watching);
      getCategoryTasks(type: 'Other', list: other);
      getCategoryTasks(type: 'Studying', list: studying);
      returnTaskCategories();
      emit(GetTasksSuccessState());
    }).catchError((error) {
      emit(GetTasksErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getCategoryTasks({required String type, required List list}) {
    allTasks.forEach((element) {
      if (element.type == type) {
        list.add(element);
      }
    });
  }

  List<TaskCategory> taskCategories = [];

  void returnTaskCategories() {
    taskCategories = [
      TaskCategory(icon: Icons.all_inbox, title: 'All', tasks: allTasks),
      TaskCategory(icon: Icons.person, title: 'Personal', tasks: personal),
      TaskCategory(icon: Icons.sports, title: 'Sports', tasks: sports),
      TaskCategory(icon: Icons.read_more, title: 'Reading', tasks: reading),
      TaskCategory(icon: Icons.watch_later, title: 'Watching', tasks: watching),
      TaskCategory(icon: Icons.book, title: 'Studying', tasks: studying),
      TaskCategory(icon: Icons.menu, title: 'Other', tasks: other),
    ];
  }

  List<Task>? currentList = [];

  void changeTaskList(String type) {
    if (type == 'All') {
      currentList = allTasks;
    }
    switch (type) {
      case 'Personal':
        currentList = personal;
        break;
      case 'Sports':
        currentList = sports;
        break;
      case 'Reading':
        currentList = reading;
        break;
      case 'Watching':
        currentList = watching;
        break;
      case 'Studying':
        currentList = studying;
        break;
      case 'Other':
        currentList = other;
        break;
    }
    emit(ChangeHomeTasksListSuccessState());
  }

  void updateDatabase({required int id}) {
    database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?',
        ['complete', '$id']).then((value) {
      emit(UpdateTaskItemSuccessState());
      getAllTasksFromDatabase(database);
    }).catchError((error) {
      print(error.toString());
      emit(UpdateTaskItemErrorState(error.toString()));
    });
  }

  deleteTaskItem({
    required int id,
  }) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', ['$id']).then((value) {
      emit(DeleteTaskItemSuccessState());
      getAllTasksFromDatabase(database);
    }).catchError((error) {
      print(error.toString());
      emit(DeleteTaskItemErrorState(error.toString()));
    });
  }
}
