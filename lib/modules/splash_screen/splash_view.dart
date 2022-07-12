import 'package:flutter/material.dart';
import 'package:simple_todo_app/layout/todo_layout.dart';
import 'package:simple_todo_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:simple_todo_app/shared/components/components.dart';
import 'package:simple_todo_app/shared/components/constants.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      print('boardingFinished : $boardingFinished');
      if (boardingFinished != null) {
        navigateAndFinish(context, TodoLayout());
      } else {
        navigateAndFinish(context, OnboardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Todo App',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image(
                    width: 300.0,
                    height: 200.0,
                    image: AssetImage('assets/checklist.png')),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Welcome to Todo App',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 30.0),
              ),
              SizedBox(
                height: 50.0,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
