import 'package:beats/Onboarding/Data_Model.dart';
import 'package:beats/Onboarding/OnBoard_page.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class OnBoarding extends StatefulWidget {

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {



final PageController pageController = PageController();

final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {

   double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          itemCount: onboardData.length,
          itemBuilder: (BuildContext context, int index) {
            return OnBoard_Page(
              pageModel: onboardData[index],
               pageController: pageController,
               
              );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
        
        Container(
          child: Align(
            alignment: Alignment.bottomLeft,
          child: Padding(
            padding:  EdgeInsets.only(bottom: height*0.06, left: width*0.45),
            child: CirclePageIndicator(
              currentPageNotifier: _currentPageNotifier,
              itemCount: onboardData.length,
              dotColor: Colors.blue,
            ),
          ),
          ),
        )
      ],
    );
  }
}