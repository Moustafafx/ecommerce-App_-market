import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/auth/view/profile_view.dart';
import 'package:flutter_application_1/features/cart/view/cart_view.dart';
import 'package:flutter_application_1/features/home/view/home_view.dart';
import 'package:flutter_application_1/features/orderhistory/view/historyorder.dart';

class Root extends StatefulWidget {
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final PageController _pageController = PageController();
  int currentState = 0;

  List<Widget> screens = [
    HomeView(),
    CartView(),
    Historyorder(),

    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorsinapp,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentState = index;
          });
        },
      ),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),

        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: Container(
            height: 110,
            child: BottomNavigationBar(
              selectedIconTheme: IconThemeData(
                size: 30,
                // حجم الأيقونة بعد اختيارها
              ),
              unselectedIconTheme: IconThemeData(
                size: 27, // حجم الأيقونة قبل الضغط عليها
                color: Colors.grey,
              ),
              selectedItemColor: AppColors.colorbluebutton,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.colorsinapp,
              currentIndex: currentState,
              onTap: (index) {
                setState(() {
                  currentState = index;
                });
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: "",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),

                BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
