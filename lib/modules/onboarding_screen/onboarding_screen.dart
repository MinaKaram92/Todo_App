import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/layout/todo_layout.dart';
import 'package:simple_todo_app/models/onboarding_model.dart';
import 'package:simple_todo_app/shared/components/components.dart';
import 'package:simple_todo_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageControllder = PageController();

  bool islastOnboarding = false;

  List<OnboardingModel> onboardingModel = [
    OnboardingModel(
      image:
          'https://cdn.pixabay.com/photo/2013/07/12/18/22/checklist-153371_960_720.png',
      title: 'Todo App',
      text: 'A simble app to manage your time.',
    ),
    OnboardingModel(
      image:
          'https://cdn.pixabay.com/photo/2017/06/23/10/53/board-2434286_960_720.jpg',
      title: 'Done tasks',
      text: 'Here you can find your done tasks.',
    ),
    OnboardingModel(
      image:
          'https://cdn.pixabay.com/photo/2017/09/18/09/56/office-2761159_960_720.png',
      title: 'Archived Tasks',
      text: 'Here you can find your archived tasks',
    ),
  ];

  void gotoLayout() {
    CacheHelper.saveData(key: 'islastOnboarding', value: islastOnboarding)
        .then((value) {
      navigateAndFinish(context, TodoLayout());
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    islastOnboarding = true;
                  });
                  gotoLayout();
                },
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.pink, fontSize: 20.0),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return buildOnBoardingScreen(context, onboardingModel[index]);
                },
                physics: BouncingScrollPhysics(),
                allowImplicitScrolling: true,
                scrollDirection: Axis.horizontal,
                itemCount: onboardingModel.length,
                controller: pageControllder,
                onPageChanged: (index) {
                  if (index == onboardingModel.length - 1) {
                    setState(() {
                      islastOnboarding = true;
                    });
                  } else {
                    setState(() {
                      islastOnboarding = false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                Container(
                  height: 30.0,
                  child: SmoothPageIndicator(
                    controller: pageControllder,
                    count: onboardingModel.length,
                    axisDirection: Axis.horizontal,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 3,
                      activeDotColor: Colors.pink,
                      dotColor: Colors.white,
                      spacing: 10.0,
                    ),
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(
                    Icons.forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (islastOnboarding) {
                      gotoLayout();
                    } else {
                      pageControllder.nextPage(
                        duration: Duration(seconds: 5),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: Colors.pink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingScreen(context, OnboardingModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          width: 250.0,
          height: 250.0,
          image: NetworkImage(model.image!),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            model.title!,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.pink,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Text(
          model.text!,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        //SmoothPageIndicator(controller: controller, count: )
      ],
    );
  }
}
