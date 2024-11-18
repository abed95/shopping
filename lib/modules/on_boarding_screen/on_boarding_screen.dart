
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/boarding_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../login_screen/login_screen.dart';

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard1.png',
        title: 'On Board 1 Title',
        body: 'OnBoard 1 Body'),
    BoardingModel(
        image: 'assets/images/onboard2.png',
        title: 'On Board 2 Title',
        body: 'OnBoard 2 Body'),
    BoardingModel(
        image: 'assets/images/onboard3.png',
        title: 'On Board 3 Title',
        body: 'OnBoard 3 Body'),
  ];

  var boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            navigateAndFinish(context, LoginScreen());
          },
              child: Text('SKIP',style: TextStyle(color: defaultColor),)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length -1){
                    setState(() {
                      isLast = true;
                    });
                    print('last');
                  }else{
                    setState(() {
                      isLast =false;
                    });
                    print('not last');
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      navigateAndFinish(context,LoginScreen());                      }
                    boardController.nextPage(duration: Duration(
                        milliseconds: 750
                    ), curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
