import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/widgets/coustom_buttom.dart';
import 'package:flutter_application_1/features/home/view/home_view.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_application_1/onbording_screens/model_onbording/modelbording.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingRootScreens extends StatefulWidget {
  const OnbordingRootScreens({super.key});

  @override
  State<OnbordingRootScreens> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnbordingRootScreens> {
  final PageController controller = PageController();
  bool isLastPage = false;
  final List<Modelbording> pages = [
    Modelbording(
      image: "assets/images/Onboarding_Screens/Illustration_Onboarding_1.png",
      title: "Welcome to Marketi",
      subtitle:
          "Discover a world of endless possibilities and shop from the comfort of your fingertips Browse through a wide range of products, from fashion and electronics to home.",
    ),

    Modelbording(
      image: "assets/images/Onboarding_Screens/Illustration_Onboarding_2.png",
      title: "Easy to Buy",
      subtitle:
          "Find the perfect item that suits your style and needs With secure payment options and fast delivery, shopping has never been easier.",
    ),

    Modelbording(
      image: "assets/images/Onboarding_Screens/Illustration_Onboarding_3.png",
      title: "Wonderful User Experience",
      subtitle:
          "Start exploring now and experience the convenience of online shopping at its best.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == pages.length - 1;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 150),
                    Image.asset(
                      pages[index].image,
                      fit: BoxFit.contain,
                      height: 270,
                    ),
                    SizedBox(height: 40),
                    SmoothPageIndicator(
                      controller: controller,
                      count: pages.length,
                      effect: WormEffect(
                        dotColor: Color(0xffB2CCFF),
                        activeDotColor: Color(0xff001640),
                      ),
                    ),

                    SizedBox(height: 40),

                    coustomtext(
                      text: pages[index].title,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                      child: coustomtext(
                        text: pages[index].subtitle,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3F80FF),
                ),
                onPressed: () {
                  if (isLastPage) {
                    Navigator.pushNamed(context, "login");
                  } else {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  isLastPage ? "Get Started" : "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
