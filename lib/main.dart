import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:simple_todo_app/bloc_observer.dart';
import 'package:simple_todo_app/layout/todo_layout.dart';
import 'package:simple_todo_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:simple_todo_app/modules/splash_screen/splash_view.dart';
import 'package:simple_todo_app/shared/components/constants.dart';
import 'package:simple_todo_app/shared/components/themes/themes.dart';
import 'package:simple_todo_app/shared/cubit/cubit.dart';
import 'package:simple_todo_app/shared/cubit/states.dart';
import 'package:simple_todo_app/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await CacheHelper.init();
  /* await deleteDatabase('todo.db').then((value) {
    print('database successfully deleted......');
  }); */

  boardingFinished = CacheHelper.getData(key: 'islastOnboarding');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  print('isdark from main: $isDark');
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool? isDark;
  // This widget is the root of your application.
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()
        ..createDatabase()
        ..cachedThemeMode(isDark),
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: TodoCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: SplashView(),
          );
        },
      ),
    );
  }
}
