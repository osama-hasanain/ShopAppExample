import 'package:api/modual/Login/login.dart';
import 'package:api/shared/components/components.dart';
import 'package:api/shared/network/local/cache_helper.dart';
import 'package:api/shared/styles/colors.dart';
import'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  String img;
  String title;
  String body;
  BoardingModel(this.img,this.title,this.body);
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  var isLast = false;

  List<BoardingModel> list = [
    BoardingModel(
    'assets/images/onboard_2.jpg',
    'Screen',
     'Screen Body'
    ),
    BoardingModel(
    'assets/images/onboard_1.png',
    'Screen 2',
     'Screen 2 Body'
    ),
    BoardingModel(
    'assets/images/onboard_3.png',
    'Screen 3',
     'Screen 3 Body'
    ),
  ];

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value)
        navigateToAndFinish(context,ShopLoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              text: 'SKIP',
              onPressed:submit
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context,index) => buildBoardingItem(list[index]),
                itemCount: list.length,
                onPageChanged: (index){
                  if(index == list.length-1)
                    isLast = true;
                  else
                    isLast = false;
                },
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: list.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                child: Icon(Icons.arrow_forward_ios),
                    onPressed: (){
                      if(isLast) submit();
                      else
                       boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    },
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel onboard){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(onboard.img),
          ),
        ),
        SizedBox(height: 30,),
        Text(
          onboard.title,
          style: TextStyle(
              fontSize: 24
          ),
        ),
        SizedBox(height: 15,),
        Text(
          onboard.body,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
