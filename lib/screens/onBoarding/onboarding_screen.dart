import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:shop_app/screens/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  List<OnBoarding> onboarding = [
    OnBoarding(
        image: "assets/images/image1.png",
        heading: "Need Groceries Now?",
        body: "Shop from a wide selection of grocery items"),
    OnBoarding(
        image: "assets/images/image2.png",
        heading: "Make Your Order ",
        body: "Put anything in the cart and confirm your order successfully"),
    OnBoarding(
        image: "assets/images/image3.png",
        heading: "Receive Your Order",
        body:
            "Congratulation! your order will be at your door as fast as we could"),
  ];

  PageController _pageController = PageController();
  int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          backwardsCompatibility: false,
          elevation: 0,
          actions: [
            defaultTextButton(
              text: Text("Skip",
                  style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.w400)),
              function: () {
                CacheHelper.saveData(key: "onBoarding", value: true)
                    .then((value) => {
                          if (value) {navigateAndFinish(context,ShopLoginScreen())}
                        });
              },
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) => pageIndex = index,
                itemCount: onboarding.length,
                itemBuilder: (context, index) {
                  return buildOnboardingItem(onboarding[index]);
                },
              ),
            ),
            Row(children: [
              SmoothPageIndicator(
                controller: _pageController,
                count: onboarding.length,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 12,
                    dotWidth: 12,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: primaryColor),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.easeInOut);
                  if (pageIndex == onboarding.length - 1) {
                    CacheHelper.saveData(key: "onBoarding", value: true)
                        .then((value) => {
                              if (value) {navigateAndFinish(context,ShopLoginScreen())}
                            });
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
